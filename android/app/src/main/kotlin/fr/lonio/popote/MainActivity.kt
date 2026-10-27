package fr.lonio.popote

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.provider.MediaStore
import android.view.WindowManager
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream
import java.io.InputStream

/**
 * Canal « popote/platform » : uniquement des intents système déclenchés par
 * l'utilisateur (partage de texte, sélecteur de fichiers, galerie, appareil
 * photo) et le maintien de l'écran allumé. Aucun accès réseau.
 */
class MainActivity : FlutterActivity() {
    private val reqSave = 41
    private val reqOpen = 42
    private val reqGallery = 43
    private val reqCamera = 44

    private var pending: MethodChannel.Result? = null
    private var pendingBytes: ByteArray? = null
    private var pendingDest: String? = null
    private var cameraFile: File? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "popote/platform")
            .setMethodCallHandler { call, result -> handle(call, result) }
    }

    private fun handle(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "shareText" -> {
                val send = Intent(Intent.ACTION_SEND).apply {
                    type = "text/plain"
                    putExtra(Intent.EXTRA_TEXT, call.argument<String>("text"))
                    putExtra(Intent.EXTRA_SUBJECT, call.argument<String>("subject"))
                }
                startActivity(Intent.createChooser(send, call.argument<String>("subject")))
                result.success(true)
            }
            "keepScreenOn" -> {
                if (call.argument<Boolean>("on") == true) {
                    window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                } else {
                    window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                }
                result.success(true)
            }
            "saveDocument" -> {
                if (!begin(result)) return
                pendingBytes = call.argument<ByteArray>("bytes")
                val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
                    addCategory(Intent.CATEGORY_OPENABLE)
                    type = call.argument<String>("mimeType") ?: "application/octet-stream"
                    putExtra(Intent.EXTRA_TITLE, call.argument<String>("fileName"))
                }
                launch(intent, reqSave)
            }
            "openDocument" -> {
                if (!begin(result)) return
                val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
                    addCategory(Intent.CATEGORY_OPENABLE)
                    type = "*/*"
                    putExtra(
                        Intent.EXTRA_MIME_TYPES,
                        arrayOf("application/zip", "application/json", "application/octet-stream"),
                    )
                }
                launch(intent, reqOpen)
            }
            "pickImage" -> {
                if (!begin(result)) return
                pendingDest = call.argument<String>("dest")
                if (call.argument<String>("source") == "camera") {
                    val dir = File(cacheDir, "camera").apply { mkdirs() }
                    val file = File(dir, "capture.jpg")
                    cameraFile = file
                    val uri = FileProvider.getUriForFile(this, "$packageName.files", file)
                    val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE).apply {
                        putExtra(MediaStore.EXTRA_OUTPUT, uri)
                        addFlags(
                            Intent.FLAG_GRANT_WRITE_URI_PERMISSION or
                                Intent.FLAG_GRANT_READ_URI_PERMISSION,
                        )
                    }
                    launch(intent, reqCamera)
                } else {
                    val intent = Intent(Intent.ACTION_GET_CONTENT).apply {
                        addCategory(Intent.CATEGORY_OPENABLE)
                        type = "image/*"
                    }
                    launch(intent, reqGallery)
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun begin(result: MethodChannel.Result): Boolean {
        if (pending != null) {
            result.error("busy", "Une autre demande est en cours", null)
            return false
        }
        pending = result
        return true
    }

    private fun launch(intent: Intent, code: Int) {
        try {
            @Suppress("DEPRECATION")
            startActivityForResult(intent, code)
        } catch (e: ActivityNotFoundException) {
            complete(null)
        }
    }

    private fun complete(value: Any?) {
        val r = pending
        pending = null
        pendingBytes = null
        r?.success(value)
    }

    @Deprecated("API Activity classique, suffisante ici")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        @Suppress("DEPRECATION")
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode !in listOf(reqSave, reqOpen, reqGallery, reqCamera)) return
        if (resultCode != Activity.RESULT_OK) {
            complete(null)
            return
        }
        try {
            when (requestCode) {
                reqSave -> {
                    val uri = data?.data
                    if (uri == null) {
                        complete(false)
                    } else {
                        contentResolver.openOutputStream(uri)?.use { it.write(pendingBytes) }
                        complete(true)
                    }
                }
                reqOpen -> {
                    val uri = data?.data
                    complete(uri?.let { u -> contentResolver.openInputStream(u)?.use { it.readBytes() } })
                }
                reqGallery -> {
                    val uri = data?.data
                    complete(uri != null && storeImage(uri))
                }
                reqCamera -> {
                    val file = cameraFile
                    val ok = file != null && storeImage(Uri.fromFile(file))
                    file?.delete()
                    complete(ok)
                }
            }
        } catch (e: Exception) {
            complete(null)
        }
    }

    /** Réduit l'image (1600 px max) et l'enregistre en JPEG dans le dossier de l'app. */
    private fun storeImage(uri: Uri): Boolean {
        val dest = pendingDest ?: return false
        val bounds = BitmapFactory.Options().apply { inJustDecodeBounds = true }
        open(uri).use { BitmapFactory.decodeStream(it, null, bounds) }
        var sample = 1
        while (bounds.outWidth / (sample * 2) >= 1600 || bounds.outHeight / (sample * 2) >= 1600) {
            sample *= 2
        }
        val opts = BitmapFactory.Options().apply { inSampleSize = sample }
        val bitmap = open(uri).use { BitmapFactory.decodeStream(it, null, opts) } ?: return false
        File(dest).parentFile?.mkdirs()
        FileOutputStream(dest).use { bitmap.compress(Bitmap.CompressFormat.JPEG, 85, it) }
        return true
    }

    private fun open(uri: Uri): InputStream =
        if (uri.scheme == "file") File(uri.path!!).inputStream()
        else contentResolver.openInputStream(uri)!!
}
