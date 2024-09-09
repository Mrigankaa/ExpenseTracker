import 'package:expencetracker/core/exception/failure.dart';
import 'package:expencetracker/core/usecase/usecase.dart';
import 'package:expencetracker/feature/settings/domain/repo/category_repo.dart';
import 'package:fpdart/src/either.dart';

class UpdateCategoryUsecase implements UseCase<void,UpdateCateGoryParams>{
  final CategoryRepo categoryRepo;
  UpdateCategoryUsecase(this.categoryRepo);

  @override
  Future<Either<Failure, void>> call(UpdateCateGoryParams params) {
    return categoryRepo.updateCategory(params.category, params.key);
  }

}


class UpdateCateGoryParams{
  final Map<String,dynamic> category;
  final int key;
  UpdateCateGoryParams(this.category,this.key);
}