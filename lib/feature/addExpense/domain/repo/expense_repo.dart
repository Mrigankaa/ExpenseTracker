import 'package:expencetracker/core/exception/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ExpenseRepo {
  Future<Either<Failure,void>>addExpense(Map<String, dynamic> expense);
  Future<Either<Failure,List<Map<String,dynamic>>>> getAllExpense();
  Future<Either<Failure,void>>updateExpense(int key,Map<String, dynamic> expense);
  Future<Either<Failure,void>>deleteExpense(int key);
}