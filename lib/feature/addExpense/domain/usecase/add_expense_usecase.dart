
import 'package:expencetracker/core/exception/failure.dart';
import 'package:expencetracker/core/usecase/usecase.dart';
import 'package:expencetracker/feature/addExpense/domain/repo/expense_repo.dart';
import 'package:fpdart/src/either.dart';
class AddExpenseUsecase implements UseCase<void,ExpenseParams>{
  final ExpenseRepo addExpenseRepo;
  AddExpenseUsecase(this.addExpenseRepo);
  
  @override
  Future<Either<Failure, void>> call(ExpenseParams params) async{
    return await addExpenseRepo.addExpense(params.expense);
  }
  
}

class ExpenseParams{
  Map<String,dynamic>expense;
  // final String category;
  // final String? photo;
  // final double price;
  // final String? note;

  ExpenseParams({ required this.expense });
}