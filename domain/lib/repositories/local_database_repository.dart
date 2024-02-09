part of repositories;

abstract class LocalDataBaseRepository<T extends CollectionSchema> {
  Future<void> updateObject(T object);

  Future<void> addObject(T object);

  Future<void> updateObjects(List<T> objects);

  Future<void> deleteObject(T object);

  Future<void> deleteObjectAtIndex(T object);

  Future<void> deleteAll();

  Future<T?> getObjectById(int id);

  Future<List<T>> getObjects();
}
