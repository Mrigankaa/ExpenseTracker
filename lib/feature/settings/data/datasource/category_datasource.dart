import 'package:hive/hive.dart';

abstract interface class CategoryDatasource {
  Future<List<Map<String,dynamic>>> getAllCategory();
  Future<void> addCategory(Map<String,dynamic> category);
  Future<void> updateCateGory(Map<String,dynamic> category,int key);
  Future<void> deleteCategory(int key);
}


class CatgoryDatasourceImpl implements CategoryDatasource{
   final _categoryBox = Hive.box("category");

  @override
  Future<void> addCategory(Map<String, dynamic> category) async{
    await _categoryBox.add(category);
  }

  @override
  Future<void> deleteCategory(int key)async {
    await _categoryBox.delete(key);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllCategory() async {
    final data = await _categoryBox.keys.map((key){
      final item = _categoryBox.get(key);
      return {"key":key,"categoryName":item['categoryName']};
    }).toList();
    return data;
  }

  @override
  Future<void> updateCateGory(Map<String, dynamic> category, int key) async{
   await _categoryBox.put(key, category);
  }

}