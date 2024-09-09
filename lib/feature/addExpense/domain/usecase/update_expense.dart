import 'package:expencetracker/core/exception/failure.dart';
import 'package:expencetracker/core/usecase/usecase.dart';
import 'package:expencetracker/feature/addExpense/domain/repo/expense_repo.dart';
import 'package:fpdart/src/either.dart';

class UpdateExpense implements UseCase<void,UpdateExpenseParams>{
  final ExpenseRepo addExpenseRepo;
  UpdateExpense(this.addExpenseRepo);

  @override
  Future<Either<Failure, void>> call(UpdateExpenseParams params) async{
    return await addExpenseRepo.updateExpense(params.key, params.expense);
  }
}


class UpdateExpenseParams{

  Map<String,dynamic>expense ;
  int key;

  UpdateExpenseParams({required this.expense,required this.key});
}