part of repositories;

class LocalDataBaseRepositoryImpl<T extends CollectionSchema>
    implements LocalDataBaseRepository<T> {
  final IsarCollection<T> collection;
  final Isar isar;

  LocalDataBaseRepositoryImpl({
    required this.collection,
    required this.isar,
  });

  @override
  Future<void> deleteObject(T object) async {
    await isar.writeTxn(() async {
      await collection.delete(object.id);
    });
  }

  @override
  Future<void> deleteAll() async {
    await collection.clear();
  }

  @override
  Future<T?> getObjectById(int id) async {
    return await collection.get(id);
  }

  @override
  Future<void> updateObject(T object) async {
    await isar.writeTxn(() async {
      await collection.put(object);
    });
  }

  @override
  Future<void> updateObjects(List<T> objects) async {
    await isar.writeTxn(() async {
      await collection.putAll(objects);
    });
  }

  @override
  Future<List<T>> getObjects() async {
    return await collection.where().findAll();
  }

  @override
  Future<void> addObject(T object) async {
    await isar.writeTxn(() async {
      await collection.put(object);
    });
  }

  @override
  Future<void> deleteObjectAtIndex(T object) async {
    await isar.writeTxn(() async {
      await collection.delete(object.id);
    });
  }
}
