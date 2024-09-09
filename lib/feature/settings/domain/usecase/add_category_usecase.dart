import 'package:expencetracker/core/exception/failure.dart';
import 'package:expencetracker/core/usecase/usecase.dart';
import 'package:expencetracker/feature/settings/domain/repo/category_repo.dart';
import 'package:fpdart/src/either.dart';

class AddCategoryUsecase implements UseCase<void, AddCateGoryParams>{
  final CategoryRepo categoryRepo;
  AddCategoryUsecase(this.categoryRepo);
  @override
  Future<Either<Failure, void>> call(AddCateGoryParams params) {
   return categoryRepo.addCategory(params.category);
  }
}


class AddCateGoryParams{
  final Map<String,dynamic> category;
  AddCateGoryParams(this.category);
}