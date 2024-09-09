import 'package:expencetracker/core/exception/exception.dart';
import 'package:expencetracker/core/exception/failure.dart';
import 'package:expencetracker/feature/settings/data/datasource/category_datasource.dart';
import 'package:expencetracker/feature/settings/domain/repo/category_repo.dart';
import 'package:fpdart/src/either.dart';

class CetegoryRepoImpl implements CategoryRepo{
  final CategoryDatasource categoryDatasource;
  CetegoryRepoImpl(this.categoryDatasource);

  @override
  Future<Either<Failure, void>> addCategory(Map<String, dynamic> category)async {
    try {
      await categoryDatasource.addCategory(category);
      return right(null);
    }on StorageException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(int key) async{
     try {
      await categoryDatasource.deleteCategory(key);
      return right(null);
    }on StorageException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getAllCategory() async{
    try {
      final response = await categoryDatasource.getAllCategory();
      return right(response);
    }on StorageException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateCategory(Map<String, dynamic> category, int key)async {
    try {
      await categoryDatasource.updateCateGory(category,key);
      return right(null);
    }on StorageException catch (e) {
      return left(Failure(e.message));
    }
  }

}