// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $IngredientsTable extends Ingredients
    with TableInfo<$IngredientsTable, IngredientRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aisleMeta = const VerificationMeta('aisle');
  @override
  late final GeneratedColumn<String> aisle = GeneratedColumn<String>(
    'aisle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultUnitMeta = const VerificationMeta(
    'defaultUnit',
  );
  @override
  late final GeneratedColumn<String> defaultUnit = GeneratedColumn<String>(
    'default_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgPieceWeightGMeta = const VerificationMeta(
    'avgPieceWeightG',
  );
  @override
  late final GeneratedColumn<double> avgPieceWeightG = GeneratedColumn<double>(
    'avg_piece_weight_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pantryMeta = const VerificationMeta('pantry');
  @override
  late final GeneratedColumn<bool> pantry = GeneratedColumn<bool>(
    'pantry',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pantry" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _perishableMeta = const VerificationMeta(
    'perishable',
  );
  @override
  late final GeneratedColumn<bool> perishable = GeneratedColumn<bool>(
    'perishable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("perishable" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _markersMeta = const VerificationMeta(
    'markers',
  );
  @override
  late final GeneratedColumn<String> markers = GeneratedColumn<String>(
    'markers',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _allergensMeta = const VerificationMeta(
    'allergens',
  );
  @override
  late final GeneratedColumn<String> allergens = GeneratedColumn<String>(
    'allergens',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _seasonMonthsMeta = const VerificationMeta(
    'seasonMonths',
  );
  @override
  late final GeneratedColumn<String> seasonMonths = GeneratedColumn<String>(
    'season_months',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
    'origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nutritionMeta = const VerificationMeta(
    'nutrition',
  );
  @override
  late final GeneratedColumn<String> nutrition = GeneratedColumn<String>(
    'nutrition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _densityMeta = const VerificationMeta(
    'density',
  );
  @override
  late final GeneratedColumn<double> density = GeneratedColumn<double>(
    'density',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ciqualCodeMeta = const VerificationMeta(
    'ciqualCode',
  );
  @override
  late final GeneratedColumn<String> ciqualCode = GeneratedColumn<String>(
    'ciqual_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    aisle,
    defaultUnit,
    avgPieceWeightG,
    pantry,
    perishable,
    markers,
    allergens,
    seasonMonths,
    origin,
    nutrition,
    density,
    ciqualCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<IngredientRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('aisle')) {
      context.handle(
        _aisleMeta,
        aisle.isAcceptableOrUnknown(data['aisle']!, _aisleMeta),
      );
    } else if (isInserting) {
      context.missing(_aisleMeta);
    }
    if (data.containsKey('default_unit')) {
      context.handle(
        _defaultUnitMeta,
        defaultUnit.isAcceptableOrUnknown(
          data['default_unit']!,
          _defaultUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defaultUnitMeta);
    }
    if (data.containsKey('avg_piece_weight_g')) {
      context.handle(
        _avgPieceWeightGMeta,
        avgPieceWeightG.isAcceptableOrUnknown(
          data['avg_piece_weight_g']!,
          _avgPieceWeightGMeta,
        ),
      );
    }
    if (data.containsKey('pantry')) {
      context.handle(
        _pantryMeta,
        pantry.isAcceptableOrUnknown(data['pantry']!, _pantryMeta),
      );
    }
    if (data.containsKey('perishable')) {
      context.handle(
        _perishableMeta,
        perishable.isAcceptableOrUnknown(data['perishable']!, _perishableMeta),
      );
    }
    if (data.containsKey('markers')) {
      context.handle(
        _markersMeta,
        markers.isAcceptableOrUnknown(data['markers']!, _markersMeta),
      );
    }
    if (data.containsKey('allergens')) {
      context.handle(
        _allergensMeta,
        allergens.isAcceptableOrUnknown(data['allergens']!, _allergensMeta),
      );
    }
    if (data.containsKey('season_months')) {
      context.handle(
        _seasonMonthsMeta,
        seasonMonths.isAcceptableOrUnknown(
          data['season_months']!,
          _seasonMonthsMeta,
        ),
      );
    }
    if (data.containsKey('origin')) {
      context.handle(
        _originMeta,
        origin.isAcceptableOrUnknown(data['origin']!, _originMeta),
      );
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('nutrition')) {
      context.handle(
        _nutritionMeta,
        nutrition.isAcceptableOrUnknown(data['nutrition']!, _nutritionMeta),
      );
    }
    if (data.containsKey('density')) {
      context.handle(
        _densityMeta,
        density.isAcceptableOrUnknown(data['density']!, _densityMeta),
      );
    }
    if (data.containsKey('ciqual_code')) {
      context.handle(
        _ciqualCodeMeta,
        ciqualCode.isAcceptableOrUnknown(data['ciqual_code']!, _ciqualCodeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IngredientRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IngredientRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      aisle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aisle'],
      )!,
      defaultUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_unit'],
      )!,
      avgPieceWeightG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_piece_weight_g'],
      ),
      pantry: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pantry'],
      )!,
      perishable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}perishable'],
      )!,
      markers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}markers'],
      )!,
      allergens: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allergens'],
      )!,
      seasonMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}season_months'],
      )!,
      origin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin'],
      )!,
      nutrition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nutrition'],
      ),
      density: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}density'],
      ),
      ciqualCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ciqual_code'],
      ),
    );
  }

  @override
  $IngredientsTable createAlias(String alias) {
    return $IngredientsTable(attachedDatabase, alias);
  }
}

class IngredientRow extends DataClass implements Insertable<IngredientRow> {
  final String id;
  final String name;
  final String aisle;
  final String defaultUnit;
  final double? avgPieceWeightG;
  final bool pantry;
  final bool perishable;
  final String markers;
  final String allergens;
  final String seasonMonths;
  final String origin;

  /// V2 : valeurs nutritionnelles pour 100 g (JSON de `Nutrients`).
  final String? nutrition;
  final double? density;
  final String? ciqualCode;
  const IngredientRow({
    required this.id,
    required this.name,
    required this.aisle,
    required this.defaultUnit,
    this.avgPieceWeightG,
    required this.pantry,
    required this.perishable,
    required this.markers,
    required this.allergens,
    required this.seasonMonths,
    required this.origin,
    this.nutrition,
    this.density,
    this.ciqualCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['aisle'] = Variable<String>(aisle);
    map['default_unit'] = Variable<String>(defaultUnit);
    if (!nullToAbsent || avgPieceWeightG != null) {
      map['avg_piece_weight_g'] = Variable<double>(avgPieceWeightG);
    }
    map['pantry'] = Variable<bool>(pantry);
    map['perishable'] = Variable<bool>(perishable);
    map['markers'] = Variable<String>(markers);
    map['allergens'] = Variable<String>(allergens);
    map['season_months'] = Variable<String>(seasonMonths);
    map['origin'] = Variable<String>(origin);
    if (!nullToAbsent || nutrition != null) {
      map['nutrition'] = Variable<String>(nutrition);
    }
    if (!nullToAbsent || density != null) {
      map['density'] = Variable<double>(density);
    }
    if (!nullToAbsent || ciqualCode != null) {
      map['ciqual_code'] = Variable<String>(ciqualCode);
    }
    return map;
  }

  IngredientsCompanion toCompanion(bool nullToAbsent) {
    return IngredientsCompanion(
      id: Value(id),
      name: Value(name),
      aisle: Value(aisle),
      defaultUnit: Value(defaultUnit),
      avgPieceWeightG: avgPieceWeightG == null && nullToAbsent
          ? const Value.absent()
          : Value(avgPieceWeightG),
      pantry: Value(pantry),
      perishable: Value(perishable),
      markers: Value(markers),
      allergens: Value(allergens),
      seasonMonths: Value(seasonMonths),
      origin: Value(origin),
      nutrition: nutrition == null && nullToAbsent
          ? const Value.absent()
          : Value(nutrition),
      density: density == null && nullToAbsent
          ? const Value.absent()
          : Value(density),
      ciqualCode: ciqualCode == null && nullToAbsent
          ? const Value.absent()
          : Value(ciqualCode),
    );
  }

  factory IngredientRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IngredientRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      aisle: serializer.fromJson<String>(json['aisle']),
      defaultUnit: serializer.fromJson<String>(json['defaultUnit']),
      avgPieceWeightG: serializer.fromJson<double?>(json['avgPieceWeightG']),
      pantry: serializer.fromJson<bool>(json['pantry']),
      perishable: serializer.fromJson<bool>(json['perishable']),
      markers: serializer.fromJson<String>(json['markers']),
      allergens: serializer.fromJson<String>(json['allergens']),
      seasonMonths: serializer.fromJson<String>(json['seasonMonths']),
      origin: serializer.fromJson<String>(json['origin']),
      nutrition: serializer.fromJson<String?>(json['nutrition']),
      density: serializer.fromJson<double?>(json['density']),
      ciqualCode: serializer.fromJson<String?>(json['ciqualCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'aisle': serializer.toJson<String>(aisle),
      'defaultUnit': serializer.toJson<String>(defaultUnit),
      'avgPieceWeightG': serializer.toJson<double?>(avgPieceWeightG),
      'pantry': serializer.toJson<bool>(pantry),
      'perishable': serializer.toJson<bool>(perishable),
      'markers': serializer.toJson<String>(markers),
      'allergens': serializer.toJson<String>(allergens),
      'seasonMonths': serializer.toJson<String>(seasonMonths),
      'origin': serializer.toJson<String>(origin),
      'nutrition': serializer.toJson<String?>(nutrition),
      'density': serializer.toJson<double?>(density),
      'ciqualCode': serializer.toJson<String?>(ciqualCode),
    };
  }

  IngredientRow copyWith({
    String? id,
    String? name,
    String? aisle,
    String? defaultUnit,
    Value<double?> avgPieceWeightG = const Value.absent(),
    bool? pantry,
    bool? perishable,
    String? markers,
    String? allergens,
    String? seasonMonths,
    String? origin,
    Value<String?> nutrition = const Value.absent(),
    Value<double?> density = const Value.absent(),
    Value<String?> ciqualCode = const Value.absent(),
  }) => IngredientRow(
    id: id ?? this.id,
    name: name ?? this.name,
    aisle: aisle ?? this.aisle,
    defaultUnit: defaultUnit ?? this.defaultUnit,
    avgPieceWeightG: avgPieceWeightG.present
        ? avgPieceWeightG.value
        : this.avgPieceWeightG,
    pantry: pantry ?? this.pantry,
    perishable: perishable ?? this.perishable,
    markers: markers ?? this.markers,
    allergens: allergens ?? this.allergens,
    seasonMonths: seasonMonths ?? this.seasonMonths,
    origin: origin ?? this.origin,
    nutrition: nutrition.present ? nutrition.value : this.nutrition,
    density: density.present ? density.value : this.density,
    ciqualCode: ciqualCode.present ? ciqualCode.value : this.ciqualCode,
  );
  IngredientRow copyWithCompanion(IngredientsCompanion data) {
    return IngredientRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      aisle: data.aisle.present ? data.aisle.value : this.aisle,
      defaultUnit: data.defaultUnit.present
          ? data.defaultUnit.value
          : this.defaultUnit,
      avgPieceWeightG: data.avgPieceWeightG.present
          ? data.avgPieceWeightG.value
          : this.avgPieceWeightG,
      pantry: data.pantry.present ? data.pantry.value : this.pantry,
      perishable: data.perishable.present
          ? data.perishable.value
          : this.perishable,
      markers: data.markers.present ? data.markers.value : this.markers,
      allergens: data.allergens.present ? data.allergens.value : this.allergens,
      seasonMonths: data.seasonMonths.present
          ? data.seasonMonths.value
          : this.seasonMonths,
      origin: data.origin.present ? data.origin.value : this.origin,
      nutrition: data.nutrition.present ? data.nutrition.value : this.nutrition,
      density: data.density.present ? data.density.value : this.density,
      ciqualCode: data.ciqualCode.present
          ? data.ciqualCode.value
          : this.ciqualCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IngredientRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('aisle: $aisle, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('avgPieceWeightG: $avgPieceWeightG, ')
          ..write('pantry: $pantry, ')
          ..write('perishable: $perishable, ')
          ..write('markers: $markers, ')
          ..write('allergens: $allergens, ')
          ..write('seasonMonths: $seasonMonths, ')
          ..write('origin: $origin, ')
          ..write('nutrition: $nutrition, ')
          ..write('density: $density, ')
          ..write('ciqualCode: $ciqualCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    aisle,
    defaultUnit,
    avgPieceWeightG,
    pantry,
    perishable,
    markers,
    allergens,
    seasonMonths,
    origin,
    nutrition,
    density,
    ciqualCode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IngredientRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.aisle == this.aisle &&
          other.defaultUnit == this.defaultUnit &&
          other.avgPieceWeightG == this.avgPieceWeightG &&
          other.pantry == this.pantry &&
          other.perishable == this.perishable &&
          other.markers == this.markers &&
          other.allergens == this.allergens &&
          other.seasonMonths == this.seasonMonths &&
          other.origin == this.origin &&
          other.nutrition == this.nutrition &&
          other.density == this.density &&
          other.ciqualCode == this.ciqualCode);
}

class IngredientsCompanion extends UpdateCompanion<IngredientRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> aisle;
  final Value<String> defaultUnit;
  final Value<double?> avgPieceWeightG;
  final Value<bool> pantry;
  final Value<bool> perishable;
  final Value<String> markers;
  final Value<String> allergens;
  final Value<String> seasonMonths;
  final Value<String> origin;
  final Value<String?> nutrition;
  final Value<double?> density;
  final Value<String?> ciqualCode;
  final Value<int> rowid;
  const IngredientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.aisle = const Value.absent(),
    this.defaultUnit = const Value.absent(),
    this.avgPieceWeightG = const Value.absent(),
    this.pantry = const Value.absent(),
    this.perishable = const Value.absent(),
    this.markers = const Value.absent(),
    this.allergens = const Value.absent(),
    this.seasonMonths = const Value.absent(),
    this.origin = const Value.absent(),
    this.nutrition = const Value.absent(),
    this.density = const Value.absent(),
    this.ciqualCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IngredientsCompanion.insert({
    required String id,
    required String name,
    required String aisle,
    required String defaultUnit,
    this.avgPieceWeightG = const Value.absent(),
    this.pantry = const Value.absent(),
    this.perishable = const Value.absent(),
    this.markers = const Value.absent(),
    this.allergens = const Value.absent(),
    this.seasonMonths = const Value.absent(),
    required String origin,
    this.nutrition = const Value.absent(),
    this.density = const Value.absent(),
    this.ciqualCode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       aisle = Value(aisle),
       defaultUnit = Value(defaultUnit),
       origin = Value(origin);
  static Insertable<IngredientRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? aisle,
    Expression<String>? defaultUnit,
    Expression<double>? avgPieceWeightG,
    Expression<bool>? pantry,
    Expression<bool>? perishable,
    Expression<String>? markers,
    Expression<String>? allergens,
    Expression<String>? seasonMonths,
    Expression<String>? origin,
    Expression<String>? nutrition,
    Expression<double>? density,
    Expression<String>? ciqualCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (aisle != null) 'aisle': aisle,
      if (defaultUnit != null) 'default_unit': defaultUnit,
      if (avgPieceWeightG != null) 'avg_piece_weight_g': avgPieceWeightG,
      if (pantry != null) 'pantry': pantry,
      if (perishable != null) 'perishable': perishable,
      if (markers != null) 'markers': markers,
      if (allergens != null) 'allergens': allergens,
      if (seasonMonths != null) 'season_months': seasonMonths,
      if (origin != null) 'origin': origin,
      if (nutrition != null) 'nutrition': nutrition,
      if (density != null) 'density': density,
      if (ciqualCode != null) 'ciqual_code': ciqualCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IngredientsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? aisle,
    Value<String>? defaultUnit,
    Value<double?>? avgPieceWeightG,
    Value<bool>? pantry,
    Value<bool>? perishable,
    Value<String>? markers,
    Value<String>? allergens,
    Value<String>? seasonMonths,
    Value<String>? origin,
    Value<String?>? nutrition,
    Value<double?>? density,
    Value<String?>? ciqualCode,
    Value<int>? rowid,
  }) {
    return IngredientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      aisle: aisle ?? this.aisle,
      defaultUnit: defaultUnit ?? this.defaultUnit,
      avgPieceWeightG: avgPieceWeightG ?? this.avgPieceWeightG,
      pantry: pantry ?? this.pantry,
      perishable: perishable ?? this.perishable,
      markers: markers ?? this.markers,
      allergens: allergens ?? this.allergens,
      seasonMonths: seasonMonths ?? this.seasonMonths,
      origin: origin ?? this.origin,
      nutrition: nutrition ?? this.nutrition,
      density: density ?? this.density,
      ciqualCode: ciqualCode ?? this.ciqualCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (aisle.present) {
      map['aisle'] = Variable<String>(aisle.value);
    }
    if (defaultUnit.present) {
      map['default_unit'] = Variable<String>(defaultUnit.value);
    }
    if (avgPieceWeightG.present) {
      map['avg_piece_weight_g'] = Variable<double>(avgPieceWeightG.value);
    }
    if (pantry.present) {
      map['pantry'] = Variable<bool>(pantry.value);
    }
    if (perishable.present) {
      map['perishable'] = Variable<bool>(perishable.value);
    }
    if (markers.present) {
      map['markers'] = Variable<String>(markers.value);
    }
    if (allergens.present) {
      map['allergens'] = Variable<String>(allergens.value);
    }
    if (seasonMonths.present) {
      map['season_months'] = Variable<String>(seasonMonths.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (nutrition.present) {
      map['nutrition'] = Variable<String>(nutrition.value);
    }
    if (density.present) {
      map['density'] = Variable<double>(density.value);
    }
    if (ciqualCode.present) {
      map['ciqual_code'] = Variable<String>(ciqualCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('aisle: $aisle, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('avgPieceWeightG: $avgPieceWeightG, ')
          ..write('pantry: $pantry, ')
          ..write('perishable: $perishable, ')
          ..write('markers: $markers, ')
          ..write('allergens: $allergens, ')
          ..write('seasonMonths: $seasonMonths, ')
          ..write('origin: $origin, ')
          ..write('nutrition: $nutrition, ')
          ..write('density: $density, ')
          ..write('ciqualCode: $ciqualCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecipesTable extends Recipes with TableInfo<$RecipesTable, RecipeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _servingsMeta = const VerificationMeta(
    'servings',
  );
  @override
  late final GeneratedColumn<int> servings = GeneratedColumn<int>(
    'servings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prepMinMeta = const VerificationMeta(
    'prepMin',
  );
  @override
  late final GeneratedColumn<int> prepMin = GeneratedColumn<int>(
    'prep_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cookMinMeta = const VerificationMeta(
    'cookMin',
  );
  @override
  late final GeneratedColumn<int> cookMin = GeneratedColumn<int>(
    'cook_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipmentMeta = const VerificationMeta(
    'equipment',
  );
  @override
  late final GeneratedColumn<String> equipment = GeneratedColumn<String>(
    'equipment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _mainBaseMeta = const VerificationMeta(
    'mainBase',
  );
  @override
  late final GeneratedColumn<String> mainBase = GeneratedColumn<String>(
    'main_base',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
    'origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seedVersionMeta = const VerificationMeta(
    'seedVersion',
  );
  @override
  late final GeneratedColumn<int> seedVersion = GeneratedColumn<int>(
    'seed_version',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    title,
    description,
    type,
    servings,
    prepMin,
    cookMin,
    difficulty,
    equipment,
    mainBase,
    origin,
    seedVersion,
    photoPath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('servings')) {
      context.handle(
        _servingsMeta,
        servings.isAcceptableOrUnknown(data['servings']!, _servingsMeta),
      );
    } else if (isInserting) {
      context.missing(_servingsMeta);
    }
    if (data.containsKey('prep_min')) {
      context.handle(
        _prepMinMeta,
        prepMin.isAcceptableOrUnknown(data['prep_min']!, _prepMinMeta),
      );
    } else if (isInserting) {
      context.missing(_prepMinMeta);
    }
    if (data.containsKey('cook_min')) {
      context.handle(
        _cookMinMeta,
        cookMin.isAcceptableOrUnknown(data['cook_min']!, _cookMinMeta),
      );
    } else if (isInserting) {
      context.missing(_cookMinMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('equipment')) {
      context.handle(
        _equipmentMeta,
        equipment.isAcceptableOrUnknown(data['equipment']!, _equipmentMeta),
      );
    }
    if (data.containsKey('main_base')) {
      context.handle(
        _mainBaseMeta,
        mainBase.isAcceptableOrUnknown(data['main_base']!, _mainBaseMeta),
      );
    } else if (isInserting) {
      context.missing(_mainBaseMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(
        _originMeta,
        origin.isAcceptableOrUnknown(data['origin']!, _originMeta),
      );
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('seed_version')) {
      context.handle(
        _seedVersionMeta,
        seedVersion.isAcceptableOrUnknown(
          data['seed_version']!,
          _seedVersionMeta,
        ),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      servings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servings'],
      )!,
      prepMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prep_min'],
      )!,
      cookMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cook_min'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      equipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment'],
      )!,
      mainBase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_base'],
      )!,
      origin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin'],
      )!,
      seedVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seed_version'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }
}

class RecipeRow extends DataClass implements Insertable<RecipeRow> {
  final int id;
  final String? slug;
  final String title;
  final String description;
  final String type;
  final int servings;
  final int prepMin;
  final int cookMin;
  final String difficulty;
  final String equipment;
  final String mainBase;
  final String origin;
  final int? seedVersion;
  final String? photoPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RecipeRow({
    required this.id,
    this.slug,
    required this.title,
    required this.description,
    required this.type,
    required this.servings,
    required this.prepMin,
    required this.cookMin,
    required this.difficulty,
    required this.equipment,
    required this.mainBase,
    required this.origin,
    this.seedVersion,
    this.photoPath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || slug != null) {
      map['slug'] = Variable<String>(slug);
    }
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['type'] = Variable<String>(type);
    map['servings'] = Variable<int>(servings);
    map['prep_min'] = Variable<int>(prepMin);
    map['cook_min'] = Variable<int>(cookMin);
    map['difficulty'] = Variable<String>(difficulty);
    map['equipment'] = Variable<String>(equipment);
    map['main_base'] = Variable<String>(mainBase);
    map['origin'] = Variable<String>(origin);
    if (!nullToAbsent || seedVersion != null) {
      map['seed_version'] = Variable<int>(seedVersion);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      slug: slug == null && nullToAbsent ? const Value.absent() : Value(slug),
      title: Value(title),
      description: Value(description),
      type: Value(type),
      servings: Value(servings),
      prepMin: Value(prepMin),
      cookMin: Value(cookMin),
      difficulty: Value(difficulty),
      equipment: Value(equipment),
      mainBase: Value(mainBase),
      origin: Value(origin),
      seedVersion: seedVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(seedVersion),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RecipeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeRow(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String?>(json['slug']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      type: serializer.fromJson<String>(json['type']),
      servings: serializer.fromJson<int>(json['servings']),
      prepMin: serializer.fromJson<int>(json['prepMin']),
      cookMin: serializer.fromJson<int>(json['cookMin']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      equipment: serializer.fromJson<String>(json['equipment']),
      mainBase: serializer.fromJson<String>(json['mainBase']),
      origin: serializer.fromJson<String>(json['origin']),
      seedVersion: serializer.fromJson<int?>(json['seedVersion']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String?>(slug),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'type': serializer.toJson<String>(type),
      'servings': serializer.toJson<int>(servings),
      'prepMin': serializer.toJson<int>(prepMin),
      'cookMin': serializer.toJson<int>(cookMin),
      'difficulty': serializer.toJson<String>(difficulty),
      'equipment': serializer.toJson<String>(equipment),
      'mainBase': serializer.toJson<String>(mainBase),
      'origin': serializer.toJson<String>(origin),
      'seedVersion': serializer.toJson<int?>(seedVersion),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RecipeRow copyWith({
    int? id,
    Value<String?> slug = const Value.absent(),
    String? title,
    String? description,
    String? type,
    int? servings,
    int? prepMin,
    int? cookMin,
    String? difficulty,
    String? equipment,
    String? mainBase,
    String? origin,
    Value<int?> seedVersion = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RecipeRow(
    id: id ?? this.id,
    slug: slug.present ? slug.value : this.slug,
    title: title ?? this.title,
    description: description ?? this.description,
    type: type ?? this.type,
    servings: servings ?? this.servings,
    prepMin: prepMin ?? this.prepMin,
    cookMin: cookMin ?? this.cookMin,
    difficulty: difficulty ?? this.difficulty,
    equipment: equipment ?? this.equipment,
    mainBase: mainBase ?? this.mainBase,
    origin: origin ?? this.origin,
    seedVersion: seedVersion.present ? seedVersion.value : this.seedVersion,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RecipeRow copyWithCompanion(RecipesCompanion data) {
    return RecipeRow(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      type: data.type.present ? data.type.value : this.type,
      servings: data.servings.present ? data.servings.value : this.servings,
      prepMin: data.prepMin.present ? data.prepMin.value : this.prepMin,
      cookMin: data.cookMin.present ? data.cookMin.value : this.cookMin,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      equipment: data.equipment.present ? data.equipment.value : this.equipment,
      mainBase: data.mainBase.present ? data.mainBase.value : this.mainBase,
      origin: data.origin.present ? data.origin.value : this.origin,
      seedVersion: data.seedVersion.present
          ? data.seedVersion.value
          : this.seedVersion,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeRow(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('servings: $servings, ')
          ..write('prepMin: $prepMin, ')
          ..write('cookMin: $cookMin, ')
          ..write('difficulty: $difficulty, ')
          ..write('equipment: $equipment, ')
          ..write('mainBase: $mainBase, ')
          ..write('origin: $origin, ')
          ..write('seedVersion: $seedVersion, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    slug,
    title,
    description,
    type,
    servings,
    prepMin,
    cookMin,
    difficulty,
    equipment,
    mainBase,
    origin,
    seedVersion,
    photoPath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeRow &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.title == this.title &&
          other.description == this.description &&
          other.type == this.type &&
          other.servings == this.servings &&
          other.prepMin == this.prepMin &&
          other.cookMin == this.cookMin &&
          other.difficulty == this.difficulty &&
          other.equipment == this.equipment &&
          other.mainBase == this.mainBase &&
          other.origin == this.origin &&
          other.seedVersion == this.seedVersion &&
          other.photoPath == this.photoPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RecipesCompanion extends UpdateCompanion<RecipeRow> {
  final Value<int> id;
  final Value<String?> slug;
  final Value<String> title;
  final Value<String> description;
  final Value<String> type;
  final Value<int> servings;
  final Value<int> prepMin;
  final Value<int> cookMin;
  final Value<String> difficulty;
  final Value<String> equipment;
  final Value<String> mainBase;
  final Value<String> origin;
  final Value<int?> seedVersion;
  final Value<String?> photoPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.servings = const Value.absent(),
    this.prepMin = const Value.absent(),
    this.cookMin = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.equipment = const Value.absent(),
    this.mainBase = const Value.absent(),
    this.origin = const Value.absent(),
    this.seedVersion = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RecipesCompanion.insert({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required String type,
    required int servings,
    required int prepMin,
    required int cookMin,
    required String difficulty,
    this.equipment = const Value.absent(),
    required String mainBase,
    required String origin,
    this.seedVersion = const Value.absent(),
    this.photoPath = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : title = Value(title),
       type = Value(type),
       servings = Value(servings),
       prepMin = Value(prepMin),
       cookMin = Value(cookMin),
       difficulty = Value(difficulty),
       mainBase = Value(mainBase),
       origin = Value(origin),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RecipeRow> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? type,
    Expression<int>? servings,
    Expression<int>? prepMin,
    Expression<int>? cookMin,
    Expression<String>? difficulty,
    Expression<String>? equipment,
    Expression<String>? mainBase,
    Expression<String>? origin,
    Expression<int>? seedVersion,
    Expression<String>? photoPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (servings != null) 'servings': servings,
      if (prepMin != null) 'prep_min': prepMin,
      if (cookMin != null) 'cook_min': cookMin,
      if (difficulty != null) 'difficulty': difficulty,
      if (equipment != null) 'equipment': equipment,
      if (mainBase != null) 'main_base': mainBase,
      if (origin != null) 'origin': origin,
      if (seedVersion != null) 'seed_version': seedVersion,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RecipesCompanion copyWith({
    Value<int>? id,
    Value<String?>? slug,
    Value<String>? title,
    Value<String>? description,
    Value<String>? type,
    Value<int>? servings,
    Value<int>? prepMin,
    Value<int>? cookMin,
    Value<String>? difficulty,
    Value<String>? equipment,
    Value<String>? mainBase,
    Value<String>? origin,
    Value<int?>? seedVersion,
    Value<String?>? photoPath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RecipesCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      servings: servings ?? this.servings,
      prepMin: prepMin ?? this.prepMin,
      cookMin: cookMin ?? this.cookMin,
      difficulty: difficulty ?? this.difficulty,
      equipment: equipment ?? this.equipment,
      mainBase: mainBase ?? this.mainBase,
      origin: origin ?? this.origin,
      seedVersion: seedVersion ?? this.seedVersion,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (servings.present) {
      map['servings'] = Variable<int>(servings.value);
    }
    if (prepMin.present) {
      map['prep_min'] = Variable<int>(prepMin.value);
    }
    if (cookMin.present) {
      map['cook_min'] = Variable<int>(cookMin.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (equipment.present) {
      map['equipment'] = Variable<String>(equipment.value);
    }
    if (mainBase.present) {
      map['main_base'] = Variable<String>(mainBase.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (seedVersion.present) {
      map['seed_version'] = Variable<int>(seedVersion.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('servings: $servings, ')
          ..write('prepMin: $prepMin, ')
          ..write('cookMin: $cookMin, ')
          ..write('difficulty: $difficulty, ')
          ..write('equipment: $equipment, ')
          ..write('mainBase: $mainBase, ')
          ..write('origin: $origin, ')
          ..write('seedVersion: $seedVersion, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RecipeIngredientsTable extends RecipeIngredients
    with TableInfo<$RecipeIngredientsTable, RecipeIngredientRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeIngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<String> ingredientId = GeneratedColumn<String>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id)',
    ),
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<double> qty = GeneratedColumn<double>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _optionalMeta = const VerificationMeta(
    'optional',
  );
  @override
  late final GeneratedColumn<bool> optional = GeneratedColumn<bool>(
    'optional',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("optional" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    ingredientId,
    qty,
    unit,
    optional,
    note,
    position,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeIngredientRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('optional')) {
      context.handle(
        _optionalMeta,
        optional.isAcceptableOrUnknown(data['optional']!, _optionalMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeIngredientRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeIngredientRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_id'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}qty'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      optional: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}optional'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $RecipeIngredientsTable createAlias(String alias) {
    return $RecipeIngredientsTable(attachedDatabase, alias);
  }
}

class RecipeIngredientRow extends DataClass
    implements Insertable<RecipeIngredientRow> {
  final int id;
  final int recipeId;
  final String ingredientId;
  final double qty;
  final String unit;
  final bool optional;
  final String? note;
  final int position;
  const RecipeIngredientRow({
    required this.id,
    required this.recipeId,
    required this.ingredientId,
    required this.qty,
    required this.unit,
    required this.optional,
    this.note,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<int>(recipeId);
    map['ingredient_id'] = Variable<String>(ingredientId);
    map['qty'] = Variable<double>(qty);
    map['unit'] = Variable<String>(unit);
    map['optional'] = Variable<bool>(optional);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['position'] = Variable<int>(position);
    return map;
  }

  RecipeIngredientsCompanion toCompanion(bool nullToAbsent) {
    return RecipeIngredientsCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      ingredientId: Value(ingredientId),
      qty: Value(qty),
      unit: Value(unit),
      optional: Value(optional),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      position: Value(position),
    );
  }

  factory RecipeIngredientRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeIngredientRow(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      ingredientId: serializer.fromJson<String>(json['ingredientId']),
      qty: serializer.fromJson<double>(json['qty']),
      unit: serializer.fromJson<String>(json['unit']),
      optional: serializer.fromJson<bool>(json['optional']),
      note: serializer.fromJson<String?>(json['note']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<int>(recipeId),
      'ingredientId': serializer.toJson<String>(ingredientId),
      'qty': serializer.toJson<double>(qty),
      'unit': serializer.toJson<String>(unit),
      'optional': serializer.toJson<bool>(optional),
      'note': serializer.toJson<String?>(note),
      'position': serializer.toJson<int>(position),
    };
  }

  RecipeIngredientRow copyWith({
    int? id,
    int? recipeId,
    String? ingredientId,
    double? qty,
    String? unit,
    bool? optional,
    Value<String?> note = const Value.absent(),
    int? position,
  }) => RecipeIngredientRow(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    ingredientId: ingredientId ?? this.ingredientId,
    qty: qty ?? this.qty,
    unit: unit ?? this.unit,
    optional: optional ?? this.optional,
    note: note.present ? note.value : this.note,
    position: position ?? this.position,
  );
  RecipeIngredientRow copyWithCompanion(RecipeIngredientsCompanion data) {
    return RecipeIngredientRow(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      qty: data.qty.present ? data.qty.value : this.qty,
      unit: data.unit.present ? data.unit.value : this.unit,
      optional: data.optional.present ? data.optional.value : this.optional,
      note: data.note.present ? data.note.value : this.note,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredientRow(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('qty: $qty, ')
          ..write('unit: $unit, ')
          ..write('optional: $optional, ')
          ..write('note: $note, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recipeId,
    ingredientId,
    qty,
    unit,
    optional,
    note,
    position,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeIngredientRow &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.ingredientId == this.ingredientId &&
          other.qty == this.qty &&
          other.unit == this.unit &&
          other.optional == this.optional &&
          other.note == this.note &&
          other.position == this.position);
}

class RecipeIngredientsCompanion extends UpdateCompanion<RecipeIngredientRow> {
  final Value<int> id;
  final Value<int> recipeId;
  final Value<String> ingredientId;
  final Value<double> qty;
  final Value<String> unit;
  final Value<bool> optional;
  final Value<String?> note;
  final Value<int> position;
  const RecipeIngredientsCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.qty = const Value.absent(),
    this.unit = const Value.absent(),
    this.optional = const Value.absent(),
    this.note = const Value.absent(),
    this.position = const Value.absent(),
  });
  RecipeIngredientsCompanion.insert({
    this.id = const Value.absent(),
    required int recipeId,
    required String ingredientId,
    required double qty,
    required String unit,
    this.optional = const Value.absent(),
    this.note = const Value.absent(),
    required int position,
  }) : recipeId = Value(recipeId),
       ingredientId = Value(ingredientId),
       qty = Value(qty),
       unit = Value(unit),
       position = Value(position);
  static Insertable<RecipeIngredientRow> custom({
    Expression<int>? id,
    Expression<int>? recipeId,
    Expression<String>? ingredientId,
    Expression<double>? qty,
    Expression<String>? unit,
    Expression<bool>? optional,
    Expression<String>? note,
    Expression<int>? position,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (qty != null) 'qty': qty,
      if (unit != null) 'unit': unit,
      if (optional != null) 'optional': optional,
      if (note != null) 'note': note,
      if (position != null) 'position': position,
    });
  }

  RecipeIngredientsCompanion copyWith({
    Value<int>? id,
    Value<int>? recipeId,
    Value<String>? ingredientId,
    Value<double>? qty,
    Value<String>? unit,
    Value<bool>? optional,
    Value<String?>? note,
    Value<int>? position,
  }) {
    return RecipeIngredientsCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      ingredientId: ingredientId ?? this.ingredientId,
      qty: qty ?? this.qty,
      unit: unit ?? this.unit,
      optional: optional ?? this.optional,
      note: note ?? this.note,
      position: position ?? this.position,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<String>(ingredientId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<double>(qty.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (optional.present) {
      map['optional'] = Variable<bool>(optional.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredientsCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('qty: $qty, ')
          ..write('unit: $unit, ')
          ..write('optional: $optional, ')
          ..write('note: $note, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }
}

class $RecipeStepsTable extends RecipeSteps
    with TableInfo<$RecipeStepsTable, RecipeStepRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, recipeId, position, body];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeStepRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeStepRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeStepRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
    );
  }

  @override
  $RecipeStepsTable createAlias(String alias) {
    return $RecipeStepsTable(attachedDatabase, alias);
  }
}

class RecipeStepRow extends DataClass implements Insertable<RecipeStepRow> {
  final int id;
  final int recipeId;
  final int position;
  final String body;
  const RecipeStepRow({
    required this.id,
    required this.recipeId,
    required this.position,
    required this.body,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<int>(recipeId);
    map['position'] = Variable<int>(position);
    map['body'] = Variable<String>(body);
    return map;
  }

  RecipeStepsCompanion toCompanion(bool nullToAbsent) {
    return RecipeStepsCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      position: Value(position),
      body: Value(body),
    );
  }

  factory RecipeStepRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeStepRow(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      position: serializer.fromJson<int>(json['position']),
      body: serializer.fromJson<String>(json['body']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<int>(recipeId),
      'position': serializer.toJson<int>(position),
      'body': serializer.toJson<String>(body),
    };
  }

  RecipeStepRow copyWith({
    int? id,
    int? recipeId,
    int? position,
    String? body,
  }) => RecipeStepRow(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    position: position ?? this.position,
    body: body ?? this.body,
  );
  RecipeStepRow copyWithCompanion(RecipeStepsCompanion data) {
    return RecipeStepRow(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      position: data.position.present ? data.position.value : this.position,
      body: data.body.present ? data.body.value : this.body,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeStepRow(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('position: $position, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recipeId, position, body);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeStepRow &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.position == this.position &&
          other.body == this.body);
}

class RecipeStepsCompanion extends UpdateCompanion<RecipeStepRow> {
  final Value<int> id;
  final Value<int> recipeId;
  final Value<int> position;
  final Value<String> body;
  const RecipeStepsCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.position = const Value.absent(),
    this.body = const Value.absent(),
  });
  RecipeStepsCompanion.insert({
    this.id = const Value.absent(),
    required int recipeId,
    required int position,
    required String body,
  }) : recipeId = Value(recipeId),
       position = Value(position),
       body = Value(body);
  static Insertable<RecipeStepRow> custom({
    Expression<int>? id,
    Expression<int>? recipeId,
    Expression<int>? position,
    Expression<String>? body,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (position != null) 'position': position,
      if (body != null) 'body': body,
    });
  }

  RecipeStepsCompanion copyWith({
    Value<int>? id,
    Value<int>? recipeId,
    Value<int>? position,
    Value<String>? body,
  }) {
    return RecipeStepsCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      position: position ?? this.position,
      body: body ?? this.body,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeStepsCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('position: $position, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }
}

class $RecipeUserStatesTable extends RecipeUserStates
    with TableInfo<$RecipeUserStatesTable, RecipeUserStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeUserStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _favoriteMeta = const VerificationMeta(
    'favorite',
  );
  @override
  late final GeneratedColumn<bool> favorite = GeneratedColumn<bool>(
    'favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _toPlaceMeta = const VerificationMeta(
    'toPlace',
  );
  @override
  late final GeneratedColumn<bool> toPlace = GeneratedColumn<bool>(
    'to_place',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("to_place" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dislikedMeta = const VerificationMeta(
    'disliked',
  );
  @override
  late final GeneratedColumn<bool> disliked = GeneratedColumn<bool>(
    'disliked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("disliked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastPlannedAtMeta = const VerificationMeta(
    'lastPlannedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastPlannedAt =
      GeneratedColumn<DateTime>(
        'last_planned_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    recipeId,
    favorite,
    toPlace,
    disliked,
    lastPlannedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_user_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeUserStateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    }
    if (data.containsKey('favorite')) {
      context.handle(
        _favoriteMeta,
        favorite.isAcceptableOrUnknown(data['favorite']!, _favoriteMeta),
      );
    }
    if (data.containsKey('to_place')) {
      context.handle(
        _toPlaceMeta,
        toPlace.isAcceptableOrUnknown(data['to_place']!, _toPlaceMeta),
      );
    }
    if (data.containsKey('disliked')) {
      context.handle(
        _dislikedMeta,
        disliked.isAcceptableOrUnknown(data['disliked']!, _dislikedMeta),
      );
    }
    if (data.containsKey('last_planned_at')) {
      context.handle(
        _lastPlannedAtMeta,
        lastPlannedAt.isAcceptableOrUnknown(
          data['last_planned_at']!,
          _lastPlannedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {recipeId};
  @override
  RecipeUserStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeUserStateRow(
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      favorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}favorite'],
      )!,
      toPlace: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}to_place'],
      )!,
      disliked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}disliked'],
      )!,
      lastPlannedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_planned_at'],
      ),
    );
  }

  @override
  $RecipeUserStatesTable createAlias(String alias) {
    return $RecipeUserStatesTable(attachedDatabase, alias);
  }
}

class RecipeUserStateRow extends DataClass
    implements Insertable<RecipeUserStateRow> {
  final int recipeId;
  final bool favorite;
  final bool toPlace;
  final bool disliked;
  final DateTime? lastPlannedAt;
  const RecipeUserStateRow({
    required this.recipeId,
    required this.favorite,
    required this.toPlace,
    required this.disliked,
    this.lastPlannedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['recipe_id'] = Variable<int>(recipeId);
    map['favorite'] = Variable<bool>(favorite);
    map['to_place'] = Variable<bool>(toPlace);
    map['disliked'] = Variable<bool>(disliked);
    if (!nullToAbsent || lastPlannedAt != null) {
      map['last_planned_at'] = Variable<DateTime>(lastPlannedAt);
    }
    return map;
  }

  RecipeUserStatesCompanion toCompanion(bool nullToAbsent) {
    return RecipeUserStatesCompanion(
      recipeId: Value(recipeId),
      favorite: Value(favorite),
      toPlace: Value(toPlace),
      disliked: Value(disliked),
      lastPlannedAt: lastPlannedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPlannedAt),
    );
  }

  factory RecipeUserStateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeUserStateRow(
      recipeId: serializer.fromJson<int>(json['recipeId']),
      favorite: serializer.fromJson<bool>(json['favorite']),
      toPlace: serializer.fromJson<bool>(json['toPlace']),
      disliked: serializer.fromJson<bool>(json['disliked']),
      lastPlannedAt: serializer.fromJson<DateTime?>(json['lastPlannedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'recipeId': serializer.toJson<int>(recipeId),
      'favorite': serializer.toJson<bool>(favorite),
      'toPlace': serializer.toJson<bool>(toPlace),
      'disliked': serializer.toJson<bool>(disliked),
      'lastPlannedAt': serializer.toJson<DateTime?>(lastPlannedAt),
    };
  }

  RecipeUserStateRow copyWith({
    int? recipeId,
    bool? favorite,
    bool? toPlace,
    bool? disliked,
    Value<DateTime?> lastPlannedAt = const Value.absent(),
  }) => RecipeUserStateRow(
    recipeId: recipeId ?? this.recipeId,
    favorite: favorite ?? this.favorite,
    toPlace: toPlace ?? this.toPlace,
    disliked: disliked ?? this.disliked,
    lastPlannedAt: lastPlannedAt.present
        ? lastPlannedAt.value
        : this.lastPlannedAt,
  );
  RecipeUserStateRow copyWithCompanion(RecipeUserStatesCompanion data) {
    return RecipeUserStateRow(
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      favorite: data.favorite.present ? data.favorite.value : this.favorite,
      toPlace: data.toPlace.present ? data.toPlace.value : this.toPlace,
      disliked: data.disliked.present ? data.disliked.value : this.disliked,
      lastPlannedAt: data.lastPlannedAt.present
          ? data.lastPlannedAt.value
          : this.lastPlannedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeUserStateRow(')
          ..write('recipeId: $recipeId, ')
          ..write('favorite: $favorite, ')
          ..write('toPlace: $toPlace, ')
          ..write('disliked: $disliked, ')
          ..write('lastPlannedAt: $lastPlannedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(recipeId, favorite, toPlace, disliked, lastPlannedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeUserStateRow &&
          other.recipeId == this.recipeId &&
          other.favorite == this.favorite &&
          other.toPlace == this.toPlace &&
          other.disliked == this.disliked &&
          other.lastPlannedAt == this.lastPlannedAt);
}

class RecipeUserStatesCompanion extends UpdateCompanion<RecipeUserStateRow> {
  final Value<int> recipeId;
  final Value<bool> favorite;
  final Value<bool> toPlace;
  final Value<bool> disliked;
  final Value<DateTime?> lastPlannedAt;
  const RecipeUserStatesCompanion({
    this.recipeId = const Value.absent(),
    this.favorite = const Value.absent(),
    this.toPlace = const Value.absent(),
    this.disliked = const Value.absent(),
    this.lastPlannedAt = const Value.absent(),
  });
  RecipeUserStatesCompanion.insert({
    this.recipeId = const Value.absent(),
    this.favorite = const Value.absent(),
    this.toPlace = const Value.absent(),
    this.disliked = const Value.absent(),
    this.lastPlannedAt = const Value.absent(),
  });
  static Insertable<RecipeUserStateRow> custom({
    Expression<int>? recipeId,
    Expression<bool>? favorite,
    Expression<bool>? toPlace,
    Expression<bool>? disliked,
    Expression<DateTime>? lastPlannedAt,
  }) {
    return RawValuesInsertable({
      if (recipeId != null) 'recipe_id': recipeId,
      if (favorite != null) 'favorite': favorite,
      if (toPlace != null) 'to_place': toPlace,
      if (disliked != null) 'disliked': disliked,
      if (lastPlannedAt != null) 'last_planned_at': lastPlannedAt,
    });
  }

  RecipeUserStatesCompanion copyWith({
    Value<int>? recipeId,
    Value<bool>? favorite,
    Value<bool>? toPlace,
    Value<bool>? disliked,
    Value<DateTime?>? lastPlannedAt,
  }) {
    return RecipeUserStatesCompanion(
      recipeId: recipeId ?? this.recipeId,
      favorite: favorite ?? this.favorite,
      toPlace: toPlace ?? this.toPlace,
      disliked: disliked ?? this.disliked,
      lastPlannedAt: lastPlannedAt ?? this.lastPlannedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (favorite.present) {
      map['favorite'] = Variable<bool>(favorite.value);
    }
    if (toPlace.present) {
      map['to_place'] = Variable<bool>(toPlace.value);
    }
    if (disliked.present) {
      map['disliked'] = Variable<bool>(disliked.value);
    }
    if (lastPlannedAt.present) {
      map['last_planned_at'] = Variable<DateTime>(lastPlannedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeUserStatesCompanion(')
          ..write('recipeId: $recipeId, ')
          ..write('favorite: $favorite, ')
          ..write('toPlace: $toPlace, ')
          ..write('disliked: $disliked, ')
          ..write('lastPlannedAt: $lastPlannedAt')
          ..write(')'))
        .toString();
  }
}

class $ProfilesTable extends Profiles
    with TableInfo<$ProfilesTable, ProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _onboardedMeta = const VerificationMeta(
    'onboarded',
  );
  @override
  late final GeneratedColumn<bool> onboarded = GeneratedColumn<bool>(
    'onboarded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarded" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _peopleMeta = const VerificationMeta('people');
  @override
  late final GeneratedColumn<int> people = GeneratedColumn<int>(
    'people',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _dietMeta = const VerificationMeta('diet');
  @override
  late final GeneratedColumn<String> diet = GeneratedColumn<String>(
    'diet',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('omnivore'),
  );
  static const VerificationMeta _noPorkMeta = const VerificationMeta('noPork');
  @override
  late final GeneratedColumn<bool> noPork = GeneratedColumn<bool>(
    'no_pork',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("no_pork" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _maxMinWeekdayMeta = const VerificationMeta(
    'maxMinWeekday',
  );
  @override
  late final GeneratedColumn<int> maxMinWeekday = GeneratedColumn<int>(
    'max_min_weekday',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _maxMinWeekendMeta = const VerificationMeta(
    'maxMinWeekend',
  );
  @override
  late final GeneratedColumn<int> maxMinWeekend = GeneratedColumn<int>(
    'max_min_weekend',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  static const VerificationMeta _weekStartDayMeta = const VerificationMeta(
    'weekStartDay',
  );
  @override
  late final GeneratedColumn<int> weekStartDay = GeneratedColumn<int>(
    'week_start_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _favoriteShareMeta = const VerificationMeta(
    'favoriteShare',
  );
  @override
  late final GeneratedColumn<double> favoriteShare = GeneratedColumn<double>(
    'favorite_share',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.4),
  );
  static const VerificationMeta _antiRepeatWeeksMeta = const VerificationMeta(
    'antiRepeatWeeks',
  );
  @override
  late final GeneratedColumn<int> antiRepeatWeeks = GeneratedColumn<int>(
    'anti_repeat_weeks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _aisleOrderMeta = const VerificationMeta(
    'aisleOrder',
  );
  @override
  late final GeneratedColumn<String> aisleOrder = GeneratedColumn<String>(
    'aisle_order',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    onboarded,
    people,
    diet,
    noPork,
    maxMinWeekday,
    maxMinWeekend,
    weekStartDay,
    favoriteShare,
    antiRepeatWeeks,
    aisleOrder,
    themeMode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onboarded')) {
      context.handle(
        _onboardedMeta,
        onboarded.isAcceptableOrUnknown(data['onboarded']!, _onboardedMeta),
      );
    }
    if (data.containsKey('people')) {
      context.handle(
        _peopleMeta,
        people.isAcceptableOrUnknown(data['people']!, _peopleMeta),
      );
    }
    if (data.containsKey('diet')) {
      context.handle(
        _dietMeta,
        diet.isAcceptableOrUnknown(data['diet']!, _dietMeta),
      );
    }
    if (data.containsKey('no_pork')) {
      context.handle(
        _noPorkMeta,
        noPork.isAcceptableOrUnknown(data['no_pork']!, _noPorkMeta),
      );
    }
    if (data.containsKey('max_min_weekday')) {
      context.handle(
        _maxMinWeekdayMeta,
        maxMinWeekday.isAcceptableOrUnknown(
          data['max_min_weekday']!,
          _maxMinWeekdayMeta,
        ),
      );
    }
    if (data.containsKey('max_min_weekend')) {
      context.handle(
        _maxMinWeekendMeta,
        maxMinWeekend.isAcceptableOrUnknown(
          data['max_min_weekend']!,
          _maxMinWeekendMeta,
        ),
      );
    }
    if (data.containsKey('week_start_day')) {
      context.handle(
        _weekStartDayMeta,
        weekStartDay.isAcceptableOrUnknown(
          data['week_start_day']!,
          _weekStartDayMeta,
        ),
      );
    }
    if (data.containsKey('favorite_share')) {
      context.handle(
        _favoriteShareMeta,
        favoriteShare.isAcceptableOrUnknown(
          data['favorite_share']!,
          _favoriteShareMeta,
        ),
      );
    }
    if (data.containsKey('anti_repeat_weeks')) {
      context.handle(
        _antiRepeatWeeksMeta,
        antiRepeatWeeks.isAcceptableOrUnknown(
          data['anti_repeat_weeks']!,
          _antiRepeatWeeksMeta,
        ),
      );
    }
    if (data.containsKey('aisle_order')) {
      context.handle(
        _aisleOrderMeta,
        aisleOrder.isAcceptableOrUnknown(data['aisle_order']!, _aisleOrderMeta),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      onboarded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarded'],
      )!,
      people: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}people'],
      )!,
      diet: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}diet'],
      )!,
      noPork: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}no_pork'],
      )!,
      maxMinWeekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_min_weekday'],
      )!,
      maxMinWeekend: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_min_weekend'],
      )!,
      weekStartDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_start_day'],
      )!,
      favoriteShare: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}favorite_share'],
      )!,
      antiRepeatWeeks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}anti_repeat_weeks'],
      )!,
      aisleOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aisle_order'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class ProfileRow extends DataClass implements Insertable<ProfileRow> {
  final int id;
  final bool onboarded;
  final int people;
  final String diet;
  final bool noPork;
  final int maxMinWeekday;
  final int maxMinWeekend;
  final int weekStartDay;
  final double favoriteShare;
  final int antiRepeatWeeks;
  final String aisleOrder;
  final String themeMode;
  const ProfileRow({
    required this.id,
    required this.onboarded,
    required this.people,
    required this.diet,
    required this.noPork,
    required this.maxMinWeekday,
    required this.maxMinWeekend,
    required this.weekStartDay,
    required this.favoriteShare,
    required this.antiRepeatWeeks,
    required this.aisleOrder,
    required this.themeMode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['onboarded'] = Variable<bool>(onboarded);
    map['people'] = Variable<int>(people);
    map['diet'] = Variable<String>(diet);
    map['no_pork'] = Variable<bool>(noPork);
    map['max_min_weekday'] = Variable<int>(maxMinWeekday);
    map['max_min_weekend'] = Variable<int>(maxMinWeekend);
    map['week_start_day'] = Variable<int>(weekStartDay);
    map['favorite_share'] = Variable<double>(favoriteShare);
    map['anti_repeat_weeks'] = Variable<int>(antiRepeatWeeks);
    map['aisle_order'] = Variable<String>(aisleOrder);
    map['theme_mode'] = Variable<String>(themeMode);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      onboarded: Value(onboarded),
      people: Value(people),
      diet: Value(diet),
      noPork: Value(noPork),
      maxMinWeekday: Value(maxMinWeekday),
      maxMinWeekend: Value(maxMinWeekend),
      weekStartDay: Value(weekStartDay),
      favoriteShare: Value(favoriteShare),
      antiRepeatWeeks: Value(antiRepeatWeeks),
      aisleOrder: Value(aisleOrder),
      themeMode: Value(themeMode),
    );
  }

  factory ProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileRow(
      id: serializer.fromJson<int>(json['id']),
      onboarded: serializer.fromJson<bool>(json['onboarded']),
      people: serializer.fromJson<int>(json['people']),
      diet: serializer.fromJson<String>(json['diet']),
      noPork: serializer.fromJson<bool>(json['noPork']),
      maxMinWeekday: serializer.fromJson<int>(json['maxMinWeekday']),
      maxMinWeekend: serializer.fromJson<int>(json['maxMinWeekend']),
      weekStartDay: serializer.fromJson<int>(json['weekStartDay']),
      favoriteShare: serializer.fromJson<double>(json['favoriteShare']),
      antiRepeatWeeks: serializer.fromJson<int>(json['antiRepeatWeeks']),
      aisleOrder: serializer.fromJson<String>(json['aisleOrder']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onboarded': serializer.toJson<bool>(onboarded),
      'people': serializer.toJson<int>(people),
      'diet': serializer.toJson<String>(diet),
      'noPork': serializer.toJson<bool>(noPork),
      'maxMinWeekday': serializer.toJson<int>(maxMinWeekday),
      'maxMinWeekend': serializer.toJson<int>(maxMinWeekend),
      'weekStartDay': serializer.toJson<int>(weekStartDay),
      'favoriteShare': serializer.toJson<double>(favoriteShare),
      'antiRepeatWeeks': serializer.toJson<int>(antiRepeatWeeks),
      'aisleOrder': serializer.toJson<String>(aisleOrder),
      'themeMode': serializer.toJson<String>(themeMode),
    };
  }

  ProfileRow copyWith({
    int? id,
    bool? onboarded,
    int? people,
    String? diet,
    bool? noPork,
    int? maxMinWeekday,
    int? maxMinWeekend,
    int? weekStartDay,
    double? favoriteShare,
    int? antiRepeatWeeks,
    String? aisleOrder,
    String? themeMode,
  }) => ProfileRow(
    id: id ?? this.id,
    onboarded: onboarded ?? this.onboarded,
    people: people ?? this.people,
    diet: diet ?? this.diet,
    noPork: noPork ?? this.noPork,
    maxMinWeekday: maxMinWeekday ?? this.maxMinWeekday,
    maxMinWeekend: maxMinWeekend ?? this.maxMinWeekend,
    weekStartDay: weekStartDay ?? this.weekStartDay,
    favoriteShare: favoriteShare ?? this.favoriteShare,
    antiRepeatWeeks: antiRepeatWeeks ?? this.antiRepeatWeeks,
    aisleOrder: aisleOrder ?? this.aisleOrder,
    themeMode: themeMode ?? this.themeMode,
  );
  ProfileRow copyWithCompanion(ProfilesCompanion data) {
    return ProfileRow(
      id: data.id.present ? data.id.value : this.id,
      onboarded: data.onboarded.present ? data.onboarded.value : this.onboarded,
      people: data.people.present ? data.people.value : this.people,
      diet: data.diet.present ? data.diet.value : this.diet,
      noPork: data.noPork.present ? data.noPork.value : this.noPork,
      maxMinWeekday: data.maxMinWeekday.present
          ? data.maxMinWeekday.value
          : this.maxMinWeekday,
      maxMinWeekend: data.maxMinWeekend.present
          ? data.maxMinWeekend.value
          : this.maxMinWeekend,
      weekStartDay: data.weekStartDay.present
          ? data.weekStartDay.value
          : this.weekStartDay,
      favoriteShare: data.favoriteShare.present
          ? data.favoriteShare.value
          : this.favoriteShare,
      antiRepeatWeeks: data.antiRepeatWeeks.present
          ? data.antiRepeatWeeks.value
          : this.antiRepeatWeeks,
      aisleOrder: data.aisleOrder.present
          ? data.aisleOrder.value
          : this.aisleOrder,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileRow(')
          ..write('id: $id, ')
          ..write('onboarded: $onboarded, ')
          ..write('people: $people, ')
          ..write('diet: $diet, ')
          ..write('noPork: $noPork, ')
          ..write('maxMinWeekday: $maxMinWeekday, ')
          ..write('maxMinWeekend: $maxMinWeekend, ')
          ..write('weekStartDay: $weekStartDay, ')
          ..write('favoriteShare: $favoriteShare, ')
          ..write('antiRepeatWeeks: $antiRepeatWeeks, ')
          ..write('aisleOrder: $aisleOrder, ')
          ..write('themeMode: $themeMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    onboarded,
    people,
    diet,
    noPork,
    maxMinWeekday,
    maxMinWeekend,
    weekStartDay,
    favoriteShare,
    antiRepeatWeeks,
    aisleOrder,
    themeMode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileRow &&
          other.id == this.id &&
          other.onboarded == this.onboarded &&
          other.people == this.people &&
          other.diet == this.diet &&
          other.noPork == this.noPork &&
          other.maxMinWeekday == this.maxMinWeekday &&
          other.maxMinWeekend == this.maxMinWeekend &&
          other.weekStartDay == this.weekStartDay &&
          other.favoriteShare == this.favoriteShare &&
          other.antiRepeatWeeks == this.antiRepeatWeeks &&
          other.aisleOrder == this.aisleOrder &&
          other.themeMode == this.themeMode);
}

class ProfilesCompanion extends UpdateCompanion<ProfileRow> {
  final Value<int> id;
  final Value<bool> onboarded;
  final Value<int> people;
  final Value<String> diet;
  final Value<bool> noPork;
  final Value<int> maxMinWeekday;
  final Value<int> maxMinWeekend;
  final Value<int> weekStartDay;
  final Value<double> favoriteShare;
  final Value<int> antiRepeatWeeks;
  final Value<String> aisleOrder;
  final Value<String> themeMode;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.onboarded = const Value.absent(),
    this.people = const Value.absent(),
    this.diet = const Value.absent(),
    this.noPork = const Value.absent(),
    this.maxMinWeekday = const Value.absent(),
    this.maxMinWeekend = const Value.absent(),
    this.weekStartDay = const Value.absent(),
    this.favoriteShare = const Value.absent(),
    this.antiRepeatWeeks = const Value.absent(),
    this.aisleOrder = const Value.absent(),
    this.themeMode = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.onboarded = const Value.absent(),
    this.people = const Value.absent(),
    this.diet = const Value.absent(),
    this.noPork = const Value.absent(),
    this.maxMinWeekday = const Value.absent(),
    this.maxMinWeekend = const Value.absent(),
    this.weekStartDay = const Value.absent(),
    this.favoriteShare = const Value.absent(),
    this.antiRepeatWeeks = const Value.absent(),
    this.aisleOrder = const Value.absent(),
    this.themeMode = const Value.absent(),
  });
  static Insertable<ProfileRow> custom({
    Expression<int>? id,
    Expression<bool>? onboarded,
    Expression<int>? people,
    Expression<String>? diet,
    Expression<bool>? noPork,
    Expression<int>? maxMinWeekday,
    Expression<int>? maxMinWeekend,
    Expression<int>? weekStartDay,
    Expression<double>? favoriteShare,
    Expression<int>? antiRepeatWeeks,
    Expression<String>? aisleOrder,
    Expression<String>? themeMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onboarded != null) 'onboarded': onboarded,
      if (people != null) 'people': people,
      if (diet != null) 'diet': diet,
      if (noPork != null) 'no_pork': noPork,
      if (maxMinWeekday != null) 'max_min_weekday': maxMinWeekday,
      if (maxMinWeekend != null) 'max_min_weekend': maxMinWeekend,
      if (weekStartDay != null) 'week_start_day': weekStartDay,
      if (favoriteShare != null) 'favorite_share': favoriteShare,
      if (antiRepeatWeeks != null) 'anti_repeat_weeks': antiRepeatWeeks,
      if (aisleOrder != null) 'aisle_order': aisleOrder,
      if (themeMode != null) 'theme_mode': themeMode,
    });
  }

  ProfilesCompanion copyWith({
    Value<int>? id,
    Value<bool>? onboarded,
    Value<int>? people,
    Value<String>? diet,
    Value<bool>? noPork,
    Value<int>? maxMinWeekday,
    Value<int>? maxMinWeekend,
    Value<int>? weekStartDay,
    Value<double>? favoriteShare,
    Value<int>? antiRepeatWeeks,
    Value<String>? aisleOrder,
    Value<String>? themeMode,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      onboarded: onboarded ?? this.onboarded,
      people: people ?? this.people,
      diet: diet ?? this.diet,
      noPork: noPork ?? this.noPork,
      maxMinWeekday: maxMinWeekday ?? this.maxMinWeekday,
      maxMinWeekend: maxMinWeekend ?? this.maxMinWeekend,
      weekStartDay: weekStartDay ?? this.weekStartDay,
      favoriteShare: favoriteShare ?? this.favoriteShare,
      antiRepeatWeeks: antiRepeatWeeks ?? this.antiRepeatWeeks,
      aisleOrder: aisleOrder ?? this.aisleOrder,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onboarded.present) {
      map['onboarded'] = Variable<bool>(onboarded.value);
    }
    if (people.present) {
      map['people'] = Variable<int>(people.value);
    }
    if (diet.present) {
      map['diet'] = Variable<String>(diet.value);
    }
    if (noPork.present) {
      map['no_pork'] = Variable<bool>(noPork.value);
    }
    if (maxMinWeekday.present) {
      map['max_min_weekday'] = Variable<int>(maxMinWeekday.value);
    }
    if (maxMinWeekend.present) {
      map['max_min_weekend'] = Variable<int>(maxMinWeekend.value);
    }
    if (weekStartDay.present) {
      map['week_start_day'] = Variable<int>(weekStartDay.value);
    }
    if (favoriteShare.present) {
      map['favorite_share'] = Variable<double>(favoriteShare.value);
    }
    if (antiRepeatWeeks.present) {
      map['anti_repeat_weeks'] = Variable<int>(antiRepeatWeeks.value);
    }
    if (aisleOrder.present) {
      map['aisle_order'] = Variable<String>(aisleOrder.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('onboarded: $onboarded, ')
          ..write('people: $people, ')
          ..write('diet: $diet, ')
          ..write('noPork: $noPork, ')
          ..write('maxMinWeekday: $maxMinWeekday, ')
          ..write('maxMinWeekend: $maxMinWeekend, ')
          ..write('weekStartDay: $weekStartDay, ')
          ..write('favoriteShare: $favoriteShare, ')
          ..write('antiRepeatWeeks: $antiRepeatWeeks, ')
          ..write('aisleOrder: $aisleOrder, ')
          ..write('themeMode: $themeMode')
          ..write(')'))
        .toString();
  }
}

class $ProfileAversionsTable extends ProfileAversions
    with TableInfo<$ProfileAversionsTable, ProfileAversionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileAversionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<String> ingredientId = GeneratedColumn<String>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [ingredientId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_aversions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileAversionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ingredientId};
  @override
  ProfileAversionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileAversionRow(
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_id'],
      )!,
    );
  }

  @override
  $ProfileAversionsTable createAlias(String alias) {
    return $ProfileAversionsTable(attachedDatabase, alias);
  }
}

class ProfileAversionRow extends DataClass
    implements Insertable<ProfileAversionRow> {
  final String ingredientId;
  const ProfileAversionRow({required this.ingredientId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ingredient_id'] = Variable<String>(ingredientId);
    return map;
  }

  ProfileAversionsCompanion toCompanion(bool nullToAbsent) {
    return ProfileAversionsCompanion(ingredientId: Value(ingredientId));
  }

  factory ProfileAversionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileAversionRow(
      ingredientId: serializer.fromJson<String>(json['ingredientId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ingredientId': serializer.toJson<String>(ingredientId),
    };
  }

  ProfileAversionRow copyWith({String? ingredientId}) =>
      ProfileAversionRow(ingredientId: ingredientId ?? this.ingredientId);
  ProfileAversionRow copyWithCompanion(ProfileAversionsCompanion data) {
    return ProfileAversionRow(
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileAversionRow(')
          ..write('ingredientId: $ingredientId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => ingredientId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileAversionRow && other.ingredientId == this.ingredientId);
}

class ProfileAversionsCompanion extends UpdateCompanion<ProfileAversionRow> {
  final Value<String> ingredientId;
  final Value<int> rowid;
  const ProfileAversionsCompanion({
    this.ingredientId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileAversionsCompanion.insert({
    required String ingredientId,
    this.rowid = const Value.absent(),
  }) : ingredientId = Value(ingredientId);
  static Insertable<ProfileAversionRow> custom({
    Expression<String>? ingredientId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileAversionsCompanion copyWith({
    Value<String>? ingredientId,
    Value<int>? rowid,
  }) {
    return ProfileAversionsCompanion(
      ingredientId: ingredientId ?? this.ingredientId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<String>(ingredientId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileAversionsCompanion(')
          ..write('ingredientId: $ingredientId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfileExclusionsTable extends ProfileExclusions
    with TableInfo<$ProfileExclusionsTable, ProfileExclusionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileExclusionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _allergenMeta = const VerificationMeta(
    'allergen',
  );
  @override
  late final GeneratedColumn<String> allergen = GeneratedColumn<String>(
    'allergen',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [allergen];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_exclusions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileExclusionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('allergen')) {
      context.handle(
        _allergenMeta,
        allergen.isAcceptableOrUnknown(data['allergen']!, _allergenMeta),
      );
    } else if (isInserting) {
      context.missing(_allergenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {allergen};
  @override
  ProfileExclusionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileExclusionRow(
      allergen: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allergen'],
      )!,
    );
  }

  @override
  $ProfileExclusionsTable createAlias(String alias) {
    return $ProfileExclusionsTable(attachedDatabase, alias);
  }
}

class ProfileExclusionRow extends DataClass
    implements Insertable<ProfileExclusionRow> {
  final String allergen;
  const ProfileExclusionRow({required this.allergen});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['allergen'] = Variable<String>(allergen);
    return map;
  }

  ProfileExclusionsCompanion toCompanion(bool nullToAbsent) {
    return ProfileExclusionsCompanion(allergen: Value(allergen));
  }

  factory ProfileExclusionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileExclusionRow(
      allergen: serializer.fromJson<String>(json['allergen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'allergen': serializer.toJson<String>(allergen)};
  }

  ProfileExclusionRow copyWith({String? allergen}) =>
      ProfileExclusionRow(allergen: allergen ?? this.allergen);
  ProfileExclusionRow copyWithCompanion(ProfileExclusionsCompanion data) {
    return ProfileExclusionRow(
      allergen: data.allergen.present ? data.allergen.value : this.allergen,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileExclusionRow(')
          ..write('allergen: $allergen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => allergen.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileExclusionRow && other.allergen == this.allergen);
}

class ProfileExclusionsCompanion extends UpdateCompanion<ProfileExclusionRow> {
  final Value<String> allergen;
  final Value<int> rowid;
  const ProfileExclusionsCompanion({
    this.allergen = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileExclusionsCompanion.insert({
    required String allergen,
    this.rowid = const Value.absent(),
  }) : allergen = Value(allergen);
  static Insertable<ProfileExclusionRow> custom({
    Expression<String>? allergen,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (allergen != null) 'allergen': allergen,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileExclusionsCompanion copyWith({
    Value<String>? allergen,
    Value<int>? rowid,
  }) {
    return ProfileExclusionsCompanion(
      allergen: allergen ?? this.allergen,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (allergen.present) {
      map['allergen'] = Variable<String>(allergen.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileExclusionsCompanion(')
          ..write('allergen: $allergen, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfileEquipmentTable extends ProfileEquipment
    with TableInfo<$ProfileEquipmentTable, ProfileEquipmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileEquipmentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _equipmentMeta = const VerificationMeta(
    'equipment',
  );
  @override
  late final GeneratedColumn<String> equipment = GeneratedColumn<String>(
    'equipment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [equipment];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_equipment';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileEquipmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('equipment')) {
      context.handle(
        _equipmentMeta,
        equipment.isAcceptableOrUnknown(data['equipment']!, _equipmentMeta),
      );
    } else if (isInserting) {
      context.missing(_equipmentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {equipment};
  @override
  ProfileEquipmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileEquipmentRow(
      equipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment'],
      )!,
    );
  }

  @override
  $ProfileEquipmentTable createAlias(String alias) {
    return $ProfileEquipmentTable(attachedDatabase, alias);
  }
}

class ProfileEquipmentRow extends DataClass
    implements Insertable<ProfileEquipmentRow> {
  final String equipment;
  const ProfileEquipmentRow({required this.equipment});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['equipment'] = Variable<String>(equipment);
    return map;
  }

  ProfileEquipmentCompanion toCompanion(bool nullToAbsent) {
    return ProfileEquipmentCompanion(equipment: Value(equipment));
  }

  factory ProfileEquipmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileEquipmentRow(
      equipment: serializer.fromJson<String>(json['equipment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'equipment': serializer.toJson<String>(equipment)};
  }

  ProfileEquipmentRow copyWith({String? equipment}) =>
      ProfileEquipmentRow(equipment: equipment ?? this.equipment);
  ProfileEquipmentRow copyWithCompanion(ProfileEquipmentCompanion data) {
    return ProfileEquipmentRow(
      equipment: data.equipment.present ? data.equipment.value : this.equipment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileEquipmentRow(')
          ..write('equipment: $equipment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => equipment.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileEquipmentRow && other.equipment == this.equipment);
}

class ProfileEquipmentCompanion extends UpdateCompanion<ProfileEquipmentRow> {
  final Value<String> equipment;
  final Value<int> rowid;
  const ProfileEquipmentCompanion({
    this.equipment = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileEquipmentCompanion.insert({
    required String equipment,
    this.rowid = const Value.absent(),
  }) : equipment = Value(equipment);
  static Insertable<ProfileEquipmentRow> custom({
    Expression<String>? equipment,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (equipment != null) 'equipment': equipment,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileEquipmentCompanion copyWith({
    Value<String>? equipment,
    Value<int>? rowid,
  }) {
    return ProfileEquipmentCompanion(
      equipment: equipment ?? this.equipment,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (equipment.present) {
      map['equipment'] = Variable<String>(equipment.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileEquipmentCompanion(')
          ..write('equipment: $equipment, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfileSlotsTable extends ProfileSlots
    with TableInfo<$ProfileSlotsTable, ProfileSlotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileSlotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<int> day = GeneratedColumn<int>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealMeta = const VerificationMeta('meal');
  @override
  late final GeneratedColumn<String> meal = GeneratedColumn<String>(
    'meal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [day, meal];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_slots';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileSlotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('meal')) {
      context.handle(
        _mealMeta,
        meal.isAcceptableOrUnknown(data['meal']!, _mealMeta),
      );
    } else if (isInserting) {
      context.missing(_mealMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {day, meal};
  @override
  ProfileSlotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileSlotRow(
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day'],
      )!,
      meal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal'],
      )!,
    );
  }

  @override
  $ProfileSlotsTable createAlias(String alias) {
    return $ProfileSlotsTable(attachedDatabase, alias);
  }
}

class ProfileSlotRow extends DataClass implements Insertable<ProfileSlotRow> {
  final int day;
  final String meal;
  const ProfileSlotRow({required this.day, required this.meal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day'] = Variable<int>(day);
    map['meal'] = Variable<String>(meal);
    return map;
  }

  ProfileSlotsCompanion toCompanion(bool nullToAbsent) {
    return ProfileSlotsCompanion(day: Value(day), meal: Value(meal));
  }

  factory ProfileSlotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileSlotRow(
      day: serializer.fromJson<int>(json['day']),
      meal: serializer.fromJson<String>(json['meal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'day': serializer.toJson<int>(day),
      'meal': serializer.toJson<String>(meal),
    };
  }

  ProfileSlotRow copyWith({int? day, String? meal}) =>
      ProfileSlotRow(day: day ?? this.day, meal: meal ?? this.meal);
  ProfileSlotRow copyWithCompanion(ProfileSlotsCompanion data) {
    return ProfileSlotRow(
      day: data.day.present ? data.day.value : this.day,
      meal: data.meal.present ? data.meal.value : this.meal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileSlotRow(')
          ..write('day: $day, ')
          ..write('meal: $meal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(day, meal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileSlotRow &&
          other.day == this.day &&
          other.meal == this.meal);
}

class ProfileSlotsCompanion extends UpdateCompanion<ProfileSlotRow> {
  final Value<int> day;
  final Value<String> meal;
  final Value<int> rowid;
  const ProfileSlotsCompanion({
    this.day = const Value.absent(),
    this.meal = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileSlotsCompanion.insert({
    required int day,
    required String meal,
    this.rowid = const Value.absent(),
  }) : day = Value(day),
       meal = Value(meal);
  static Insertable<ProfileSlotRow> custom({
    Expression<int>? day,
    Expression<String>? meal,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (day != null) 'day': day,
      if (meal != null) 'meal': meal,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileSlotsCompanion copyWith({
    Value<int>? day,
    Value<String>? meal,
    Value<int>? rowid,
  }) {
    return ProfileSlotsCompanion(
      day: day ?? this.day,
      meal: meal ?? this.meal,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (day.present) {
      map['day'] = Variable<int>(day.value);
    }
    if (meal.present) {
      map['meal'] = Variable<String>(meal.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileSlotsCompanion(')
          ..write('day: $day, ')
          ..write('meal: $meal, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeekMenusTable extends WeekMenus
    with TableInfo<$WeekMenusTable, WeekMenuRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeekMenusTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _seedMeta = const VerificationMeta('seed');
  @override
  late final GeneratedColumn<int> seed = GeneratedColumn<int>(
    'seed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, startDate, status, seed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'week_menus';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeekMenuRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('seed')) {
      context.handle(
        _seedMeta,
        seed.isAcceptableOrUnknown(data['seed']!, _seedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeekMenuRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeekMenuRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      seed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seed'],
      )!,
    );
  }

  @override
  $WeekMenusTable createAlias(String alias) {
    return $WeekMenusTable(attachedDatabase, alias);
  }
}

class WeekMenuRow extends DataClass implements Insertable<WeekMenuRow> {
  final int id;
  final DateTime startDate;
  final String status;
  final int seed;
  const WeekMenuRow({
    required this.id,
    required this.startDate,
    required this.status,
    required this.seed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_date'] = Variable<DateTime>(startDate);
    map['status'] = Variable<String>(status);
    map['seed'] = Variable<int>(seed);
    return map;
  }

  WeekMenusCompanion toCompanion(bool nullToAbsent) {
    return WeekMenusCompanion(
      id: Value(id),
      startDate: Value(startDate),
      status: Value(status),
      seed: Value(seed),
    );
  }

  factory WeekMenuRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeekMenuRow(
      id: serializer.fromJson<int>(json['id']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      status: serializer.fromJson<String>(json['status']),
      seed: serializer.fromJson<int>(json['seed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startDate': serializer.toJson<DateTime>(startDate),
      'status': serializer.toJson<String>(status),
      'seed': serializer.toJson<int>(seed),
    };
  }

  WeekMenuRow copyWith({
    int? id,
    DateTime? startDate,
    String? status,
    int? seed,
  }) => WeekMenuRow(
    id: id ?? this.id,
    startDate: startDate ?? this.startDate,
    status: status ?? this.status,
    seed: seed ?? this.seed,
  );
  WeekMenuRow copyWithCompanion(WeekMenusCompanion data) {
    return WeekMenuRow(
      id: data.id.present ? data.id.value : this.id,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      status: data.status.present ? data.status.value : this.status,
      seed: data.seed.present ? data.seed.value : this.seed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeekMenuRow(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('status: $status, ')
          ..write('seed: $seed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startDate, status, seed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeekMenuRow &&
          other.id == this.id &&
          other.startDate == this.startDate &&
          other.status == this.status &&
          other.seed == this.seed);
}

class WeekMenusCompanion extends UpdateCompanion<WeekMenuRow> {
  final Value<int> id;
  final Value<DateTime> startDate;
  final Value<String> status;
  final Value<int> seed;
  const WeekMenusCompanion({
    this.id = const Value.absent(),
    this.startDate = const Value.absent(),
    this.status = const Value.absent(),
    this.seed = const Value.absent(),
  });
  WeekMenusCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startDate,
    this.status = const Value.absent(),
    this.seed = const Value.absent(),
  }) : startDate = Value(startDate);
  static Insertable<WeekMenuRow> custom({
    Expression<int>? id,
    Expression<DateTime>? startDate,
    Expression<String>? status,
    Expression<int>? seed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startDate != null) 'start_date': startDate,
      if (status != null) 'status': status,
      if (seed != null) 'seed': seed,
    });
  }

  WeekMenusCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? startDate,
    Value<String>? status,
    Value<int>? seed,
  }) {
    return WeekMenusCompanion(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      status: status ?? this.status,
      seed: seed ?? this.seed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (seed.present) {
      map['seed'] = Variable<int>(seed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeekMenusCompanion(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('status: $status, ')
          ..write('seed: $seed')
          ..write(')'))
        .toString();
  }
}

class $MenuSlotsTable extends MenuSlots
    with TableInfo<$MenuSlotsTable, MenuSlotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuSlotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _menuIdMeta = const VerificationMeta('menuId');
  @override
  late final GeneratedColumn<int> menuId = GeneratedColumn<int>(
    'menu_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES week_menus (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<int> day = GeneratedColumn<int>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealMeta = const VerificationMeta('meal');
  @override
  late final GeneratedColumn<String> meal = GeneratedColumn<String>(
    'meal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id)',
    ),
  );
  static const VerificationMeta _servingsMeta = const VerificationMeta(
    'servings',
  );
  @override
  late final GeneratedColumn<int> servings = GeneratedColumn<int>(
    'servings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lockedMeta = const VerificationMeta('locked');
  @override
  late final GeneratedColumn<bool> locked = GeneratedColumn<bool>(
    'locked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("locked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _leftoversFromMeta = const VerificationMeta(
    'leftoversFrom',
  );
  @override
  late final GeneratedColumn<String> leftoversFrom = GeneratedColumn<String>(
    'leftovers_from',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    menuId,
    day,
    meal,
    kind,
    recipeId,
    servings,
    locked,
    leftoversFrom,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_slots';
  @override
  VerificationContext validateIntegrity(
    Insertable<MenuSlotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('menu_id')) {
      context.handle(
        _menuIdMeta,
        menuId.isAcceptableOrUnknown(data['menu_id']!, _menuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_menuIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('meal')) {
      context.handle(
        _mealMeta,
        meal.isAcceptableOrUnknown(data['meal']!, _mealMeta),
      );
    } else if (isInserting) {
      context.missing(_mealMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    }
    if (data.containsKey('servings')) {
      context.handle(
        _servingsMeta,
        servings.isAcceptableOrUnknown(data['servings']!, _servingsMeta),
      );
    } else if (isInserting) {
      context.missing(_servingsMeta);
    }
    if (data.containsKey('locked')) {
      context.handle(
        _lockedMeta,
        locked.isAcceptableOrUnknown(data['locked']!, _lockedMeta),
      );
    }
    if (data.containsKey('leftovers_from')) {
      context.handle(
        _leftoversFromMeta,
        leftoversFrom.isAcceptableOrUnknown(
          data['leftovers_from']!,
          _leftoversFromMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {menuId, day, meal},
  ];
  @override
  MenuSlotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuSlotRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      menuId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}menu_id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day'],
      )!,
      meal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      ),
      servings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servings'],
      )!,
      locked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}locked'],
      )!,
      leftoversFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}leftovers_from'],
      ),
    );
  }

  @override
  $MenuSlotsTable createAlias(String alias) {
    return $MenuSlotsTable(attachedDatabase, alias);
  }
}

class MenuSlotRow extends DataClass implements Insertable<MenuSlotRow> {
  final int id;
  final int menuId;
  final int day;
  final String meal;
  final String kind;
  final int? recipeId;
  final int servings;
  final bool locked;

  /// Créneau source des restes, codé « jour:repas » dans le même menu.
  final String? leftoversFrom;
  const MenuSlotRow({
    required this.id,
    required this.menuId,
    required this.day,
    required this.meal,
    required this.kind,
    this.recipeId,
    required this.servings,
    required this.locked,
    this.leftoversFrom,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['menu_id'] = Variable<int>(menuId);
    map['day'] = Variable<int>(day);
    map['meal'] = Variable<String>(meal);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || recipeId != null) {
      map['recipe_id'] = Variable<int>(recipeId);
    }
    map['servings'] = Variable<int>(servings);
    map['locked'] = Variable<bool>(locked);
    if (!nullToAbsent || leftoversFrom != null) {
      map['leftovers_from'] = Variable<String>(leftoversFrom);
    }
    return map;
  }

  MenuSlotsCompanion toCompanion(bool nullToAbsent) {
    return MenuSlotsCompanion(
      id: Value(id),
      menuId: Value(menuId),
      day: Value(day),
      meal: Value(meal),
      kind: Value(kind),
      recipeId: recipeId == null && nullToAbsent
          ? const Value.absent()
          : Value(recipeId),
      servings: Value(servings),
      locked: Value(locked),
      leftoversFrom: leftoversFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(leftoversFrom),
    );
  }

  factory MenuSlotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuSlotRow(
      id: serializer.fromJson<int>(json['id']),
      menuId: serializer.fromJson<int>(json['menuId']),
      day: serializer.fromJson<int>(json['day']),
      meal: serializer.fromJson<String>(json['meal']),
      kind: serializer.fromJson<String>(json['kind']),
      recipeId: serializer.fromJson<int?>(json['recipeId']),
      servings: serializer.fromJson<int>(json['servings']),
      locked: serializer.fromJson<bool>(json['locked']),
      leftoversFrom: serializer.fromJson<String?>(json['leftoversFrom']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'menuId': serializer.toJson<int>(menuId),
      'day': serializer.toJson<int>(day),
      'meal': serializer.toJson<String>(meal),
      'kind': serializer.toJson<String>(kind),
      'recipeId': serializer.toJson<int?>(recipeId),
      'servings': serializer.toJson<int>(servings),
      'locked': serializer.toJson<bool>(locked),
      'leftoversFrom': serializer.toJson<String?>(leftoversFrom),
    };
  }

  MenuSlotRow copyWith({
    int? id,
    int? menuId,
    int? day,
    String? meal,
    String? kind,
    Value<int?> recipeId = const Value.absent(),
    int? servings,
    bool? locked,
    Value<String?> leftoversFrom = const Value.absent(),
  }) => MenuSlotRow(
    id: id ?? this.id,
    menuId: menuId ?? this.menuId,
    day: day ?? this.day,
    meal: meal ?? this.meal,
    kind: kind ?? this.kind,
    recipeId: recipeId.present ? recipeId.value : this.recipeId,
    servings: servings ?? this.servings,
    locked: locked ?? this.locked,
    leftoversFrom: leftoversFrom.present
        ? leftoversFrom.value
        : this.leftoversFrom,
  );
  MenuSlotRow copyWithCompanion(MenuSlotsCompanion data) {
    return MenuSlotRow(
      id: data.id.present ? data.id.value : this.id,
      menuId: data.menuId.present ? data.menuId.value : this.menuId,
      day: data.day.present ? data.day.value : this.day,
      meal: data.meal.present ? data.meal.value : this.meal,
      kind: data.kind.present ? data.kind.value : this.kind,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      servings: data.servings.present ? data.servings.value : this.servings,
      locked: data.locked.present ? data.locked.value : this.locked,
      leftoversFrom: data.leftoversFrom.present
          ? data.leftoversFrom.value
          : this.leftoversFrom,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuSlotRow(')
          ..write('id: $id, ')
          ..write('menuId: $menuId, ')
          ..write('day: $day, ')
          ..write('meal: $meal, ')
          ..write('kind: $kind, ')
          ..write('recipeId: $recipeId, ')
          ..write('servings: $servings, ')
          ..write('locked: $locked, ')
          ..write('leftoversFrom: $leftoversFrom')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    menuId,
    day,
    meal,
    kind,
    recipeId,
    servings,
    locked,
    leftoversFrom,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuSlotRow &&
          other.id == this.id &&
          other.menuId == this.menuId &&
          other.day == this.day &&
          other.meal == this.meal &&
          other.kind == this.kind &&
          other.recipeId == this.recipeId &&
          other.servings == this.servings &&
          other.locked == this.locked &&
          other.leftoversFrom == this.leftoversFrom);
}

class MenuSlotsCompanion extends UpdateCompanion<MenuSlotRow> {
  final Value<int> id;
  final Value<int> menuId;
  final Value<int> day;
  final Value<String> meal;
  final Value<String> kind;
  final Value<int?> recipeId;
  final Value<int> servings;
  final Value<bool> locked;
  final Value<String?> leftoversFrom;
  const MenuSlotsCompanion({
    this.id = const Value.absent(),
    this.menuId = const Value.absent(),
    this.day = const Value.absent(),
    this.meal = const Value.absent(),
    this.kind = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.servings = const Value.absent(),
    this.locked = const Value.absent(),
    this.leftoversFrom = const Value.absent(),
  });
  MenuSlotsCompanion.insert({
    this.id = const Value.absent(),
    required int menuId,
    required int day,
    required String meal,
    required String kind,
    this.recipeId = const Value.absent(),
    required int servings,
    this.locked = const Value.absent(),
    this.leftoversFrom = const Value.absent(),
  }) : menuId = Value(menuId),
       day = Value(day),
       meal = Value(meal),
       kind = Value(kind),
       servings = Value(servings);
  static Insertable<MenuSlotRow> custom({
    Expression<int>? id,
    Expression<int>? menuId,
    Expression<int>? day,
    Expression<String>? meal,
    Expression<String>? kind,
    Expression<int>? recipeId,
    Expression<int>? servings,
    Expression<bool>? locked,
    Expression<String>? leftoversFrom,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (menuId != null) 'menu_id': menuId,
      if (day != null) 'day': day,
      if (meal != null) 'meal': meal,
      if (kind != null) 'kind': kind,
      if (recipeId != null) 'recipe_id': recipeId,
      if (servings != null) 'servings': servings,
      if (locked != null) 'locked': locked,
      if (leftoversFrom != null) 'leftovers_from': leftoversFrom,
    });
  }

  MenuSlotsCompanion copyWith({
    Value<int>? id,
    Value<int>? menuId,
    Value<int>? day,
    Value<String>? meal,
    Value<String>? kind,
    Value<int?>? recipeId,
    Value<int>? servings,
    Value<bool>? locked,
    Value<String?>? leftoversFrom,
  }) {
    return MenuSlotsCompanion(
      id: id ?? this.id,
      menuId: menuId ?? this.menuId,
      day: day ?? this.day,
      meal: meal ?? this.meal,
      kind: kind ?? this.kind,
      recipeId: recipeId ?? this.recipeId,
      servings: servings ?? this.servings,
      locked: locked ?? this.locked,
      leftoversFrom: leftoversFrom ?? this.leftoversFrom,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (menuId.present) {
      map['menu_id'] = Variable<int>(menuId.value);
    }
    if (day.present) {
      map['day'] = Variable<int>(day.value);
    }
    if (meal.present) {
      map['meal'] = Variable<String>(meal.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (servings.present) {
      map['servings'] = Variable<int>(servings.value);
    }
    if (locked.present) {
      map['locked'] = Variable<bool>(locked.value);
    }
    if (leftoversFrom.present) {
      map['leftovers_from'] = Variable<String>(leftoversFrom.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenuSlotsCompanion(')
          ..write('id: $id, ')
          ..write('menuId: $menuId, ')
          ..write('day: $day, ')
          ..write('meal: $meal, ')
          ..write('kind: $kind, ')
          ..write('recipeId: $recipeId, ')
          ..write('servings: $servings, ')
          ..write('locked: $locked, ')
          ..write('leftoversFrom: $leftoversFrom')
          ..write(')'))
        .toString();
  }
}

class $WeekExtrasTable extends WeekExtras
    with TableInfo<$WeekExtrasTable, WeekExtraRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeekExtrasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _menuIdMeta = const VerificationMeta('menuId');
  @override
  late final GeneratedColumn<int> menuId = GeneratedColumn<int>(
    'menu_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES week_menus (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id)',
    ),
  );
  static const VerificationMeta _servingsMeta = const VerificationMeta(
    'servings',
  );
  @override
  late final GeneratedColumn<int> servings = GeneratedColumn<int>(
    'servings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, menuId, recipeId, servings];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'week_extras';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeekExtraRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('menu_id')) {
      context.handle(
        _menuIdMeta,
        menuId.isAcceptableOrUnknown(data['menu_id']!, _menuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_menuIdMeta);
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('servings')) {
      context.handle(
        _servingsMeta,
        servings.isAcceptableOrUnknown(data['servings']!, _servingsMeta),
      );
    } else if (isInserting) {
      context.missing(_servingsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeekExtraRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeekExtraRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      menuId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}menu_id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      servings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servings'],
      )!,
    );
  }

  @override
  $WeekExtrasTable createAlias(String alias) {
    return $WeekExtrasTable(attachedDatabase, alias);
  }
}

class WeekExtraRow extends DataClass implements Insertable<WeekExtraRow> {
  final int id;
  final int menuId;
  final int recipeId;
  final int servings;
  const WeekExtraRow({
    required this.id,
    required this.menuId,
    required this.recipeId,
    required this.servings,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['menu_id'] = Variable<int>(menuId);
    map['recipe_id'] = Variable<int>(recipeId);
    map['servings'] = Variable<int>(servings);
    return map;
  }

  WeekExtrasCompanion toCompanion(bool nullToAbsent) {
    return WeekExtrasCompanion(
      id: Value(id),
      menuId: Value(menuId),
      recipeId: Value(recipeId),
      servings: Value(servings),
    );
  }

  factory WeekExtraRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeekExtraRow(
      id: serializer.fromJson<int>(json['id']),
      menuId: serializer.fromJson<int>(json['menuId']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      servings: serializer.fromJson<int>(json['servings']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'menuId': serializer.toJson<int>(menuId),
      'recipeId': serializer.toJson<int>(recipeId),
      'servings': serializer.toJson<int>(servings),
    };
  }

  WeekExtraRow copyWith({int? id, int? menuId, int? recipeId, int? servings}) =>
      WeekExtraRow(
        id: id ?? this.id,
        menuId: menuId ?? this.menuId,
        recipeId: recipeId ?? this.recipeId,
        servings: servings ?? this.servings,
      );
  WeekExtraRow copyWithCompanion(WeekExtrasCompanion data) {
    return WeekExtraRow(
      id: data.id.present ? data.id.value : this.id,
      menuId: data.menuId.present ? data.menuId.value : this.menuId,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      servings: data.servings.present ? data.servings.value : this.servings,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeekExtraRow(')
          ..write('id: $id, ')
          ..write('menuId: $menuId, ')
          ..write('recipeId: $recipeId, ')
          ..write('servings: $servings')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, menuId, recipeId, servings);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeekExtraRow &&
          other.id == this.id &&
          other.menuId == this.menuId &&
          other.recipeId == this.recipeId &&
          other.servings == this.servings);
}

class WeekExtrasCompanion extends UpdateCompanion<WeekExtraRow> {
  final Value<int> id;
  final Value<int> menuId;
  final Value<int> recipeId;
  final Value<int> servings;
  const WeekExtrasCompanion({
    this.id = const Value.absent(),
    this.menuId = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.servings = const Value.absent(),
  });
  WeekExtrasCompanion.insert({
    this.id = const Value.absent(),
    required int menuId,
    required int recipeId,
    required int servings,
  }) : menuId = Value(menuId),
       recipeId = Value(recipeId),
       servings = Value(servings);
  static Insertable<WeekExtraRow> custom({
    Expression<int>? id,
    Expression<int>? menuId,
    Expression<int>? recipeId,
    Expression<int>? servings,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (menuId != null) 'menu_id': menuId,
      if (recipeId != null) 'recipe_id': recipeId,
      if (servings != null) 'servings': servings,
    });
  }

  WeekExtrasCompanion copyWith({
    Value<int>? id,
    Value<int>? menuId,
    Value<int>? recipeId,
    Value<int>? servings,
  }) {
    return WeekExtrasCompanion(
      id: id ?? this.id,
      menuId: menuId ?? this.menuId,
      recipeId: recipeId ?? this.recipeId,
      servings: servings ?? this.servings,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (menuId.present) {
      map['menu_id'] = Variable<int>(menuId.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (servings.present) {
      map['servings'] = Variable<int>(servings.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeekExtrasCompanion(')
          ..write('id: $id, ')
          ..write('menuId: $menuId, ')
          ..write('recipeId: $recipeId, ')
          ..write('servings: $servings')
          ..write(')'))
        .toString();
  }
}

class $ShoppingItemsTable extends ShoppingItems
    with TableInfo<$ShoppingItemsTable, ShoppingItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShoppingItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _menuIdMeta = const VerificationMeta('menuId');
  @override
  late final GeneratedColumn<int> menuId = GeneratedColumn<int>(
    'menu_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES week_menus (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<String> ingredientId = GeneratedColumn<String>(
    'ingredient_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id)',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _boughtMeta = const VerificationMeta('bought');
  @override
  late final GeneratedColumn<bool> bought = GeneratedColumn<bool>(
    'bought',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("bought" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _atHomeMeta = const VerificationMeta('atHome');
  @override
  late final GeneratedColumn<bool> atHome = GeneratedColumn<bool>(
    'at_home',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("at_home" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _manualMeta = const VerificationMeta('manual');
  @override
  late final GeneratedColumn<bool> manual = GeneratedColumn<bool>(
    'manual',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("manual" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    menuId,
    ingredientId,
    label,
    quantity,
    unit,
    bought,
    atHome,
    manual,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shopping_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShoppingItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('menu_id')) {
      context.handle(
        _menuIdMeta,
        menuId.isAcceptableOrUnknown(data['menu_id']!, _menuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_menuIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('bought')) {
      context.handle(
        _boughtMeta,
        bought.isAcceptableOrUnknown(data['bought']!, _boughtMeta),
      );
    }
    if (data.containsKey('at_home')) {
      context.handle(
        _atHomeMeta,
        atHome.isAcceptableOrUnknown(data['at_home']!, _atHomeMeta),
      );
    }
    if (data.containsKey('manual')) {
      context.handle(
        _manualMeta,
        manual.isAcceptableOrUnknown(data['manual']!, _manualMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShoppingItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShoppingItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      menuId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}menu_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_id'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      bought: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}bought'],
      )!,
      atHome: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}at_home'],
      )!,
      manual: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}manual'],
      )!,
    );
  }

  @override
  $ShoppingItemsTable createAlias(String alias) {
    return $ShoppingItemsTable(attachedDatabase, alias);
  }
}

class ShoppingItemRow extends DataClass implements Insertable<ShoppingItemRow> {
  final int id;
  final int menuId;
  final String? ingredientId;
  final String? label;
  final double? quantity;
  final String? unit;
  final bool bought;
  final bool atHome;
  final bool manual;
  const ShoppingItemRow({
    required this.id,
    required this.menuId,
    this.ingredientId,
    this.label,
    this.quantity,
    this.unit,
    required this.bought,
    required this.atHome,
    required this.manual,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['menu_id'] = Variable<int>(menuId);
    if (!nullToAbsent || ingredientId != null) {
      map['ingredient_id'] = Variable<String>(ingredientId);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<double>(quantity);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    map['bought'] = Variable<bool>(bought);
    map['at_home'] = Variable<bool>(atHome);
    map['manual'] = Variable<bool>(manual);
    return map;
  }

  ShoppingItemsCompanion toCompanion(bool nullToAbsent) {
    return ShoppingItemsCompanion(
      id: Value(id),
      menuId: Value(menuId),
      ingredientId: ingredientId == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientId),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      bought: Value(bought),
      atHome: Value(atHome),
      manual: Value(manual),
    );
  }

  factory ShoppingItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShoppingItemRow(
      id: serializer.fromJson<int>(json['id']),
      menuId: serializer.fromJson<int>(json['menuId']),
      ingredientId: serializer.fromJson<String?>(json['ingredientId']),
      label: serializer.fromJson<String?>(json['label']),
      quantity: serializer.fromJson<double?>(json['quantity']),
      unit: serializer.fromJson<String?>(json['unit']),
      bought: serializer.fromJson<bool>(json['bought']),
      atHome: serializer.fromJson<bool>(json['atHome']),
      manual: serializer.fromJson<bool>(json['manual']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'menuId': serializer.toJson<int>(menuId),
      'ingredientId': serializer.toJson<String?>(ingredientId),
      'label': serializer.toJson<String?>(label),
      'quantity': serializer.toJson<double?>(quantity),
      'unit': serializer.toJson<String?>(unit),
      'bought': serializer.toJson<bool>(bought),
      'atHome': serializer.toJson<bool>(atHome),
      'manual': serializer.toJson<bool>(manual),
    };
  }

  ShoppingItemRow copyWith({
    int? id,
    int? menuId,
    Value<String?> ingredientId = const Value.absent(),
    Value<String?> label = const Value.absent(),
    Value<double?> quantity = const Value.absent(),
    Value<String?> unit = const Value.absent(),
    bool? bought,
    bool? atHome,
    bool? manual,
  }) => ShoppingItemRow(
    id: id ?? this.id,
    menuId: menuId ?? this.menuId,
    ingredientId: ingredientId.present ? ingredientId.value : this.ingredientId,
    label: label.present ? label.value : this.label,
    quantity: quantity.present ? quantity.value : this.quantity,
    unit: unit.present ? unit.value : this.unit,
    bought: bought ?? this.bought,
    atHome: atHome ?? this.atHome,
    manual: manual ?? this.manual,
  );
  ShoppingItemRow copyWithCompanion(ShoppingItemsCompanion data) {
    return ShoppingItemRow(
      id: data.id.present ? data.id.value : this.id,
      menuId: data.menuId.present ? data.menuId.value : this.menuId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      label: data.label.present ? data.label.value : this.label,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      bought: data.bought.present ? data.bought.value : this.bought,
      atHome: data.atHome.present ? data.atHome.value : this.atHome,
      manual: data.manual.present ? data.manual.value : this.manual,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingItemRow(')
          ..write('id: $id, ')
          ..write('menuId: $menuId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('label: $label, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('bought: $bought, ')
          ..write('atHome: $atHome, ')
          ..write('manual: $manual')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    menuId,
    ingredientId,
    label,
    quantity,
    unit,
    bought,
    atHome,
    manual,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingItemRow &&
          other.id == this.id &&
          other.menuId == this.menuId &&
          other.ingredientId == this.ingredientId &&
          other.label == this.label &&
          other.quantity == this.quantity &&
          other.unit == this.unit &&
          other.bought == this.bought &&
          other.atHome == this.atHome &&
          other.manual == this.manual);
}

class ShoppingItemsCompanion extends UpdateCompanion<ShoppingItemRow> {
  final Value<int> id;
  final Value<int> menuId;
  final Value<String?> ingredientId;
  final Value<String?> label;
  final Value<double?> quantity;
  final Value<String?> unit;
  final Value<bool> bought;
  final Value<bool> atHome;
  final Value<bool> manual;
  const ShoppingItemsCompanion({
    this.id = const Value.absent(),
    this.menuId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.label = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.bought = const Value.absent(),
    this.atHome = const Value.absent(),
    this.manual = const Value.absent(),
  });
  ShoppingItemsCompanion.insert({
    this.id = const Value.absent(),
    required int menuId,
    this.ingredientId = const Value.absent(),
    this.label = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.bought = const Value.absent(),
    this.atHome = const Value.absent(),
    this.manual = const Value.absent(),
  }) : menuId = Value(menuId);
  static Insertable<ShoppingItemRow> custom({
    Expression<int>? id,
    Expression<int>? menuId,
    Expression<String>? ingredientId,
    Expression<String>? label,
    Expression<double>? quantity,
    Expression<String>? unit,
    Expression<bool>? bought,
    Expression<bool>? atHome,
    Expression<bool>? manual,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (menuId != null) 'menu_id': menuId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (label != null) 'label': label,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
      if (bought != null) 'bought': bought,
      if (atHome != null) 'at_home': atHome,
      if (manual != null) 'manual': manual,
    });
  }

  ShoppingItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? menuId,
    Value<String?>? ingredientId,
    Value<String?>? label,
    Value<double?>? quantity,
    Value<String?>? unit,
    Value<bool>? bought,
    Value<bool>? atHome,
    Value<bool>? manual,
  }) {
    return ShoppingItemsCompanion(
      id: id ?? this.id,
      menuId: menuId ?? this.menuId,
      ingredientId: ingredientId ?? this.ingredientId,
      label: label ?? this.label,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      bought: bought ?? this.bought,
      atHome: atHome ?? this.atHome,
      manual: manual ?? this.manual,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (menuId.present) {
      map['menu_id'] = Variable<int>(menuId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<String>(ingredientId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (bought.present) {
      map['bought'] = Variable<bool>(bought.value);
    }
    if (atHome.present) {
      map['at_home'] = Variable<bool>(atHome.value);
    }
    if (manual.present) {
      map['manual'] = Variable<bool>(manual.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingItemsCompanion(')
          ..write('id: $id, ')
          ..write('menuId: $menuId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('label: $label, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('bought: $bought, ')
          ..write('atHome: $atHome, ')
          ..write('manual: $manual')
          ..write(')'))
        .toString();
  }
}

class $AppMetaTable extends AppMeta with TableInfo<$AppMetaTable, AppMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetaRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppMetaTable createAlias(String alias) {
    return $AppMetaTable(attachedDatabase, alias);
  }
}

class AppMetaRow extends DataClass implements Insertable<AppMetaRow> {
  final String key;
  final String value;
  const AppMetaRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppMetaCompanion toCompanion(bool nullToAbsent) {
    return AppMetaCompanion(key: Value(key), value: Value(value));
  }

  factory AppMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetaRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppMetaRow copyWith({String? key, String? value}) =>
      AppMetaRow(key: key ?? this.key, value: value ?? this.value);
  AppMetaRow copyWithCompanion(AppMetaCompanion data) {
    return AppMetaRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetaRow &&
          other.key == this.key &&
          other.value == this.value);
}

class AppMetaCompanion extends UpdateCompanion<AppMetaRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppMetaRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomProductsTable extends CustomProducts
    with TableInfo<$CustomProductsTable, CustomProductRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _packageQtyMeta = const VerificationMeta(
    'packageQty',
  );
  @override
  late final GeneratedColumn<double> packageQty = GeneratedColumn<double>(
    'package_qty',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _packageUnitMeta = const VerificationMeta(
    'packageUnit',
  );
  @override
  late final GeneratedColumn<String> packageUnit = GeneratedColumn<String>(
    'package_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _servingGMeta = const VerificationMeta(
    'servingG',
  );
  @override
  late final GeneratedColumn<double> servingG = GeneratedColumn<double>(
    'serving_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nutritionMeta = const VerificationMeta(
    'nutrition',
  );
  @override
  late final GeneratedColumn<String> nutrition = GeneratedColumn<String>(
    'nutrition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoriesMeta = const VerificationMeta(
    'categories',
  );
  @override
  late final GeneratedColumn<String> categories = GeneratedColumn<String>(
    'categories',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    barcode,
    name,
    brand,
    packageQty,
    packageUnit,
    servingG,
    nutrition,
    categories,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomProductRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    } else if (isInserting) {
      context.missing(_barcodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('package_qty')) {
      context.handle(
        _packageQtyMeta,
        packageQty.isAcceptableOrUnknown(data['package_qty']!, _packageQtyMeta),
      );
    }
    if (data.containsKey('package_unit')) {
      context.handle(
        _packageUnitMeta,
        packageUnit.isAcceptableOrUnknown(
          data['package_unit']!,
          _packageUnitMeta,
        ),
      );
    }
    if (data.containsKey('serving_g')) {
      context.handle(
        _servingGMeta,
        servingG.isAcceptableOrUnknown(data['serving_g']!, _servingGMeta),
      );
    }
    if (data.containsKey('nutrition')) {
      context.handle(
        _nutritionMeta,
        nutrition.isAcceptableOrUnknown(data['nutrition']!, _nutritionMeta),
      );
    }
    if (data.containsKey('categories')) {
      context.handle(
        _categoriesMeta,
        categories.isAcceptableOrUnknown(data['categories']!, _categoriesMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {barcode};
  @override
  CustomProductRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomProductRow(
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      packageQty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}package_qty'],
      ),
      packageUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_unit'],
      ),
      servingG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}serving_g'],
      ),
      nutrition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nutrition'],
      ),
      categories: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categories'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CustomProductsTable createAlias(String alias) {
    return $CustomProductsTable(attachedDatabase, alias);
  }
}

class CustomProductRow extends DataClass
    implements Insertable<CustomProductRow> {
  final String barcode;
  final String name;
  final String? brand;
  final double? packageQty;
  final String? packageUnit;
  final double? servingG;
  final String? nutrition;
  final String categories;
  final DateTime updatedAt;
  const CustomProductRow({
    required this.barcode,
    required this.name,
    this.brand,
    this.packageQty,
    this.packageUnit,
    this.servingG,
    this.nutrition,
    required this.categories,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['barcode'] = Variable<String>(barcode);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || packageQty != null) {
      map['package_qty'] = Variable<double>(packageQty);
    }
    if (!nullToAbsent || packageUnit != null) {
      map['package_unit'] = Variable<String>(packageUnit);
    }
    if (!nullToAbsent || servingG != null) {
      map['serving_g'] = Variable<double>(servingG);
    }
    if (!nullToAbsent || nutrition != null) {
      map['nutrition'] = Variable<String>(nutrition);
    }
    map['categories'] = Variable<String>(categories);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CustomProductsCompanion toCompanion(bool nullToAbsent) {
    return CustomProductsCompanion(
      barcode: Value(barcode),
      name: Value(name),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      packageQty: packageQty == null && nullToAbsent
          ? const Value.absent()
          : Value(packageQty),
      packageUnit: packageUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(packageUnit),
      servingG: servingG == null && nullToAbsent
          ? const Value.absent()
          : Value(servingG),
      nutrition: nutrition == null && nullToAbsent
          ? const Value.absent()
          : Value(nutrition),
      categories: Value(categories),
      updatedAt: Value(updatedAt),
    );
  }

  factory CustomProductRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomProductRow(
      barcode: serializer.fromJson<String>(json['barcode']),
      name: serializer.fromJson<String>(json['name']),
      brand: serializer.fromJson<String?>(json['brand']),
      packageQty: serializer.fromJson<double?>(json['packageQty']),
      packageUnit: serializer.fromJson<String?>(json['packageUnit']),
      servingG: serializer.fromJson<double?>(json['servingG']),
      nutrition: serializer.fromJson<String?>(json['nutrition']),
      categories: serializer.fromJson<String>(json['categories']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'barcode': serializer.toJson<String>(barcode),
      'name': serializer.toJson<String>(name),
      'brand': serializer.toJson<String?>(brand),
      'packageQty': serializer.toJson<double?>(packageQty),
      'packageUnit': serializer.toJson<String?>(packageUnit),
      'servingG': serializer.toJson<double?>(servingG),
      'nutrition': serializer.toJson<String?>(nutrition),
      'categories': serializer.toJson<String>(categories),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CustomProductRow copyWith({
    String? barcode,
    String? name,
    Value<String?> brand = const Value.absent(),
    Value<double?> packageQty = const Value.absent(),
    Value<String?> packageUnit = const Value.absent(),
    Value<double?> servingG = const Value.absent(),
    Value<String?> nutrition = const Value.absent(),
    String? categories,
    DateTime? updatedAt,
  }) => CustomProductRow(
    barcode: barcode ?? this.barcode,
    name: name ?? this.name,
    brand: brand.present ? brand.value : this.brand,
    packageQty: packageQty.present ? packageQty.value : this.packageQty,
    packageUnit: packageUnit.present ? packageUnit.value : this.packageUnit,
    servingG: servingG.present ? servingG.value : this.servingG,
    nutrition: nutrition.present ? nutrition.value : this.nutrition,
    categories: categories ?? this.categories,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CustomProductRow copyWithCompanion(CustomProductsCompanion data) {
    return CustomProductRow(
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      name: data.name.present ? data.name.value : this.name,
      brand: data.brand.present ? data.brand.value : this.brand,
      packageQty: data.packageQty.present
          ? data.packageQty.value
          : this.packageQty,
      packageUnit: data.packageUnit.present
          ? data.packageUnit.value
          : this.packageUnit,
      servingG: data.servingG.present ? data.servingG.value : this.servingG,
      nutrition: data.nutrition.present ? data.nutrition.value : this.nutrition,
      categories: data.categories.present
          ? data.categories.value
          : this.categories,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomProductRow(')
          ..write('barcode: $barcode, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('packageQty: $packageQty, ')
          ..write('packageUnit: $packageUnit, ')
          ..write('servingG: $servingG, ')
          ..write('nutrition: $nutrition, ')
          ..write('categories: $categories, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    barcode,
    name,
    brand,
    packageQty,
    packageUnit,
    servingG,
    nutrition,
    categories,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomProductRow &&
          other.barcode == this.barcode &&
          other.name == this.name &&
          other.brand == this.brand &&
          other.packageQty == this.packageQty &&
          other.packageUnit == this.packageUnit &&
          other.servingG == this.servingG &&
          other.nutrition == this.nutrition &&
          other.categories == this.categories &&
          other.updatedAt == this.updatedAt);
}

class CustomProductsCompanion extends UpdateCompanion<CustomProductRow> {
  final Value<String> barcode;
  final Value<String> name;
  final Value<String?> brand;
  final Value<double?> packageQty;
  final Value<String?> packageUnit;
  final Value<double?> servingG;
  final Value<String?> nutrition;
  final Value<String> categories;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CustomProductsCompanion({
    this.barcode = const Value.absent(),
    this.name = const Value.absent(),
    this.brand = const Value.absent(),
    this.packageQty = const Value.absent(),
    this.packageUnit = const Value.absent(),
    this.servingG = const Value.absent(),
    this.nutrition = const Value.absent(),
    this.categories = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomProductsCompanion.insert({
    required String barcode,
    required String name,
    this.brand = const Value.absent(),
    this.packageQty = const Value.absent(),
    this.packageUnit = const Value.absent(),
    this.servingG = const Value.absent(),
    this.nutrition = const Value.absent(),
    this.categories = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : barcode = Value(barcode),
       name = Value(name),
       updatedAt = Value(updatedAt);
  static Insertable<CustomProductRow> custom({
    Expression<String>? barcode,
    Expression<String>? name,
    Expression<String>? brand,
    Expression<double>? packageQty,
    Expression<String>? packageUnit,
    Expression<double>? servingG,
    Expression<String>? nutrition,
    Expression<String>? categories,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (barcode != null) 'barcode': barcode,
      if (name != null) 'name': name,
      if (brand != null) 'brand': brand,
      if (packageQty != null) 'package_qty': packageQty,
      if (packageUnit != null) 'package_unit': packageUnit,
      if (servingG != null) 'serving_g': servingG,
      if (nutrition != null) 'nutrition': nutrition,
      if (categories != null) 'categories': categories,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomProductsCompanion copyWith({
    Value<String>? barcode,
    Value<String>? name,
    Value<String?>? brand,
    Value<double?>? packageQty,
    Value<String?>? packageUnit,
    Value<double?>? servingG,
    Value<String?>? nutrition,
    Value<String>? categories,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CustomProductsCompanion(
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      packageQty: packageQty ?? this.packageQty,
      packageUnit: packageUnit ?? this.packageUnit,
      servingG: servingG ?? this.servingG,
      nutrition: nutrition ?? this.nutrition,
      categories: categories ?? this.categories,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (packageQty.present) {
      map['package_qty'] = Variable<double>(packageQty.value);
    }
    if (packageUnit.present) {
      map['package_unit'] = Variable<String>(packageUnit.value);
    }
    if (servingG.present) {
      map['serving_g'] = Variable<double>(servingG.value);
    }
    if (nutrition.present) {
      map['nutrition'] = Variable<String>(nutrition.value);
    }
    if (categories.present) {
      map['categories'] = Variable<String>(categories.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomProductsCompanion(')
          ..write('barcode: $barcode, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('packageQty: $packageQty, ')
          ..write('packageUnit: $packageUnit, ')
          ..write('servingG: $servingG, ')
          ..write('nutrition: $nutrition, ')
          ..write('categories: $categories, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductLinksTable extends ProductLinks
    with TableInfo<$ProductLinksTable, ProductLinkRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<String> ingredientId = GeneratedColumn<String>(
    'ingredient_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id)',
    ),
  );
  static const VerificationMeta _linkedAtMeta = const VerificationMeta(
    'linkedAt',
  );
  @override
  late final GeneratedColumn<DateTime> linkedAt = GeneratedColumn<DateTime>(
    'linked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [barcode, ingredientId, linkedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_links';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductLinkRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    } else if (isInserting) {
      context.missing(_barcodeMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    }
    if (data.containsKey('linked_at')) {
      context.handle(
        _linkedAtMeta,
        linkedAt.isAcceptableOrUnknown(data['linked_at']!, _linkedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_linkedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {barcode};
  @override
  ProductLinkRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductLinkRow(
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_id'],
      ),
      linkedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}linked_at'],
      )!,
    );
  }

  @override
  $ProductLinksTable createAlias(String alias) {
    return $ProductLinksTable(attachedDatabase, alias);
  }
}

class ProductLinkRow extends DataClass implements Insertable<ProductLinkRow> {
  final String barcode;
  final String? ingredientId;
  final DateTime linkedAt;
  const ProductLinkRow({
    required this.barcode,
    this.ingredientId,
    required this.linkedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['barcode'] = Variable<String>(barcode);
    if (!nullToAbsent || ingredientId != null) {
      map['ingredient_id'] = Variable<String>(ingredientId);
    }
    map['linked_at'] = Variable<DateTime>(linkedAt);
    return map;
  }

  ProductLinksCompanion toCompanion(bool nullToAbsent) {
    return ProductLinksCompanion(
      barcode: Value(barcode),
      ingredientId: ingredientId == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientId),
      linkedAt: Value(linkedAt),
    );
  }

  factory ProductLinkRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductLinkRow(
      barcode: serializer.fromJson<String>(json['barcode']),
      ingredientId: serializer.fromJson<String?>(json['ingredientId']),
      linkedAt: serializer.fromJson<DateTime>(json['linkedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'barcode': serializer.toJson<String>(barcode),
      'ingredientId': serializer.toJson<String?>(ingredientId),
      'linkedAt': serializer.toJson<DateTime>(linkedAt),
    };
  }

  ProductLinkRow copyWith({
    String? barcode,
    Value<String?> ingredientId = const Value.absent(),
    DateTime? linkedAt,
  }) => ProductLinkRow(
    barcode: barcode ?? this.barcode,
    ingredientId: ingredientId.present ? ingredientId.value : this.ingredientId,
    linkedAt: linkedAt ?? this.linkedAt,
  );
  ProductLinkRow copyWithCompanion(ProductLinksCompanion data) {
    return ProductLinkRow(
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      linkedAt: data.linkedAt.present ? data.linkedAt.value : this.linkedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductLinkRow(')
          ..write('barcode: $barcode, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('linkedAt: $linkedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(barcode, ingredientId, linkedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductLinkRow &&
          other.barcode == this.barcode &&
          other.ingredientId == this.ingredientId &&
          other.linkedAt == this.linkedAt);
}

class ProductLinksCompanion extends UpdateCompanion<ProductLinkRow> {
  final Value<String> barcode;
  final Value<String?> ingredientId;
  final Value<DateTime> linkedAt;
  final Value<int> rowid;
  const ProductLinksCompanion({
    this.barcode = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.linkedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductLinksCompanion.insert({
    required String barcode,
    this.ingredientId = const Value.absent(),
    required DateTime linkedAt,
    this.rowid = const Value.absent(),
  }) : barcode = Value(barcode),
       linkedAt = Value(linkedAt);
  static Insertable<ProductLinkRow> custom({
    Expression<String>? barcode,
    Expression<String>? ingredientId,
    Expression<DateTime>? linkedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (barcode != null) 'barcode': barcode,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (linkedAt != null) 'linked_at': linkedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductLinksCompanion copyWith({
    Value<String>? barcode,
    Value<String?>? ingredientId,
    Value<DateTime>? linkedAt,
    Value<int>? rowid,
  }) {
    return ProductLinksCompanion(
      barcode: barcode ?? this.barcode,
      ingredientId: ingredientId ?? this.ingredientId,
      linkedAt: linkedAt ?? this.linkedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<String>(ingredientId.value);
    }
    if (linkedAt.present) {
      map['linked_at'] = Variable<DateTime>(linkedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductLinksCompanion(')
          ..write('barcode: $barcode, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('linkedAt: $linkedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockLotsTable extends StockLots
    with TableInfo<$StockLotsTable, StockLotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockLotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<String> ingredientId = GeneratedColumn<String>(
    'ingredient_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id)',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bestBeforeMeta = const VerificationMeta(
    'bestBefore',
  );
  @override
  late final GeneratedColumn<DateTime> bestBefore = GeneratedColumn<DateTime>(
    'best_before',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    barcode,
    ingredientId,
    label,
    quantity,
    unit,
    location,
    addedAt,
    bestBefore,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_lots';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockLotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    if (data.containsKey('best_before')) {
      context.handle(
        _bestBeforeMeta,
        bestBefore.isAcceptableOrUnknown(data['best_before']!, _bestBeforeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockLotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockLotRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_id'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
      bestBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}best_before'],
      ),
    );
  }

  @override
  $StockLotsTable createAlias(String alias) {
    return $StockLotsTable(attachedDatabase, alias);
  }
}

class StockLotRow extends DataClass implements Insertable<StockLotRow> {
  final int id;
  final String? barcode;
  final String? ingredientId;
  final String label;
  final double quantity;
  final String unit;
  final String location;
  final DateTime addedAt;
  final DateTime? bestBefore;
  const StockLotRow({
    required this.id,
    this.barcode,
    this.ingredientId,
    required this.label,
    required this.quantity,
    required this.unit,
    required this.location,
    required this.addedAt,
    this.bestBefore,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    if (!nullToAbsent || ingredientId != null) {
      map['ingredient_id'] = Variable<String>(ingredientId);
    }
    map['label'] = Variable<String>(label);
    map['quantity'] = Variable<double>(quantity);
    map['unit'] = Variable<String>(unit);
    map['location'] = Variable<String>(location);
    map['added_at'] = Variable<DateTime>(addedAt);
    if (!nullToAbsent || bestBefore != null) {
      map['best_before'] = Variable<DateTime>(bestBefore);
    }
    return map;
  }

  StockLotsCompanion toCompanion(bool nullToAbsent) {
    return StockLotsCompanion(
      id: Value(id),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      ingredientId: ingredientId == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientId),
      label: Value(label),
      quantity: Value(quantity),
      unit: Value(unit),
      location: Value(location),
      addedAt: Value(addedAt),
      bestBefore: bestBefore == null && nullToAbsent
          ? const Value.absent()
          : Value(bestBefore),
    );
  }

  factory StockLotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockLotRow(
      id: serializer.fromJson<int>(json['id']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      ingredientId: serializer.fromJson<String?>(json['ingredientId']),
      label: serializer.fromJson<String>(json['label']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unit: serializer.fromJson<String>(json['unit']),
      location: serializer.fromJson<String>(json['location']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
      bestBefore: serializer.fromJson<DateTime?>(json['bestBefore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'barcode': serializer.toJson<String?>(barcode),
      'ingredientId': serializer.toJson<String?>(ingredientId),
      'label': serializer.toJson<String>(label),
      'quantity': serializer.toJson<double>(quantity),
      'unit': serializer.toJson<String>(unit),
      'location': serializer.toJson<String>(location),
      'addedAt': serializer.toJson<DateTime>(addedAt),
      'bestBefore': serializer.toJson<DateTime?>(bestBefore),
    };
  }

  StockLotRow copyWith({
    int? id,
    Value<String?> barcode = const Value.absent(),
    Value<String?> ingredientId = const Value.absent(),
    String? label,
    double? quantity,
    String? unit,
    String? location,
    DateTime? addedAt,
    Value<DateTime?> bestBefore = const Value.absent(),
  }) => StockLotRow(
    id: id ?? this.id,
    barcode: barcode.present ? barcode.value : this.barcode,
    ingredientId: ingredientId.present ? ingredientId.value : this.ingredientId,
    label: label ?? this.label,
    quantity: quantity ?? this.quantity,
    unit: unit ?? this.unit,
    location: location ?? this.location,
    addedAt: addedAt ?? this.addedAt,
    bestBefore: bestBefore.present ? bestBefore.value : this.bestBefore,
  );
  StockLotRow copyWithCompanion(StockLotsCompanion data) {
    return StockLotRow(
      id: data.id.present ? data.id.value : this.id,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      label: data.label.present ? data.label.value : this.label,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      location: data.location.present ? data.location.value : this.location,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
      bestBefore: data.bestBefore.present
          ? data.bestBefore.value
          : this.bestBefore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockLotRow(')
          ..write('id: $id, ')
          ..write('barcode: $barcode, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('label: $label, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('location: $location, ')
          ..write('addedAt: $addedAt, ')
          ..write('bestBefore: $bestBefore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    barcode,
    ingredientId,
    label,
    quantity,
    unit,
    location,
    addedAt,
    bestBefore,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockLotRow &&
          other.id == this.id &&
          other.barcode == this.barcode &&
          other.ingredientId == this.ingredientId &&
          other.label == this.label &&
          other.quantity == this.quantity &&
          other.unit == this.unit &&
          other.location == this.location &&
          other.addedAt == this.addedAt &&
          other.bestBefore == this.bestBefore);
}

class StockLotsCompanion extends UpdateCompanion<StockLotRow> {
  final Value<int> id;
  final Value<String?> barcode;
  final Value<String?> ingredientId;
  final Value<String> label;
  final Value<double> quantity;
  final Value<String> unit;
  final Value<String> location;
  final Value<DateTime> addedAt;
  final Value<DateTime?> bestBefore;
  const StockLotsCompanion({
    this.id = const Value.absent(),
    this.barcode = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.label = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.location = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.bestBefore = const Value.absent(),
  });
  StockLotsCompanion.insert({
    this.id = const Value.absent(),
    this.barcode = const Value.absent(),
    this.ingredientId = const Value.absent(),
    required String label,
    required double quantity,
    required String unit,
    required String location,
    required DateTime addedAt,
    this.bestBefore = const Value.absent(),
  }) : label = Value(label),
       quantity = Value(quantity),
       unit = Value(unit),
       location = Value(location),
       addedAt = Value(addedAt);
  static Insertable<StockLotRow> custom({
    Expression<int>? id,
    Expression<String>? barcode,
    Expression<String>? ingredientId,
    Expression<String>? label,
    Expression<double>? quantity,
    Expression<String>? unit,
    Expression<String>? location,
    Expression<DateTime>? addedAt,
    Expression<DateTime>? bestBefore,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (barcode != null) 'barcode': barcode,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (label != null) 'label': label,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
      if (location != null) 'location': location,
      if (addedAt != null) 'added_at': addedAt,
      if (bestBefore != null) 'best_before': bestBefore,
    });
  }

  StockLotsCompanion copyWith({
    Value<int>? id,
    Value<String?>? barcode,
    Value<String?>? ingredientId,
    Value<String>? label,
    Value<double>? quantity,
    Value<String>? unit,
    Value<String>? location,
    Value<DateTime>? addedAt,
    Value<DateTime?>? bestBefore,
  }) {
    return StockLotsCompanion(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      ingredientId: ingredientId ?? this.ingredientId,
      label: label ?? this.label,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      location: location ?? this.location,
      addedAt: addedAt ?? this.addedAt,
      bestBefore: bestBefore ?? this.bestBefore,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<String>(ingredientId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (bestBefore.present) {
      map['best_before'] = Variable<DateTime>(bestBefore.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockLotsCompanion(')
          ..write('id: $id, ')
          ..write('barcode: $barcode, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('label: $label, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('location: $location, ')
          ..write('addedAt: $addedAt, ')
          ..write('bestBefore: $bestBefore')
          ..write(')'))
        .toString();
  }
}

class $StockMovementsTable extends StockMovements
    with TableInfo<$StockMovementsTable, StockMovementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _lotIdMeta = const VerificationMeta('lotId');
  @override
  late final GeneratedColumn<int> lotId = GeneratedColumn<int>(
    'lot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deltaMeta = const VerificationMeta('delta');
  @override
  late final GeneratedColumn<double> delta = GeneratedColumn<double>(
    'delta',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completionIdMeta = const VerificationMeta(
    'completionId',
  );
  @override
  late final GeneratedColumn<int> completionId = GeneratedColumn<int>(
    'completion_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _logEntryIdMeta = const VerificationMeta(
    'logEntryId',
  );
  @override
  late final GeneratedColumn<int> logEntryId = GeneratedColumn<int>(
    'log_entry_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<String> ingredientId = GeneratedColumn<String>(
    'ingredient_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lotId,
    delta,
    kind,
    at,
    completionId,
    logEntryId,
    label,
    barcode,
    ingredientId,
    unit,
    location,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockMovementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lot_id')) {
      context.handle(
        _lotIdMeta,
        lotId.isAcceptableOrUnknown(data['lot_id']!, _lotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lotIdMeta);
    }
    if (data.containsKey('delta')) {
      context.handle(
        _deltaMeta,
        delta.isAcceptableOrUnknown(data['delta']!, _deltaMeta),
      );
    } else if (isInserting) {
      context.missing(_deltaMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('completion_id')) {
      context.handle(
        _completionIdMeta,
        completionId.isAcceptableOrUnknown(
          data['completion_id']!,
          _completionIdMeta,
        ),
      );
    }
    if (data.containsKey('log_entry_id')) {
      context.handle(
        _logEntryIdMeta,
        logEntryId.isAcceptableOrUnknown(
          data['log_entry_id']!,
          _logEntryIdMeta,
        ),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockMovementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockMovementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lotId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lot_id'],
      )!,
      delta: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}delta'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
      completionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completion_id'],
      ),
      logEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}log_entry_id'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_id'],
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
    );
  }

  @override
  $StockMovementsTable createAlias(String alias) {
    return $StockMovementsTable(attachedDatabase, alias);
  }
}

class StockMovementRow extends DataClass
    implements Insertable<StockMovementRow> {
  final int id;
  final int lotId;
  final double delta;
  final String kind;
  final DateTime at;
  final int? completionId;
  final int? logEntryId;
  final String? label;
  final String? barcode;
  final String? ingredientId;
  final String? unit;
  final String? location;
  const StockMovementRow({
    required this.id,
    required this.lotId,
    required this.delta,
    required this.kind,
    required this.at,
    this.completionId,
    this.logEntryId,
    this.label,
    this.barcode,
    this.ingredientId,
    this.unit,
    this.location,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lot_id'] = Variable<int>(lotId);
    map['delta'] = Variable<double>(delta);
    map['kind'] = Variable<String>(kind);
    map['at'] = Variable<DateTime>(at);
    if (!nullToAbsent || completionId != null) {
      map['completion_id'] = Variable<int>(completionId);
    }
    if (!nullToAbsent || logEntryId != null) {
      map['log_entry_id'] = Variable<int>(logEntryId);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    if (!nullToAbsent || ingredientId != null) {
      map['ingredient_id'] = Variable<String>(ingredientId);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    return map;
  }

  StockMovementsCompanion toCompanion(bool nullToAbsent) {
    return StockMovementsCompanion(
      id: Value(id),
      lotId: Value(lotId),
      delta: Value(delta),
      kind: Value(kind),
      at: Value(at),
      completionId: completionId == null && nullToAbsent
          ? const Value.absent()
          : Value(completionId),
      logEntryId: logEntryId == null && nullToAbsent
          ? const Value.absent()
          : Value(logEntryId),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      ingredientId: ingredientId == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientId),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
    );
  }

  factory StockMovementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockMovementRow(
      id: serializer.fromJson<int>(json['id']),
      lotId: serializer.fromJson<int>(json['lotId']),
      delta: serializer.fromJson<double>(json['delta']),
      kind: serializer.fromJson<String>(json['kind']),
      at: serializer.fromJson<DateTime>(json['at']),
      completionId: serializer.fromJson<int?>(json['completionId']),
      logEntryId: serializer.fromJson<int?>(json['logEntryId']),
      label: serializer.fromJson<String?>(json['label']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      ingredientId: serializer.fromJson<String?>(json['ingredientId']),
      unit: serializer.fromJson<String?>(json['unit']),
      location: serializer.fromJson<String?>(json['location']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lotId': serializer.toJson<int>(lotId),
      'delta': serializer.toJson<double>(delta),
      'kind': serializer.toJson<String>(kind),
      'at': serializer.toJson<DateTime>(at),
      'completionId': serializer.toJson<int?>(completionId),
      'logEntryId': serializer.toJson<int?>(logEntryId),
      'label': serializer.toJson<String?>(label),
      'barcode': serializer.toJson<String?>(barcode),
      'ingredientId': serializer.toJson<String?>(ingredientId),
      'unit': serializer.toJson<String?>(unit),
      'location': serializer.toJson<String?>(location),
    };
  }

  StockMovementRow copyWith({
    int? id,
    int? lotId,
    double? delta,
    String? kind,
    DateTime? at,
    Value<int?> completionId = const Value.absent(),
    Value<int?> logEntryId = const Value.absent(),
    Value<String?> label = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    Value<String?> ingredientId = const Value.absent(),
    Value<String?> unit = const Value.absent(),
    Value<String?> location = const Value.absent(),
  }) => StockMovementRow(
    id: id ?? this.id,
    lotId: lotId ?? this.lotId,
    delta: delta ?? this.delta,
    kind: kind ?? this.kind,
    at: at ?? this.at,
    completionId: completionId.present ? completionId.value : this.completionId,
    logEntryId: logEntryId.present ? logEntryId.value : this.logEntryId,
    label: label.present ? label.value : this.label,
    barcode: barcode.present ? barcode.value : this.barcode,
    ingredientId: ingredientId.present ? ingredientId.value : this.ingredientId,
    unit: unit.present ? unit.value : this.unit,
    location: location.present ? location.value : this.location,
  );
  StockMovementRow copyWithCompanion(StockMovementsCompanion data) {
    return StockMovementRow(
      id: data.id.present ? data.id.value : this.id,
      lotId: data.lotId.present ? data.lotId.value : this.lotId,
      delta: data.delta.present ? data.delta.value : this.delta,
      kind: data.kind.present ? data.kind.value : this.kind,
      at: data.at.present ? data.at.value : this.at,
      completionId: data.completionId.present
          ? data.completionId.value
          : this.completionId,
      logEntryId: data.logEntryId.present
          ? data.logEntryId.value
          : this.logEntryId,
      label: data.label.present ? data.label.value : this.label,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      unit: data.unit.present ? data.unit.value : this.unit,
      location: data.location.present ? data.location.value : this.location,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementRow(')
          ..write('id: $id, ')
          ..write('lotId: $lotId, ')
          ..write('delta: $delta, ')
          ..write('kind: $kind, ')
          ..write('at: $at, ')
          ..write('completionId: $completionId, ')
          ..write('logEntryId: $logEntryId, ')
          ..write('label: $label, ')
          ..write('barcode: $barcode, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('unit: $unit, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lotId,
    delta,
    kind,
    at,
    completionId,
    logEntryId,
    label,
    barcode,
    ingredientId,
    unit,
    location,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockMovementRow &&
          other.id == this.id &&
          other.lotId == this.lotId &&
          other.delta == this.delta &&
          other.kind == this.kind &&
          other.at == this.at &&
          other.completionId == this.completionId &&
          other.logEntryId == this.logEntryId &&
          other.label == this.label &&
          other.barcode == this.barcode &&
          other.ingredientId == this.ingredientId &&
          other.unit == this.unit &&
          other.location == this.location);
}

class StockMovementsCompanion extends UpdateCompanion<StockMovementRow> {
  final Value<int> id;
  final Value<int> lotId;
  final Value<double> delta;
  final Value<String> kind;
  final Value<DateTime> at;
  final Value<int?> completionId;
  final Value<int?> logEntryId;
  final Value<String?> label;
  final Value<String?> barcode;
  final Value<String?> ingredientId;
  final Value<String?> unit;
  final Value<String?> location;
  const StockMovementsCompanion({
    this.id = const Value.absent(),
    this.lotId = const Value.absent(),
    this.delta = const Value.absent(),
    this.kind = const Value.absent(),
    this.at = const Value.absent(),
    this.completionId = const Value.absent(),
    this.logEntryId = const Value.absent(),
    this.label = const Value.absent(),
    this.barcode = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.unit = const Value.absent(),
    this.location = const Value.absent(),
  });
  StockMovementsCompanion.insert({
    this.id = const Value.absent(),
    required int lotId,
    required double delta,
    required String kind,
    required DateTime at,
    this.completionId = const Value.absent(),
    this.logEntryId = const Value.absent(),
    this.label = const Value.absent(),
    this.barcode = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.unit = const Value.absent(),
    this.location = const Value.absent(),
  }) : lotId = Value(lotId),
       delta = Value(delta),
       kind = Value(kind),
       at = Value(at);
  static Insertable<StockMovementRow> custom({
    Expression<int>? id,
    Expression<int>? lotId,
    Expression<double>? delta,
    Expression<String>? kind,
    Expression<DateTime>? at,
    Expression<int>? completionId,
    Expression<int>? logEntryId,
    Expression<String>? label,
    Expression<String>? barcode,
    Expression<String>? ingredientId,
    Expression<String>? unit,
    Expression<String>? location,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lotId != null) 'lot_id': lotId,
      if (delta != null) 'delta': delta,
      if (kind != null) 'kind': kind,
      if (at != null) 'at': at,
      if (completionId != null) 'completion_id': completionId,
      if (logEntryId != null) 'log_entry_id': logEntryId,
      if (label != null) 'label': label,
      if (barcode != null) 'barcode': barcode,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (unit != null) 'unit': unit,
      if (location != null) 'location': location,
    });
  }

  StockMovementsCompanion copyWith({
    Value<int>? id,
    Value<int>? lotId,
    Value<double>? delta,
    Value<String>? kind,
    Value<DateTime>? at,
    Value<int?>? completionId,
    Value<int?>? logEntryId,
    Value<String?>? label,
    Value<String?>? barcode,
    Value<String?>? ingredientId,
    Value<String?>? unit,
    Value<String?>? location,
  }) {
    return StockMovementsCompanion(
      id: id ?? this.id,
      lotId: lotId ?? this.lotId,
      delta: delta ?? this.delta,
      kind: kind ?? this.kind,
      at: at ?? this.at,
      completionId: completionId ?? this.completionId,
      logEntryId: logEntryId ?? this.logEntryId,
      label: label ?? this.label,
      barcode: barcode ?? this.barcode,
      ingredientId: ingredientId ?? this.ingredientId,
      unit: unit ?? this.unit,
      location: location ?? this.location,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lotId.present) {
      map['lot_id'] = Variable<int>(lotId.value);
    }
    if (delta.present) {
      map['delta'] = Variable<double>(delta.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (completionId.present) {
      map['completion_id'] = Variable<int>(completionId.value);
    }
    if (logEntryId.present) {
      map['log_entry_id'] = Variable<int>(logEntryId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<String>(ingredientId.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementsCompanion(')
          ..write('id: $id, ')
          ..write('lotId: $lotId, ')
          ..write('delta: $delta, ')
          ..write('kind: $kind, ')
          ..write('at: $at, ')
          ..write('completionId: $completionId, ')
          ..write('logEntryId: $logEntryId, ')
          ..write('label: $label, ')
          ..write('barcode: $barcode, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('unit: $unit, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }
}

class $MealCompletionsTable extends MealCompletions
    with TableInfo<$MealCompletionsTable, MealCompletionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealCompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _menuIdMeta = const VerificationMeta('menuId');
  @override
  late final GeneratedColumn<int> menuId = GeneratedColumn<int>(
    'menu_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES week_menus (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<String> slot = GeneratedColumn<String>(
    'slot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _extraIdMeta = const VerificationMeta(
    'extraId',
  );
  @override
  late final GeneratedColumn<int> extraId = GeneratedColumn<int>(
    'extra_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cookedServingsMeta = const VerificationMeta(
    'cookedServings',
  );
  @override
  late final GeneratedColumn<int> cookedServings = GeneratedColumn<int>(
    'cooked_servings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _portionsEatenMeta = const VerificationMeta(
    'portionsEaten',
  );
  @override
  late final GeneratedColumn<double> portionsEaten = GeneratedColumn<double>(
    'portions_eaten',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _excludedMeta = const VerificationMeta(
    'excluded',
  );
  @override
  late final GeneratedColumn<String> excluded = GeneratedColumn<String>(
    'excluded',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _replacementsMeta = const VerificationMeta(
    'replacements',
  );
  @override
  late final GeneratedColumn<String> replacements = GeneratedColumn<String>(
    'replacements',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    menuId,
    slot,
    extraId,
    recipeId,
    cookedServings,
    portionsEaten,
    excluded,
    replacements,
    at,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_completions';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealCompletionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('menu_id')) {
      context.handle(
        _menuIdMeta,
        menuId.isAcceptableOrUnknown(data['menu_id']!, _menuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_menuIdMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    }
    if (data.containsKey('extra_id')) {
      context.handle(
        _extraIdMeta,
        extraId.isAcceptableOrUnknown(data['extra_id']!, _extraIdMeta),
      );
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('cooked_servings')) {
      context.handle(
        _cookedServingsMeta,
        cookedServings.isAcceptableOrUnknown(
          data['cooked_servings']!,
          _cookedServingsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cookedServingsMeta);
    }
    if (data.containsKey('portions_eaten')) {
      context.handle(
        _portionsEatenMeta,
        portionsEaten.isAcceptableOrUnknown(
          data['portions_eaten']!,
          _portionsEatenMeta,
        ),
      );
    }
    if (data.containsKey('excluded')) {
      context.handle(
        _excludedMeta,
        excluded.isAcceptableOrUnknown(data['excluded']!, _excludedMeta),
      );
    }
    if (data.containsKey('replacements')) {
      context.handle(
        _replacementsMeta,
        replacements.isAcceptableOrUnknown(
          data['replacements']!,
          _replacementsMeta,
        ),
      );
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealCompletionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealCompletionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      menuId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}menu_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slot'],
      ),
      extraId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}extra_id'],
      ),
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      cookedServings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cooked_servings'],
      )!,
      portionsEaten: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}portions_eaten'],
      )!,
      excluded: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}excluded'],
      )!,
      replacements: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}replacements'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
    );
  }

  @override
  $MealCompletionsTable createAlias(String alias) {
    return $MealCompletionsTable(attachedDatabase, alias);
  }
}

class MealCompletionRow extends DataClass
    implements Insertable<MealCompletionRow> {
  final int id;
  final int menuId;

  /// Créneau « jour:repas », ou null pour un extra.
  final String? slot;
  final int? extraId;
  final int recipeId;
  final int cookedServings;
  final double portionsEaten;
  final String excluded;

  /// JSON { ingrédient d'origine: remplacement }.
  final String replacements;
  final DateTime at;
  const MealCompletionRow({
    required this.id,
    required this.menuId,
    this.slot,
    this.extraId,
    required this.recipeId,
    required this.cookedServings,
    required this.portionsEaten,
    required this.excluded,
    required this.replacements,
    required this.at,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['menu_id'] = Variable<int>(menuId);
    if (!nullToAbsent || slot != null) {
      map['slot'] = Variable<String>(slot);
    }
    if (!nullToAbsent || extraId != null) {
      map['extra_id'] = Variable<int>(extraId);
    }
    map['recipe_id'] = Variable<int>(recipeId);
    map['cooked_servings'] = Variable<int>(cookedServings);
    map['portions_eaten'] = Variable<double>(portionsEaten);
    map['excluded'] = Variable<String>(excluded);
    map['replacements'] = Variable<String>(replacements);
    map['at'] = Variable<DateTime>(at);
    return map;
  }

  MealCompletionsCompanion toCompanion(bool nullToAbsent) {
    return MealCompletionsCompanion(
      id: Value(id),
      menuId: Value(menuId),
      slot: slot == null && nullToAbsent ? const Value.absent() : Value(slot),
      extraId: extraId == null && nullToAbsent
          ? const Value.absent()
          : Value(extraId),
      recipeId: Value(recipeId),
      cookedServings: Value(cookedServings),
      portionsEaten: Value(portionsEaten),
      excluded: Value(excluded),
      replacements: Value(replacements),
      at: Value(at),
    );
  }

  factory MealCompletionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealCompletionRow(
      id: serializer.fromJson<int>(json['id']),
      menuId: serializer.fromJson<int>(json['menuId']),
      slot: serializer.fromJson<String?>(json['slot']),
      extraId: serializer.fromJson<int?>(json['extraId']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      cookedServings: serializer.fromJson<int>(json['cookedServings']),
      portionsEaten: serializer.fromJson<double>(json['portionsEaten']),
      excluded: serializer.fromJson<String>(json['excluded']),
      replacements: serializer.fromJson<String>(json['replacements']),
      at: serializer.fromJson<DateTime>(json['at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'menuId': serializer.toJson<int>(menuId),
      'slot': serializer.toJson<String?>(slot),
      'extraId': serializer.toJson<int?>(extraId),
      'recipeId': serializer.toJson<int>(recipeId),
      'cookedServings': serializer.toJson<int>(cookedServings),
      'portionsEaten': serializer.toJson<double>(portionsEaten),
      'excluded': serializer.toJson<String>(excluded),
      'replacements': serializer.toJson<String>(replacements),
      'at': serializer.toJson<DateTime>(at),
    };
  }

  MealCompletionRow copyWith({
    int? id,
    int? menuId,
    Value<String?> slot = const Value.absent(),
    Value<int?> extraId = const Value.absent(),
    int? recipeId,
    int? cookedServings,
    double? portionsEaten,
    String? excluded,
    String? replacements,
    DateTime? at,
  }) => MealCompletionRow(
    id: id ?? this.id,
    menuId: menuId ?? this.menuId,
    slot: slot.present ? slot.value : this.slot,
    extraId: extraId.present ? extraId.value : this.extraId,
    recipeId: recipeId ?? this.recipeId,
    cookedServings: cookedServings ?? this.cookedServings,
    portionsEaten: portionsEaten ?? this.portionsEaten,
    excluded: excluded ?? this.excluded,
    replacements: replacements ?? this.replacements,
    at: at ?? this.at,
  );
  MealCompletionRow copyWithCompanion(MealCompletionsCompanion data) {
    return MealCompletionRow(
      id: data.id.present ? data.id.value : this.id,
      menuId: data.menuId.present ? data.menuId.value : this.menuId,
      slot: data.slot.present ? data.slot.value : this.slot,
      extraId: data.extraId.present ? data.extraId.value : this.extraId,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      cookedServings: data.cookedServings.present
          ? data.cookedServings.value
          : this.cookedServings,
      portionsEaten: data.portionsEaten.present
          ? data.portionsEaten.value
          : this.portionsEaten,
      excluded: data.excluded.present ? data.excluded.value : this.excluded,
      replacements: data.replacements.present
          ? data.replacements.value
          : this.replacements,
      at: data.at.present ? data.at.value : this.at,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealCompletionRow(')
          ..write('id: $id, ')
          ..write('menuId: $menuId, ')
          ..write('slot: $slot, ')
          ..write('extraId: $extraId, ')
          ..write('recipeId: $recipeId, ')
          ..write('cookedServings: $cookedServings, ')
          ..write('portionsEaten: $portionsEaten, ')
          ..write('excluded: $excluded, ')
          ..write('replacements: $replacements, ')
          ..write('at: $at')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    menuId,
    slot,
    extraId,
    recipeId,
    cookedServings,
    portionsEaten,
    excluded,
    replacements,
    at,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealCompletionRow &&
          other.id == this.id &&
          other.menuId == this.menuId &&
          other.slot == this.slot &&
          other.extraId == this.extraId &&
          other.recipeId == this.recipeId &&
          other.cookedServings == this.cookedServings &&
          other.portionsEaten == this.portionsEaten &&
          other.excluded == this.excluded &&
          other.replacements == this.replacements &&
          other.at == this.at);
}

class MealCompletionsCompanion extends UpdateCompanion<MealCompletionRow> {
  final Value<int> id;
  final Value<int> menuId;
  final Value<String?> slot;
  final Value<int?> extraId;
  final Value<int> recipeId;
  final Value<int> cookedServings;
  final Value<double> portionsEaten;
  final Value<String> excluded;
  final Value<String> replacements;
  final Value<DateTime> at;
  const MealCompletionsCompanion({
    this.id = const Value.absent(),
    this.menuId = const Value.absent(),
    this.slot = const Value.absent(),
    this.extraId = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.cookedServings = const Value.absent(),
    this.portionsEaten = const Value.absent(),
    this.excluded = const Value.absent(),
    this.replacements = const Value.absent(),
    this.at = const Value.absent(),
  });
  MealCompletionsCompanion.insert({
    this.id = const Value.absent(),
    required int menuId,
    this.slot = const Value.absent(),
    this.extraId = const Value.absent(),
    required int recipeId,
    required int cookedServings,
    this.portionsEaten = const Value.absent(),
    this.excluded = const Value.absent(),
    this.replacements = const Value.absent(),
    required DateTime at,
  }) : menuId = Value(menuId),
       recipeId = Value(recipeId),
       cookedServings = Value(cookedServings),
       at = Value(at);
  static Insertable<MealCompletionRow> custom({
    Expression<int>? id,
    Expression<int>? menuId,
    Expression<String>? slot,
    Expression<int>? extraId,
    Expression<int>? recipeId,
    Expression<int>? cookedServings,
    Expression<double>? portionsEaten,
    Expression<String>? excluded,
    Expression<String>? replacements,
    Expression<DateTime>? at,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (menuId != null) 'menu_id': menuId,
      if (slot != null) 'slot': slot,
      if (extraId != null) 'extra_id': extraId,
      if (recipeId != null) 'recipe_id': recipeId,
      if (cookedServings != null) 'cooked_servings': cookedServings,
      if (portionsEaten != null) 'portions_eaten': portionsEaten,
      if (excluded != null) 'excluded': excluded,
      if (replacements != null) 'replacements': replacements,
      if (at != null) 'at': at,
    });
  }

  MealCompletionsCompanion copyWith({
    Value<int>? id,
    Value<int>? menuId,
    Value<String?>? slot,
    Value<int?>? extraId,
    Value<int>? recipeId,
    Value<int>? cookedServings,
    Value<double>? portionsEaten,
    Value<String>? excluded,
    Value<String>? replacements,
    Value<DateTime>? at,
  }) {
    return MealCompletionsCompanion(
      id: id ?? this.id,
      menuId: menuId ?? this.menuId,
      slot: slot ?? this.slot,
      extraId: extraId ?? this.extraId,
      recipeId: recipeId ?? this.recipeId,
      cookedServings: cookedServings ?? this.cookedServings,
      portionsEaten: portionsEaten ?? this.portionsEaten,
      excluded: excluded ?? this.excluded,
      replacements: replacements ?? this.replacements,
      at: at ?? this.at,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (menuId.present) {
      map['menu_id'] = Variable<int>(menuId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<String>(slot.value);
    }
    if (extraId.present) {
      map['extra_id'] = Variable<int>(extraId.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (cookedServings.present) {
      map['cooked_servings'] = Variable<int>(cookedServings.value);
    }
    if (portionsEaten.present) {
      map['portions_eaten'] = Variable<double>(portionsEaten.value);
    }
    if (excluded.present) {
      map['excluded'] = Variable<String>(excluded.value);
    }
    if (replacements.present) {
      map['replacements'] = Variable<String>(replacements.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealCompletionsCompanion(')
          ..write('id: $id, ')
          ..write('menuId: $menuId, ')
          ..write('slot: $slot, ')
          ..write('extraId: $extraId, ')
          ..write('recipeId: $recipeId, ')
          ..write('cookedServings: $cookedServings, ')
          ..write('portionsEaten: $portionsEaten, ')
          ..write('excluded: $excluded, ')
          ..write('replacements: $replacements, ')
          ..write('at: $at')
          ..write(')'))
        .toString();
  }
}

class $FoodLogEntriesTable extends FoodLogEntries
    with TableInfo<$FoodLogEntriesTable, FoodLogEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodLogEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _momentMeta = const VerificationMeta('moment');
  @override
  late final GeneratedColumn<String> moment = GeneratedColumn<String>(
    'moment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refMeta = const VerificationMeta('ref');
  @override
  late final GeneratedColumn<String> ref = GeneratedColumn<String>(
    'ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gramsMeta = const VerificationMeta('grams');
  @override
  late final GeneratedColumn<double> grams = GeneratedColumn<double>(
    'grams',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kcalMeta = const VerificationMeta('kcal');
  @override
  late final GeneratedColumn<double> kcal = GeneratedColumn<double>(
    'kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinMeta = const VerificationMeta(
    'protein',
  );
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
    'protein',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _carbsMeta = const VerificationMeta('carbs');
  @override
  late final GeneratedColumn<double> carbs = GeneratedColumn<double>(
    'carbs',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
    'fat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completionIdMeta = const VerificationMeta(
    'completionId',
  );
  @override
  late final GeneratedColumn<int> completionId = GeneratedColumn<int>(
    'completion_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    moment,
    label,
    source,
    ref,
    grams,
    kcal,
    protein,
    carbs,
    fat,
    completionId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_log_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodLogEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('moment')) {
      context.handle(
        _momentMeta,
        moment.isAcceptableOrUnknown(data['moment']!, _momentMeta),
      );
    } else if (isInserting) {
      context.missing(_momentMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('ref')) {
      context.handle(
        _refMeta,
        ref.isAcceptableOrUnknown(data['ref']!, _refMeta),
      );
    }
    if (data.containsKey('grams')) {
      context.handle(
        _gramsMeta,
        grams.isAcceptableOrUnknown(data['grams']!, _gramsMeta),
      );
    }
    if (data.containsKey('kcal')) {
      context.handle(
        _kcalMeta,
        kcal.isAcceptableOrUnknown(data['kcal']!, _kcalMeta),
      );
    } else if (isInserting) {
      context.missing(_kcalMeta);
    }
    if (data.containsKey('protein')) {
      context.handle(
        _proteinMeta,
        protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta),
      );
    }
    if (data.containsKey('carbs')) {
      context.handle(
        _carbsMeta,
        carbs.isAcceptableOrUnknown(data['carbs']!, _carbsMeta),
      );
    }
    if (data.containsKey('fat')) {
      context.handle(
        _fatMeta,
        fat.isAcceptableOrUnknown(data['fat']!, _fatMeta),
      );
    }
    if (data.containsKey('completion_id')) {
      context.handle(
        _completionIdMeta,
        completionId.isAcceptableOrUnknown(
          data['completion_id']!,
          _completionIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodLogEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodLogEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      moment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}moment'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      ref: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ref'],
      ),
      grams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grams'],
      ),
      kcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal'],
      )!,
      protein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein'],
      )!,
      carbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs'],
      )!,
      fat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat'],
      )!,
      completionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completion_id'],
      ),
    );
  }

  @override
  $FoodLogEntriesTable createAlias(String alias) {
    return $FoodLogEntriesTable(attachedDatabase, alias);
  }
}

class FoodLogEntryRow extends DataClass implements Insertable<FoodLogEntryRow> {
  final int id;
  final DateTime date;
  final String moment;
  final String label;
  final String source;
  final String? ref;
  final double? grams;
  final double kcal;
  final double protein;
  final double carbs;
  final double fat;
  final int? completionId;
  const FoodLogEntryRow({
    required this.id,
    required this.date,
    required this.moment,
    required this.label,
    required this.source,
    this.ref,
    this.grams,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.completionId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['moment'] = Variable<String>(moment);
    map['label'] = Variable<String>(label);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || ref != null) {
      map['ref'] = Variable<String>(ref);
    }
    if (!nullToAbsent || grams != null) {
      map['grams'] = Variable<double>(grams);
    }
    map['kcal'] = Variable<double>(kcal);
    map['protein'] = Variable<double>(protein);
    map['carbs'] = Variable<double>(carbs);
    map['fat'] = Variable<double>(fat);
    if (!nullToAbsent || completionId != null) {
      map['completion_id'] = Variable<int>(completionId);
    }
    return map;
  }

  FoodLogEntriesCompanion toCompanion(bool nullToAbsent) {
    return FoodLogEntriesCompanion(
      id: Value(id),
      date: Value(date),
      moment: Value(moment),
      label: Value(label),
      source: Value(source),
      ref: ref == null && nullToAbsent ? const Value.absent() : Value(ref),
      grams: grams == null && nullToAbsent
          ? const Value.absent()
          : Value(grams),
      kcal: Value(kcal),
      protein: Value(protein),
      carbs: Value(carbs),
      fat: Value(fat),
      completionId: completionId == null && nullToAbsent
          ? const Value.absent()
          : Value(completionId),
    );
  }

  factory FoodLogEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodLogEntryRow(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      moment: serializer.fromJson<String>(json['moment']),
      label: serializer.fromJson<String>(json['label']),
      source: serializer.fromJson<String>(json['source']),
      ref: serializer.fromJson<String?>(json['ref']),
      grams: serializer.fromJson<double?>(json['grams']),
      kcal: serializer.fromJson<double>(json['kcal']),
      protein: serializer.fromJson<double>(json['protein']),
      carbs: serializer.fromJson<double>(json['carbs']),
      fat: serializer.fromJson<double>(json['fat']),
      completionId: serializer.fromJson<int?>(json['completionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'moment': serializer.toJson<String>(moment),
      'label': serializer.toJson<String>(label),
      'source': serializer.toJson<String>(source),
      'ref': serializer.toJson<String?>(ref),
      'grams': serializer.toJson<double?>(grams),
      'kcal': serializer.toJson<double>(kcal),
      'protein': serializer.toJson<double>(protein),
      'carbs': serializer.toJson<double>(carbs),
      'fat': serializer.toJson<double>(fat),
      'completionId': serializer.toJson<int?>(completionId),
    };
  }

  FoodLogEntryRow copyWith({
    int? id,
    DateTime? date,
    String? moment,
    String? label,
    String? source,
    Value<String?> ref = const Value.absent(),
    Value<double?> grams = const Value.absent(),
    double? kcal,
    double? protein,
    double? carbs,
    double? fat,
    Value<int?> completionId = const Value.absent(),
  }) => FoodLogEntryRow(
    id: id ?? this.id,
    date: date ?? this.date,
    moment: moment ?? this.moment,
    label: label ?? this.label,
    source: source ?? this.source,
    ref: ref.present ? ref.value : this.ref,
    grams: grams.present ? grams.value : this.grams,
    kcal: kcal ?? this.kcal,
    protein: protein ?? this.protein,
    carbs: carbs ?? this.carbs,
    fat: fat ?? this.fat,
    completionId: completionId.present ? completionId.value : this.completionId,
  );
  FoodLogEntryRow copyWithCompanion(FoodLogEntriesCompanion data) {
    return FoodLogEntryRow(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      moment: data.moment.present ? data.moment.value : this.moment,
      label: data.label.present ? data.label.value : this.label,
      source: data.source.present ? data.source.value : this.source,
      ref: data.ref.present ? data.ref.value : this.ref,
      grams: data.grams.present ? data.grams.value : this.grams,
      kcal: data.kcal.present ? data.kcal.value : this.kcal,
      protein: data.protein.present ? data.protein.value : this.protein,
      carbs: data.carbs.present ? data.carbs.value : this.carbs,
      fat: data.fat.present ? data.fat.value : this.fat,
      completionId: data.completionId.present
          ? data.completionId.value
          : this.completionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodLogEntryRow(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('moment: $moment, ')
          ..write('label: $label, ')
          ..write('source: $source, ')
          ..write('ref: $ref, ')
          ..write('grams: $grams, ')
          ..write('kcal: $kcal, ')
          ..write('protein: $protein, ')
          ..write('carbs: $carbs, ')
          ..write('fat: $fat, ')
          ..write('completionId: $completionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    moment,
    label,
    source,
    ref,
    grams,
    kcal,
    protein,
    carbs,
    fat,
    completionId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodLogEntryRow &&
          other.id == this.id &&
          other.date == this.date &&
          other.moment == this.moment &&
          other.label == this.label &&
          other.source == this.source &&
          other.ref == this.ref &&
          other.grams == this.grams &&
          other.kcal == this.kcal &&
          other.protein == this.protein &&
          other.carbs == this.carbs &&
          other.fat == this.fat &&
          other.completionId == this.completionId);
}

class FoodLogEntriesCompanion extends UpdateCompanion<FoodLogEntryRow> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> moment;
  final Value<String> label;
  final Value<String> source;
  final Value<String?> ref;
  final Value<double?> grams;
  final Value<double> kcal;
  final Value<double> protein;
  final Value<double> carbs;
  final Value<double> fat;
  final Value<int?> completionId;
  const FoodLogEntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.moment = const Value.absent(),
    this.label = const Value.absent(),
    this.source = const Value.absent(),
    this.ref = const Value.absent(),
    this.grams = const Value.absent(),
    this.kcal = const Value.absent(),
    this.protein = const Value.absent(),
    this.carbs = const Value.absent(),
    this.fat = const Value.absent(),
    this.completionId = const Value.absent(),
  });
  FoodLogEntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String moment,
    required String label,
    required String source,
    this.ref = const Value.absent(),
    this.grams = const Value.absent(),
    required double kcal,
    this.protein = const Value.absent(),
    this.carbs = const Value.absent(),
    this.fat = const Value.absent(),
    this.completionId = const Value.absent(),
  }) : date = Value(date),
       moment = Value(moment),
       label = Value(label),
       source = Value(source),
       kcal = Value(kcal);
  static Insertable<FoodLogEntryRow> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? moment,
    Expression<String>? label,
    Expression<String>? source,
    Expression<String>? ref,
    Expression<double>? grams,
    Expression<double>? kcal,
    Expression<double>? protein,
    Expression<double>? carbs,
    Expression<double>? fat,
    Expression<int>? completionId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (moment != null) 'moment': moment,
      if (label != null) 'label': label,
      if (source != null) 'source': source,
      if (ref != null) 'ref': ref,
      if (grams != null) 'grams': grams,
      if (kcal != null) 'kcal': kcal,
      if (protein != null) 'protein': protein,
      if (carbs != null) 'carbs': carbs,
      if (fat != null) 'fat': fat,
      if (completionId != null) 'completion_id': completionId,
    });
  }

  FoodLogEntriesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? moment,
    Value<String>? label,
    Value<String>? source,
    Value<String?>? ref,
    Value<double?>? grams,
    Value<double>? kcal,
    Value<double>? protein,
    Value<double>? carbs,
    Value<double>? fat,
    Value<int?>? completionId,
  }) {
    return FoodLogEntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      moment: moment ?? this.moment,
      label: label ?? this.label,
      source: source ?? this.source,
      ref: ref ?? this.ref,
      grams: grams ?? this.grams,
      kcal: kcal ?? this.kcal,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      completionId: completionId ?? this.completionId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (moment.present) {
      map['moment'] = Variable<String>(moment.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (ref.present) {
      map['ref'] = Variable<String>(ref.value);
    }
    if (grams.present) {
      map['grams'] = Variable<double>(grams.value);
    }
    if (kcal.present) {
      map['kcal'] = Variable<double>(kcal.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (carbs.present) {
      map['carbs'] = Variable<double>(carbs.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (completionId.present) {
      map['completion_id'] = Variable<int>(completionId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodLogEntriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('moment: $moment, ')
          ..write('label: $label, ')
          ..write('source: $source, ')
          ..write('ref: $ref, ')
          ..write('grams: $grams, ')
          ..write('kcal: $kcal, ')
          ..write('protein: $protein, ')
          ..write('carbs: $carbs, ')
          ..write('fat: $fat, ')
          ..write('completionId: $completionId')
          ..write(')'))
        .toString();
  }
}

class $MealPresetsTable extends MealPresets
    with TableInfo<$MealPresetsTable, MealPresetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealPresetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _defaultMomentMeta = const VerificationMeta(
    'defaultMoment',
  );
  @override
  late final GeneratedColumn<String> defaultMoment = GeneratedColumn<String>(
    'default_moment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recipePortionsMeta = const VerificationMeta(
    'recipePortions',
  );
  @override
  late final GeneratedColumn<double> recipePortions = GeneratedColumn<double>(
    'recipe_portions',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    defaultMoment,
    recipeId,
    recipePortions,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_presets';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealPresetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('default_moment')) {
      context.handle(
        _defaultMomentMeta,
        defaultMoment.isAcceptableOrUnknown(
          data['default_moment']!,
          _defaultMomentMeta,
        ),
      );
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    }
    if (data.containsKey('recipe_portions')) {
      context.handle(
        _recipePortionsMeta,
        recipePortions.isAcceptableOrUnknown(
          data['recipe_portions']!,
          _recipePortionsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealPresetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealPresetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      defaultMoment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_moment'],
      ),
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      ),
      recipePortions: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}recipe_portions'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MealPresetsTable createAlias(String alias) {
    return $MealPresetsTable(attachedDatabase, alias);
  }
}

class MealPresetRow extends DataClass implements Insertable<MealPresetRow> {
  final int id;
  final String name;
  final String? defaultMoment;
  final int? recipeId;
  final double? recipePortions;
  final DateTime createdAt;
  const MealPresetRow({
    required this.id,
    required this.name,
    this.defaultMoment,
    this.recipeId,
    this.recipePortions,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || defaultMoment != null) {
      map['default_moment'] = Variable<String>(defaultMoment);
    }
    if (!nullToAbsent || recipeId != null) {
      map['recipe_id'] = Variable<int>(recipeId);
    }
    if (!nullToAbsent || recipePortions != null) {
      map['recipe_portions'] = Variable<double>(recipePortions);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MealPresetsCompanion toCompanion(bool nullToAbsent) {
    return MealPresetsCompanion(
      id: Value(id),
      name: Value(name),
      defaultMoment: defaultMoment == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultMoment),
      recipeId: recipeId == null && nullToAbsent
          ? const Value.absent()
          : Value(recipeId),
      recipePortions: recipePortions == null && nullToAbsent
          ? const Value.absent()
          : Value(recipePortions),
      createdAt: Value(createdAt),
    );
  }

  factory MealPresetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealPresetRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      defaultMoment: serializer.fromJson<String?>(json['defaultMoment']),
      recipeId: serializer.fromJson<int?>(json['recipeId']),
      recipePortions: serializer.fromJson<double?>(json['recipePortions']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'defaultMoment': serializer.toJson<String?>(defaultMoment),
      'recipeId': serializer.toJson<int?>(recipeId),
      'recipePortions': serializer.toJson<double?>(recipePortions),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MealPresetRow copyWith({
    int? id,
    String? name,
    Value<String?> defaultMoment = const Value.absent(),
    Value<int?> recipeId = const Value.absent(),
    Value<double?> recipePortions = const Value.absent(),
    DateTime? createdAt,
  }) => MealPresetRow(
    id: id ?? this.id,
    name: name ?? this.name,
    defaultMoment: defaultMoment.present
        ? defaultMoment.value
        : this.defaultMoment,
    recipeId: recipeId.present ? recipeId.value : this.recipeId,
    recipePortions: recipePortions.present
        ? recipePortions.value
        : this.recipePortions,
    createdAt: createdAt ?? this.createdAt,
  );
  MealPresetRow copyWithCompanion(MealPresetsCompanion data) {
    return MealPresetRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      defaultMoment: data.defaultMoment.present
          ? data.defaultMoment.value
          : this.defaultMoment,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      recipePortions: data.recipePortions.present
          ? data.recipePortions.value
          : this.recipePortions,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealPresetRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('defaultMoment: $defaultMoment, ')
          ..write('recipeId: $recipeId, ')
          ..write('recipePortions: $recipePortions, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, defaultMoment, recipeId, recipePortions, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealPresetRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.defaultMoment == this.defaultMoment &&
          other.recipeId == this.recipeId &&
          other.recipePortions == this.recipePortions &&
          other.createdAt == this.createdAt);
}

class MealPresetsCompanion extends UpdateCompanion<MealPresetRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> defaultMoment;
  final Value<int?> recipeId;
  final Value<double?> recipePortions;
  final Value<DateTime> createdAt;
  const MealPresetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.defaultMoment = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.recipePortions = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MealPresetsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.defaultMoment = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.recipePortions = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<MealPresetRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? defaultMoment,
    Expression<int>? recipeId,
    Expression<double>? recipePortions,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (defaultMoment != null) 'default_moment': defaultMoment,
      if (recipeId != null) 'recipe_id': recipeId,
      if (recipePortions != null) 'recipe_portions': recipePortions,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MealPresetsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? defaultMoment,
    Value<int?>? recipeId,
    Value<double?>? recipePortions,
    Value<DateTime>? createdAt,
  }) {
    return MealPresetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      defaultMoment: defaultMoment ?? this.defaultMoment,
      recipeId: recipeId ?? this.recipeId,
      recipePortions: recipePortions ?? this.recipePortions,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (defaultMoment.present) {
      map['default_moment'] = Variable<String>(defaultMoment.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (recipePortions.present) {
      map['recipe_portions'] = Variable<double>(recipePortions.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealPresetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('defaultMoment: $defaultMoment, ')
          ..write('recipeId: $recipeId, ')
          ..write('recipePortions: $recipePortions, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MealPresetItemsTable extends MealPresetItems
    with TableInfo<$MealPresetItemsTable, MealPresetItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealPresetItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _presetIdMeta = const VerificationMeta(
    'presetId',
  );
  @override
  late final GeneratedColumn<int> presetId = GeneratedColumn<int>(
    'preset_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meal_presets (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gramsMeta = const VerificationMeta('grams');
  @override
  late final GeneratedColumn<double> grams = GeneratedColumn<double>(
    'grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nutritionMeta = const VerificationMeta(
    'nutrition',
  );
  @override
  late final GeneratedColumn<String> nutrition = GeneratedColumn<String>(
    'nutrition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<String> ingredientId = GeneratedColumn<String>(
    'ingredient_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    presetId,
    label,
    grams,
    nutrition,
    ingredientId,
    barcode,
    position,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_preset_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealPresetItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('preset_id')) {
      context.handle(
        _presetIdMeta,
        presetId.isAcceptableOrUnknown(data['preset_id']!, _presetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_presetIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('grams')) {
      context.handle(
        _gramsMeta,
        grams.isAcceptableOrUnknown(data['grams']!, _gramsMeta),
      );
    } else if (isInserting) {
      context.missing(_gramsMeta);
    }
    if (data.containsKey('nutrition')) {
      context.handle(
        _nutritionMeta,
        nutrition.isAcceptableOrUnknown(data['nutrition']!, _nutritionMeta),
      );
    } else if (isInserting) {
      context.missing(_nutritionMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealPresetItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealPresetItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      presetId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preset_id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      grams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grams'],
      )!,
      nutrition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nutrition'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_id'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $MealPresetItemsTable createAlias(String alias) {
    return $MealPresetItemsTable(attachedDatabase, alias);
  }
}

class MealPresetItemRow extends DataClass
    implements Insertable<MealPresetItemRow> {
  final int id;
  final int presetId;
  final String label;
  final double grams;
  final String nutrition;
  final String? ingredientId;
  final String? barcode;
  final int position;
  const MealPresetItemRow({
    required this.id,
    required this.presetId,
    required this.label,
    required this.grams,
    required this.nutrition,
    this.ingredientId,
    this.barcode,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['preset_id'] = Variable<int>(presetId);
    map['label'] = Variable<String>(label);
    map['grams'] = Variable<double>(grams);
    map['nutrition'] = Variable<String>(nutrition);
    if (!nullToAbsent || ingredientId != null) {
      map['ingredient_id'] = Variable<String>(ingredientId);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['position'] = Variable<int>(position);
    return map;
  }

  MealPresetItemsCompanion toCompanion(bool nullToAbsent) {
    return MealPresetItemsCompanion(
      id: Value(id),
      presetId: Value(presetId),
      label: Value(label),
      grams: Value(grams),
      nutrition: Value(nutrition),
      ingredientId: ingredientId == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientId),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      position: Value(position),
    );
  }

  factory MealPresetItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealPresetItemRow(
      id: serializer.fromJson<int>(json['id']),
      presetId: serializer.fromJson<int>(json['presetId']),
      label: serializer.fromJson<String>(json['label']),
      grams: serializer.fromJson<double>(json['grams']),
      nutrition: serializer.fromJson<String>(json['nutrition']),
      ingredientId: serializer.fromJson<String?>(json['ingredientId']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'presetId': serializer.toJson<int>(presetId),
      'label': serializer.toJson<String>(label),
      'grams': serializer.toJson<double>(grams),
      'nutrition': serializer.toJson<String>(nutrition),
      'ingredientId': serializer.toJson<String?>(ingredientId),
      'barcode': serializer.toJson<String?>(barcode),
      'position': serializer.toJson<int>(position),
    };
  }

  MealPresetItemRow copyWith({
    int? id,
    int? presetId,
    String? label,
    double? grams,
    String? nutrition,
    Value<String?> ingredientId = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    int? position,
  }) => MealPresetItemRow(
    id: id ?? this.id,
    presetId: presetId ?? this.presetId,
    label: label ?? this.label,
    grams: grams ?? this.grams,
    nutrition: nutrition ?? this.nutrition,
    ingredientId: ingredientId.present ? ingredientId.value : this.ingredientId,
    barcode: barcode.present ? barcode.value : this.barcode,
    position: position ?? this.position,
  );
  MealPresetItemRow copyWithCompanion(MealPresetItemsCompanion data) {
    return MealPresetItemRow(
      id: data.id.present ? data.id.value : this.id,
      presetId: data.presetId.present ? data.presetId.value : this.presetId,
      label: data.label.present ? data.label.value : this.label,
      grams: data.grams.present ? data.grams.value : this.grams,
      nutrition: data.nutrition.present ? data.nutrition.value : this.nutrition,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealPresetItemRow(')
          ..write('id: $id, ')
          ..write('presetId: $presetId, ')
          ..write('label: $label, ')
          ..write('grams: $grams, ')
          ..write('nutrition: $nutrition, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('barcode: $barcode, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    presetId,
    label,
    grams,
    nutrition,
    ingredientId,
    barcode,
    position,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealPresetItemRow &&
          other.id == this.id &&
          other.presetId == this.presetId &&
          other.label == this.label &&
          other.grams == this.grams &&
          other.nutrition == this.nutrition &&
          other.ingredientId == this.ingredientId &&
          other.barcode == this.barcode &&
          other.position == this.position);
}

class MealPresetItemsCompanion extends UpdateCompanion<MealPresetItemRow> {
  final Value<int> id;
  final Value<int> presetId;
  final Value<String> label;
  final Value<double> grams;
  final Value<String> nutrition;
  final Value<String?> ingredientId;
  final Value<String?> barcode;
  final Value<int> position;
  const MealPresetItemsCompanion({
    this.id = const Value.absent(),
    this.presetId = const Value.absent(),
    this.label = const Value.absent(),
    this.grams = const Value.absent(),
    this.nutrition = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.barcode = const Value.absent(),
    this.position = const Value.absent(),
  });
  MealPresetItemsCompanion.insert({
    this.id = const Value.absent(),
    required int presetId,
    required String label,
    required double grams,
    required String nutrition,
    this.ingredientId = const Value.absent(),
    this.barcode = const Value.absent(),
    required int position,
  }) : presetId = Value(presetId),
       label = Value(label),
       grams = Value(grams),
       nutrition = Value(nutrition),
       position = Value(position);
  static Insertable<MealPresetItemRow> custom({
    Expression<int>? id,
    Expression<int>? presetId,
    Expression<String>? label,
    Expression<double>? grams,
    Expression<String>? nutrition,
    Expression<String>? ingredientId,
    Expression<String>? barcode,
    Expression<int>? position,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (presetId != null) 'preset_id': presetId,
      if (label != null) 'label': label,
      if (grams != null) 'grams': grams,
      if (nutrition != null) 'nutrition': nutrition,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (barcode != null) 'barcode': barcode,
      if (position != null) 'position': position,
    });
  }

  MealPresetItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? presetId,
    Value<String>? label,
    Value<double>? grams,
    Value<String>? nutrition,
    Value<String?>? ingredientId,
    Value<String?>? barcode,
    Value<int>? position,
  }) {
    return MealPresetItemsCompanion(
      id: id ?? this.id,
      presetId: presetId ?? this.presetId,
      label: label ?? this.label,
      grams: grams ?? this.grams,
      nutrition: nutrition ?? this.nutrition,
      ingredientId: ingredientId ?? this.ingredientId,
      barcode: barcode ?? this.barcode,
      position: position ?? this.position,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (presetId.present) {
      map['preset_id'] = Variable<int>(presetId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (grams.present) {
      map['grams'] = Variable<double>(grams.value);
    }
    if (nutrition.present) {
      map['nutrition'] = Variable<String>(nutrition.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<String>(ingredientId.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealPresetItemsCompanion(')
          ..write('id: $id, ')
          ..write('presetId: $presetId, ')
          ..write('label: $label, ')
          ..write('grams: $grams, ')
          ..write('nutrition: $nutrition, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('barcode: $barcode, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }
}

class $NutritionProfilesTable extends NutritionProfiles
    with TableInfo<$NutritionProfilesTable, NutritionProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityMeta = const VerificationMeta(
    'activity',
  );
  @override
  late final GeneratedColumn<String> activity = GeneratedColumn<String>(
    'activity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sex,
    birthDate,
    heightCm,
    activity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<NutritionProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('activity')) {
      context.handle(
        _activityMeta,
        activity.isAcceptableOrUnknown(data['activity']!, _activityMeta),
      );
    } else if (isInserting) {
      context.missing(_activityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NutritionProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      )!,
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      )!,
      activity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity'],
      )!,
    );
  }

  @override
  $NutritionProfilesTable createAlias(String alias) {
    return $NutritionProfilesTable(attachedDatabase, alias);
  }
}

class NutritionProfileRow extends DataClass
    implements Insertable<NutritionProfileRow> {
  final int id;
  final String sex;
  final DateTime birthDate;
  final double heightCm;
  final String activity;
  const NutritionProfileRow({
    required this.id,
    required this.sex,
    required this.birthDate,
    required this.heightCm,
    required this.activity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sex'] = Variable<String>(sex);
    map['birth_date'] = Variable<DateTime>(birthDate);
    map['height_cm'] = Variable<double>(heightCm);
    map['activity'] = Variable<String>(activity);
    return map;
  }

  NutritionProfilesCompanion toCompanion(bool nullToAbsent) {
    return NutritionProfilesCompanion(
      id: Value(id),
      sex: Value(sex),
      birthDate: Value(birthDate),
      heightCm: Value(heightCm),
      activity: Value(activity),
    );
  }

  factory NutritionProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionProfileRow(
      id: serializer.fromJson<int>(json['id']),
      sex: serializer.fromJson<String>(json['sex']),
      birthDate: serializer.fromJson<DateTime>(json['birthDate']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      activity: serializer.fromJson<String>(json['activity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sex': serializer.toJson<String>(sex),
      'birthDate': serializer.toJson<DateTime>(birthDate),
      'heightCm': serializer.toJson<double>(heightCm),
      'activity': serializer.toJson<String>(activity),
    };
  }

  NutritionProfileRow copyWith({
    int? id,
    String? sex,
    DateTime? birthDate,
    double? heightCm,
    String? activity,
  }) => NutritionProfileRow(
    id: id ?? this.id,
    sex: sex ?? this.sex,
    birthDate: birthDate ?? this.birthDate,
    heightCm: heightCm ?? this.heightCm,
    activity: activity ?? this.activity,
  );
  NutritionProfileRow copyWithCompanion(NutritionProfilesCompanion data) {
    return NutritionProfileRow(
      id: data.id.present ? data.id.value : this.id,
      sex: data.sex.present ? data.sex.value : this.sex,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      activity: data.activity.present ? data.activity.value : this.activity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionProfileRow(')
          ..write('id: $id, ')
          ..write('sex: $sex, ')
          ..write('birthDate: $birthDate, ')
          ..write('heightCm: $heightCm, ')
          ..write('activity: $activity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sex, birthDate, heightCm, activity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionProfileRow &&
          other.id == this.id &&
          other.sex == this.sex &&
          other.birthDate == this.birthDate &&
          other.heightCm == this.heightCm &&
          other.activity == this.activity);
}

class NutritionProfilesCompanion extends UpdateCompanion<NutritionProfileRow> {
  final Value<int> id;
  final Value<String> sex;
  final Value<DateTime> birthDate;
  final Value<double> heightCm;
  final Value<String> activity;
  const NutritionProfilesCompanion({
    this.id = const Value.absent(),
    this.sex = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.activity = const Value.absent(),
  });
  NutritionProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String sex,
    required DateTime birthDate,
    required double heightCm,
    required String activity,
  }) : sex = Value(sex),
       birthDate = Value(birthDate),
       heightCm = Value(heightCm),
       activity = Value(activity);
  static Insertable<NutritionProfileRow> custom({
    Expression<int>? id,
    Expression<String>? sex,
    Expression<DateTime>? birthDate,
    Expression<double>? heightCm,
    Expression<String>? activity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sex != null) 'sex': sex,
      if (birthDate != null) 'birth_date': birthDate,
      if (heightCm != null) 'height_cm': heightCm,
      if (activity != null) 'activity': activity,
    });
  }

  NutritionProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? sex,
    Value<DateTime>? birthDate,
    Value<double>? heightCm,
    Value<String>? activity,
  }) {
    return NutritionProfilesCompanion(
      id: id ?? this.id,
      sex: sex ?? this.sex,
      birthDate: birthDate ?? this.birthDate,
      heightCm: heightCm ?? this.heightCm,
      activity: activity ?? this.activity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (activity.present) {
      map['activity'] = Variable<String>(activity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionProfilesCompanion(')
          ..write('id: $id, ')
          ..write('sex: $sex, ')
          ..write('birthDate: $birthDate, ')
          ..write('heightCm: $heightCm, ')
          ..write('activity: $activity')
          ..write(')'))
        .toString();
  }
}

class $NutritionGoalsTable extends NutritionGoals
    with TableInfo<$NutritionGoalsTable, NutritionGoalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dailyKcalDeltaMeta = const VerificationMeta(
    'dailyKcalDelta',
  );
  @override
  late final GeneratedColumn<double> dailyKcalDelta = GeneratedColumn<double>(
    'daily_kcal_delta',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetWeightKgMeta = const VerificationMeta(
    'targetWeightKg',
  );
  @override
  late final GeneratedColumn<double> targetWeightKg = GeneratedColumn<double>(
    'target_weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startDate,
    kind,
    dailyKcalDelta,
    targetWeightKg,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<NutritionGoalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('daily_kcal_delta')) {
      context.handle(
        _dailyKcalDeltaMeta,
        dailyKcalDelta.isAcceptableOrUnknown(
          data['daily_kcal_delta']!,
          _dailyKcalDeltaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyKcalDeltaMeta);
    }
    if (data.containsKey('target_weight_kg')) {
      context.handle(
        _targetWeightKgMeta,
        targetWeightKg.isAcceptableOrUnknown(
          data['target_weight_kg']!,
          _targetWeightKgMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NutritionGoalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionGoalRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      dailyKcalDelta: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}daily_kcal_delta'],
      )!,
      targetWeightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_weight_kg'],
      ),
    );
  }

  @override
  $NutritionGoalsTable createAlias(String alias) {
    return $NutritionGoalsTable(attachedDatabase, alias);
  }
}

class NutritionGoalRow extends DataClass
    implements Insertable<NutritionGoalRow> {
  final int id;
  final DateTime startDate;
  final String kind;
  final double dailyKcalDelta;
  final double? targetWeightKg;
  const NutritionGoalRow({
    required this.id,
    required this.startDate,
    required this.kind,
    required this.dailyKcalDelta,
    this.targetWeightKg,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_date'] = Variable<DateTime>(startDate);
    map['kind'] = Variable<String>(kind);
    map['daily_kcal_delta'] = Variable<double>(dailyKcalDelta);
    if (!nullToAbsent || targetWeightKg != null) {
      map['target_weight_kg'] = Variable<double>(targetWeightKg);
    }
    return map;
  }

  NutritionGoalsCompanion toCompanion(bool nullToAbsent) {
    return NutritionGoalsCompanion(
      id: Value(id),
      startDate: Value(startDate),
      kind: Value(kind),
      dailyKcalDelta: Value(dailyKcalDelta),
      targetWeightKg: targetWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(targetWeightKg),
    );
  }

  factory NutritionGoalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionGoalRow(
      id: serializer.fromJson<int>(json['id']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      kind: serializer.fromJson<String>(json['kind']),
      dailyKcalDelta: serializer.fromJson<double>(json['dailyKcalDelta']),
      targetWeightKg: serializer.fromJson<double?>(json['targetWeightKg']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startDate': serializer.toJson<DateTime>(startDate),
      'kind': serializer.toJson<String>(kind),
      'dailyKcalDelta': serializer.toJson<double>(dailyKcalDelta),
      'targetWeightKg': serializer.toJson<double?>(targetWeightKg),
    };
  }

  NutritionGoalRow copyWith({
    int? id,
    DateTime? startDate,
    String? kind,
    double? dailyKcalDelta,
    Value<double?> targetWeightKg = const Value.absent(),
  }) => NutritionGoalRow(
    id: id ?? this.id,
    startDate: startDate ?? this.startDate,
    kind: kind ?? this.kind,
    dailyKcalDelta: dailyKcalDelta ?? this.dailyKcalDelta,
    targetWeightKg: targetWeightKg.present
        ? targetWeightKg.value
        : this.targetWeightKg,
  );
  NutritionGoalRow copyWithCompanion(NutritionGoalsCompanion data) {
    return NutritionGoalRow(
      id: data.id.present ? data.id.value : this.id,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      kind: data.kind.present ? data.kind.value : this.kind,
      dailyKcalDelta: data.dailyKcalDelta.present
          ? data.dailyKcalDelta.value
          : this.dailyKcalDelta,
      targetWeightKg: data.targetWeightKg.present
          ? data.targetWeightKg.value
          : this.targetWeightKg,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionGoalRow(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('kind: $kind, ')
          ..write('dailyKcalDelta: $dailyKcalDelta, ')
          ..write('targetWeightKg: $targetWeightKg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, startDate, kind, dailyKcalDelta, targetWeightKg);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionGoalRow &&
          other.id == this.id &&
          other.startDate == this.startDate &&
          other.kind == this.kind &&
          other.dailyKcalDelta == this.dailyKcalDelta &&
          other.targetWeightKg == this.targetWeightKg);
}

class NutritionGoalsCompanion extends UpdateCompanion<NutritionGoalRow> {
  final Value<int> id;
  final Value<DateTime> startDate;
  final Value<String> kind;
  final Value<double> dailyKcalDelta;
  final Value<double?> targetWeightKg;
  const NutritionGoalsCompanion({
    this.id = const Value.absent(),
    this.startDate = const Value.absent(),
    this.kind = const Value.absent(),
    this.dailyKcalDelta = const Value.absent(),
    this.targetWeightKg = const Value.absent(),
  });
  NutritionGoalsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startDate,
    required String kind,
    required double dailyKcalDelta,
    this.targetWeightKg = const Value.absent(),
  }) : startDate = Value(startDate),
       kind = Value(kind),
       dailyKcalDelta = Value(dailyKcalDelta);
  static Insertable<NutritionGoalRow> custom({
    Expression<int>? id,
    Expression<DateTime>? startDate,
    Expression<String>? kind,
    Expression<double>? dailyKcalDelta,
    Expression<double>? targetWeightKg,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startDate != null) 'start_date': startDate,
      if (kind != null) 'kind': kind,
      if (dailyKcalDelta != null) 'daily_kcal_delta': dailyKcalDelta,
      if (targetWeightKg != null) 'target_weight_kg': targetWeightKg,
    });
  }

  NutritionGoalsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? startDate,
    Value<String>? kind,
    Value<double>? dailyKcalDelta,
    Value<double?>? targetWeightKg,
  }) {
    return NutritionGoalsCompanion(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      kind: kind ?? this.kind,
      dailyKcalDelta: dailyKcalDelta ?? this.dailyKcalDelta,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (dailyKcalDelta.present) {
      map['daily_kcal_delta'] = Variable<double>(dailyKcalDelta.value);
    }
    if (targetWeightKg.present) {
      map['target_weight_kg'] = Variable<double>(targetWeightKg.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionGoalsCompanion(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('kind: $kind, ')
          ..write('dailyKcalDelta: $dailyKcalDelta, ')
          ..write('targetWeightKg: $targetWeightKg')
          ..write(')'))
        .toString();
  }
}

class $BodyWeightsTable extends BodyWeights
    with TableInfo<$BodyWeightsTable, BodyWeightRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyWeightsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyFatPctMeta = const VerificationMeta(
    'bodyFatPct',
  );
  @override
  late final GeneratedColumn<double> bodyFatPct = GeneratedColumn<double>(
    'body_fat_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, weightKg, bodyFatPct];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_weights';
  @override
  VerificationContext validateIntegrity(
    Insertable<BodyWeightRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('body_fat_pct')) {
      context.handle(
        _bodyFatPctMeta,
        bodyFatPct.isAcceptableOrUnknown(
          data['body_fat_pct']!,
          _bodyFatPctMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BodyWeightRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BodyWeightRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      bodyFatPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}body_fat_pct'],
      ),
    );
  }

  @override
  $BodyWeightsTable createAlias(String alias) {
    return $BodyWeightsTable(attachedDatabase, alias);
  }
}

class BodyWeightRow extends DataClass implements Insertable<BodyWeightRow> {
  final int id;
  final DateTime date;
  final double weightKg;
  final double? bodyFatPct;
  const BodyWeightRow({
    required this.id,
    required this.date,
    required this.weightKg,
    this.bodyFatPct,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['weight_kg'] = Variable<double>(weightKg);
    if (!nullToAbsent || bodyFatPct != null) {
      map['body_fat_pct'] = Variable<double>(bodyFatPct);
    }
    return map;
  }

  BodyWeightsCompanion toCompanion(bool nullToAbsent) {
    return BodyWeightsCompanion(
      id: Value(id),
      date: Value(date),
      weightKg: Value(weightKg),
      bodyFatPct: bodyFatPct == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFatPct),
    );
  }

  factory BodyWeightRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BodyWeightRow(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      bodyFatPct: serializer.fromJson<double?>(json['bodyFatPct']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'weightKg': serializer.toJson<double>(weightKg),
      'bodyFatPct': serializer.toJson<double?>(bodyFatPct),
    };
  }

  BodyWeightRow copyWith({
    int? id,
    DateTime? date,
    double? weightKg,
    Value<double?> bodyFatPct = const Value.absent(),
  }) => BodyWeightRow(
    id: id ?? this.id,
    date: date ?? this.date,
    weightKg: weightKg ?? this.weightKg,
    bodyFatPct: bodyFatPct.present ? bodyFatPct.value : this.bodyFatPct,
  );
  BodyWeightRow copyWithCompanion(BodyWeightsCompanion data) {
    return BodyWeightRow(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      bodyFatPct: data.bodyFatPct.present
          ? data.bodyFatPct.value
          : this.bodyFatPct,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BodyWeightRow(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('bodyFatPct: $bodyFatPct')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, weightKg, bodyFatPct);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyWeightRow &&
          other.id == this.id &&
          other.date == this.date &&
          other.weightKg == this.weightKg &&
          other.bodyFatPct == this.bodyFatPct);
}

class BodyWeightsCompanion extends UpdateCompanion<BodyWeightRow> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<double> weightKg;
  final Value<double?> bodyFatPct;
  const BodyWeightsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.bodyFatPct = const Value.absent(),
  });
  BodyWeightsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required double weightKg,
    this.bodyFatPct = const Value.absent(),
  }) : date = Value(date),
       weightKg = Value(weightKg);
  static Insertable<BodyWeightRow> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<double>? weightKg,
    Expression<double>? bodyFatPct,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (weightKg != null) 'weight_kg': weightKg,
      if (bodyFatPct != null) 'body_fat_pct': bodyFatPct,
    });
  }

  BodyWeightsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<double>? weightKg,
    Value<double?>? bodyFatPct,
  }) {
    return BodyWeightsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      weightKg: weightKg ?? this.weightKg,
      bodyFatPct: bodyFatPct ?? this.bodyFatPct,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (bodyFatPct.present) {
      map['body_fat_pct'] = Variable<double>(bodyFatPct.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BodyWeightsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('bodyFatPct: $bodyFatPct')
          ..write(')'))
        .toString();
  }
}

class $DailyStepsTable extends DailySteps
    with TableInfo<$DailyStepsTable, DailyStepsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [date, steps];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyStepsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    } else if (isInserting) {
      context.missing(_stepsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DailyStepsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyStepsRow(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      )!,
    );
  }

  @override
  $DailyStepsTable createAlias(String alias) {
    return $DailyStepsTable(attachedDatabase, alias);
  }
}

class DailyStepsRow extends DataClass implements Insertable<DailyStepsRow> {
  final DateTime date;
  final int steps;
  const DailyStepsRow({required this.date, required this.steps});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['steps'] = Variable<int>(steps);
    return map;
  }

  DailyStepsCompanion toCompanion(bool nullToAbsent) {
    return DailyStepsCompanion(date: Value(date), steps: Value(steps));
  }

  factory DailyStepsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyStepsRow(
      date: serializer.fromJson<DateTime>(json['date']),
      steps: serializer.fromJson<int>(json['steps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'steps': serializer.toJson<int>(steps),
    };
  }

  DailyStepsRow copyWith({DateTime? date, int? steps}) =>
      DailyStepsRow(date: date ?? this.date, steps: steps ?? this.steps);
  DailyStepsRow copyWithCompanion(DailyStepsCompanion data) {
    return DailyStepsRow(
      date: data.date.present ? data.date.value : this.date,
      steps: data.steps.present ? data.steps.value : this.steps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyStepsRow(')
          ..write('date: $date, ')
          ..write('steps: $steps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, steps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyStepsRow &&
          other.date == this.date &&
          other.steps == this.steps);
}

class DailyStepsCompanion extends UpdateCompanion<DailyStepsRow> {
  final Value<DateTime> date;
  final Value<int> steps;
  final Value<int> rowid;
  const DailyStepsCompanion({
    this.date = const Value.absent(),
    this.steps = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyStepsCompanion.insert({
    required DateTime date,
    required int steps,
    this.rowid = const Value.absent(),
  }) : date = Value(date),
       steps = Value(steps);
  static Insertable<DailyStepsRow> custom({
    Expression<DateTime>? date,
    Expression<int>? steps,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (steps != null) 'steps': steps,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyStepsCompanion copyWith({
    Value<DateTime>? date,
    Value<int>? steps,
    Value<int>? rowid,
  }) {
    return DailyStepsCompanion(
      date: date ?? this.date,
      steps: steps ?? this.steps,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyStepsCompanion(')
          ..write('date: $date, ')
          ..write('steps: $steps, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts
    with TableInfo<$WorkoutsTable, WorkoutRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseNameMeta = const VerificationMeta(
    'exerciseName',
  );
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
    'exercise_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metMeta = const VerificationMeta('met');
  @override
  late final GeneratedColumn<double> met = GeneratedColumn<double>(
    'met',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinMeta = const VerificationMeta(
    'durationMin',
  );
  @override
  late final GeneratedColumn<double> durationMin = GeneratedColumn<double>(
    'duration_min',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intensityMeta = const VerificationMeta(
    'intensity',
  );
  @override
  late final GeneratedColumn<String> intensity = GeneratedColumn<String>(
    'intensity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('moderate'),
  );
  static const VerificationMeta _kcalOverrideMeta = const VerificationMeta(
    'kcalOverride',
  );
  @override
  late final GeneratedColumn<double> kcalOverride = GeneratedColumn<double>(
    'kcal_override',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    exerciseName,
    met,
    durationMin,
    intensity,
    kcalOverride,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
        _exerciseNameMeta,
        exerciseName.isAcceptableOrUnknown(
          data['exercise_name']!,
          _exerciseNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseNameMeta);
    }
    if (data.containsKey('met')) {
      context.handle(
        _metMeta,
        met.isAcceptableOrUnknown(data['met']!, _metMeta),
      );
    } else if (isInserting) {
      context.missing(_metMeta);
    }
    if (data.containsKey('duration_min')) {
      context.handle(
        _durationMinMeta,
        durationMin.isAcceptableOrUnknown(
          data['duration_min']!,
          _durationMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinMeta);
    }
    if (data.containsKey('intensity')) {
      context.handle(
        _intensityMeta,
        intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta),
      );
    }
    if (data.containsKey('kcal_override')) {
      context.handle(
        _kcalOverrideMeta,
        kcalOverride.isAcceptableOrUnknown(
          data['kcal_override']!,
          _kcalOverrideMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      exerciseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_name'],
      )!,
      met: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}met'],
      )!,
      durationMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}duration_min'],
      )!,
      intensity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intensity'],
      )!,
      kcalOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_override'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(attachedDatabase, alias);
  }
}

class WorkoutRow extends DataClass implements Insertable<WorkoutRow> {
  final int id;
  final DateTime date;
  final String exerciseName;
  final double met;
  final double durationMin;
  final String intensity;
  final double? kcalOverride;
  final String? note;
  const WorkoutRow({
    required this.id,
    required this.date,
    required this.exerciseName,
    required this.met,
    required this.durationMin,
    required this.intensity,
    this.kcalOverride,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['exercise_name'] = Variable<String>(exerciseName);
    map['met'] = Variable<double>(met);
    map['duration_min'] = Variable<double>(durationMin);
    map['intensity'] = Variable<String>(intensity);
    if (!nullToAbsent || kcalOverride != null) {
      map['kcal_override'] = Variable<double>(kcalOverride);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      id: Value(id),
      date: Value(date),
      exerciseName: Value(exerciseName),
      met: Value(met),
      durationMin: Value(durationMin),
      intensity: Value(intensity),
      kcalOverride: kcalOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(kcalOverride),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory WorkoutRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutRow(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      exerciseName: serializer.fromJson<String>(json['exerciseName']),
      met: serializer.fromJson<double>(json['met']),
      durationMin: serializer.fromJson<double>(json['durationMin']),
      intensity: serializer.fromJson<String>(json['intensity']),
      kcalOverride: serializer.fromJson<double?>(json['kcalOverride']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'exerciseName': serializer.toJson<String>(exerciseName),
      'met': serializer.toJson<double>(met),
      'durationMin': serializer.toJson<double>(durationMin),
      'intensity': serializer.toJson<String>(intensity),
      'kcalOverride': serializer.toJson<double?>(kcalOverride),
      'note': serializer.toJson<String?>(note),
    };
  }

  WorkoutRow copyWith({
    int? id,
    DateTime? date,
    String? exerciseName,
    double? met,
    double? durationMin,
    String? intensity,
    Value<double?> kcalOverride = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => WorkoutRow(
    id: id ?? this.id,
    date: date ?? this.date,
    exerciseName: exerciseName ?? this.exerciseName,
    met: met ?? this.met,
    durationMin: durationMin ?? this.durationMin,
    intensity: intensity ?? this.intensity,
    kcalOverride: kcalOverride.present ? kcalOverride.value : this.kcalOverride,
    note: note.present ? note.value : this.note,
  );
  WorkoutRow copyWithCompanion(WorkoutsCompanion data) {
    return WorkoutRow(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      exerciseName: data.exerciseName.present
          ? data.exerciseName.value
          : this.exerciseName,
      met: data.met.present ? data.met.value : this.met,
      durationMin: data.durationMin.present
          ? data.durationMin.value
          : this.durationMin,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      kcalOverride: data.kcalOverride.present
          ? data.kcalOverride.value
          : this.kcalOverride,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutRow(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('met: $met, ')
          ..write('durationMin: $durationMin, ')
          ..write('intensity: $intensity, ')
          ..write('kcalOverride: $kcalOverride, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    exerciseName,
    met,
    durationMin,
    intensity,
    kcalOverride,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutRow &&
          other.id == this.id &&
          other.date == this.date &&
          other.exerciseName == this.exerciseName &&
          other.met == this.met &&
          other.durationMin == this.durationMin &&
          other.intensity == this.intensity &&
          other.kcalOverride == this.kcalOverride &&
          other.note == this.note);
}

class WorkoutsCompanion extends UpdateCompanion<WorkoutRow> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> exerciseName;
  final Value<double> met;
  final Value<double> durationMin;
  final Value<String> intensity;
  final Value<double?> kcalOverride;
  final Value<String?> note;
  const WorkoutsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.exerciseName = const Value.absent(),
    this.met = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.intensity = const Value.absent(),
    this.kcalOverride = const Value.absent(),
    this.note = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String exerciseName,
    required double met,
    required double durationMin,
    this.intensity = const Value.absent(),
    this.kcalOverride = const Value.absent(),
    this.note = const Value.absent(),
  }) : date = Value(date),
       exerciseName = Value(exerciseName),
       met = Value(met),
       durationMin = Value(durationMin);
  static Insertable<WorkoutRow> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? exerciseName,
    Expression<double>? met,
    Expression<double>? durationMin,
    Expression<String>? intensity,
    Expression<double>? kcalOverride,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (exerciseName != null) 'exercise_name': exerciseName,
      if (met != null) 'met': met,
      if (durationMin != null) 'duration_min': durationMin,
      if (intensity != null) 'intensity': intensity,
      if (kcalOverride != null) 'kcal_override': kcalOverride,
      if (note != null) 'note': note,
    });
  }

  WorkoutsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? exerciseName,
    Value<double>? met,
    Value<double>? durationMin,
    Value<String>? intensity,
    Value<double?>? kcalOverride,
    Value<String?>? note,
  }) {
    return WorkoutsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      exerciseName: exerciseName ?? this.exerciseName,
      met: met ?? this.met,
      durationMin: durationMin ?? this.durationMin,
      intensity: intensity ?? this.intensity,
      kcalOverride: kcalOverride ?? this.kcalOverride,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    if (met.present) {
      map['met'] = Variable<double>(met.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<double>(durationMin.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<String>(intensity.value);
    }
    if (kcalOverride.present) {
      map['kcal_override'] = Variable<double>(kcalOverride.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('met: $met, ')
          ..write('durationMin: $durationMin, ')
          ..write('intensity: $intensity, ')
          ..write('kcalOverride: $kcalOverride, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $StrengthSessionsTable extends StrengthSessions
    with TableInfo<$StrengthSessionsTable, StrengthSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StrengthSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMinMeta = const VerificationMeta(
    'durationMin',
  );
  @override
  late final GeneratedColumn<double> durationMin = GeneratedColumn<double>(
    'duration_min',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kcalOverrideMeta = const VerificationMeta(
    'kcalOverride',
  );
  @override
  late final GeneratedColumn<double> kcalOverride = GeneratedColumn<double>(
    'kcal_override',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    name,
    durationMin,
    kcalOverride,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'strength_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StrengthSessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('duration_min')) {
      context.handle(
        _durationMinMeta,
        durationMin.isAcceptableOrUnknown(
          data['duration_min']!,
          _durationMinMeta,
        ),
      );
    }
    if (data.containsKey('kcal_override')) {
      context.handle(
        _kcalOverrideMeta,
        kcalOverride.isAcceptableOrUnknown(
          data['kcal_override']!,
          _kcalOverrideMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StrengthSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StrengthSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      durationMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}duration_min'],
      ),
      kcalOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_override'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $StrengthSessionsTable createAlias(String alias) {
    return $StrengthSessionsTable(attachedDatabase, alias);
  }
}

class StrengthSessionRow extends DataClass
    implements Insertable<StrengthSessionRow> {
  final int id;
  final DateTime date;
  final String? name;
  final double? durationMin;
  final double? kcalOverride;
  final String? note;
  const StrengthSessionRow({
    required this.id,
    required this.date,
    this.name,
    this.durationMin,
    this.kcalOverride,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || durationMin != null) {
      map['duration_min'] = Variable<double>(durationMin);
    }
    if (!nullToAbsent || kcalOverride != null) {
      map['kcal_override'] = Variable<double>(kcalOverride);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  StrengthSessionsCompanion toCompanion(bool nullToAbsent) {
    return StrengthSessionsCompanion(
      id: Value(id),
      date: Value(date),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      durationMin: durationMin == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMin),
      kcalOverride: kcalOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(kcalOverride),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory StrengthSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StrengthSessionRow(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      name: serializer.fromJson<String?>(json['name']),
      durationMin: serializer.fromJson<double?>(json['durationMin']),
      kcalOverride: serializer.fromJson<double?>(json['kcalOverride']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'name': serializer.toJson<String?>(name),
      'durationMin': serializer.toJson<double?>(durationMin),
      'kcalOverride': serializer.toJson<double?>(kcalOverride),
      'note': serializer.toJson<String?>(note),
    };
  }

  StrengthSessionRow copyWith({
    int? id,
    DateTime? date,
    Value<String?> name = const Value.absent(),
    Value<double?> durationMin = const Value.absent(),
    Value<double?> kcalOverride = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => StrengthSessionRow(
    id: id ?? this.id,
    date: date ?? this.date,
    name: name.present ? name.value : this.name,
    durationMin: durationMin.present ? durationMin.value : this.durationMin,
    kcalOverride: kcalOverride.present ? kcalOverride.value : this.kcalOverride,
    note: note.present ? note.value : this.note,
  );
  StrengthSessionRow copyWithCompanion(StrengthSessionsCompanion data) {
    return StrengthSessionRow(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      name: data.name.present ? data.name.value : this.name,
      durationMin: data.durationMin.present
          ? data.durationMin.value
          : this.durationMin,
      kcalOverride: data.kcalOverride.present
          ? data.kcalOverride.value
          : this.kcalOverride,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StrengthSessionRow(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('name: $name, ')
          ..write('durationMin: $durationMin, ')
          ..write('kcalOverride: $kcalOverride, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, name, durationMin, kcalOverride, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StrengthSessionRow &&
          other.id == this.id &&
          other.date == this.date &&
          other.name == this.name &&
          other.durationMin == this.durationMin &&
          other.kcalOverride == this.kcalOverride &&
          other.note == this.note);
}

class StrengthSessionsCompanion extends UpdateCompanion<StrengthSessionRow> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String?> name;
  final Value<double?> durationMin;
  final Value<double?> kcalOverride;
  final Value<String?> note;
  const StrengthSessionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.name = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.kcalOverride = const Value.absent(),
    this.note = const Value.absent(),
  });
  StrengthSessionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.name = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.kcalOverride = const Value.absent(),
    this.note = const Value.absent(),
  }) : date = Value(date);
  static Insertable<StrengthSessionRow> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? name,
    Expression<double>? durationMin,
    Expression<double>? kcalOverride,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (name != null) 'name': name,
      if (durationMin != null) 'duration_min': durationMin,
      if (kcalOverride != null) 'kcal_override': kcalOverride,
      if (note != null) 'note': note,
    });
  }

  StrengthSessionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String?>? name,
    Value<double?>? durationMin,
    Value<double?>? kcalOverride,
    Value<String?>? note,
  }) {
    return StrengthSessionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      name: name ?? this.name,
      durationMin: durationMin ?? this.durationMin,
      kcalOverride: kcalOverride ?? this.kcalOverride,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<double>(durationMin.value);
    }
    if (kcalOverride.present) {
      map['kcal_override'] = Variable<double>(kcalOverride.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StrengthSessionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('name: $name, ')
          ..write('durationMin: $durationMin, ')
          ..write('kcalOverride: $kcalOverride, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $StrengthSetsTable extends StrengthSets
    with TableInfo<$StrengthSetsTable, StrengthSetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StrengthSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES strength_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _exerciseMeta = const VerificationMeta(
    'exercise',
  );
  @override
  late final GeneratedColumn<String> exercise = GeneratedColumn<String>(
    'exercise',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setIndexMeta = const VerificationMeta(
    'setIndex',
  );
  @override
  late final GeneratedColumn<int> setIndex = GeneratedColumn<int>(
    'set_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restSecMeta = const VerificationMeta(
    'restSec',
  );
  @override
  late final GeneratedColumn<int> restSec = GeneratedColumn<int>(
    'rest_sec',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    exercise,
    setIndex,
    reps,
    weightKg,
    restSec,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'strength_sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<StrengthSetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('exercise')) {
      context.handle(
        _exerciseMeta,
        exercise.isAcceptableOrUnknown(data['exercise']!, _exerciseMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseMeta);
    }
    if (data.containsKey('set_index')) {
      context.handle(
        _setIndexMeta,
        setIndex.isAcceptableOrUnknown(data['set_index']!, _setIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_setIndexMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('rest_sec')) {
      context.handle(
        _restSecMeta,
        restSec.isAcceptableOrUnknown(data['rest_sec']!, _restSecMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StrengthSetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StrengthSetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      exercise: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise'],
      )!,
      setIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_index'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      restSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_sec'],
      ),
    );
  }

  @override
  $StrengthSetsTable createAlias(String alias) {
    return $StrengthSetsTable(attachedDatabase, alias);
  }
}

class StrengthSetRow extends DataClass implements Insertable<StrengthSetRow> {
  final int id;
  final int sessionId;
  final String exercise;
  final int setIndex;
  final int reps;
  final double weightKg;
  final int? restSec;
  const StrengthSetRow({
    required this.id,
    required this.sessionId,
    required this.exercise,
    required this.setIndex,
    required this.reps,
    required this.weightKg,
    this.restSec,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['exercise'] = Variable<String>(exercise);
    map['set_index'] = Variable<int>(setIndex);
    map['reps'] = Variable<int>(reps);
    map['weight_kg'] = Variable<double>(weightKg);
    if (!nullToAbsent || restSec != null) {
      map['rest_sec'] = Variable<int>(restSec);
    }
    return map;
  }

  StrengthSetsCompanion toCompanion(bool nullToAbsent) {
    return StrengthSetsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exercise: Value(exercise),
      setIndex: Value(setIndex),
      reps: Value(reps),
      weightKg: Value(weightKg),
      restSec: restSec == null && nullToAbsent
          ? const Value.absent()
          : Value(restSec),
    );
  }

  factory StrengthSetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StrengthSetRow(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      exercise: serializer.fromJson<String>(json['exercise']),
      setIndex: serializer.fromJson<int>(json['setIndex']),
      reps: serializer.fromJson<int>(json['reps']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      restSec: serializer.fromJson<int?>(json['restSec']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'exercise': serializer.toJson<String>(exercise),
      'setIndex': serializer.toJson<int>(setIndex),
      'reps': serializer.toJson<int>(reps),
      'weightKg': serializer.toJson<double>(weightKg),
      'restSec': serializer.toJson<int?>(restSec),
    };
  }

  StrengthSetRow copyWith({
    int? id,
    int? sessionId,
    String? exercise,
    int? setIndex,
    int? reps,
    double? weightKg,
    Value<int?> restSec = const Value.absent(),
  }) => StrengthSetRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    exercise: exercise ?? this.exercise,
    setIndex: setIndex ?? this.setIndex,
    reps: reps ?? this.reps,
    weightKg: weightKg ?? this.weightKg,
    restSec: restSec.present ? restSec.value : this.restSec,
  );
  StrengthSetRow copyWithCompanion(StrengthSetsCompanion data) {
    return StrengthSetRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      exercise: data.exercise.present ? data.exercise.value : this.exercise,
      setIndex: data.setIndex.present ? data.setIndex.value : this.setIndex,
      reps: data.reps.present ? data.reps.value : this.reps,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      restSec: data.restSec.present ? data.restSec.value : this.restSec,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StrengthSetRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exercise: $exercise, ')
          ..write('setIndex: $setIndex, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('restSec: $restSec')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, exercise, setIndex, reps, weightKg, restSec);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StrengthSetRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.exercise == this.exercise &&
          other.setIndex == this.setIndex &&
          other.reps == this.reps &&
          other.weightKg == this.weightKg &&
          other.restSec == this.restSec);
}

class StrengthSetsCompanion extends UpdateCompanion<StrengthSetRow> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<String> exercise;
  final Value<int> setIndex;
  final Value<int> reps;
  final Value<double> weightKg;
  final Value<int?> restSec;
  const StrengthSetsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.exercise = const Value.absent(),
    this.setIndex = const Value.absent(),
    this.reps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.restSec = const Value.absent(),
  });
  StrengthSetsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required String exercise,
    required int setIndex,
    required int reps,
    required double weightKg,
    this.restSec = const Value.absent(),
  }) : sessionId = Value(sessionId),
       exercise = Value(exercise),
       setIndex = Value(setIndex),
       reps = Value(reps),
       weightKg = Value(weightKg);
  static Insertable<StrengthSetRow> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<String>? exercise,
    Expression<int>? setIndex,
    Expression<int>? reps,
    Expression<double>? weightKg,
    Expression<int>? restSec,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (exercise != null) 'exercise': exercise,
      if (setIndex != null) 'set_index': setIndex,
      if (reps != null) 'reps': reps,
      if (weightKg != null) 'weight_kg': weightKg,
      if (restSec != null) 'rest_sec': restSec,
    });
  }

  StrengthSetsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<String>? exercise,
    Value<int>? setIndex,
    Value<int>? reps,
    Value<double>? weightKg,
    Value<int?>? restSec,
  }) {
    return StrengthSetsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exercise: exercise ?? this.exercise,
      setIndex: setIndex ?? this.setIndex,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      restSec: restSec ?? this.restSec,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (exercise.present) {
      map['exercise'] = Variable<String>(exercise.value);
    }
    if (setIndex.present) {
      map['set_index'] = Variable<int>(setIndex.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (restSec.present) {
      map['rest_sec'] = Variable<int>(restSec.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StrengthSetsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exercise: $exercise, ')
          ..write('setIndex: $setIndex, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('restSec: $restSec')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $IngredientsTable ingredients = $IngredientsTable(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  late final $RecipeIngredientsTable recipeIngredients =
      $RecipeIngredientsTable(this);
  late final $RecipeStepsTable recipeSteps = $RecipeStepsTable(this);
  late final $RecipeUserStatesTable recipeUserStates = $RecipeUserStatesTable(
    this,
  );
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $ProfileAversionsTable profileAversions = $ProfileAversionsTable(
    this,
  );
  late final $ProfileExclusionsTable profileExclusions =
      $ProfileExclusionsTable(this);
  late final $ProfileEquipmentTable profileEquipment = $ProfileEquipmentTable(
    this,
  );
  late final $ProfileSlotsTable profileSlots = $ProfileSlotsTable(this);
  late final $WeekMenusTable weekMenus = $WeekMenusTable(this);
  late final $MenuSlotsTable menuSlots = $MenuSlotsTable(this);
  late final $WeekExtrasTable weekExtras = $WeekExtrasTable(this);
  late final $ShoppingItemsTable shoppingItems = $ShoppingItemsTable(this);
  late final $AppMetaTable appMeta = $AppMetaTable(this);
  late final $CustomProductsTable customProducts = $CustomProductsTable(this);
  late final $ProductLinksTable productLinks = $ProductLinksTable(this);
  late final $StockLotsTable stockLots = $StockLotsTable(this);
  late final $StockMovementsTable stockMovements = $StockMovementsTable(this);
  late final $MealCompletionsTable mealCompletions = $MealCompletionsTable(
    this,
  );
  late final $FoodLogEntriesTable foodLogEntries = $FoodLogEntriesTable(this);
  late final $MealPresetsTable mealPresets = $MealPresetsTable(this);
  late final $MealPresetItemsTable mealPresetItems = $MealPresetItemsTable(
    this,
  );
  late final $NutritionProfilesTable nutritionProfiles =
      $NutritionProfilesTable(this);
  late final $NutritionGoalsTable nutritionGoals = $NutritionGoalsTable(this);
  late final $BodyWeightsTable bodyWeights = $BodyWeightsTable(this);
  late final $DailyStepsTable dailySteps = $DailyStepsTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $StrengthSessionsTable strengthSessions = $StrengthSessionsTable(
    this,
  );
  late final $StrengthSetsTable strengthSets = $StrengthSetsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    ingredients,
    recipes,
    recipeIngredients,
    recipeSteps,
    recipeUserStates,
    profiles,
    profileAversions,
    profileExclusions,
    profileEquipment,
    profileSlots,
    weekMenus,
    menuSlots,
    weekExtras,
    shoppingItems,
    appMeta,
    customProducts,
    productLinks,
    stockLots,
    stockMovements,
    mealCompletions,
    foodLogEntries,
    mealPresets,
    mealPresetItems,
    nutritionProfiles,
    nutritionGoals,
    bodyWeights,
    dailySteps,
    workouts,
    strengthSessions,
    strengthSets,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_ingredients', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_steps', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_user_state', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'week_menus',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('menu_slots', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'week_menus',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('week_extras', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'week_menus',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('shopping_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'week_menus',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_completions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meal_presets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_preset_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'strength_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('strength_sets', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$IngredientsTableCreateCompanionBuilder =
    IngredientsCompanion Function({
      required String id,
      required String name,
      required String aisle,
      required String defaultUnit,
      Value<double?> avgPieceWeightG,
      Value<bool> pantry,
      Value<bool> perishable,
      Value<String> markers,
      Value<String> allergens,
      Value<String> seasonMonths,
      required String origin,
      Value<String?> nutrition,
      Value<double?> density,
      Value<String?> ciqualCode,
      Value<int> rowid,
    });
typedef $$IngredientsTableUpdateCompanionBuilder =
    IngredientsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> aisle,
      Value<String> defaultUnit,
      Value<double?> avgPieceWeightG,
      Value<bool> pantry,
      Value<bool> perishable,
      Value<String> markers,
      Value<String> allergens,
      Value<String> seasonMonths,
      Value<String> origin,
      Value<String?> nutrition,
      Value<double?> density,
      Value<String?> ciqualCode,
      Value<int> rowid,
    });

final class $$IngredientsTableReferences
    extends BaseReferences<_$AppDatabase, $IngredientsTable, IngredientRow> {
  $$IngredientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecipeIngredientsTable, List<RecipeIngredientRow>>
  _recipeIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recipeIngredients,
        aliasName: 'ingredients__id__recipe_ingredients__ingredient_id',
      );

  $$RecipeIngredientsTableProcessedTableManager get recipeIngredientsRefs {
    final manager = $$RecipeIngredientsTableTableManager(
      $_db,
      $_db.recipeIngredients,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recipeIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProfileAversionsTable, List<ProfileAversionRow>>
  _profileAversionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.profileAversions,
    aliasName: 'ingredients__id__profile_aversions__ingredient_id',
  );

  $$ProfileAversionsTableProcessedTableManager get profileAversionsRefs {
    final manager = $$ProfileAversionsTableTableManager(
      $_db,
      $_db.profileAversions,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _profileAversionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ShoppingItemsTable, List<ShoppingItemRow>>
  _shoppingItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.shoppingItems,
    aliasName: 'ingredients__id__shopping_items__ingredient_id',
  );

  $$ShoppingItemsTableProcessedTableManager get shoppingItemsRefs {
    final manager = $$ShoppingItemsTableTableManager(
      $_db,
      $_db.shoppingItems,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_shoppingItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProductLinksTable, List<ProductLinkRow>>
  _productLinksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.productLinks,
    aliasName: 'ingredients__id__product_links__ingredient_id',
  );

  $$ProductLinksTableProcessedTableManager get productLinksRefs {
    final manager = $$ProductLinksTableTableManager(
      $_db,
      $_db.productLinks,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_productLinksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StockLotsTable, List<StockLotRow>>
  _stockLotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stockLots,
    aliasName: 'ingredients__id__stock_lots__ingredient_id',
  );

  $$StockLotsTableProcessedTableManager get stockLotsRefs {
    final manager = $$StockLotsTableTableManager(
      $_db,
      $_db.stockLots,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockLotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$IngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aisle => $composableBuilder(
    column: $table.aisle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgPieceWeightG => $composableBuilder(
    column: $table.avgPieceWeightG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pantry => $composableBuilder(
    column: $table.pantry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get perishable => $composableBuilder(
    column: $table.perishable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get markers => $composableBuilder(
    column: $table.markers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allergens => $composableBuilder(
    column: $table.allergens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seasonMonths => $composableBuilder(
    column: $table.seasonMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nutrition => $composableBuilder(
    column: $table.nutrition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get density => $composableBuilder(
    column: $table.density,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ciqualCode => $composableBuilder(
    column: $table.ciqualCode,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipeIngredientsRefs(
    Expression<bool> Function($$RecipeIngredientsTableFilterComposer f) f,
  ) {
    final $$RecipeIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeIngredients,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.recipeIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> profileAversionsRefs(
    Expression<bool> Function($$ProfileAversionsTableFilterComposer f) f,
  ) {
    final $$ProfileAversionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileAversions,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileAversionsTableFilterComposer(
            $db: $db,
            $table: $db.profileAversions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> shoppingItemsRefs(
    Expression<bool> Function($$ShoppingItemsTableFilterComposer f) f,
  ) {
    final $$ShoppingItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shoppingItems,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingItemsTableFilterComposer(
            $db: $db,
            $table: $db.shoppingItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> productLinksRefs(
    Expression<bool> Function($$ProductLinksTableFilterComposer f) f,
  ) {
    final $$ProductLinksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productLinks,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductLinksTableFilterComposer(
            $db: $db,
            $table: $db.productLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stockLotsRefs(
    Expression<bool> Function($$StockLotsTableFilterComposer f) f,
  ) {
    final $$StockLotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockLots,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockLotsTableFilterComposer(
            $db: $db,
            $table: $db.stockLots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aisle => $composableBuilder(
    column: $table.aisle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgPieceWeightG => $composableBuilder(
    column: $table.avgPieceWeightG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pantry => $composableBuilder(
    column: $table.pantry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get perishable => $composableBuilder(
    column: $table.perishable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get markers => $composableBuilder(
    column: $table.markers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allergens => $composableBuilder(
    column: $table.allergens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seasonMonths => $composableBuilder(
    column: $table.seasonMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nutrition => $composableBuilder(
    column: $table.nutrition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get density => $composableBuilder(
    column: $table.density,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ciqualCode => $composableBuilder(
    column: $table.ciqualCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get aisle =>
      $composableBuilder(column: $table.aisle, builder: (column) => column);

  GeneratedColumn<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgPieceWeightG => $composableBuilder(
    column: $table.avgPieceWeightG,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pantry =>
      $composableBuilder(column: $table.pantry, builder: (column) => column);

  GeneratedColumn<bool> get perishable => $composableBuilder(
    column: $table.perishable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get markers =>
      $composableBuilder(column: $table.markers, builder: (column) => column);

  GeneratedColumn<String> get allergens =>
      $composableBuilder(column: $table.allergens, builder: (column) => column);

  GeneratedColumn<String> get seasonMonths => $composableBuilder(
    column: $table.seasonMonths,
    builder: (column) => column,
  );

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<String> get nutrition =>
      $composableBuilder(column: $table.nutrition, builder: (column) => column);

  GeneratedColumn<double> get density =>
      $composableBuilder(column: $table.density, builder: (column) => column);

  GeneratedColumn<String> get ciqualCode => $composableBuilder(
    column: $table.ciqualCode,
    builder: (column) => column,
  );

  Expression<T> recipeIngredientsRefs<T extends Object>(
    Expression<T> Function($$RecipeIngredientsTableAnnotationComposer a) f,
  ) {
    final $$RecipeIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recipeIngredients,
          getReferencedColumn: (t) => t.ingredientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecipeIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.recipeIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> profileAversionsRefs<T extends Object>(
    Expression<T> Function($$ProfileAversionsTableAnnotationComposer a) f,
  ) {
    final $$ProfileAversionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileAversions,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileAversionsTableAnnotationComposer(
            $db: $db,
            $table: $db.profileAversions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> shoppingItemsRefs<T extends Object>(
    Expression<T> Function($$ShoppingItemsTableAnnotationComposer a) f,
  ) {
    final $$ShoppingItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shoppingItems,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.shoppingItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> productLinksRefs<T extends Object>(
    Expression<T> Function($$ProductLinksTableAnnotationComposer a) f,
  ) {
    final $$ProductLinksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productLinks,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductLinksTableAnnotationComposer(
            $db: $db,
            $table: $db.productLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> stockLotsRefs<T extends Object>(
    Expression<T> Function($$StockLotsTableAnnotationComposer a) f,
  ) {
    final $$StockLotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockLots,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockLotsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockLots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IngredientsTable,
          IngredientRow,
          $$IngredientsTableFilterComposer,
          $$IngredientsTableOrderingComposer,
          $$IngredientsTableAnnotationComposer,
          $$IngredientsTableCreateCompanionBuilder,
          $$IngredientsTableUpdateCompanionBuilder,
          (IngredientRow, $$IngredientsTableReferences),
          IngredientRow,
          PrefetchHooks Function({
            bool recipeIngredientsRefs,
            bool profileAversionsRefs,
            bool shoppingItemsRefs,
            bool productLinksRefs,
            bool stockLotsRefs,
          })
        > {
  $$IngredientsTableTableManager(_$AppDatabase db, $IngredientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngredientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> aisle = const Value.absent(),
                Value<String> defaultUnit = const Value.absent(),
                Value<double?> avgPieceWeightG = const Value.absent(),
                Value<bool> pantry = const Value.absent(),
                Value<bool> perishable = const Value.absent(),
                Value<String> markers = const Value.absent(),
                Value<String> allergens = const Value.absent(),
                Value<String> seasonMonths = const Value.absent(),
                Value<String> origin = const Value.absent(),
                Value<String?> nutrition = const Value.absent(),
                Value<double?> density = const Value.absent(),
                Value<String?> ciqualCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IngredientsCompanion(
                id: id,
                name: name,
                aisle: aisle,
                defaultUnit: defaultUnit,
                avgPieceWeightG: avgPieceWeightG,
                pantry: pantry,
                perishable: perishable,
                markers: markers,
                allergens: allergens,
                seasonMonths: seasonMonths,
                origin: origin,
                nutrition: nutrition,
                density: density,
                ciqualCode: ciqualCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String aisle,
                required String defaultUnit,
                Value<double?> avgPieceWeightG = const Value.absent(),
                Value<bool> pantry = const Value.absent(),
                Value<bool> perishable = const Value.absent(),
                Value<String> markers = const Value.absent(),
                Value<String> allergens = const Value.absent(),
                Value<String> seasonMonths = const Value.absent(),
                required String origin,
                Value<String?> nutrition = const Value.absent(),
                Value<double?> density = const Value.absent(),
                Value<String?> ciqualCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IngredientsCompanion.insert(
                id: id,
                name: name,
                aisle: aisle,
                defaultUnit: defaultUnit,
                avgPieceWeightG: avgPieceWeightG,
                pantry: pantry,
                perishable: perishable,
                markers: markers,
                allergens: allergens,
                seasonMonths: seasonMonths,
                origin: origin,
                nutrition: nutrition,
                density: density,
                ciqualCode: ciqualCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IngredientsTable, IngredientRow>(table),
                  $$IngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                recipeIngredientsRefs = false,
                profileAversionsRefs = false,
                shoppingItemsRefs = false,
                productLinksRefs = false,
                stockLotsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recipeIngredientsRefs) db.recipeIngredients,
                    if (profileAversionsRefs) db.profileAversions,
                    if (shoppingItemsRefs) db.shoppingItems,
                    if (productLinksRefs) db.productLinks,
                    if (stockLotsRefs) db.stockLots,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recipeIngredientsRefs)
                        await $_getPrefetchedDataByColumns<
                          IngredientRow,
                          $IngredientsTable,
                          RecipeIngredientRow,
                          $RecipeIngredientsTable
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._recipeIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeIngredientsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'ingredient_id',
                          typedResults: items,
                        ),
                      if (profileAversionsRefs)
                        await $_getPrefetchedDataByColumns<
                          IngredientRow,
                          $IngredientsTable,
                          ProfileAversionRow,
                          $ProfileAversionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._profileAversionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).profileAversionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'ingredient_id',
                          typedResults: items,
                        ),
                      if (shoppingItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          IngredientRow,
                          $IngredientsTable,
                          ShoppingItemRow,
                          $ShoppingItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._shoppingItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).shoppingItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'ingredient_id',
                          typedResults: items,
                        ),
                      if (productLinksRefs)
                        await $_getPrefetchedDataByColumns<
                          IngredientRow,
                          $IngredientsTable,
                          ProductLinkRow,
                          $ProductLinksTable
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._productLinksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).productLinksRefs,
                          currentColumn: 'id',
                          referencedColumn: 'ingredient_id',
                          typedResults: items,
                        ),
                      if (stockLotsRefs)
                        await $_getPrefetchedDataByColumns<
                          IngredientRow,
                          $IngredientsTable,
                          StockLotRow,
                          $StockLotsTable
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._stockLotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).stockLotsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'ingredient_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$IngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IngredientsTable,
      IngredientRow,
      $$IngredientsTableFilterComposer,
      $$IngredientsTableOrderingComposer,
      $$IngredientsTableAnnotationComposer,
      $$IngredientsTableCreateCompanionBuilder,
      $$IngredientsTableUpdateCompanionBuilder,
      (IngredientRow, $$IngredientsTableReferences),
      IngredientRow,
      PrefetchHooks Function({
        bool recipeIngredientsRefs,
        bool profileAversionsRefs,
        bool shoppingItemsRefs,
        bool productLinksRefs,
        bool stockLotsRefs,
      })
    >;
typedef $$RecipesTableCreateCompanionBuilder = RecipesCompanion Function({
  Value<int> id,
  Value<String?> slug,
  required String title,
  Value<String> description,
  required String type,
  required int servings,
  required int prepMin,
  required int cookMin,
  required String difficulty,
  Value<String> equipment,
  required String mainBase,
  required String origin,
  Value<int?> seedVersion,
  Value<String?> photoPath,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$RecipesTableUpdateCompanionBuilder = RecipesCompanion Function({
  Value<int> id,
  Value<String?> slug,
  Value<String> title,
  Value<String> description,
  Value<String> type,
  Value<int> servings,
  Value<int> prepMin,
  Value<int> cookMin,
  Value<String> difficulty,
  Value<String> equipment,
  Value<String> mainBase,
  Value<String> origin,
  Value<int?> seedVersion,
  Value<String?> photoPath,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$RecipesTableReferences
    extends BaseReferences<_$AppDatabase, $RecipesTable, RecipeRow> {
  $$RecipesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecipeIngredientsTable, List<RecipeIngredientRow>>
  _recipeIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recipeIngredients,
        aliasName: 'recipes__id__recipe_ingredients__recipe_id',
      );

  $$RecipeIngredientsTableProcessedTableManager get recipeIngredientsRefs {
    final manager = $$RecipeIngredientsTableTableManager(
      $_db,
      $_db.recipeIngredients,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recipeIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecipeStepsTable, List<RecipeStepRow>>
  _recipeStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeSteps,
    aliasName: 'recipes__id__recipe_steps__recipe_id',
  );

  $$RecipeStepsTableProcessedTableManager get recipeStepsRefs {
    final manager = $$RecipeStepsTableTableManager(
      $_db,
      $_db.recipeSteps,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recipeStepsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecipeUserStatesTable, List<RecipeUserStateRow>>
  _recipeUserStatesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeUserStates,
    aliasName: 'recipes__id__recipe_user_state__recipe_id',
  );

  $$RecipeUserStatesTableProcessedTableManager get recipeUserStatesRefs {
    final manager = $$RecipeUserStatesTableTableManager(
      $_db,
      $_db.recipeUserStates,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recipeUserStatesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MenuSlotsTable, List<MenuSlotRow>>
  _menuSlotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.menuSlots,
    aliasName: 'recipes__id__menu_slots__recipe_id',
  );

  $$MenuSlotsTableProcessedTableManager get menuSlotsRefs {
    final manager = $$MenuSlotsTableTableManager(
      $_db,
      $_db.menuSlots,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_menuSlotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WeekExtrasTable, List<WeekExtraRow>>
  _weekExtrasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weekExtras,
    aliasName: 'recipes__id__week_extras__recipe_id',
  );

  $$WeekExtrasTableProcessedTableManager get weekExtrasRefs {
    final manager = $$WeekExtrasTableTableManager(
      $_db,
      $_db.weekExtras,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_weekExtrasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecipesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prepMin => $composableBuilder(
    column: $table.prepMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cookMin => $composableBuilder(
    column: $table.cookMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mainBase => $composableBuilder(
    column: $table.mainBase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seedVersion => $composableBuilder(
    column: $table.seedVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipeIngredientsRefs(
    Expression<bool> Function($$RecipeIngredientsTableFilterComposer f) f,
  ) {
    final $$RecipeIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeIngredients,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.recipeIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recipeStepsRefs(
    Expression<bool> Function($$RecipeStepsTableFilterComposer f) f,
  ) {
    final $$RecipeStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeSteps,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeStepsTableFilterComposer(
            $db: $db,
            $table: $db.recipeSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recipeUserStatesRefs(
    Expression<bool> Function($$RecipeUserStatesTableFilterComposer f) f,
  ) {
    final $$RecipeUserStatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeUserStates,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeUserStatesTableFilterComposer(
            $db: $db,
            $table: $db.recipeUserStates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> menuSlotsRefs(
    Expression<bool> Function($$MenuSlotsTableFilterComposer f) f,
  ) {
    final $$MenuSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuSlots,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuSlotsTableFilterComposer(
            $db: $db,
            $table: $db.menuSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> weekExtrasRefs(
    Expression<bool> Function($$WeekExtrasTableFilterComposer f) f,
  ) {
    final $$WeekExtrasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weekExtras,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekExtrasTableFilterComposer(
            $db: $db,
            $table: $db.weekExtras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prepMin => $composableBuilder(
    column: $table.prepMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cookMin => $composableBuilder(
    column: $table.cookMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mainBase => $composableBuilder(
    column: $table.mainBase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seedVersion => $composableBuilder(
    column: $table.seedVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get servings =>
      $composableBuilder(column: $table.servings, builder: (column) => column);

  GeneratedColumn<int> get prepMin =>
      $composableBuilder(column: $table.prepMin, builder: (column) => column);

  GeneratedColumn<int> get cookMin =>
      $composableBuilder(column: $table.cookMin, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get equipment =>
      $composableBuilder(column: $table.equipment, builder: (column) => column);

  GeneratedColumn<String> get mainBase =>
      $composableBuilder(column: $table.mainBase, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<int> get seedVersion => $composableBuilder(
    column: $table.seedVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> recipeIngredientsRefs<T extends Object>(
    Expression<T> Function($$RecipeIngredientsTableAnnotationComposer a) f,
  ) {
    final $$RecipeIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recipeIngredients,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecipeIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.recipeIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> recipeStepsRefs<T extends Object>(
    Expression<T> Function($$RecipeStepsTableAnnotationComposer a) f,
  ) {
    final $$RecipeStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeSteps,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recipeUserStatesRefs<T extends Object>(
    Expression<T> Function($$RecipeUserStatesTableAnnotationComposer a) f,
  ) {
    final $$RecipeUserStatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeUserStates,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeUserStatesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeUserStates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> menuSlotsRefs<T extends Object>(
    Expression<T> Function($$MenuSlotsTableAnnotationComposer a) f,
  ) {
    final $$MenuSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuSlots,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.menuSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> weekExtrasRefs<T extends Object>(
    Expression<T> Function($$WeekExtrasTableAnnotationComposer a) f,
  ) {
    final $$WeekExtrasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weekExtras,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekExtrasTableAnnotationComposer(
            $db: $db,
            $table: $db.weekExtras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipesTable,
          RecipeRow,
          $$RecipesTableFilterComposer,
          $$RecipesTableOrderingComposer,
          $$RecipesTableAnnotationComposer,
          $$RecipesTableCreateCompanionBuilder,
          $$RecipesTableUpdateCompanionBuilder,
          (RecipeRow, $$RecipesTableReferences),
          RecipeRow,
          PrefetchHooks Function({
            bool recipeIngredientsRefs,
            bool recipeStepsRefs,
            bool recipeUserStatesRefs,
            bool menuSlotsRefs,
            bool weekExtrasRefs,
          })
        > {
  $$RecipesTableTableManager(_$AppDatabase db, $RecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> slug = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> servings = const Value.absent(),
                Value<int> prepMin = const Value.absent(),
                Value<int> cookMin = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> equipment = const Value.absent(),
                Value<String> mainBase = const Value.absent(),
                Value<String> origin = const Value.absent(),
                Value<int?> seedVersion = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RecipesCompanion(
                id: id,
                slug: slug,
                title: title,
                description: description,
                type: type,
                servings: servings,
                prepMin: prepMin,
                cookMin: cookMin,
                difficulty: difficulty,
                equipment: equipment,
                mainBase: mainBase,
                origin: origin,
                seedVersion: seedVersion,
                photoPath: photoPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> slug = const Value.absent(),
                required String title,
                Value<String> description = const Value.absent(),
                required String type,
                required int servings,
                required int prepMin,
                required int cookMin,
                required String difficulty,
                Value<String> equipment = const Value.absent(),
                required String mainBase,
                required String origin,
                Value<int?> seedVersion = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => RecipesCompanion.insert(
                id: id,
                slug: slug,
                title: title,
                description: description,
                type: type,
                servings: servings,
                prepMin: prepMin,
                cookMin: cookMin,
                difficulty: difficulty,
                equipment: equipment,
                mainBase: mainBase,
                origin: origin,
                seedVersion: seedVersion,
                photoPath: photoPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipesTable, RecipeRow>(table),
                  $$RecipesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                recipeIngredientsRefs = false,
                recipeStepsRefs = false,
                recipeUserStatesRefs = false,
                menuSlotsRefs = false,
                weekExtrasRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recipeIngredientsRefs) db.recipeIngredients,
                    if (recipeStepsRefs) db.recipeSteps,
                    if (recipeUserStatesRefs) db.recipeUserStates,
                    if (menuSlotsRefs) db.menuSlots,
                    if (weekExtrasRefs) db.weekExtras,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recipeIngredientsRefs)
                        await $_getPrefetchedDataByColumns<
                          RecipeRow,
                          $RecipesTable,
                          RecipeIngredientRow,
                          $RecipeIngredientsTable
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._recipeIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeIngredientsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'recipe_id',
                          typedResults: items,
                        ),
                      if (recipeStepsRefs)
                        await $_getPrefetchedDataByColumns<
                          RecipeRow,
                          $RecipesTable,
                          RecipeStepRow,
                          $RecipeStepsTable
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._recipeStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeStepsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'recipe_id',
                          typedResults: items,
                        ),
                      if (recipeUserStatesRefs)
                        await $_getPrefetchedDataByColumns<
                          RecipeRow,
                          $RecipesTable,
                          RecipeUserStateRow,
                          $RecipeUserStatesTable
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._recipeUserStatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeUserStatesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'recipe_id',
                          typedResults: items,
                        ),
                      if (menuSlotsRefs)
                        await $_getPrefetchedDataByColumns<
                          RecipeRow,
                          $RecipesTable,
                          MenuSlotRow,
                          $MenuSlotsTable
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._menuSlotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).menuSlotsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'recipe_id',
                          typedResults: items,
                        ),
                      if (weekExtrasRefs)
                        await $_getPrefetchedDataByColumns<
                          RecipeRow,
                          $RecipesTable,
                          WeekExtraRow,
                          $WeekExtrasTable
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._weekExtrasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).weekExtrasRefs,
                          currentColumn: 'id',
                          referencedColumn: 'recipe_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipesTable,
      RecipeRow,
      $$RecipesTableFilterComposer,
      $$RecipesTableOrderingComposer,
      $$RecipesTableAnnotationComposer,
      $$RecipesTableCreateCompanionBuilder,
      $$RecipesTableUpdateCompanionBuilder,
      (RecipeRow, $$RecipesTableReferences),
      RecipeRow,
      PrefetchHooks Function({
        bool recipeIngredientsRefs,
        bool recipeStepsRefs,
        bool recipeUserStatesRefs,
        bool menuSlotsRefs,
        bool weekExtrasRefs,
      })
    >;
typedef $$RecipeIngredientsTableCreateCompanionBuilder =
    RecipeIngredientsCompanion Function({
      Value<int> id,
      required int recipeId,
      required String ingredientId,
      required double qty,
      required String unit,
      Value<bool> optional,
      Value<String?> note,
      required int position,
    });
typedef $$RecipeIngredientsTableUpdateCompanionBuilder =
    RecipeIngredientsCompanion Function({
      Value<int> id,
      Value<int> recipeId,
      Value<String> ingredientId,
      Value<double> qty,
      Value<String> unit,
      Value<bool> optional,
      Value<String?> note,
      Value<int> position,
    });

final class $$RecipeIngredientsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecipeIngredientsTable,
          RecipeIngredientRow
        > {
  $$RecipeIngredientsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('recipe_ingredients__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) => db
      .ingredients
      .createAlias('recipe_ingredients__ingredient_id__ingredients__id');

  $$IngredientsTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<String>('ingredient_id')!;

    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeIngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get optional => $composableBuilder(
    column: $table.optional,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get optional => $composableBuilder(
    column: $table.optional,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<bool> get optional =>
      $composableBuilder(column: $table.optional, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeIngredientsTable,
          RecipeIngredientRow,
          $$RecipeIngredientsTableFilterComposer,
          $$RecipeIngredientsTableOrderingComposer,
          $$RecipeIngredientsTableAnnotationComposer,
          $$RecipeIngredientsTableCreateCompanionBuilder,
          $$RecipeIngredientsTableUpdateCompanionBuilder,
          (RecipeIngredientRow, $$RecipeIngredientsTableReferences),
          RecipeIngredientRow,
          PrefetchHooks Function({bool recipeId, bool ingredientId})
        > {
  $$RecipeIngredientsTableTableManager(
    _$AppDatabase db,
    $RecipeIngredientsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeIngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeIngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeIngredientsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> recipeId = const Value.absent(),
                Value<String> ingredientId = const Value.absent(),
                Value<double> qty = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<bool> optional = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> position = const Value.absent(),
              }) => RecipeIngredientsCompanion(
                id: id,
                recipeId: recipeId,
                ingredientId: ingredientId,
                qty: qty,
                unit: unit,
                optional: optional,
                note: note,
                position: position,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int recipeId,
                required String ingredientId,
                required double qty,
                required String unit,
                Value<bool> optional = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required int position,
              }) => RecipeIngredientsCompanion.insert(
                id: id,
                recipeId: recipeId,
                ingredientId: ingredientId,
                qty: qty,
                unit: unit,
                optional: optional,
                note: note,
                position: position,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipeIngredientsTable, RecipeIngredientRow>(
                    table,
                  ),
                  $$RecipeIngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false, ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$RecipeIngredientsTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$RecipeIngredientsTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (ingredientId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ingredientId,
                        referencedTable: $$RecipeIngredientsTableReferences
                            ._ingredientIdTable(db),
                        referencedColumn: $$RecipeIngredientsTableReferences
                            ._ingredientIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeIngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeIngredientsTable,
      RecipeIngredientRow,
      $$RecipeIngredientsTableFilterComposer,
      $$RecipeIngredientsTableOrderingComposer,
      $$RecipeIngredientsTableAnnotationComposer,
      $$RecipeIngredientsTableCreateCompanionBuilder,
      $$RecipeIngredientsTableUpdateCompanionBuilder,
      (RecipeIngredientRow, $$RecipeIngredientsTableReferences),
      RecipeIngredientRow,
      PrefetchHooks Function({bool recipeId, bool ingredientId})
    >;
typedef $$RecipeStepsTableCreateCompanionBuilder =
    RecipeStepsCompanion Function({
      Value<int> id,
      required int recipeId,
      required int position,
      required String body,
    });
typedef $$RecipeStepsTableUpdateCompanionBuilder =
    RecipeStepsCompanion Function({
      Value<int> id,
      Value<int> recipeId,
      Value<int> position,
      Value<String> body,
    });

final class $$RecipeStepsTableReferences
    extends BaseReferences<_$AppDatabase, $RecipeStepsTable, RecipeStepRow> {
  $$RecipeStepsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('recipe_steps__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeStepsTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeStepsTable> {
  $$RecipeStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeStepsTable> {
  $$RecipeStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeStepsTable> {
  $$RecipeStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeStepsTable,
          RecipeStepRow,
          $$RecipeStepsTableFilterComposer,
          $$RecipeStepsTableOrderingComposer,
          $$RecipeStepsTableAnnotationComposer,
          $$RecipeStepsTableCreateCompanionBuilder,
          $$RecipeStepsTableUpdateCompanionBuilder,
          (RecipeStepRow, $$RecipeStepsTableReferences),
          RecipeStepRow,
          PrefetchHooks Function({bool recipeId})
        > {
  $$RecipeStepsTableTableManager(_$AppDatabase db, $RecipeStepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> recipeId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> body = const Value.absent(),
              }) => RecipeStepsCompanion(
                id: id,
                recipeId: recipeId,
                position: position,
                body: body,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int recipeId,
                required int position,
                required String body,
              }) => RecipeStepsCompanion.insert(
                id: id,
                recipeId: recipeId,
                position: position,
                body: body,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipeStepsTable, RecipeStepRow>(table),
                  $$RecipeStepsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$RecipeStepsTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$RecipeStepsTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeStepsTable,
      RecipeStepRow,
      $$RecipeStepsTableFilterComposer,
      $$RecipeStepsTableOrderingComposer,
      $$RecipeStepsTableAnnotationComposer,
      $$RecipeStepsTableCreateCompanionBuilder,
      $$RecipeStepsTableUpdateCompanionBuilder,
      (RecipeStepRow, $$RecipeStepsTableReferences),
      RecipeStepRow,
      PrefetchHooks Function({bool recipeId})
    >;
typedef $$RecipeUserStatesTableCreateCompanionBuilder =
    RecipeUserStatesCompanion Function({
      Value<int> recipeId,
      Value<bool> favorite,
      Value<bool> toPlace,
      Value<bool> disliked,
      Value<DateTime?> lastPlannedAt,
    });
typedef $$RecipeUserStatesTableUpdateCompanionBuilder =
    RecipeUserStatesCompanion Function({
      Value<int> recipeId,
      Value<bool> favorite,
      Value<bool> toPlace,
      Value<bool> disliked,
      Value<DateTime?> lastPlannedAt,
    });

final class $$RecipeUserStatesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecipeUserStatesTable,
          RecipeUserStateRow
        > {
  $$RecipeUserStatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('recipe_user_state__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeUserStatesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeUserStatesTable> {
  $$RecipeUserStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get favorite => $composableBuilder(
    column: $table.favorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get toPlace => $composableBuilder(
    column: $table.toPlace,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get disliked => $composableBuilder(
    column: $table.disliked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPlannedAt => $composableBuilder(
    column: $table.lastPlannedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeUserStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeUserStatesTable> {
  $$RecipeUserStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get favorite => $composableBuilder(
    column: $table.favorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get toPlace => $composableBuilder(
    column: $table.toPlace,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get disliked => $composableBuilder(
    column: $table.disliked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPlannedAt => $composableBuilder(
    column: $table.lastPlannedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeUserStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeUserStatesTable> {
  $$RecipeUserStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get favorite =>
      $composableBuilder(column: $table.favorite, builder: (column) => column);

  GeneratedColumn<bool> get toPlace =>
      $composableBuilder(column: $table.toPlace, builder: (column) => column);

  GeneratedColumn<bool> get disliked =>
      $composableBuilder(column: $table.disliked, builder: (column) => column);

  GeneratedColumn<DateTime> get lastPlannedAt => $composableBuilder(
    column: $table.lastPlannedAt,
    builder: (column) => column,
  );

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeUserStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeUserStatesTable,
          RecipeUserStateRow,
          $$RecipeUserStatesTableFilterComposer,
          $$RecipeUserStatesTableOrderingComposer,
          $$RecipeUserStatesTableAnnotationComposer,
          $$RecipeUserStatesTableCreateCompanionBuilder,
          $$RecipeUserStatesTableUpdateCompanionBuilder,
          (RecipeUserStateRow, $$RecipeUserStatesTableReferences),
          RecipeUserStateRow,
          PrefetchHooks Function({bool recipeId})
        > {
  $$RecipeUserStatesTableTableManager(
    _$AppDatabase db,
    $RecipeUserStatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeUserStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeUserStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeUserStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> recipeId = const Value.absent(),
                Value<bool> favorite = const Value.absent(),
                Value<bool> toPlace = const Value.absent(),
                Value<bool> disliked = const Value.absent(),
                Value<DateTime?> lastPlannedAt = const Value.absent(),
              }) => RecipeUserStatesCompanion(
                recipeId: recipeId,
                favorite: favorite,
                toPlace: toPlace,
                disliked: disliked,
                lastPlannedAt: lastPlannedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> recipeId = const Value.absent(),
                Value<bool> favorite = const Value.absent(),
                Value<bool> toPlace = const Value.absent(),
                Value<bool> disliked = const Value.absent(),
                Value<DateTime?> lastPlannedAt = const Value.absent(),
              }) => RecipeUserStatesCompanion.insert(
                recipeId: recipeId,
                favorite: favorite,
                toPlace: toPlace,
                disliked: disliked,
                lastPlannedAt: lastPlannedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipeUserStatesTable, RecipeUserStateRow>(
                    table,
                  ),
                  $$RecipeUserStatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$RecipeUserStatesTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$RecipeUserStatesTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeUserStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeUserStatesTable,
      RecipeUserStateRow,
      $$RecipeUserStatesTableFilterComposer,
      $$RecipeUserStatesTableOrderingComposer,
      $$RecipeUserStatesTableAnnotationComposer,
      $$RecipeUserStatesTableCreateCompanionBuilder,
      $$RecipeUserStatesTableUpdateCompanionBuilder,
      (RecipeUserStateRow, $$RecipeUserStatesTableReferences),
      RecipeUserStateRow,
      PrefetchHooks Function({bool recipeId})
    >;
typedef $$ProfilesTableCreateCompanionBuilder = ProfilesCompanion Function({
  Value<int> id,
  Value<bool> onboarded,
  Value<int> people,
  Value<String> diet,
  Value<bool> noPork,
  Value<int> maxMinWeekday,
  Value<int> maxMinWeekend,
  Value<int> weekStartDay,
  Value<double> favoriteShare,
  Value<int> antiRepeatWeeks,
  Value<String> aisleOrder,
  Value<String> themeMode,
});
typedef $$ProfilesTableUpdateCompanionBuilder = ProfilesCompanion Function({
  Value<int> id,
  Value<bool> onboarded,
  Value<int> people,
  Value<String> diet,
  Value<bool> noPork,
  Value<int> maxMinWeekday,
  Value<int> maxMinWeekend,
  Value<int> weekStartDay,
  Value<double> favoriteShare,
  Value<int> antiRepeatWeeks,
  Value<String> aisleOrder,
  Value<String> themeMode,
});

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboarded => $composableBuilder(
    column: $table.onboarded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get people => $composableBuilder(
    column: $table.people,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get diet => $composableBuilder(
    column: $table.diet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get noPork => $composableBuilder(
    column: $table.noPork,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxMinWeekday => $composableBuilder(
    column: $table.maxMinWeekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxMinWeekend => $composableBuilder(
    column: $table.maxMinWeekend,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekStartDay => $composableBuilder(
    column: $table.weekStartDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get favoriteShare => $composableBuilder(
    column: $table.favoriteShare,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get antiRepeatWeeks => $composableBuilder(
    column: $table.antiRepeatWeeks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aisleOrder => $composableBuilder(
    column: $table.aisleOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboarded => $composableBuilder(
    column: $table.onboarded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get people => $composableBuilder(
    column: $table.people,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diet => $composableBuilder(
    column: $table.diet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get noPork => $composableBuilder(
    column: $table.noPork,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxMinWeekday => $composableBuilder(
    column: $table.maxMinWeekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxMinWeekend => $composableBuilder(
    column: $table.maxMinWeekend,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekStartDay => $composableBuilder(
    column: $table.weekStartDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get favoriteShare => $composableBuilder(
    column: $table.favoriteShare,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get antiRepeatWeeks => $composableBuilder(
    column: $table.antiRepeatWeeks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aisleOrder => $composableBuilder(
    column: $table.aisleOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get onboarded =>
      $composableBuilder(column: $table.onboarded, builder: (column) => column);

  GeneratedColumn<int> get people =>
      $composableBuilder(column: $table.people, builder: (column) => column);

  GeneratedColumn<String> get diet =>
      $composableBuilder(column: $table.diet, builder: (column) => column);

  GeneratedColumn<bool> get noPork =>
      $composableBuilder(column: $table.noPork, builder: (column) => column);

  GeneratedColumn<int> get maxMinWeekday => $composableBuilder(
    column: $table.maxMinWeekday,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxMinWeekend => $composableBuilder(
    column: $table.maxMinWeekend,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weekStartDay => $composableBuilder(
    column: $table.weekStartDay,
    builder: (column) => column,
  );

  GeneratedColumn<double> get favoriteShare => $composableBuilder(
    column: $table.favoriteShare,
    builder: (column) => column,
  );

  GeneratedColumn<int> get antiRepeatWeeks => $composableBuilder(
    column: $table.antiRepeatWeeks,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aisleOrder => $composableBuilder(
    column: $table.aisleOrder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          ProfileRow,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (
            ProfileRow,
            BaseReferences<_$AppDatabase, $ProfilesTable, ProfileRow>,
          ),
          ProfileRow,
          PrefetchHooks Function()
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboarded = const Value.absent(),
                Value<int> people = const Value.absent(),
                Value<String> diet = const Value.absent(),
                Value<bool> noPork = const Value.absent(),
                Value<int> maxMinWeekday = const Value.absent(),
                Value<int> maxMinWeekend = const Value.absent(),
                Value<int> weekStartDay = const Value.absent(),
                Value<double> favoriteShare = const Value.absent(),
                Value<int> antiRepeatWeeks = const Value.absent(),
                Value<String> aisleOrder = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                onboarded: onboarded,
                people: people,
                diet: diet,
                noPork: noPork,
                maxMinWeekday: maxMinWeekday,
                maxMinWeekend: maxMinWeekend,
                weekStartDay: weekStartDay,
                favoriteShare: favoriteShare,
                antiRepeatWeeks: antiRepeatWeeks,
                aisleOrder: aisleOrder,
                themeMode: themeMode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboarded = const Value.absent(),
                Value<int> people = const Value.absent(),
                Value<String> diet = const Value.absent(),
                Value<bool> noPork = const Value.absent(),
                Value<int> maxMinWeekday = const Value.absent(),
                Value<int> maxMinWeekend = const Value.absent(),
                Value<int> weekStartDay = const Value.absent(),
                Value<double> favoriteShare = const Value.absent(),
                Value<int> antiRepeatWeeks = const Value.absent(),
                Value<String> aisleOrder = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                onboarded: onboarded,
                people: people,
                diet: diet,
                noPork: noPork,
                maxMinWeekday: maxMinWeekday,
                maxMinWeekend: maxMinWeekend,
                weekStartDay: weekStartDay,
                favoriteShare: favoriteShare,
                antiRepeatWeeks: antiRepeatWeeks,
                aisleOrder: aisleOrder,
                themeMode: themeMode,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfilesTable, ProfileRow>(table),
                  BaseReferences<_$AppDatabase, $ProfilesTable, ProfileRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      ProfileRow,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (ProfileRow, BaseReferences<_$AppDatabase, $ProfilesTable, ProfileRow>),
      ProfileRow,
      PrefetchHooks Function()
    >;
typedef $$ProfileAversionsTableCreateCompanionBuilder =
    ProfileAversionsCompanion Function({
      required String ingredientId,
      Value<int> rowid,
    });
typedef $$ProfileAversionsTableUpdateCompanionBuilder =
    ProfileAversionsCompanion Function({
      Value<String> ingredientId,
      Value<int> rowid,
    });

final class $$ProfileAversionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProfileAversionsTable,
          ProfileAversionRow
        > {
  $$ProfileAversionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) => db
      .ingredients
      .createAlias('profile_aversions__ingredient_id__ingredients__id');

  $$IngredientsTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<String>('ingredient_id')!;

    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProfileAversionsTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileAversionsTable> {
  $$ProfileAversionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileAversionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileAversionsTable> {
  $$ProfileAversionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileAversionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileAversionsTable> {
  $$ProfileAversionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileAversionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileAversionsTable,
          ProfileAversionRow,
          $$ProfileAversionsTableFilterComposer,
          $$ProfileAversionsTableOrderingComposer,
          $$ProfileAversionsTableAnnotationComposer,
          $$ProfileAversionsTableCreateCompanionBuilder,
          $$ProfileAversionsTableUpdateCompanionBuilder,
          (ProfileAversionRow, $$ProfileAversionsTableReferences),
          ProfileAversionRow,
          PrefetchHooks Function({bool ingredientId})
        > {
  $$ProfileAversionsTableTableManager(
    _$AppDatabase db,
    $ProfileAversionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileAversionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileAversionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileAversionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> ingredientId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfileAversionsCompanion(
                ingredientId: ingredientId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String ingredientId,
                Value<int> rowid = const Value.absent(),
              }) => ProfileAversionsCompanion.insert(
                ingredientId: ingredientId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfileAversionsTable, ProfileAversionRow>(
                    table,
                  ),
                  $$ProfileAversionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ingredientId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ingredientId,
                        referencedTable: $$ProfileAversionsTableReferences
                            ._ingredientIdTable(db),
                        referencedColumn: $$ProfileAversionsTableReferences
                            ._ingredientIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProfileAversionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileAversionsTable,
      ProfileAversionRow,
      $$ProfileAversionsTableFilterComposer,
      $$ProfileAversionsTableOrderingComposer,
      $$ProfileAversionsTableAnnotationComposer,
      $$ProfileAversionsTableCreateCompanionBuilder,
      $$ProfileAversionsTableUpdateCompanionBuilder,
      (ProfileAversionRow, $$ProfileAversionsTableReferences),
      ProfileAversionRow,
      PrefetchHooks Function({bool ingredientId})
    >;
typedef $$ProfileExclusionsTableCreateCompanionBuilder =
    ProfileExclusionsCompanion Function({
      required String allergen,
      Value<int> rowid,
    });
typedef $$ProfileExclusionsTableUpdateCompanionBuilder =
    ProfileExclusionsCompanion Function({
      Value<String> allergen,
      Value<int> rowid,
    });

class $$ProfileExclusionsTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileExclusionsTable> {
  $$ProfileExclusionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get allergen => $composableBuilder(
    column: $table.allergen,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfileExclusionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileExclusionsTable> {
  $$ProfileExclusionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get allergen => $composableBuilder(
    column: $table.allergen,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileExclusionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileExclusionsTable> {
  $$ProfileExclusionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get allergen =>
      $composableBuilder(column: $table.allergen, builder: (column) => column);
}

class $$ProfileExclusionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileExclusionsTable,
          ProfileExclusionRow,
          $$ProfileExclusionsTableFilterComposer,
          $$ProfileExclusionsTableOrderingComposer,
          $$ProfileExclusionsTableAnnotationComposer,
          $$ProfileExclusionsTableCreateCompanionBuilder,
          $$ProfileExclusionsTableUpdateCompanionBuilder,
          (
            ProfileExclusionRow,
            BaseReferences<
              _$AppDatabase,
              $ProfileExclusionsTable,
              ProfileExclusionRow
            >,
          ),
          ProfileExclusionRow,
          PrefetchHooks Function()
        > {
  $$ProfileExclusionsTableTableManager(
    _$AppDatabase db,
    $ProfileExclusionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileExclusionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileExclusionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileExclusionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback: ({
            Value<String> allergen = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => ProfileExclusionsCompanion(allergen: allergen, rowid: rowid),
          createCompanionCallback:
              ({
                required String allergen,
                Value<int> rowid = const Value.absent(),
              }) => ProfileExclusionsCompanion.insert(
                allergen: allergen,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfileExclusionsTable, ProfileExclusionRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ProfileExclusionsTable,
                    ProfileExclusionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfileExclusionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileExclusionsTable,
      ProfileExclusionRow,
      $$ProfileExclusionsTableFilterComposer,
      $$ProfileExclusionsTableOrderingComposer,
      $$ProfileExclusionsTableAnnotationComposer,
      $$ProfileExclusionsTableCreateCompanionBuilder,
      $$ProfileExclusionsTableUpdateCompanionBuilder,
      (
        ProfileExclusionRow,
        BaseReferences<
          _$AppDatabase,
          $ProfileExclusionsTable,
          ProfileExclusionRow
        >,
      ),
      ProfileExclusionRow,
      PrefetchHooks Function()
    >;
typedef $$ProfileEquipmentTableCreateCompanionBuilder =
    ProfileEquipmentCompanion Function({
      required String equipment,
      Value<int> rowid,
    });
typedef $$ProfileEquipmentTableUpdateCompanionBuilder =
    ProfileEquipmentCompanion Function({
      Value<String> equipment,
      Value<int> rowid,
    });

class $$ProfileEquipmentTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileEquipmentTable> {
  $$ProfileEquipmentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfileEquipmentTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileEquipmentTable> {
  $$ProfileEquipmentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileEquipmentTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileEquipmentTable> {
  $$ProfileEquipmentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get equipment =>
      $composableBuilder(column: $table.equipment, builder: (column) => column);
}

class $$ProfileEquipmentTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileEquipmentTable,
          ProfileEquipmentRow,
          $$ProfileEquipmentTableFilterComposer,
          $$ProfileEquipmentTableOrderingComposer,
          $$ProfileEquipmentTableAnnotationComposer,
          $$ProfileEquipmentTableCreateCompanionBuilder,
          $$ProfileEquipmentTableUpdateCompanionBuilder,
          (
            ProfileEquipmentRow,
            BaseReferences<
              _$AppDatabase,
              $ProfileEquipmentTable,
              ProfileEquipmentRow
            >,
          ),
          ProfileEquipmentRow,
          PrefetchHooks Function()
        > {
  $$ProfileEquipmentTableTableManager(
    _$AppDatabase db,
    $ProfileEquipmentTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileEquipmentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileEquipmentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileEquipmentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> equipment = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => ProfileEquipmentCompanion(equipment: equipment, rowid: rowid),
          createCompanionCallback:
              ({
                required String equipment,
                Value<int> rowid = const Value.absent(),
              }) => ProfileEquipmentCompanion.insert(
                equipment: equipment,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfileEquipmentTable, ProfileEquipmentRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ProfileEquipmentTable,
                    ProfileEquipmentRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfileEquipmentTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileEquipmentTable,
      ProfileEquipmentRow,
      $$ProfileEquipmentTableFilterComposer,
      $$ProfileEquipmentTableOrderingComposer,
      $$ProfileEquipmentTableAnnotationComposer,
      $$ProfileEquipmentTableCreateCompanionBuilder,
      $$ProfileEquipmentTableUpdateCompanionBuilder,
      (
        ProfileEquipmentRow,
        BaseReferences<
          _$AppDatabase,
          $ProfileEquipmentTable,
          ProfileEquipmentRow
        >,
      ),
      ProfileEquipmentRow,
      PrefetchHooks Function()
    >;
typedef $$ProfileSlotsTableCreateCompanionBuilder =
    ProfileSlotsCompanion Function({
      required int day,
      required String meal,
      Value<int> rowid,
    });
typedef $$ProfileSlotsTableUpdateCompanionBuilder =
    ProfileSlotsCompanion Function({
      Value<int> day,
      Value<String> meal,
      Value<int> rowid,
    });

class $$ProfileSlotsTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileSlotsTable> {
  $$ProfileSlotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meal => $composableBuilder(
    column: $table.meal,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfileSlotsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileSlotsTable> {
  $$ProfileSlotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meal => $composableBuilder(
    column: $table.meal,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileSlotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileSlotsTable> {
  $$ProfileSlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get meal =>
      $composableBuilder(column: $table.meal, builder: (column) => column);
}

class $$ProfileSlotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileSlotsTable,
          ProfileSlotRow,
          $$ProfileSlotsTableFilterComposer,
          $$ProfileSlotsTableOrderingComposer,
          $$ProfileSlotsTableAnnotationComposer,
          $$ProfileSlotsTableCreateCompanionBuilder,
          $$ProfileSlotsTableUpdateCompanionBuilder,
          (
            ProfileSlotRow,
            BaseReferences<_$AppDatabase, $ProfileSlotsTable, ProfileSlotRow>,
          ),
          ProfileSlotRow,
          PrefetchHooks Function()
        > {
  $$ProfileSlotsTableTableManager(_$AppDatabase db, $ProfileSlotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileSlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileSlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileSlotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> day = const Value.absent(),
            Value<String> meal = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => ProfileSlotsCompanion(day: day, meal: meal, rowid: rowid),
          createCompanionCallback:
              ({
                required int day,
                required String meal,
                Value<int> rowid = const Value.absent(),
              }) => ProfileSlotsCompanion.insert(
                day: day,
                meal: meal,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfileSlotsTable, ProfileSlotRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ProfileSlotsTable,
                    ProfileSlotRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfileSlotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileSlotsTable,
      ProfileSlotRow,
      $$ProfileSlotsTableFilterComposer,
      $$ProfileSlotsTableOrderingComposer,
      $$ProfileSlotsTableAnnotationComposer,
      $$ProfileSlotsTableCreateCompanionBuilder,
      $$ProfileSlotsTableUpdateCompanionBuilder,
      (
        ProfileSlotRow,
        BaseReferences<_$AppDatabase, $ProfileSlotsTable, ProfileSlotRow>,
      ),
      ProfileSlotRow,
      PrefetchHooks Function()
    >;
typedef $$WeekMenusTableCreateCompanionBuilder = WeekMenusCompanion Function({
  Value<int> id,
  required DateTime startDate,
  Value<String> status,
  Value<int> seed,
});
typedef $$WeekMenusTableUpdateCompanionBuilder = WeekMenusCompanion Function({
  Value<int> id,
  Value<DateTime> startDate,
  Value<String> status,
  Value<int> seed,
});

final class $$WeekMenusTableReferences
    extends BaseReferences<_$AppDatabase, $WeekMenusTable, WeekMenuRow> {
  $$WeekMenusTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MenuSlotsTable, List<MenuSlotRow>>
  _menuSlotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.menuSlots,
    aliasName: 'week_menus__id__menu_slots__menu_id',
  );

  $$MenuSlotsTableProcessedTableManager get menuSlotsRefs {
    final manager = $$MenuSlotsTableTableManager(
      $_db,
      $_db.menuSlots,
    ).filter((f) => f.menuId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_menuSlotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WeekExtrasTable, List<WeekExtraRow>>
  _weekExtrasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weekExtras,
    aliasName: 'week_menus__id__week_extras__menu_id',
  );

  $$WeekExtrasTableProcessedTableManager get weekExtrasRefs {
    final manager = $$WeekExtrasTableTableManager(
      $_db,
      $_db.weekExtras,
    ).filter((f) => f.menuId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_weekExtrasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ShoppingItemsTable, List<ShoppingItemRow>>
  _shoppingItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.shoppingItems,
    aliasName: 'week_menus__id__shopping_items__menu_id',
  );

  $$ShoppingItemsTableProcessedTableManager get shoppingItemsRefs {
    final manager = $$ShoppingItemsTableTableManager(
      $_db,
      $_db.shoppingItems,
    ).filter((f) => f.menuId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_shoppingItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MealCompletionsTable, List<MealCompletionRow>>
  _mealCompletionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealCompletions,
    aliasName: 'week_menus__id__meal_completions__menu_id',
  );

  $$MealCompletionsTableProcessedTableManager get mealCompletionsRefs {
    final manager = $$MealCompletionsTableTableManager(
      $_db,
      $_db.mealCompletions,
    ).filter((f) => f.menuId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mealCompletionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WeekMenusTableFilterComposer
    extends Composer<_$AppDatabase, $WeekMenusTable> {
  $$WeekMenusTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seed => $composableBuilder(
    column: $table.seed,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> menuSlotsRefs(
    Expression<bool> Function($$MenuSlotsTableFilterComposer f) f,
  ) {
    final $$MenuSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuSlots,
      getReferencedColumn: (t) => t.menuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuSlotsTableFilterComposer(
            $db: $db,
            $table: $db.menuSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> weekExtrasRefs(
    Expression<bool> Function($$WeekExtrasTableFilterComposer f) f,
  ) {
    final $$WeekExtrasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weekExtras,
      getReferencedColumn: (t) => t.menuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekExtrasTableFilterComposer(
            $db: $db,
            $table: $db.weekExtras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> shoppingItemsRefs(
    Expression<bool> Function($$ShoppingItemsTableFilterComposer f) f,
  ) {
    final $$ShoppingItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shoppingItems,
      getReferencedColumn: (t) => t.menuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingItemsTableFilterComposer(
            $db: $db,
            $table: $db.shoppingItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mealCompletionsRefs(
    Expression<bool> Function($$MealCompletionsTableFilterComposer f) f,
  ) {
    final $$MealCompletionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealCompletions,
      getReferencedColumn: (t) => t.menuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealCompletionsTableFilterComposer(
            $db: $db,
            $table: $db.mealCompletions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeekMenusTableOrderingComposer
    extends Composer<_$AppDatabase, $WeekMenusTable> {
  $$WeekMenusTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seed => $composableBuilder(
    column: $table.seed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeekMenusTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeekMenusTable> {
  $$WeekMenusTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get seed =>
      $composableBuilder(column: $table.seed, builder: (column) => column);

  Expression<T> menuSlotsRefs<T extends Object>(
    Expression<T> Function($$MenuSlotsTableAnnotationComposer a) f,
  ) {
    final $$MenuSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuSlots,
      getReferencedColumn: (t) => t.menuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.menuSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> weekExtrasRefs<T extends Object>(
    Expression<T> Function($$WeekExtrasTableAnnotationComposer a) f,
  ) {
    final $$WeekExtrasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weekExtras,
      getReferencedColumn: (t) => t.menuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekExtrasTableAnnotationComposer(
            $db: $db,
            $table: $db.weekExtras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> shoppingItemsRefs<T extends Object>(
    Expression<T> Function($$ShoppingItemsTableAnnotationComposer a) f,
  ) {
    final $$ShoppingItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shoppingItems,
      getReferencedColumn: (t) => t.menuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.shoppingItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mealCompletionsRefs<T extends Object>(
    Expression<T> Function($$MealCompletionsTableAnnotationComposer a) f,
  ) {
    final $$MealCompletionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealCompletions,
      getReferencedColumn: (t) => t.menuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealCompletionsTableAnnotationComposer(
            $db: $db,
            $table: $db.mealCompletions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeekMenusTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeekMenusTable,
          WeekMenuRow,
          $$WeekMenusTableFilterComposer,
          $$WeekMenusTableOrderingComposer,
          $$WeekMenusTableAnnotationComposer,
          $$WeekMenusTableCreateCompanionBuilder,
          $$WeekMenusTableUpdateCompanionBuilder,
          (WeekMenuRow, $$WeekMenusTableReferences),
          WeekMenuRow,
          PrefetchHooks Function({
            bool menuSlotsRefs,
            bool weekExtrasRefs,
            bool shoppingItemsRefs,
            bool mealCompletionsRefs,
          })
        > {
  $$WeekMenusTableTableManager(_$AppDatabase db, $WeekMenusTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeekMenusTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeekMenusTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeekMenusTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> seed = const Value.absent(),
              }) => WeekMenusCompanion(
                id: id,
                startDate: startDate,
                status: status,
                seed: seed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime startDate,
                Value<String> status = const Value.absent(),
                Value<int> seed = const Value.absent(),
              }) => WeekMenusCompanion.insert(
                id: id,
                startDate: startDate,
                status: status,
                seed: seed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WeekMenusTable, WeekMenuRow>(table),
                  $$WeekMenusTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                menuSlotsRefs = false,
                weekExtrasRefs = false,
                shoppingItemsRefs = false,
                mealCompletionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (menuSlotsRefs) db.menuSlots,
                    if (weekExtrasRefs) db.weekExtras,
                    if (shoppingItemsRefs) db.shoppingItems,
                    if (mealCompletionsRefs) db.mealCompletions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (menuSlotsRefs)
                        await $_getPrefetchedDataByColumns<
                          WeekMenuRow,
                          $WeekMenusTable,
                          MenuSlotRow,
                          $MenuSlotsTable
                        >(
                          currentTable: table,
                          referencedTable: $$WeekMenusTableReferences
                              ._menuSlotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeekMenusTableReferences(
                                db,
                                table,
                                p0,
                              ).menuSlotsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'menu_id',
                          typedResults: items,
                        ),
                      if (weekExtrasRefs)
                        await $_getPrefetchedDataByColumns<
                          WeekMenuRow,
                          $WeekMenusTable,
                          WeekExtraRow,
                          $WeekExtrasTable
                        >(
                          currentTable: table,
                          referencedTable: $$WeekMenusTableReferences
                              ._weekExtrasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeekMenusTableReferences(
                                db,
                                table,
                                p0,
                              ).weekExtrasRefs,
                          currentColumn: 'id',
                          referencedColumn: 'menu_id',
                          typedResults: items,
                        ),
                      if (shoppingItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          WeekMenuRow,
                          $WeekMenusTable,
                          ShoppingItemRow,
                          $ShoppingItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$WeekMenusTableReferences
                              ._shoppingItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeekMenusTableReferences(
                                db,
                                table,
                                p0,
                              ).shoppingItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'menu_id',
                          typedResults: items,
                        ),
                      if (mealCompletionsRefs)
                        await $_getPrefetchedDataByColumns<
                          WeekMenuRow,
                          $WeekMenusTable,
                          MealCompletionRow,
                          $MealCompletionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$WeekMenusTableReferences
                              ._mealCompletionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeekMenusTableReferences(
                                db,
                                table,
                                p0,
                              ).mealCompletionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'menu_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WeekMenusTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeekMenusTable,
      WeekMenuRow,
      $$WeekMenusTableFilterComposer,
      $$WeekMenusTableOrderingComposer,
      $$WeekMenusTableAnnotationComposer,
      $$WeekMenusTableCreateCompanionBuilder,
      $$WeekMenusTableUpdateCompanionBuilder,
      (WeekMenuRow, $$WeekMenusTableReferences),
      WeekMenuRow,
      PrefetchHooks Function({
        bool menuSlotsRefs,
        bool weekExtrasRefs,
        bool shoppingItemsRefs,
        bool mealCompletionsRefs,
      })
    >;
typedef $$MenuSlotsTableCreateCompanionBuilder = MenuSlotsCompanion Function({
  Value<int> id,
  required int menuId,
  required int day,
  required String meal,
  required String kind,
  Value<int?> recipeId,
  required int servings,
  Value<bool> locked,
  Value<String?> leftoversFrom,
});
typedef $$MenuSlotsTableUpdateCompanionBuilder = MenuSlotsCompanion Function({
  Value<int> id,
  Value<int> menuId,
  Value<int> day,
  Value<String> meal,
  Value<String> kind,
  Value<int?> recipeId,
  Value<int> servings,
  Value<bool> locked,
  Value<String?> leftoversFrom,
});

final class $$MenuSlotsTableReferences
    extends BaseReferences<_$AppDatabase, $MenuSlotsTable, MenuSlotRow> {
  $$MenuSlotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WeekMenusTable _menuIdTable(_$AppDatabase db) =>
      db.weekMenus.createAlias('menu_slots__menu_id__week_menus__id');

  $$WeekMenusTableProcessedTableManager get menuId {
    final $_column = $_itemColumn<int>('menu_id')!;

    final manager = $$WeekMenusTableTableManager(
      $_db,
      $_db.weekMenus,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_menuIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('menu_slots__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager? get recipeId {
    final $_column = $_itemColumn<int>('recipe_id');
    if ($_column == null) return null;
    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MenuSlotsTableFilterComposer
    extends Composer<_$AppDatabase, $MenuSlotsTable> {
  $$MenuSlotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meal => $composableBuilder(
    column: $table.meal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get locked => $composableBuilder(
    column: $table.locked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get leftoversFrom => $composableBuilder(
    column: $table.leftoversFrom,
    builder: (column) => ColumnFilters(column),
  );

  $$WeekMenusTableFilterComposer get menuId {
    final $$WeekMenusTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.weekMenus,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekMenusTableFilterComposer(
            $db: $db,
            $table: $db.weekMenus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuSlotsTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuSlotsTable> {
  $$MenuSlotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meal => $composableBuilder(
    column: $table.meal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get locked => $composableBuilder(
    column: $table.locked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get leftoversFrom => $composableBuilder(
    column: $table.leftoversFrom,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeekMenusTableOrderingComposer get menuId {
    final $$WeekMenusTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.weekMenus,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekMenusTableOrderingComposer(
            $db: $db,
            $table: $db.weekMenus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuSlotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuSlotsTable> {
  $$MenuSlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get meal =>
      $composableBuilder(column: $table.meal, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get servings =>
      $composableBuilder(column: $table.servings, builder: (column) => column);

  GeneratedColumn<bool> get locked =>
      $composableBuilder(column: $table.locked, builder: (column) => column);

  GeneratedColumn<String> get leftoversFrom => $composableBuilder(
    column: $table.leftoversFrom,
    builder: (column) => column,
  );

  $$WeekMenusTableAnnotationComposer get menuId {
    final $$WeekMenusTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.weekMenus,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekMenusTableAnnotationComposer(
            $db: $db,
            $table: $db.weekMenus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuSlotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenuSlotsTable,
          MenuSlotRow,
          $$MenuSlotsTableFilterComposer,
          $$MenuSlotsTableOrderingComposer,
          $$MenuSlotsTableAnnotationComposer,
          $$MenuSlotsTableCreateCompanionBuilder,
          $$MenuSlotsTableUpdateCompanionBuilder,
          (MenuSlotRow, $$MenuSlotsTableReferences),
          MenuSlotRow,
          PrefetchHooks Function({bool menuId, bool recipeId})
        > {
  $$MenuSlotsTableTableManager(_$AppDatabase db, $MenuSlotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuSlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuSlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuSlotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> menuId = const Value.absent(),
                Value<int> day = const Value.absent(),
                Value<String> meal = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int?> recipeId = const Value.absent(),
                Value<int> servings = const Value.absent(),
                Value<bool> locked = const Value.absent(),
                Value<String?> leftoversFrom = const Value.absent(),
              }) => MenuSlotsCompanion(
                id: id,
                menuId: menuId,
                day: day,
                meal: meal,
                kind: kind,
                recipeId: recipeId,
                servings: servings,
                locked: locked,
                leftoversFrom: leftoversFrom,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int menuId,
                required int day,
                required String meal,
                required String kind,
                Value<int?> recipeId = const Value.absent(),
                required int servings,
                Value<bool> locked = const Value.absent(),
                Value<String?> leftoversFrom = const Value.absent(),
              }) => MenuSlotsCompanion.insert(
                id: id,
                menuId: menuId,
                day: day,
                meal: meal,
                kind: kind,
                recipeId: recipeId,
                servings: servings,
                locked: locked,
                leftoversFrom: leftoversFrom,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MenuSlotsTable, MenuSlotRow>(table),
                  $$MenuSlotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({menuId = false, recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (menuId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.menuId,
                        referencedTable: $$MenuSlotsTableReferences
                            ._menuIdTable(db),
                        referencedColumn: $$MenuSlotsTableReferences
                            ._menuIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$MenuSlotsTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$MenuSlotsTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MenuSlotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenuSlotsTable,
      MenuSlotRow,
      $$MenuSlotsTableFilterComposer,
      $$MenuSlotsTableOrderingComposer,
      $$MenuSlotsTableAnnotationComposer,
      $$MenuSlotsTableCreateCompanionBuilder,
      $$MenuSlotsTableUpdateCompanionBuilder,
      (MenuSlotRow, $$MenuSlotsTableReferences),
      MenuSlotRow,
      PrefetchHooks Function({bool menuId, bool recipeId})
    >;
typedef $$WeekExtrasTableCreateCompanionBuilder = WeekExtrasCompanion Function({
  Value<int> id,
  required int menuId,
  required int recipeId,
  required int servings,
});
typedef $$WeekExtrasTableUpdateCompanionBuilder = WeekExtrasCompanion Function({
  Value<int> id,
  Value<int> menuId,
  Value<int> recipeId,
  Value<int> servings,
});

final class $$WeekExtrasTableReferences
    extends BaseReferences<_$AppDatabase, $WeekExtrasTable, WeekExtraRow> {
  $$WeekExtrasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WeekMenusTable _menuIdTable(_$AppDatabase db) =>
      db.weekMenus.createAlias('week_extras__menu_id__week_menus__id');

  $$WeekMenusTableProcessedTableManager get menuId {
    final $_column = $_itemColumn<int>('menu_id')!;

    final manager = $$WeekMenusTableTableManager(
      $_db,
      $_db.weekMenus,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_menuIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('week_extras__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeekExtrasTableFilterComposer
    extends Composer<_$AppDatabase, $WeekExtrasTable> {
  $$WeekExtrasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnFilters(column),
  );

  $$WeekMenusTableFilterComposer get menuId {
    final $$WeekMenusTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.weekMenus,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekMenusTableFilterComposer(
            $db: $db,
            $table: $db.weekMenus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeekExtrasTableOrderingComposer
    extends Composer<_$AppDatabase, $WeekExtrasTable> {
  $$WeekExtrasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeekMenusTableOrderingComposer get menuId {
    final $$WeekMenusTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.weekMenus,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekMenusTableOrderingComposer(
            $db: $db,
            $table: $db.weekMenus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeekExtrasTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeekExtrasTable> {
  $$WeekExtrasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get servings =>
      $composableBuilder(column: $table.servings, builder: (column) => column);

  $$WeekMenusTableAnnotationComposer get menuId {
    final $$WeekMenusTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.weekMenus,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekMenusTableAnnotationComposer(
            $db: $db,
            $table: $db.weekMenus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeekExtrasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeekExtrasTable,
          WeekExtraRow,
          $$WeekExtrasTableFilterComposer,
          $$WeekExtrasTableOrderingComposer,
          $$WeekExtrasTableAnnotationComposer,
          $$WeekExtrasTableCreateCompanionBuilder,
          $$WeekExtrasTableUpdateCompanionBuilder,
          (WeekExtraRow, $$WeekExtrasTableReferences),
          WeekExtraRow,
          PrefetchHooks Function({bool menuId, bool recipeId})
        > {
  $$WeekExtrasTableTableManager(_$AppDatabase db, $WeekExtrasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeekExtrasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeekExtrasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeekExtrasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> menuId = const Value.absent(),
                Value<int> recipeId = const Value.absent(),
                Value<int> servings = const Value.absent(),
              }) => WeekExtrasCompanion(
                id: id,
                menuId: menuId,
                recipeId: recipeId,
                servings: servings,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int menuId,
                required int recipeId,
                required int servings,
              }) => WeekExtrasCompanion.insert(
                id: id,
                menuId: menuId,
                recipeId: recipeId,
                servings: servings,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WeekExtrasTable, WeekExtraRow>(table),
                  $$WeekExtrasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({menuId = false, recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (menuId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.menuId,
                        referencedTable: $$WeekExtrasTableReferences
                            ._menuIdTable(db),
                        referencedColumn: $$WeekExtrasTableReferences
                            ._menuIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$WeekExtrasTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$WeekExtrasTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeekExtrasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeekExtrasTable,
      WeekExtraRow,
      $$WeekExtrasTableFilterComposer,
      $$WeekExtrasTableOrderingComposer,
      $$WeekExtrasTableAnnotationComposer,
      $$WeekExtrasTableCreateCompanionBuilder,
      $$WeekExtrasTableUpdateCompanionBuilder,
      (WeekExtraRow, $$WeekExtrasTableReferences),
      WeekExtraRow,
      PrefetchHooks Function({bool menuId, bool recipeId})
    >;
typedef $$ShoppingItemsTableCreateCompanionBuilder =
    ShoppingItemsCompanion Function({
      Value<int> id,
      required int menuId,
      Value<String?> ingredientId,
      Value<String?> label,
      Value<double?> quantity,
      Value<String?> unit,
      Value<bool> bought,
      Value<bool> atHome,
      Value<bool> manual,
    });
typedef $$ShoppingItemsTableUpdateCompanionBuilder =
    ShoppingItemsCompanion Function({
      Value<int> id,
      Value<int> menuId,
      Value<String?> ingredientId,
      Value<String?> label,
      Value<double?> quantity,
      Value<String?> unit,
      Value<bool> bought,
      Value<bool> atHome,
      Value<bool> manual,
    });

final class $$ShoppingItemsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ShoppingItemsTable, ShoppingItemRow> {
  $$ShoppingItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WeekMenusTable _menuIdTable(_$AppDatabase db) =>
      db.weekMenus.createAlias('shopping_items__menu_id__week_menus__id');

  $$WeekMenusTableProcessedTableManager get menuId {
    final $_column = $_itemColumn<int>('menu_id')!;

    final manager = $$WeekMenusTableTableManager(
      $_db,
      $_db.weekMenus,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_menuIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) => db
      .ingredients
      .createAlias('shopping_items__ingredient_id__ingredients__id');

  $$IngredientsTableProcessedTableManager? get ingredientId {
    final $_column = $_itemColumn<String>('ingredient_id');
    if ($_column == null) return null;
    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ShoppingItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ShoppingItemsTable> {
  $$ShoppingItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get bought => $composableBuilder(
    column: $table.bought,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get atHome => $composableBuilder(
    column: $table.atHome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get manual => $composableBuilder(
    column: $table.manual,
    builder: (column) => ColumnFilters(column),
  );

  $$WeekMenusTableFilterComposer get menuId {
    final $$WeekMenusTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.weekMenus,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekMenusTableFilterComposer(
            $db: $db,
            $table: $db.weekMenus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShoppingItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShoppingItemsTable> {
  $$ShoppingItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get bought => $composableBuilder(
    column: $table.bought,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get atHome => $composableBuilder(
    column: $table.atHome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get manual => $composableBuilder(
    column: $table.manual,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeekMenusTableOrderingComposer get menuId {
    final $$WeekMenusTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.weekMenus,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekMenusTableOrderingComposer(
            $db: $db,
            $table: $db.weekMenus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShoppingItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShoppingItemsTable> {
  $$ShoppingItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<bool> get bought =>
      $composableBuilder(column: $table.bought, builder: (column) => column);

  GeneratedColumn<bool> get atHome =>
      $composableBuilder(column: $table.atHome, builder: (column) => column);

  GeneratedColumn<bool> get manual =>
      $composableBuilder(column: $table.manual, builder: (column) => column);

  $$WeekMenusTableAnnotationComposer get menuId {
    final $$WeekMenusTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.weekMenus,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekMenusTableAnnotationComposer(
            $db: $db,
            $table: $db.weekMenus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShoppingItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShoppingItemsTable,
          ShoppingItemRow,
          $$ShoppingItemsTableFilterComposer,
          $$ShoppingItemsTableOrderingComposer,
          $$ShoppingItemsTableAnnotationComposer,
          $$ShoppingItemsTableCreateCompanionBuilder,
          $$ShoppingItemsTableUpdateCompanionBuilder,
          (ShoppingItemRow, $$ShoppingItemsTableReferences),
          ShoppingItemRow,
          PrefetchHooks Function({bool menuId, bool ingredientId})
        > {
  $$ShoppingItemsTableTableManager(_$AppDatabase db, $ShoppingItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShoppingItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShoppingItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShoppingItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> menuId = const Value.absent(),
                Value<String?> ingredientId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<double?> quantity = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<bool> bought = const Value.absent(),
                Value<bool> atHome = const Value.absent(),
                Value<bool> manual = const Value.absent(),
              }) => ShoppingItemsCompanion(
                id: id,
                menuId: menuId,
                ingredientId: ingredientId,
                label: label,
                quantity: quantity,
                unit: unit,
                bought: bought,
                atHome: atHome,
                manual: manual,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int menuId,
                Value<String?> ingredientId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<double?> quantity = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<bool> bought = const Value.absent(),
                Value<bool> atHome = const Value.absent(),
                Value<bool> manual = const Value.absent(),
              }) => ShoppingItemsCompanion.insert(
                id: id,
                menuId: menuId,
                ingredientId: ingredientId,
                label: label,
                quantity: quantity,
                unit: unit,
                bought: bought,
                atHome: atHome,
                manual: manual,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShoppingItemsTable, ShoppingItemRow>(table),
                  $$ShoppingItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({menuId = false, ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (menuId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.menuId,
                        referencedTable: $$ShoppingItemsTableReferences
                            ._menuIdTable(db),
                        referencedColumn: $$ShoppingItemsTableReferences
                            ._menuIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (ingredientId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ingredientId,
                        referencedTable: $$ShoppingItemsTableReferences
                            ._ingredientIdTable(db),
                        referencedColumn: $$ShoppingItemsTableReferences
                            ._ingredientIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ShoppingItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShoppingItemsTable,
      ShoppingItemRow,
      $$ShoppingItemsTableFilterComposer,
      $$ShoppingItemsTableOrderingComposer,
      $$ShoppingItemsTableAnnotationComposer,
      $$ShoppingItemsTableCreateCompanionBuilder,
      $$ShoppingItemsTableUpdateCompanionBuilder,
      (ShoppingItemRow, $$ShoppingItemsTableReferences),
      ShoppingItemRow,
      PrefetchHooks Function({bool menuId, bool ingredientId})
    >;
typedef $$AppMetaTableCreateCompanionBuilder = AppMetaCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$AppMetaTableUpdateCompanionBuilder = AppMetaCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$AppMetaTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetaTable,
          AppMetaRow,
          $$AppMetaTableFilterComposer,
          $$AppMetaTableOrderingComposer,
          $$AppMetaTableAnnotationComposer,
          $$AppMetaTableCreateCompanionBuilder,
          $$AppMetaTableUpdateCompanionBuilder,
          (
            AppMetaRow,
            BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>,
          ),
          AppMetaRow,
          PrefetchHooks Function()
        > {
  $$AppMetaTableTableManager(_$AppDatabase db, $AppMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => AppMetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => AppMetaCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppMetaTable, AppMetaRow>(table),
                  BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetaTable,
      AppMetaRow,
      $$AppMetaTableFilterComposer,
      $$AppMetaTableOrderingComposer,
      $$AppMetaTableAnnotationComposer,
      $$AppMetaTableCreateCompanionBuilder,
      $$AppMetaTableUpdateCompanionBuilder,
      (AppMetaRow, BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>),
      AppMetaRow,
      PrefetchHooks Function()
    >;
typedef $$CustomProductsTableCreateCompanionBuilder =
    CustomProductsCompanion Function({
      required String barcode,
      required String name,
      Value<String?> brand,
      Value<double?> packageQty,
      Value<String?> packageUnit,
      Value<double?> servingG,
      Value<String?> nutrition,
      Value<String> categories,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CustomProductsTableUpdateCompanionBuilder =
    CustomProductsCompanion Function({
      Value<String> barcode,
      Value<String> name,
      Value<String?> brand,
      Value<double?> packageQty,
      Value<String?> packageUnit,
      Value<double?> servingG,
      Value<String?> nutrition,
      Value<String> categories,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CustomProductsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomProductsTable> {
  $$CustomProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get packageQty => $composableBuilder(
    column: $table.packageQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packageUnit => $composableBuilder(
    column: $table.packageUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get servingG => $composableBuilder(
    column: $table.servingG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nutrition => $composableBuilder(
    column: $table.nutrition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categories => $composableBuilder(
    column: $table.categories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomProductsTable> {
  $$CustomProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get packageQty => $composableBuilder(
    column: $table.packageQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packageUnit => $composableBuilder(
    column: $table.packageUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get servingG => $composableBuilder(
    column: $table.servingG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nutrition => $composableBuilder(
    column: $table.nutrition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categories => $composableBuilder(
    column: $table.categories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomProductsTable> {
  $$CustomProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<double> get packageQty => $composableBuilder(
    column: $table.packageQty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get packageUnit => $composableBuilder(
    column: $table.packageUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get servingG =>
      $composableBuilder(column: $table.servingG, builder: (column) => column);

  GeneratedColumn<String> get nutrition =>
      $composableBuilder(column: $table.nutrition, builder: (column) => column);

  GeneratedColumn<String> get categories => $composableBuilder(
    column: $table.categories,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CustomProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomProductsTable,
          CustomProductRow,
          $$CustomProductsTableFilterComposer,
          $$CustomProductsTableOrderingComposer,
          $$CustomProductsTableAnnotationComposer,
          $$CustomProductsTableCreateCompanionBuilder,
          $$CustomProductsTableUpdateCompanionBuilder,
          (
            CustomProductRow,
            BaseReferences<
              _$AppDatabase,
              $CustomProductsTable,
              CustomProductRow
            >,
          ),
          CustomProductRow,
          PrefetchHooks Function()
        > {
  $$CustomProductsTableTableManager(
    _$AppDatabase db,
    $CustomProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> barcode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<double?> packageQty = const Value.absent(),
                Value<String?> packageUnit = const Value.absent(),
                Value<double?> servingG = const Value.absent(),
                Value<String?> nutrition = const Value.absent(),
                Value<String> categories = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomProductsCompanion(
                barcode: barcode,
                name: name,
                brand: brand,
                packageQty: packageQty,
                packageUnit: packageUnit,
                servingG: servingG,
                nutrition: nutrition,
                categories: categories,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String barcode,
                required String name,
                Value<String?> brand = const Value.absent(),
                Value<double?> packageQty = const Value.absent(),
                Value<String?> packageUnit = const Value.absent(),
                Value<double?> servingG = const Value.absent(),
                Value<String?> nutrition = const Value.absent(),
                Value<String> categories = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CustomProductsCompanion.insert(
                barcode: barcode,
                name: name,
                brand: brand,
                packageQty: packageQty,
                packageUnit: packageUnit,
                servingG: servingG,
                nutrition: nutrition,
                categories: categories,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CustomProductsTable, CustomProductRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CustomProductsTable,
                    CustomProductRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomProductsTable,
      CustomProductRow,
      $$CustomProductsTableFilterComposer,
      $$CustomProductsTableOrderingComposer,
      $$CustomProductsTableAnnotationComposer,
      $$CustomProductsTableCreateCompanionBuilder,
      $$CustomProductsTableUpdateCompanionBuilder,
      (
        CustomProductRow,
        BaseReferences<_$AppDatabase, $CustomProductsTable, CustomProductRow>,
      ),
      CustomProductRow,
      PrefetchHooks Function()
    >;
typedef $$ProductLinksTableCreateCompanionBuilder =
    ProductLinksCompanion Function({
      required String barcode,
      Value<String?> ingredientId,
      required DateTime linkedAt,
      Value<int> rowid,
    });
typedef $$ProductLinksTableUpdateCompanionBuilder =
    ProductLinksCompanion Function({
      Value<String> barcode,
      Value<String?> ingredientId,
      Value<DateTime> linkedAt,
      Value<int> rowid,
    });

final class $$ProductLinksTableReferences
    extends BaseReferences<_$AppDatabase, $ProductLinksTable, ProductLinkRow> {
  $$ProductLinksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) => db
      .ingredients
      .createAlias('product_links__ingredient_id__ingredients__id');

  $$IngredientsTableProcessedTableManager? get ingredientId {
    final $_column = $_itemColumn<String>('ingredient_id');
    if ($_column == null) return null;
    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductLinksTableFilterComposer
    extends Composer<_$AppDatabase, $ProductLinksTable> {
  $$ProductLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get linkedAt => $composableBuilder(
    column: $table.linkedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductLinksTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductLinksTable> {
  $$ProductLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get linkedAt => $composableBuilder(
    column: $table.linkedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductLinksTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductLinksTable> {
  $$ProductLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<DateTime> get linkedAt =>
      $composableBuilder(column: $table.linkedAt, builder: (column) => column);

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductLinksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductLinksTable,
          ProductLinkRow,
          $$ProductLinksTableFilterComposer,
          $$ProductLinksTableOrderingComposer,
          $$ProductLinksTableAnnotationComposer,
          $$ProductLinksTableCreateCompanionBuilder,
          $$ProductLinksTableUpdateCompanionBuilder,
          (ProductLinkRow, $$ProductLinksTableReferences),
          ProductLinkRow,
          PrefetchHooks Function({bool ingredientId})
        > {
  $$ProductLinksTableTableManager(_$AppDatabase db, $ProductLinksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductLinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> barcode = const Value.absent(),
                Value<String?> ingredientId = const Value.absent(),
                Value<DateTime> linkedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductLinksCompanion(
                barcode: barcode,
                ingredientId: ingredientId,
                linkedAt: linkedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String barcode,
                Value<String?> ingredientId = const Value.absent(),
                required DateTime linkedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProductLinksCompanion.insert(
                barcode: barcode,
                ingredientId: ingredientId,
                linkedAt: linkedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductLinksTable, ProductLinkRow>(table),
                  $$ProductLinksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ingredientId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ingredientId,
                        referencedTable: $$ProductLinksTableReferences
                            ._ingredientIdTable(db),
                        referencedColumn: $$ProductLinksTableReferences
                            ._ingredientIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProductLinksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductLinksTable,
      ProductLinkRow,
      $$ProductLinksTableFilterComposer,
      $$ProductLinksTableOrderingComposer,
      $$ProductLinksTableAnnotationComposer,
      $$ProductLinksTableCreateCompanionBuilder,
      $$ProductLinksTableUpdateCompanionBuilder,
      (ProductLinkRow, $$ProductLinksTableReferences),
      ProductLinkRow,
      PrefetchHooks Function({bool ingredientId})
    >;
typedef $$StockLotsTableCreateCompanionBuilder = StockLotsCompanion Function({
  Value<int> id,
  Value<String?> barcode,
  Value<String?> ingredientId,
  required String label,
  required double quantity,
  required String unit,
  required String location,
  required DateTime addedAt,
  Value<DateTime?> bestBefore,
});
typedef $$StockLotsTableUpdateCompanionBuilder = StockLotsCompanion Function({
  Value<int> id,
  Value<String?> barcode,
  Value<String?> ingredientId,
  Value<String> label,
  Value<double> quantity,
  Value<String> unit,
  Value<String> location,
  Value<DateTime> addedAt,
  Value<DateTime?> bestBefore,
});

final class $$StockLotsTableReferences
    extends BaseReferences<_$AppDatabase, $StockLotsTable, StockLotRow> {
  $$StockLotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) =>
      db.ingredients.createAlias('stock_lots__ingredient_id__ingredients__id');

  $$IngredientsTableProcessedTableManager? get ingredientId {
    final $_column = $_itemColumn<String>('ingredient_id');
    if ($_column == null) return null;
    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StockLotsTableFilterComposer
    extends Composer<_$AppDatabase, $StockLotsTable> {
  $$StockLotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bestBefore => $composableBuilder(
    column: $table.bestBefore,
    builder: (column) => ColumnFilters(column),
  );

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockLotsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockLotsTable> {
  $$StockLotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bestBefore => $composableBuilder(
    column: $table.bestBefore,
    builder: (column) => ColumnOrderings(column),
  );

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockLotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockLotsTable> {
  $$StockLotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get bestBefore => $composableBuilder(
    column: $table.bestBefore,
    builder: (column) => column,
  );

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockLotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockLotsTable,
          StockLotRow,
          $$StockLotsTableFilterComposer,
          $$StockLotsTableOrderingComposer,
          $$StockLotsTableAnnotationComposer,
          $$StockLotsTableCreateCompanionBuilder,
          $$StockLotsTableUpdateCompanionBuilder,
          (StockLotRow, $$StockLotsTableReferences),
          StockLotRow,
          PrefetchHooks Function({bool ingredientId})
        > {
  $$StockLotsTableTableManager(_$AppDatabase db, $StockLotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockLotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockLotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockLotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String?> ingredientId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
                Value<DateTime?> bestBefore = const Value.absent(),
              }) => StockLotsCompanion(
                id: id,
                barcode: barcode,
                ingredientId: ingredientId,
                label: label,
                quantity: quantity,
                unit: unit,
                location: location,
                addedAt: addedAt,
                bestBefore: bestBefore,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String?> ingredientId = const Value.absent(),
                required String label,
                required double quantity,
                required String unit,
                required String location,
                required DateTime addedAt,
                Value<DateTime?> bestBefore = const Value.absent(),
              }) => StockLotsCompanion.insert(
                id: id,
                barcode: barcode,
                ingredientId: ingredientId,
                label: label,
                quantity: quantity,
                unit: unit,
                location: location,
                addedAt: addedAt,
                bestBefore: bestBefore,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StockLotsTable, StockLotRow>(table),
                  $$StockLotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ingredientId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ingredientId,
                        referencedTable: $$StockLotsTableReferences
                            ._ingredientIdTable(db),
                        referencedColumn: $$StockLotsTableReferences
                            ._ingredientIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StockLotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockLotsTable,
      StockLotRow,
      $$StockLotsTableFilterComposer,
      $$StockLotsTableOrderingComposer,
      $$StockLotsTableAnnotationComposer,
      $$StockLotsTableCreateCompanionBuilder,
      $$StockLotsTableUpdateCompanionBuilder,
      (StockLotRow, $$StockLotsTableReferences),
      StockLotRow,
      PrefetchHooks Function({bool ingredientId})
    >;
typedef $$StockMovementsTableCreateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<int> id,
      required int lotId,
      required double delta,
      required String kind,
      required DateTime at,
      Value<int?> completionId,
      Value<int?> logEntryId,
      Value<String?> label,
      Value<String?> barcode,
      Value<String?> ingredientId,
      Value<String?> unit,
      Value<String?> location,
    });
typedef $$StockMovementsTableUpdateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<int> id,
      Value<int> lotId,
      Value<double> delta,
      Value<String> kind,
      Value<DateTime> at,
      Value<int?> completionId,
      Value<int?> logEntryId,
      Value<String?> label,
      Value<String?> barcode,
      Value<String?> ingredientId,
      Value<String?> unit,
      Value<String?> location,
    });

class $$StockMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lotId => $composableBuilder(
    column: $table.lotId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get delta => $composableBuilder(
    column: $table.delta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completionId => $composableBuilder(
    column: $table.completionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get logEntryId => $composableBuilder(
    column: $table.logEntryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lotId => $composableBuilder(
    column: $table.lotId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get delta => $composableBuilder(
    column: $table.delta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completionId => $composableBuilder(
    column: $table.completionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get logEntryId => $composableBuilder(
    column: $table.logEntryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get lotId =>
      $composableBuilder(column: $table.lotId, builder: (column) => column);

  GeneratedColumn<double> get delta =>
      $composableBuilder(column: $table.delta, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<int> get completionId => $composableBuilder(
    column: $table.completionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get logEntryId => $composableBuilder(
    column: $table.logEntryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);
}

class $$StockMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockMovementsTable,
          StockMovementRow,
          $$StockMovementsTableFilterComposer,
          $$StockMovementsTableOrderingComposer,
          $$StockMovementsTableAnnotationComposer,
          $$StockMovementsTableCreateCompanionBuilder,
          $$StockMovementsTableUpdateCompanionBuilder,
          (
            StockMovementRow,
            BaseReferences<
              _$AppDatabase,
              $StockMovementsTable,
              StockMovementRow
            >,
          ),
          StockMovementRow,
          PrefetchHooks Function()
        > {
  $$StockMovementsTableTableManager(
    _$AppDatabase db,
    $StockMovementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockMovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> lotId = const Value.absent(),
                Value<double> delta = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<int?> completionId = const Value.absent(),
                Value<int?> logEntryId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String?> ingredientId = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<String?> location = const Value.absent(),
              }) => StockMovementsCompanion(
                id: id,
                lotId: lotId,
                delta: delta,
                kind: kind,
                at: at,
                completionId: completionId,
                logEntryId: logEntryId,
                label: label,
                barcode: barcode,
                ingredientId: ingredientId,
                unit: unit,
                location: location,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int lotId,
                required double delta,
                required String kind,
                required DateTime at,
                Value<int?> completionId = const Value.absent(),
                Value<int?> logEntryId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String?> ingredientId = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<String?> location = const Value.absent(),
              }) => StockMovementsCompanion.insert(
                id: id,
                lotId: lotId,
                delta: delta,
                kind: kind,
                at: at,
                completionId: completionId,
                logEntryId: logEntryId,
                label: label,
                barcode: barcode,
                ingredientId: ingredientId,
                unit: unit,
                location: location,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StockMovementsTable, StockMovementRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $StockMovementsTable,
                    StockMovementRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockMovementsTable,
      StockMovementRow,
      $$StockMovementsTableFilterComposer,
      $$StockMovementsTableOrderingComposer,
      $$StockMovementsTableAnnotationComposer,
      $$StockMovementsTableCreateCompanionBuilder,
      $$StockMovementsTableUpdateCompanionBuilder,
      (
        StockMovementRow,
        BaseReferences<_$AppDatabase, $StockMovementsTable, StockMovementRow>,
      ),
      StockMovementRow,
      PrefetchHooks Function()
    >;
typedef $$MealCompletionsTableCreateCompanionBuilder =
    MealCompletionsCompanion Function({
      Value<int> id,
      required int menuId,
      Value<String?> slot,
      Value<int?> extraId,
      required int recipeId,
      required int cookedServings,
      Value<double> portionsEaten,
      Value<String> excluded,
      Value<String> replacements,
      required DateTime at,
    });
typedef $$MealCompletionsTableUpdateCompanionBuilder =
    MealCompletionsCompanion Function({
      Value<int> id,
      Value<int> menuId,
      Value<String?> slot,
      Value<int?> extraId,
      Value<int> recipeId,
      Value<int> cookedServings,
      Value<double> portionsEaten,
      Value<String> excluded,
      Value<String> replacements,
      Value<DateTime> at,
    });

final class $$MealCompletionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MealCompletionsTable,
          MealCompletionRow
        > {
  $$MealCompletionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WeekMenusTable _menuIdTable(_$AppDatabase db) =>
      db.weekMenus.createAlias('meal_completions__menu_id__week_menus__id');

  $$WeekMenusTableProcessedTableManager get menuId {
    final $_column = $_itemColumn<int>('menu_id')!;

    final manager = $$WeekMenusTableTableManager(
      $_db,
      $_db.weekMenus,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_menuIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MealCompletionsTableFilterComposer
    extends Composer<_$AppDatabase, $MealCompletionsTable> {
  $$MealCompletionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get extraId => $composableBuilder(
    column: $table.extraId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recipeId => $composableBuilder(
    column: $table.recipeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cookedServings => $composableBuilder(
    column: $table.cookedServings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get portionsEaten => $composableBuilder(
    column: $table.portionsEaten,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get excluded => $composableBuilder(
    column: $table.excluded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replacements => $composableBuilder(
    column: $table.replacements,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  $$WeekMenusTableFilterComposer get menuId {
    final $$WeekMenusTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.weekMenus,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekMenusTableFilterComposer(
            $db: $db,
            $table: $db.weekMenus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealCompletionsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealCompletionsTable> {
  $$MealCompletionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get extraId => $composableBuilder(
    column: $table.extraId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recipeId => $composableBuilder(
    column: $table.recipeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cookedServings => $composableBuilder(
    column: $table.cookedServings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get portionsEaten => $composableBuilder(
    column: $table.portionsEaten,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get excluded => $composableBuilder(
    column: $table.excluded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replacements => $composableBuilder(
    column: $table.replacements,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeekMenusTableOrderingComposer get menuId {
    final $$WeekMenusTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.weekMenus,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekMenusTableOrderingComposer(
            $db: $db,
            $table: $db.weekMenus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealCompletionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealCompletionsTable> {
  $$MealCompletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<int> get extraId =>
      $composableBuilder(column: $table.extraId, builder: (column) => column);

  GeneratedColumn<int> get recipeId =>
      $composableBuilder(column: $table.recipeId, builder: (column) => column);

  GeneratedColumn<int> get cookedServings => $composableBuilder(
    column: $table.cookedServings,
    builder: (column) => column,
  );

  GeneratedColumn<double> get portionsEaten => $composableBuilder(
    column: $table.portionsEaten,
    builder: (column) => column,
  );

  GeneratedColumn<String> get excluded =>
      $composableBuilder(column: $table.excluded, builder: (column) => column);

  GeneratedColumn<String> get replacements => $composableBuilder(
    column: $table.replacements,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  $$WeekMenusTableAnnotationComposer get menuId {
    final $$WeekMenusTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.weekMenus,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeekMenusTableAnnotationComposer(
            $db: $db,
            $table: $db.weekMenus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealCompletionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealCompletionsTable,
          MealCompletionRow,
          $$MealCompletionsTableFilterComposer,
          $$MealCompletionsTableOrderingComposer,
          $$MealCompletionsTableAnnotationComposer,
          $$MealCompletionsTableCreateCompanionBuilder,
          $$MealCompletionsTableUpdateCompanionBuilder,
          (MealCompletionRow, $$MealCompletionsTableReferences),
          MealCompletionRow,
          PrefetchHooks Function({bool menuId})
        > {
  $$MealCompletionsTableTableManager(
    _$AppDatabase db,
    $MealCompletionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealCompletionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealCompletionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealCompletionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> menuId = const Value.absent(),
                Value<String?> slot = const Value.absent(),
                Value<int?> extraId = const Value.absent(),
                Value<int> recipeId = const Value.absent(),
                Value<int> cookedServings = const Value.absent(),
                Value<double> portionsEaten = const Value.absent(),
                Value<String> excluded = const Value.absent(),
                Value<String> replacements = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
              }) => MealCompletionsCompanion(
                id: id,
                menuId: menuId,
                slot: slot,
                extraId: extraId,
                recipeId: recipeId,
                cookedServings: cookedServings,
                portionsEaten: portionsEaten,
                excluded: excluded,
                replacements: replacements,
                at: at,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int menuId,
                Value<String?> slot = const Value.absent(),
                Value<int?> extraId = const Value.absent(),
                required int recipeId,
                required int cookedServings,
                Value<double> portionsEaten = const Value.absent(),
                Value<String> excluded = const Value.absent(),
                Value<String> replacements = const Value.absent(),
                required DateTime at,
              }) => MealCompletionsCompanion.insert(
                id: id,
                menuId: menuId,
                slot: slot,
                extraId: extraId,
                recipeId: recipeId,
                cookedServings: cookedServings,
                portionsEaten: portionsEaten,
                excluded: excluded,
                replacements: replacements,
                at: at,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MealCompletionsTable, MealCompletionRow>(table),
                  $$MealCompletionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({menuId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (menuId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.menuId,
                        referencedTable: $$MealCompletionsTableReferences
                            ._menuIdTable(db),
                        referencedColumn: $$MealCompletionsTableReferences
                            ._menuIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MealCompletionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealCompletionsTable,
      MealCompletionRow,
      $$MealCompletionsTableFilterComposer,
      $$MealCompletionsTableOrderingComposer,
      $$MealCompletionsTableAnnotationComposer,
      $$MealCompletionsTableCreateCompanionBuilder,
      $$MealCompletionsTableUpdateCompanionBuilder,
      (MealCompletionRow, $$MealCompletionsTableReferences),
      MealCompletionRow,
      PrefetchHooks Function({bool menuId})
    >;
typedef $$FoodLogEntriesTableCreateCompanionBuilder =
    FoodLogEntriesCompanion Function({
      Value<int> id,
      required DateTime date,
      required String moment,
      required String label,
      required String source,
      Value<String?> ref,
      Value<double?> grams,
      required double kcal,
      Value<double> protein,
      Value<double> carbs,
      Value<double> fat,
      Value<int?> completionId,
    });
typedef $$FoodLogEntriesTableUpdateCompanionBuilder =
    FoodLogEntriesCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> moment,
      Value<String> label,
      Value<String> source,
      Value<String?> ref,
      Value<double?> grams,
      Value<double> kcal,
      Value<double> protein,
      Value<double> carbs,
      Value<double> fat,
      Value<int?> completionId,
    });

class $$FoodLogEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FoodLogEntriesTable> {
  $$FoodLogEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moment => $composableBuilder(
    column: $table.moment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ref => $composableBuilder(
    column: $table.ref,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcal => $composableBuilder(
    column: $table.kcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completionId => $composableBuilder(
    column: $table.completionId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodLogEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodLogEntriesTable> {
  $$FoodLogEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moment => $composableBuilder(
    column: $table.moment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ref => $composableBuilder(
    column: $table.ref,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcal => $composableBuilder(
    column: $table.kcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completionId => $composableBuilder(
    column: $table.completionId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodLogEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodLogEntriesTable> {
  $$FoodLogEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get moment =>
      $composableBuilder(column: $table.moment, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get ref =>
      $composableBuilder(column: $table.ref, builder: (column) => column);

  GeneratedColumn<double> get grams =>
      $composableBuilder(column: $table.grams, builder: (column) => column);

  GeneratedColumn<double> get kcal =>
      $composableBuilder(column: $table.kcal, builder: (column) => column);

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get carbs =>
      $composableBuilder(column: $table.carbs, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<int> get completionId => $composableBuilder(
    column: $table.completionId,
    builder: (column) => column,
  );
}

class $$FoodLogEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodLogEntriesTable,
          FoodLogEntryRow,
          $$FoodLogEntriesTableFilterComposer,
          $$FoodLogEntriesTableOrderingComposer,
          $$FoodLogEntriesTableAnnotationComposer,
          $$FoodLogEntriesTableCreateCompanionBuilder,
          $$FoodLogEntriesTableUpdateCompanionBuilder,
          (
            FoodLogEntryRow,
            BaseReferences<
              _$AppDatabase,
              $FoodLogEntriesTable,
              FoodLogEntryRow
            >,
          ),
          FoodLogEntryRow,
          PrefetchHooks Function()
        > {
  $$FoodLogEntriesTableTableManager(
    _$AppDatabase db,
    $FoodLogEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodLogEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodLogEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodLogEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> moment = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> ref = const Value.absent(),
                Value<double?> grams = const Value.absent(),
                Value<double> kcal = const Value.absent(),
                Value<double> protein = const Value.absent(),
                Value<double> carbs = const Value.absent(),
                Value<double> fat = const Value.absent(),
                Value<int?> completionId = const Value.absent(),
              }) => FoodLogEntriesCompanion(
                id: id,
                date: date,
                moment: moment,
                label: label,
                source: source,
                ref: ref,
                grams: grams,
                kcal: kcal,
                protein: protein,
                carbs: carbs,
                fat: fat,
                completionId: completionId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String moment,
                required String label,
                required String source,
                Value<String?> ref = const Value.absent(),
                Value<double?> grams = const Value.absent(),
                required double kcal,
                Value<double> protein = const Value.absent(),
                Value<double> carbs = const Value.absent(),
                Value<double> fat = const Value.absent(),
                Value<int?> completionId = const Value.absent(),
              }) => FoodLogEntriesCompanion.insert(
                id: id,
                date: date,
                moment: moment,
                label: label,
                source: source,
                ref: ref,
                grams: grams,
                kcal: kcal,
                protein: protein,
                carbs: carbs,
                fat: fat,
                completionId: completionId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FoodLogEntriesTable, FoodLogEntryRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $FoodLogEntriesTable,
                    FoodLogEntryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodLogEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodLogEntriesTable,
      FoodLogEntryRow,
      $$FoodLogEntriesTableFilterComposer,
      $$FoodLogEntriesTableOrderingComposer,
      $$FoodLogEntriesTableAnnotationComposer,
      $$FoodLogEntriesTableCreateCompanionBuilder,
      $$FoodLogEntriesTableUpdateCompanionBuilder,
      (
        FoodLogEntryRow,
        BaseReferences<_$AppDatabase, $FoodLogEntriesTable, FoodLogEntryRow>,
      ),
      FoodLogEntryRow,
      PrefetchHooks Function()
    >;
typedef $$MealPresetsTableCreateCompanionBuilder =
    MealPresetsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> defaultMoment,
      Value<int?> recipeId,
      Value<double?> recipePortions,
      required DateTime createdAt,
    });
typedef $$MealPresetsTableUpdateCompanionBuilder =
    MealPresetsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> defaultMoment,
      Value<int?> recipeId,
      Value<double?> recipePortions,
      Value<DateTime> createdAt,
    });

final class $$MealPresetsTableReferences
    extends BaseReferences<_$AppDatabase, $MealPresetsTable, MealPresetRow> {
  $$MealPresetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MealPresetItemsTable, List<MealPresetItemRow>>
  _mealPresetItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealPresetItems,
    aliasName: 'meal_presets__id__meal_preset_items__preset_id',
  );

  $$MealPresetItemsTableProcessedTableManager get mealPresetItemsRefs {
    final manager = $$MealPresetItemsTableTableManager(
      $_db,
      $_db.mealPresetItems,
    ).filter((f) => f.presetId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mealPresetItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MealPresetsTableFilterComposer
    extends Composer<_$AppDatabase, $MealPresetsTable> {
  $$MealPresetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultMoment => $composableBuilder(
    column: $table.defaultMoment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recipeId => $composableBuilder(
    column: $table.recipeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get recipePortions => $composableBuilder(
    column: $table.recipePortions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mealPresetItemsRefs(
    Expression<bool> Function($$MealPresetItemsTableFilterComposer f) f,
  ) {
    final $$MealPresetItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealPresetItems,
      getReferencedColumn: (t) => t.presetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPresetItemsTableFilterComposer(
            $db: $db,
            $table: $db.mealPresetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealPresetsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealPresetsTable> {
  $$MealPresetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultMoment => $composableBuilder(
    column: $table.defaultMoment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recipeId => $composableBuilder(
    column: $table.recipeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get recipePortions => $composableBuilder(
    column: $table.recipePortions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealPresetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealPresetsTable> {
  $$MealPresetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get defaultMoment => $composableBuilder(
    column: $table.defaultMoment,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recipeId =>
      $composableBuilder(column: $table.recipeId, builder: (column) => column);

  GeneratedColumn<double> get recipePortions => $composableBuilder(
    column: $table.recipePortions,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> mealPresetItemsRefs<T extends Object>(
    Expression<T> Function($$MealPresetItemsTableAnnotationComposer a) f,
  ) {
    final $$MealPresetItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealPresetItems,
      getReferencedColumn: (t) => t.presetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPresetItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.mealPresetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealPresetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealPresetsTable,
          MealPresetRow,
          $$MealPresetsTableFilterComposer,
          $$MealPresetsTableOrderingComposer,
          $$MealPresetsTableAnnotationComposer,
          $$MealPresetsTableCreateCompanionBuilder,
          $$MealPresetsTableUpdateCompanionBuilder,
          (MealPresetRow, $$MealPresetsTableReferences),
          MealPresetRow,
          PrefetchHooks Function({bool mealPresetItemsRefs})
        > {
  $$MealPresetsTableTableManager(_$AppDatabase db, $MealPresetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealPresetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealPresetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealPresetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> defaultMoment = const Value.absent(),
                Value<int?> recipeId = const Value.absent(),
                Value<double?> recipePortions = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MealPresetsCompanion(
                id: id,
                name: name,
                defaultMoment: defaultMoment,
                recipeId: recipeId,
                recipePortions: recipePortions,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> defaultMoment = const Value.absent(),
                Value<int?> recipeId = const Value.absent(),
                Value<double?> recipePortions = const Value.absent(),
                required DateTime createdAt,
              }) => MealPresetsCompanion.insert(
                id: id,
                name: name,
                defaultMoment: defaultMoment,
                recipeId: recipeId,
                recipePortions: recipePortions,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MealPresetsTable, MealPresetRow>(table),
                  $$MealPresetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mealPresetItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (mealPresetItemsRefs) db.mealPresetItems,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mealPresetItemsRefs)
                    await $_getPrefetchedDataByColumns<
                      MealPresetRow,
                      $MealPresetsTable,
                      MealPresetItemRow,
                      $MealPresetItemsTable
                    >(
                      currentTable: table,
                      referencedTable: $$MealPresetsTableReferences
                          ._mealPresetItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MealPresetsTableReferences(
                            db,
                            table,
                            p0,
                          ).mealPresetItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'preset_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MealPresetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealPresetsTable,
      MealPresetRow,
      $$MealPresetsTableFilterComposer,
      $$MealPresetsTableOrderingComposer,
      $$MealPresetsTableAnnotationComposer,
      $$MealPresetsTableCreateCompanionBuilder,
      $$MealPresetsTableUpdateCompanionBuilder,
      (MealPresetRow, $$MealPresetsTableReferences),
      MealPresetRow,
      PrefetchHooks Function({bool mealPresetItemsRefs})
    >;
typedef $$MealPresetItemsTableCreateCompanionBuilder =
    MealPresetItemsCompanion Function({
      Value<int> id,
      required int presetId,
      required String label,
      required double grams,
      required String nutrition,
      Value<String?> ingredientId,
      Value<String?> barcode,
      required int position,
    });
typedef $$MealPresetItemsTableUpdateCompanionBuilder =
    MealPresetItemsCompanion Function({
      Value<int> id,
      Value<int> presetId,
      Value<String> label,
      Value<double> grams,
      Value<String> nutrition,
      Value<String?> ingredientId,
      Value<String?> barcode,
      Value<int> position,
    });

final class $$MealPresetItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MealPresetItemsTable,
          MealPresetItemRow
        > {
  $$MealPresetItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MealPresetsTable _presetIdTable(_$AppDatabase db) => db.mealPresets
      .createAlias('meal_preset_items__preset_id__meal_presets__id');

  $$MealPresetsTableProcessedTableManager get presetId {
    final $_column = $_itemColumn<int>('preset_id')!;

    final manager = $$MealPresetsTableTableManager(
      $_db,
      $_db.mealPresets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_presetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MealPresetItemsTableFilterComposer
    extends Composer<_$AppDatabase, $MealPresetItemsTable> {
  $$MealPresetItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nutrition => $composableBuilder(
    column: $table.nutrition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$MealPresetsTableFilterComposer get presetId {
    final $$MealPresetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.presetId,
      referencedTable: $db.mealPresets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPresetsTableFilterComposer(
            $db: $db,
            $table: $db.mealPresets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealPresetItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealPresetItemsTable> {
  $$MealPresetItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nutrition => $composableBuilder(
    column: $table.nutrition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$MealPresetsTableOrderingComposer get presetId {
    final $$MealPresetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.presetId,
      referencedTable: $db.mealPresets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPresetsTableOrderingComposer(
            $db: $db,
            $table: $db.mealPresets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealPresetItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealPresetItemsTable> {
  $$MealPresetItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<double> get grams =>
      $composableBuilder(column: $table.grams, builder: (column) => column);

  GeneratedColumn<String> get nutrition =>
      $composableBuilder(column: $table.nutrition, builder: (column) => column);

  GeneratedColumn<String> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$MealPresetsTableAnnotationComposer get presetId {
    final $$MealPresetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.presetId,
      referencedTable: $db.mealPresets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPresetsTableAnnotationComposer(
            $db: $db,
            $table: $db.mealPresets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealPresetItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealPresetItemsTable,
          MealPresetItemRow,
          $$MealPresetItemsTableFilterComposer,
          $$MealPresetItemsTableOrderingComposer,
          $$MealPresetItemsTableAnnotationComposer,
          $$MealPresetItemsTableCreateCompanionBuilder,
          $$MealPresetItemsTableUpdateCompanionBuilder,
          (MealPresetItemRow, $$MealPresetItemsTableReferences),
          MealPresetItemRow,
          PrefetchHooks Function({bool presetId})
        > {
  $$MealPresetItemsTableTableManager(
    _$AppDatabase db,
    $MealPresetItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealPresetItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealPresetItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealPresetItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> presetId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<double> grams = const Value.absent(),
                Value<String> nutrition = const Value.absent(),
                Value<String?> ingredientId = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<int> position = const Value.absent(),
              }) => MealPresetItemsCompanion(
                id: id,
                presetId: presetId,
                label: label,
                grams: grams,
                nutrition: nutrition,
                ingredientId: ingredientId,
                barcode: barcode,
                position: position,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int presetId,
                required String label,
                required double grams,
                required String nutrition,
                Value<String?> ingredientId = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                required int position,
              }) => MealPresetItemsCompanion.insert(
                id: id,
                presetId: presetId,
                label: label,
                grams: grams,
                nutrition: nutrition,
                ingredientId: ingredientId,
                barcode: barcode,
                position: position,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MealPresetItemsTable, MealPresetItemRow>(table),
                  $$MealPresetItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({presetId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (presetId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.presetId,
                        referencedTable: $$MealPresetItemsTableReferences
                            ._presetIdTable(db),
                        referencedColumn: $$MealPresetItemsTableReferences
                            ._presetIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MealPresetItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealPresetItemsTable,
      MealPresetItemRow,
      $$MealPresetItemsTableFilterComposer,
      $$MealPresetItemsTableOrderingComposer,
      $$MealPresetItemsTableAnnotationComposer,
      $$MealPresetItemsTableCreateCompanionBuilder,
      $$MealPresetItemsTableUpdateCompanionBuilder,
      (MealPresetItemRow, $$MealPresetItemsTableReferences),
      MealPresetItemRow,
      PrefetchHooks Function({bool presetId})
    >;
typedef $$NutritionProfilesTableCreateCompanionBuilder =
    NutritionProfilesCompanion Function({
      Value<int> id,
      required String sex,
      required DateTime birthDate,
      required double heightCm,
      required String activity,
    });
typedef $$NutritionProfilesTableUpdateCompanionBuilder =
    NutritionProfilesCompanion Function({
      Value<int> id,
      Value<String> sex,
      Value<DateTime> birthDate,
      Value<double> heightCm,
      Value<String> activity,
    });

class $$NutritionProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $NutritionProfilesTable> {
  $$NutritionProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NutritionProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $NutritionProfilesTable> {
  $$NutritionProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NutritionProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutritionProfilesTable> {
  $$NutritionProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<String> get activity =>
      $composableBuilder(column: $table.activity, builder: (column) => column);
}

class $$NutritionProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NutritionProfilesTable,
          NutritionProfileRow,
          $$NutritionProfilesTableFilterComposer,
          $$NutritionProfilesTableOrderingComposer,
          $$NutritionProfilesTableAnnotationComposer,
          $$NutritionProfilesTableCreateCompanionBuilder,
          $$NutritionProfilesTableUpdateCompanionBuilder,
          (
            NutritionProfileRow,
            BaseReferences<
              _$AppDatabase,
              $NutritionProfilesTable,
              NutritionProfileRow
            >,
          ),
          NutritionProfileRow,
          PrefetchHooks Function()
        > {
  $$NutritionProfilesTableTableManager(
    _$AppDatabase db,
    $NutritionProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutritionProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NutritionProfilesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<DateTime> birthDate = const Value.absent(),
                Value<double> heightCm = const Value.absent(),
                Value<String> activity = const Value.absent(),
              }) => NutritionProfilesCompanion(
                id: id,
                sex: sex,
                birthDate: birthDate,
                heightCm: heightCm,
                activity: activity,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sex,
                required DateTime birthDate,
                required double heightCm,
                required String activity,
              }) => NutritionProfilesCompanion.insert(
                id: id,
                sex: sex,
                birthDate: birthDate,
                heightCm: heightCm,
                activity: activity,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NutritionProfilesTable, NutritionProfileRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $NutritionProfilesTable,
                    NutritionProfileRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NutritionProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NutritionProfilesTable,
      NutritionProfileRow,
      $$NutritionProfilesTableFilterComposer,
      $$NutritionProfilesTableOrderingComposer,
      $$NutritionProfilesTableAnnotationComposer,
      $$NutritionProfilesTableCreateCompanionBuilder,
      $$NutritionProfilesTableUpdateCompanionBuilder,
      (
        NutritionProfileRow,
        BaseReferences<
          _$AppDatabase,
          $NutritionProfilesTable,
          NutritionProfileRow
        >,
      ),
      NutritionProfileRow,
      PrefetchHooks Function()
    >;
typedef $$NutritionGoalsTableCreateCompanionBuilder =
    NutritionGoalsCompanion Function({
      Value<int> id,
      required DateTime startDate,
      required String kind,
      required double dailyKcalDelta,
      Value<double?> targetWeightKg,
    });
typedef $$NutritionGoalsTableUpdateCompanionBuilder =
    NutritionGoalsCompanion Function({
      Value<int> id,
      Value<DateTime> startDate,
      Value<String> kind,
      Value<double> dailyKcalDelta,
      Value<double?> targetWeightKg,
    });

class $$NutritionGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $NutritionGoalsTable> {
  $$NutritionGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dailyKcalDelta => $composableBuilder(
    column: $table.dailyKcalDelta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetWeightKg => $composableBuilder(
    column: $table.targetWeightKg,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NutritionGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $NutritionGoalsTable> {
  $$NutritionGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dailyKcalDelta => $composableBuilder(
    column: $table.dailyKcalDelta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetWeightKg => $composableBuilder(
    column: $table.targetWeightKg,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NutritionGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutritionGoalsTable> {
  $$NutritionGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get dailyKcalDelta => $composableBuilder(
    column: $table.dailyKcalDelta,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetWeightKg => $composableBuilder(
    column: $table.targetWeightKg,
    builder: (column) => column,
  );
}

class $$NutritionGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NutritionGoalsTable,
          NutritionGoalRow,
          $$NutritionGoalsTableFilterComposer,
          $$NutritionGoalsTableOrderingComposer,
          $$NutritionGoalsTableAnnotationComposer,
          $$NutritionGoalsTableCreateCompanionBuilder,
          $$NutritionGoalsTableUpdateCompanionBuilder,
          (
            NutritionGoalRow,
            BaseReferences<
              _$AppDatabase,
              $NutritionGoalsTable,
              NutritionGoalRow
            >,
          ),
          NutritionGoalRow,
          PrefetchHooks Function()
        > {
  $$NutritionGoalsTableTableManager(
    _$AppDatabase db,
    $NutritionGoalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutritionGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NutritionGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<double> dailyKcalDelta = const Value.absent(),
                Value<double?> targetWeightKg = const Value.absent(),
              }) => NutritionGoalsCompanion(
                id: id,
                startDate: startDate,
                kind: kind,
                dailyKcalDelta: dailyKcalDelta,
                targetWeightKg: targetWeightKg,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime startDate,
                required String kind,
                required double dailyKcalDelta,
                Value<double?> targetWeightKg = const Value.absent(),
              }) => NutritionGoalsCompanion.insert(
                id: id,
                startDate: startDate,
                kind: kind,
                dailyKcalDelta: dailyKcalDelta,
                targetWeightKg: targetWeightKg,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NutritionGoalsTable, NutritionGoalRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $NutritionGoalsTable,
                    NutritionGoalRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NutritionGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NutritionGoalsTable,
      NutritionGoalRow,
      $$NutritionGoalsTableFilterComposer,
      $$NutritionGoalsTableOrderingComposer,
      $$NutritionGoalsTableAnnotationComposer,
      $$NutritionGoalsTableCreateCompanionBuilder,
      $$NutritionGoalsTableUpdateCompanionBuilder,
      (
        NutritionGoalRow,
        BaseReferences<_$AppDatabase, $NutritionGoalsTable, NutritionGoalRow>,
      ),
      NutritionGoalRow,
      PrefetchHooks Function()
    >;
typedef $$BodyWeightsTableCreateCompanionBuilder =
    BodyWeightsCompanion Function({
      Value<int> id,
      required DateTime date,
      required double weightKg,
      Value<double?> bodyFatPct,
    });
typedef $$BodyWeightsTableUpdateCompanionBuilder =
    BodyWeightsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<double> weightKg,
      Value<double?> bodyFatPct,
    });

class $$BodyWeightsTableFilterComposer
    extends Composer<_$AppDatabase, $BodyWeightsTable> {
  $$BodyWeightsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bodyFatPct => $composableBuilder(
    column: $table.bodyFatPct,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BodyWeightsTableOrderingComposer
    extends Composer<_$AppDatabase, $BodyWeightsTable> {
  $$BodyWeightsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bodyFatPct => $composableBuilder(
    column: $table.bodyFatPct,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BodyWeightsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BodyWeightsTable> {
  $$BodyWeightsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get bodyFatPct => $composableBuilder(
    column: $table.bodyFatPct,
    builder: (column) => column,
  );
}

class $$BodyWeightsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BodyWeightsTable,
          BodyWeightRow,
          $$BodyWeightsTableFilterComposer,
          $$BodyWeightsTableOrderingComposer,
          $$BodyWeightsTableAnnotationComposer,
          $$BodyWeightsTableCreateCompanionBuilder,
          $$BodyWeightsTableUpdateCompanionBuilder,
          (
            BodyWeightRow,
            BaseReferences<_$AppDatabase, $BodyWeightsTable, BodyWeightRow>,
          ),
          BodyWeightRow,
          PrefetchHooks Function()
        > {
  $$BodyWeightsTableTableManager(_$AppDatabase db, $BodyWeightsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BodyWeightsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BodyWeightsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BodyWeightsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<double?> bodyFatPct = const Value.absent(),
              }) => BodyWeightsCompanion(
                id: id,
                date: date,
                weightKg: weightKg,
                bodyFatPct: bodyFatPct,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required double weightKg,
                Value<double?> bodyFatPct = const Value.absent(),
              }) => BodyWeightsCompanion.insert(
                id: id,
                date: date,
                weightKg: weightKg,
                bodyFatPct: bodyFatPct,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BodyWeightsTable, BodyWeightRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BodyWeightsTable,
                    BodyWeightRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BodyWeightsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BodyWeightsTable,
      BodyWeightRow,
      $$BodyWeightsTableFilterComposer,
      $$BodyWeightsTableOrderingComposer,
      $$BodyWeightsTableAnnotationComposer,
      $$BodyWeightsTableCreateCompanionBuilder,
      $$BodyWeightsTableUpdateCompanionBuilder,
      (
        BodyWeightRow,
        BaseReferences<_$AppDatabase, $BodyWeightsTable, BodyWeightRow>,
      ),
      BodyWeightRow,
      PrefetchHooks Function()
    >;
typedef $$DailyStepsTableCreateCompanionBuilder = DailyStepsCompanion Function({
  required DateTime date,
  required int steps,
  Value<int> rowid,
});
typedef $$DailyStepsTableUpdateCompanionBuilder = DailyStepsCompanion Function({
  Value<DateTime> date,
  Value<int> steps,
  Value<int> rowid,
});

class $$DailyStepsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyStepsTable> {
  $$DailyStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyStepsTable> {
  $$DailyStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyStepsTable> {
  $$DailyStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);
}

class $$DailyStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyStepsTable,
          DailyStepsRow,
          $$DailyStepsTableFilterComposer,
          $$DailyStepsTableOrderingComposer,
          $$DailyStepsTableAnnotationComposer,
          $$DailyStepsTableCreateCompanionBuilder,
          $$DailyStepsTableUpdateCompanionBuilder,
          (
            DailyStepsRow,
            BaseReferences<_$AppDatabase, $DailyStepsTable, DailyStepsRow>,
          ),
          DailyStepsRow,
          PrefetchHooks Function()
        > {
  $$DailyStepsTableTableManager(_$AppDatabase db, $DailyStepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> date = const Value.absent(),
            Value<int> steps = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => DailyStepsCompanion(date: date, steps: steps, rowid: rowid),
          createCompanionCallback:
              ({
                required DateTime date,
                required int steps,
                Value<int> rowid = const Value.absent(),
              }) => DailyStepsCompanion.insert(
                date: date,
                steps: steps,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyStepsTable, DailyStepsRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DailyStepsTable,
                    DailyStepsRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyStepsTable,
      DailyStepsRow,
      $$DailyStepsTableFilterComposer,
      $$DailyStepsTableOrderingComposer,
      $$DailyStepsTableAnnotationComposer,
      $$DailyStepsTableCreateCompanionBuilder,
      $$DailyStepsTableUpdateCompanionBuilder,
      (
        DailyStepsRow,
        BaseReferences<_$AppDatabase, $DailyStepsTable, DailyStepsRow>,
      ),
      DailyStepsRow,
      PrefetchHooks Function()
    >;
typedef $$WorkoutsTableCreateCompanionBuilder = WorkoutsCompanion Function({
  Value<int> id,
  required DateTime date,
  required String exerciseName,
  required double met,
  required double durationMin,
  Value<String> intensity,
  Value<double?> kcalOverride,
  Value<String?> note,
});
typedef $$WorkoutsTableUpdateCompanionBuilder = WorkoutsCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<String> exerciseName,
  Value<double> met,
  Value<double> durationMin,
  Value<String> intensity,
  Value<double?> kcalOverride,
  Value<String?> note,
});

class $$WorkoutsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get met => $composableBuilder(
    column: $table.met,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcalOverride => $composableBuilder(
    column: $table.kcalOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get met => $composableBuilder(
    column: $table.met,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalOverride => $composableBuilder(
    column: $table.kcalOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get met =>
      $composableBuilder(column: $table.met, builder: (column) => column);

  GeneratedColumn<double> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumn<double> get kcalOverride => $composableBuilder(
    column: $table.kcalOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$WorkoutsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutsTable,
          WorkoutRow,
          $$WorkoutsTableFilterComposer,
          $$WorkoutsTableOrderingComposer,
          $$WorkoutsTableAnnotationComposer,
          $$WorkoutsTableCreateCompanionBuilder,
          $$WorkoutsTableUpdateCompanionBuilder,
          (
            WorkoutRow,
            BaseReferences<_$AppDatabase, $WorkoutsTable, WorkoutRow>,
          ),
          WorkoutRow,
          PrefetchHooks Function()
        > {
  $$WorkoutsTableTableManager(_$AppDatabase db, $WorkoutsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> exerciseName = const Value.absent(),
                Value<double> met = const Value.absent(),
                Value<double> durationMin = const Value.absent(),
                Value<String> intensity = const Value.absent(),
                Value<double?> kcalOverride = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => WorkoutsCompanion(
                id: id,
                date: date,
                exerciseName: exerciseName,
                met: met,
                durationMin: durationMin,
                intensity: intensity,
                kcalOverride: kcalOverride,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String exerciseName,
                required double met,
                required double durationMin,
                Value<String> intensity = const Value.absent(),
                Value<double?> kcalOverride = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => WorkoutsCompanion.insert(
                id: id,
                date: date,
                exerciseName: exerciseName,
                met: met,
                durationMin: durationMin,
                intensity: intensity,
                kcalOverride: kcalOverride,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkoutsTable, WorkoutRow>(table),
                  BaseReferences<_$AppDatabase, $WorkoutsTable, WorkoutRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutsTable,
      WorkoutRow,
      $$WorkoutsTableFilterComposer,
      $$WorkoutsTableOrderingComposer,
      $$WorkoutsTableAnnotationComposer,
      $$WorkoutsTableCreateCompanionBuilder,
      $$WorkoutsTableUpdateCompanionBuilder,
      (WorkoutRow, BaseReferences<_$AppDatabase, $WorkoutsTable, WorkoutRow>),
      WorkoutRow,
      PrefetchHooks Function()
    >;
typedef $$StrengthSessionsTableCreateCompanionBuilder =
    StrengthSessionsCompanion Function({
      Value<int> id,
      required DateTime date,
      Value<String?> name,
      Value<double?> durationMin,
      Value<double?> kcalOverride,
      Value<String?> note,
    });
typedef $$StrengthSessionsTableUpdateCompanionBuilder =
    StrengthSessionsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String?> name,
      Value<double?> durationMin,
      Value<double?> kcalOverride,
      Value<String?> note,
    });

final class $$StrengthSessionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $StrengthSessionsTable,
          StrengthSessionRow
        > {
  $$StrengthSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$StrengthSetsTable, List<StrengthSetRow>>
  _strengthSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.strengthSets,
    aliasName: 'strength_sessions__id__strength_sets__session_id',
  );

  $$StrengthSetsTableProcessedTableManager get strengthSetsRefs {
    final manager = $$StrengthSetsTableTableManager(
      $_db,
      $_db.strengthSets,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_strengthSetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StrengthSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $StrengthSessionsTable> {
  $$StrengthSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcalOverride => $composableBuilder(
    column: $table.kcalOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> strengthSetsRefs(
    Expression<bool> Function($$StrengthSetsTableFilterComposer f) f,
  ) {
    final $$StrengthSetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.strengthSets,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StrengthSetsTableFilterComposer(
            $db: $db,
            $table: $db.strengthSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StrengthSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $StrengthSessionsTable> {
  $$StrengthSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalOverride => $composableBuilder(
    column: $table.kcalOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StrengthSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StrengthSessionsTable> {
  $$StrengthSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kcalOverride => $composableBuilder(
    column: $table.kcalOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  Expression<T> strengthSetsRefs<T extends Object>(
    Expression<T> Function($$StrengthSetsTableAnnotationComposer a) f,
  ) {
    final $$StrengthSetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.strengthSets,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StrengthSetsTableAnnotationComposer(
            $db: $db,
            $table: $db.strengthSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StrengthSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StrengthSessionsTable,
          StrengthSessionRow,
          $$StrengthSessionsTableFilterComposer,
          $$StrengthSessionsTableOrderingComposer,
          $$StrengthSessionsTableAnnotationComposer,
          $$StrengthSessionsTableCreateCompanionBuilder,
          $$StrengthSessionsTableUpdateCompanionBuilder,
          (StrengthSessionRow, $$StrengthSessionsTableReferences),
          StrengthSessionRow,
          PrefetchHooks Function({bool strengthSetsRefs})
        > {
  $$StrengthSessionsTableTableManager(
    _$AppDatabase db,
    $StrengthSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StrengthSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StrengthSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StrengthSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<double?> durationMin = const Value.absent(),
                Value<double?> kcalOverride = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => StrengthSessionsCompanion(
                id: id,
                date: date,
                name: name,
                durationMin: durationMin,
                kcalOverride: kcalOverride,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                Value<String?> name = const Value.absent(),
                Value<double?> durationMin = const Value.absent(),
                Value<double?> kcalOverride = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => StrengthSessionsCompanion.insert(
                id: id,
                date: date,
                name: name,
                durationMin: durationMin,
                kcalOverride: kcalOverride,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StrengthSessionsTable, StrengthSessionRow>(
                    table,
                  ),
                  $$StrengthSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({strengthSetsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (strengthSetsRefs) db.strengthSets],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (strengthSetsRefs)
                    await $_getPrefetchedDataByColumns<
                      StrengthSessionRow,
                      $StrengthSessionsTable,
                      StrengthSetRow,
                      $StrengthSetsTable
                    >(
                      currentTable: table,
                      referencedTable: $$StrengthSessionsTableReferences
                          ._strengthSetsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$StrengthSessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).strengthSetsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'session_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$StrengthSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StrengthSessionsTable,
      StrengthSessionRow,
      $$StrengthSessionsTableFilterComposer,
      $$StrengthSessionsTableOrderingComposer,
      $$StrengthSessionsTableAnnotationComposer,
      $$StrengthSessionsTableCreateCompanionBuilder,
      $$StrengthSessionsTableUpdateCompanionBuilder,
      (StrengthSessionRow, $$StrengthSessionsTableReferences),
      StrengthSessionRow,
      PrefetchHooks Function({bool strengthSetsRefs})
    >;
typedef $$StrengthSetsTableCreateCompanionBuilder =
    StrengthSetsCompanion Function({
      Value<int> id,
      required int sessionId,
      required String exercise,
      required int setIndex,
      required int reps,
      required double weightKg,
      Value<int?> restSec,
    });
typedef $$StrengthSetsTableUpdateCompanionBuilder =
    StrengthSetsCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<String> exercise,
      Value<int> setIndex,
      Value<int> reps,
      Value<double> weightKg,
      Value<int?> restSec,
    });

final class $$StrengthSetsTableReferences
    extends BaseReferences<_$AppDatabase, $StrengthSetsTable, StrengthSetRow> {
  $$StrengthSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StrengthSessionsTable _sessionIdTable(_$AppDatabase db) => db
      .strengthSessions
      .createAlias('strength_sets__session_id__strength_sessions__id');

  $$StrengthSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$StrengthSessionsTableTableManager(
      $_db,
      $_db.strengthSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StrengthSetsTableFilterComposer
    extends Composer<_$AppDatabase, $StrengthSetsTable> {
  $$StrengthSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exercise => $composableBuilder(
    column: $table.exercise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setIndex => $composableBuilder(
    column: $table.setIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restSec => $composableBuilder(
    column: $table.restSec,
    builder: (column) => ColumnFilters(column),
  );

  $$StrengthSessionsTableFilterComposer get sessionId {
    final $$StrengthSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.strengthSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StrengthSessionsTableFilterComposer(
            $db: $db,
            $table: $db.strengthSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StrengthSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $StrengthSetsTable> {
  $$StrengthSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exercise => $composableBuilder(
    column: $table.exercise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setIndex => $composableBuilder(
    column: $table.setIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restSec => $composableBuilder(
    column: $table.restSec,
    builder: (column) => ColumnOrderings(column),
  );

  $$StrengthSessionsTableOrderingComposer get sessionId {
    final $$StrengthSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.strengthSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StrengthSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.strengthSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StrengthSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StrengthSetsTable> {
  $$StrengthSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exercise =>
      $composableBuilder(column: $table.exercise, builder: (column) => column);

  GeneratedColumn<int> get setIndex =>
      $composableBuilder(column: $table.setIndex, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get restSec =>
      $composableBuilder(column: $table.restSec, builder: (column) => column);

  $$StrengthSessionsTableAnnotationComposer get sessionId {
    final $$StrengthSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.strengthSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StrengthSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.strengthSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StrengthSetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StrengthSetsTable,
          StrengthSetRow,
          $$StrengthSetsTableFilterComposer,
          $$StrengthSetsTableOrderingComposer,
          $$StrengthSetsTableAnnotationComposer,
          $$StrengthSetsTableCreateCompanionBuilder,
          $$StrengthSetsTableUpdateCompanionBuilder,
          (StrengthSetRow, $$StrengthSetsTableReferences),
          StrengthSetRow,
          PrefetchHooks Function({bool sessionId})
        > {
  $$StrengthSetsTableTableManager(_$AppDatabase db, $StrengthSetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StrengthSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StrengthSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StrengthSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<String> exercise = const Value.absent(),
                Value<int> setIndex = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<int?> restSec = const Value.absent(),
              }) => StrengthSetsCompanion(
                id: id,
                sessionId: sessionId,
                exercise: exercise,
                setIndex: setIndex,
                reps: reps,
                weightKg: weightKg,
                restSec: restSec,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required String exercise,
                required int setIndex,
                required int reps,
                required double weightKg,
                Value<int?> restSec = const Value.absent(),
              }) => StrengthSetsCompanion.insert(
                id: id,
                sessionId: sessionId,
                exercise: exercise,
                setIndex: setIndex,
                reps: reps,
                weightKg: weightKg,
                restSec: restSec,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StrengthSetsTable, StrengthSetRow>(table),
                  $$StrengthSetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sessionId,
                        referencedTable: $$StrengthSetsTableReferences
                            ._sessionIdTable(db),
                        referencedColumn: $$StrengthSetsTableReferences
                            ._sessionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StrengthSetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StrengthSetsTable,
      StrengthSetRow,
      $$StrengthSetsTableFilterComposer,
      $$StrengthSetsTableOrderingComposer,
      $$StrengthSetsTableAnnotationComposer,
      $$StrengthSetsTableCreateCompanionBuilder,
      $$StrengthSetsTableUpdateCompanionBuilder,
      (StrengthSetRow, $$StrengthSetsTableReferences),
      StrengthSetRow,
      PrefetchHooks Function({bool sessionId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$IngredientsTableTableManager get ingredients =>
      $$IngredientsTableTableManager(_db, _db.ingredients);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db, _db.recipes);
  $$RecipeIngredientsTableTableManager get recipeIngredients =>
      $$RecipeIngredientsTableTableManager(_db, _db.recipeIngredients);
  $$RecipeStepsTableTableManager get recipeSteps =>
      $$RecipeStepsTableTableManager(_db, _db.recipeSteps);
  $$RecipeUserStatesTableTableManager get recipeUserStates =>
      $$RecipeUserStatesTableTableManager(_db, _db.recipeUserStates);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$ProfileAversionsTableTableManager get profileAversions =>
      $$ProfileAversionsTableTableManager(_db, _db.profileAversions);
  $$ProfileExclusionsTableTableManager get profileExclusions =>
      $$ProfileExclusionsTableTableManager(_db, _db.profileExclusions);
  $$ProfileEquipmentTableTableManager get profileEquipment =>
      $$ProfileEquipmentTableTableManager(_db, _db.profileEquipment);
  $$ProfileSlotsTableTableManager get profileSlots =>
      $$ProfileSlotsTableTableManager(_db, _db.profileSlots);
  $$WeekMenusTableTableManager get weekMenus =>
      $$WeekMenusTableTableManager(_db, _db.weekMenus);
  $$MenuSlotsTableTableManager get menuSlots =>
      $$MenuSlotsTableTableManager(_db, _db.menuSlots);
  $$WeekExtrasTableTableManager get weekExtras =>
      $$WeekExtrasTableTableManager(_db, _db.weekExtras);
  $$ShoppingItemsTableTableManager get shoppingItems =>
      $$ShoppingItemsTableTableManager(_db, _db.shoppingItems);
  $$AppMetaTableTableManager get appMeta =>
      $$AppMetaTableTableManager(_db, _db.appMeta);
  $$CustomProductsTableTableManager get customProducts =>
      $$CustomProductsTableTableManager(_db, _db.customProducts);
  $$ProductLinksTableTableManager get productLinks =>
      $$ProductLinksTableTableManager(_db, _db.productLinks);
  $$StockLotsTableTableManager get stockLots =>
      $$StockLotsTableTableManager(_db, _db.stockLots);
  $$StockMovementsTableTableManager get stockMovements =>
      $$StockMovementsTableTableManager(_db, _db.stockMovements);
  $$MealCompletionsTableTableManager get mealCompletions =>
      $$MealCompletionsTableTableManager(_db, _db.mealCompletions);
  $$FoodLogEntriesTableTableManager get foodLogEntries =>
      $$FoodLogEntriesTableTableManager(_db, _db.foodLogEntries);
  $$MealPresetsTableTableManager get mealPresets =>
      $$MealPresetsTableTableManager(_db, _db.mealPresets);
  $$MealPresetItemsTableTableManager get mealPresetItems =>
      $$MealPresetItemsTableTableManager(_db, _db.mealPresetItems);
  $$NutritionProfilesTableTableManager get nutritionProfiles =>
      $$NutritionProfilesTableTableManager(_db, _db.nutritionProfiles);
  $$NutritionGoalsTableTableManager get nutritionGoals =>
      $$NutritionGoalsTableTableManager(_db, _db.nutritionGoals);
  $$BodyWeightsTableTableManager get bodyWeights =>
      $$BodyWeightsTableTableManager(_db, _db.bodyWeights);
  $$DailyStepsTableTableManager get dailySteps =>
      $$DailyStepsTableTableManager(_db, _db.dailySteps);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$StrengthSessionsTableTableManager get strengthSessions =>
      $$StrengthSessionsTableTableManager(_db, _db.strengthSessions);
  $$StrengthSetsTableTableManager get strengthSets =>
      $$StrengthSetsTableTableManager(_db, _db.strengthSets);
}
