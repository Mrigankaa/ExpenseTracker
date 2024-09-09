import 'package:expencetracker/core/exception/failure.dart';
import 'package:expencetracker/core/usecase/usecase.dart';
import 'package:expencetracker/feature/addExpense/domain/repo/expense_repo.dart';
import 'package:fpdart/src/either.dart';

class GetAllExpense implements UseCase<List<Map<String,dynamic>>,NoPrams>{
   final ExpenseRepo addExpenseRepo;
   GetAllExpense(this.addExpenseRepo);

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(NoPrams params)async {
    return await addExpenseRepo.getAllExpense();
  }

}