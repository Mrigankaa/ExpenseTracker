import 'package:expencetracker/core/exception/failure.dart';
import 'package:expencetracker/core/usecase/usecase.dart';
import 'package:expencetracker/feature/addExpense/domain/repo/expense_repo.dart';
import 'package:fpdart/src/either.dart';

class DeleteExpense implements UseCase<void,DeleteExpenseParams>{
    final ExpenseRepo expenseRepo;
    DeleteExpense(this.expenseRepo);

  @override
  Future<Either<Failure, void>> call(DeleteExpenseParams params) async{
    return await expenseRepo.deleteExpense(params.key);
  }
}


class DeleteExpenseParams{
  int key;
  DeleteExpenseParams({required this.key});
}