import 'package:expencetracker/core/exception/exception.dart';
import 'package:expencetracker/core/exception/failure.dart';
import 'package:expencetracker/feature/addExpense/data/datasource/expense_datasource.dart';
import 'package:expencetracker/feature/addExpense/domain/repo/expense_repo.dart';
import 'package:fpdart/src/either.dart';

class ExpenseRepoImpl implements ExpenseRepo{
  final ExpenseDatasource expenseDatasource;
  ExpenseRepoImpl(this.expenseDatasource);
  
  @override
  Future<Either<Failure, void>> addExpense(Map<String, dynamic> expense) async{
    try {
      await expenseDatasource.addExpense(expense);
      return right(null);
    }on StorageException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteExpense(int key)async {
      try {
      await expenseDatasource.deleteExpense(key);
      return right(null);
    }on StorageException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getAllExpense()async {
     try {
      final response = await expenseDatasource.getAllExpense();
      return right(response);
    }on StorageException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, void>> updateExpense(int key, Map<String,dynamic> expense)async {
      try {
      await expenseDatasource.updateExpense(expense,key);
      return right(null);
    }on StorageException catch (e) {
      return left(Failure(e.message));
    }
  }
  
 
  
}