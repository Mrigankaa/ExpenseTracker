import 'package:expencetracker/core/exception/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CategoryRepo {
  Future<Either<Failure,List<Map<String,dynamic>>>>getAllCategory();
  Future<Either<Failure,void>>addCategory(Map<String,dynamic> category);
  Future<Either<Failure,void>>updateCategory(Map<String,dynamic>category, int key);
  Future<Either<Failure,void>>deleteCategory(int key);
}