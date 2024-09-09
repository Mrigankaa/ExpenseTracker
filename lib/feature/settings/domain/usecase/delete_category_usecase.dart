import 'package:expencetracker/core/exception/failure.dart';
import 'package:expencetracker/core/usecase/usecase.dart';
import 'package:expencetracker/feature/settings/domain/repo/category_repo.dart';
import 'package:fpdart/src/either.dart';

class DeleteCategoryUsecase implements UseCase<void,DeleteCategoryParams>{
  final CategoryRepo categoryRepo;
  DeleteCategoryUsecase(this.categoryRepo);

  @override
  Future<Either<Failure, void>> call(DeleteCategoryParams params) {
    return categoryRepo.deleteCategory(params.key);
  }
}


class DeleteCategoryParams{
  final int key;
  DeleteCategoryParams(this.key);
}