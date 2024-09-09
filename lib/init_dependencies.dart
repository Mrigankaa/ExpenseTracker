import 'package:expencetracker/feature/addExpense/data/datasource/expense_datasource.dart';
import 'package:expencetracker/feature/addExpense/data/repo/add_expense_repo_impl.dart';
import 'package:expencetracker/feature/addExpense/domain/repo/expense_repo.dart';
import 'package:expencetracker/feature/addExpense/domain/usecase/add_expense_usecase.dart';
import 'package:expencetracker/feature/addExpense/domain/usecase/delete_expense.dart';
import 'package:expencetracker/feature/addExpense/domain/usecase/get_all_expense.dart';
import 'package:expencetracker/feature/addExpense/domain/usecase/update_expense.dart';
import 'package:expencetracker/feature/addExpense/presentation/provider/add_expense_provider.dart';
import 'package:expencetracker/feature/settings/data/datasource/category_datasource.dart';
import 'package:expencetracker/feature/settings/data/repo/cetegory_repo_impl.dart';
import 'package:expencetracker/feature/settings/domain/repo/category_repo.dart';
import 'package:expencetracker/feature/settings/domain/usecase/add_category_usecase.dart';
import 'package:expencetracker/feature/settings/domain/usecase/delete_category_usecase.dart';
import 'package:expencetracker/feature/settings/domain/usecase/get_category_usecase.dart';
import 'package:expencetracker/feature/settings/domain/usecase/update_category_usecase.dart';
import 'package:get_it/get_it.dart';

final servicLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initExpense();
  _initCategory();
}

void _initExpense() {
  servicLocator
    ..registerFactory<ExpenseDatasource>(
          () => ExpenseDatasourceImpl(),
    )
    ..registerFactory<ExpenseRepo>(
          () => ExpenseRepoImpl(
        servicLocator(),
      ),
    )
    ..registerFactory(
          () => AddExpenseUsecase(
        servicLocator(),
      ),
    )
    ..registerFactory(
          () => UpdateExpense(
        servicLocator(),
      ),
    )
    ..registerFactory(
          () => DeleteExpense(
        servicLocator(),
      ),
    )
    ..registerFactory(
          () => GetAllExpense(
        servicLocator(),
      ),
    )
    ..registerLazySingleton(
          () => ExpenseProvider(
           addExpenseUsecase:servicLocator(),
           getAllExpenseUseCase:servicLocator(),
           updateExpenseUseCase:servicLocator(),
           deleteExpenseUseaCase:servicLocator()
          ),
    );
}

void _initCategory() {
  servicLocator
    ..registerFactory<CategoryDatasource>(
          () =>CatgoryDatasourceImpl(),
    )
    ..registerFactory<CategoryRepo>(
          () => CetegoryRepoImpl(
        servicLocator(),
      ),
    )
    ..registerFactory(
          () => AddCategoryUsecase(
        servicLocator(),
      ),
    )
     ..registerFactory(
          () => GetCategoryUsecase(
        servicLocator(),
      ),
    )
    ..registerFactory(
          () => UpdateCategoryUsecase(
        servicLocator(),
      ),
    )
    ..registerFactory(
          () => DeleteCategoryUsecase(
        servicLocator(),
      ),
    )
    ..registerLazySingleton(
          () => (
           a:servicLocator(),
           getAllExpense:servicLocator(),
           updateExpense:servicLocator(),
           deleteExpense:servicLocator()
          ),
    );
}