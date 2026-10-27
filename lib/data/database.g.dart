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
          ..write('origin: $origin')
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
          other.origin == this.origin);
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
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recipeIngredientsRefs) db.recipeIngredients,
                    if (profileAversionsRefs) db.profileAversions,
                    if (shoppingItemsRefs) db.shoppingItems,
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
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (menuSlotsRefs) db.menuSlots,
                    if (weekExtrasRefs) db.weekExtras,
                    if (shoppingItemsRefs) db.shoppingItems,
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
}
