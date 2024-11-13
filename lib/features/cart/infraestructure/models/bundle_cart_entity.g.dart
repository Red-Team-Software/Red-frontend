// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_cart_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBundleCartEntityCollection on Isar {
  IsarCollection<BundleCartEntity> get bundleCartEntitys => this.collection();
}

const BundleCartEntitySchema = CollectionSchema(
  name: r'BundleCartEntity',
  id: -8616834174281097782,
  properties: {
    r'quantity': PropertySchema(
      id: 0,
      name: r'quantity',
      type: IsarType.long,
    )
  },
  estimateSize: _bundleCartEntityEstimateSize,
  serialize: _bundleCartEntitySerialize,
  deserialize: _bundleCartEntityDeserialize,
  deserializeProp: _bundleCartEntityDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {
    r'bundle': LinkSchema(
      id: -1505120354750154341,
      name: r'bundle',
      target: r'BundleEntity',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _bundleCartEntityGetId,
  getLinks: _bundleCartEntityGetLinks,
  attach: _bundleCartEntityAttach,
  version: '3.1.0+1',
);

int _bundleCartEntityEstimateSize(
  BundleCartEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _bundleCartEntitySerialize(
  BundleCartEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.quantity);
}

BundleCartEntity _bundleCartEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BundleCartEntity(
    quantity: reader.readLong(offsets[0]),
  );
  object.isarId = id;
  return object;
}

P _bundleCartEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bundleCartEntityGetId(BundleCartEntity object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _bundleCartEntityGetLinks(BundleCartEntity object) {
  return [object.bundle];
}

void _bundleCartEntityAttach(
    IsarCollection<dynamic> col, Id id, BundleCartEntity object) {
  object.isarId = id;
  object.bundle.attach(col, col.isar.collection<BundleEntity>(), r'bundle', id);
}

extension BundleCartEntityQueryWhereSort
    on QueryBuilder<BundleCartEntity, BundleCartEntity, QWhere> {
  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BundleCartEntityQueryWhere
    on QueryBuilder<BundleCartEntity, BundleCartEntity, QWhereClause> {
  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BundleCartEntityQueryFilter
    on QueryBuilder<BundleCartEntity, BundleCartEntity, QFilterCondition> {
  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterFilterCondition>
      isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterFilterCondition>
      isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterFilterCondition>
      isarIdEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterFilterCondition>
      isarIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterFilterCondition>
      isarIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterFilterCondition>
      isarIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterFilterCondition>
      quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterFilterCondition>
      quantityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterFilterCondition>
      quantityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterFilterCondition>
      quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BundleCartEntityQueryObject
    on QueryBuilder<BundleCartEntity, BundleCartEntity, QFilterCondition> {}

extension BundleCartEntityQueryLinks
    on QueryBuilder<BundleCartEntity, BundleCartEntity, QFilterCondition> {
  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterFilterCondition>
      bundle(FilterQuery<BundleEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'bundle');
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterFilterCondition>
      bundleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'bundle', 0, true, 0, true);
    });
  }
}

extension BundleCartEntityQuerySortBy
    on QueryBuilder<BundleCartEntity, BundleCartEntity, QSortBy> {
  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterSortBy>
      sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension BundleCartEntityQuerySortThenBy
    on QueryBuilder<BundleCartEntity, BundleCartEntity, QSortThenBy> {
  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterSortBy>
      thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<BundleCartEntity, BundleCartEntity, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension BundleCartEntityQueryWhereDistinct
    on QueryBuilder<BundleCartEntity, BundleCartEntity, QDistinct> {
  QueryBuilder<BundleCartEntity, BundleCartEntity, QDistinct>
      distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }
}

extension BundleCartEntityQueryProperty
    on QueryBuilder<BundleCartEntity, BundleCartEntity, QQueryProperty> {
  QueryBuilder<BundleCartEntity, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<BundleCartEntity, int, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }
}
