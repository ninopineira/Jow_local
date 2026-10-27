/// Validateur JSON Schema minimal, limité aux mots-clés utilisés par les
/// schémas de `assets/recipes/` (évite une dépendance supplémentaire).
List<String> validateJson(Object? data, Object? schema) {
  final errors = <String>[];
  final root = schema as Map<String, dynamic>;

  void check(Object? v, Map<String, dynamic> s, String path) {
    if (s.containsKey(r'$ref')) {
      final ref = s[r'$ref'] as String;
      final name = ref.split('/').last;
      check(v, (root[r'$defs'] as Map)[name] as Map<String, dynamic>, path);
      return;
    }
    if (s.containsKey('const') && v != s['const']) {
      errors.add('$path : attendu ${s['const']}, obtenu $v');
    }
    if (s.containsKey('enum') && !(s['enum'] as List).contains(v)) {
      errors.add('$path : valeur hors énumération : $v');
    }
    switch (s['type']) {
      case 'object':
        if (v is! Map) {
          errors.add('$path : objet attendu');
          return;
        }
      case 'array':
        if (v is! List) {
          errors.add('$path : tableau attendu');
          return;
        }
      case 'string':
        if (v is! String) {
          errors.add('$path : texte attendu');
          return;
        }
      case 'integer':
        if (v is! int) {
          errors.add('$path : entier attendu');
          return;
        }
      case 'number':
        if (v is! num) {
          errors.add('$path : nombre attendu');
          return;
        }
      case 'boolean':
        if (v is! bool) {
          errors.add('$path : booléen attendu');
          return;
        }
    }
    if (v is Map) {
      final props = (s['properties'] as Map?)?.cast<String, dynamic>() ?? {};
      for (final r in (s['required'] as List? ?? const [])) {
        if (!v.containsKey(r)) {
          errors.add('$path : champ requis manquant « $r »');
        }
      }
      for (final k in v.keys) {
        if (props.containsKey(k)) {
          check(v[k], props[k] as Map<String, dynamic>, '$path.$k');
        } else if (s['additionalProperties'] == false) {
          errors.add('$path : champ inattendu « $k »');
        }
      }
    }
    if (v is List) {
      if (s['minItems'] is int && v.length < (s['minItems'] as int)) {
        errors.add('$path : moins de ${s['minItems']} éléments');
      }
      if (s['maxItems'] is int && v.length > (s['maxItems'] as int)) {
        errors.add('$path : plus de ${s['maxItems']} éléments');
      }
      if (s['uniqueItems'] == true && v.toSet().length != v.length) {
        errors.add('$path : éléments en double');
      }
      if (s['items'] is Map) {
        for (var i = 0; i < v.length; i++) {
          check(v[i], s['items'] as Map<String, dynamic>, '$path[$i]');
        }
      }
    }
    if (v is String) {
      if (s['minLength'] is int && v.length < (s['minLength'] as int)) {
        errors.add('$path : texte trop court');
      }
      if (s['maxLength'] is int && v.length > (s['maxLength'] as int)) {
        errors.add('$path : texte trop long');
      }
      if (s['pattern'] is String &&
          !RegExp(s['pattern'] as String).hasMatch(v)) {
        errors.add('$path : « $v » ne respecte pas ${s['pattern']}');
      }
    }
    if (v is num) {
      if (s['minimum'] is num && v < (s['minimum'] as num)) {
        errors.add('$path : $v < ${s['minimum']}');
      }
      if (s['maximum'] is num && v > (s['maximum'] as num)) {
        errors.add('$path : $v > ${s['maximum']}');
      }
      if (s['exclusiveMinimum'] is num && v <= (s['exclusiveMinimum'] as num)) {
        errors.add('$path : $v ≤ ${s['exclusiveMinimum']}');
      }
    }
  }

  check(data, root, r'$');
  return errors;
}
