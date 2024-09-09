import 'package:expencetracker/core/exception/failure.dart';
import 'package:expencetracker/core/usecase/usecase.dart';
import 'package:expencetracker/feature/settings/domain/repo/category_repo.dart';
import 'package:fpdart/src/either.dart';

class GetCategoryUsecase implements UseCase<List<Map<String,dynamic>>,NoPrams> {
  final CategoryRepo categoryRepo;
  GetCategoryUsecase(this.categoryRepo);

  @override
  Future<Either<Failure, List<Map<String,dynamic>>>> call(NoPrams params) {
    return categoryRepo.getAllCategory();
  }
  
}