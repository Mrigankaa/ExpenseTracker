import 'package:expencetracker/core/usecase/usecase.dart';
import 'package:expencetracker/feature/settings/domain/usecase/add_category_usecase.dart';
import 'package:expencetracker/feature/settings/domain/usecase/delete_category_usecase.dart';
import 'package:expencetracker/feature/settings/domain/usecase/get_category_usecase.dart';
import 'package:expencetracker/feature/settings/domain/usecase/update_category_usecase.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier{
  final AddCategoryUsecase addCategoryUsecase;
  final GetCategoryUsecase getCategoryUsecase;
  final UpdateCategoryUsecase updateCategoryUsecase;
  final DeleteCategoryUsecase deleteCategoryUsecase;

  CategoryProvider({
    required this.addCategoryUsecase, 
    required this.getCategoryUsecase, 
    required this.updateCategoryUsecase, 
    required this.deleteCategoryUsecase
  });
  

  List<Map<String,dynamic>> _categories = [];
  List<Map<String,dynamic>> get categories => _categories;

  String _failure = "";
  String get failure => _failure;

   String _success = "";
  String get success => _success;

  Future<void>getAllCategory()async{
    final response = await getCategoryUsecase.call(NoPrams());
    response.fold((failure){
      _failure = failure.message;
      notifyListeners();
    }, (r){
      print("helloo ${r}");
      _categories=r;
      notifyListeners();
    }
    );
  }

  Future<void>addCategory(Map<String,dynamic> category,String key,String value)async{

    bool isDuplicate = _categories.any((cat) => cat[key] == value);
    print(isDuplicate);
    if(!isDuplicate){
      final response = await addCategoryUsecase.call(AddCateGoryParams(category));
      response.fold((failure){
      _success = failure.message;
      notifyListeners();
    }, (r){
      getAllCategory();
      _success = "Successfully Added";
      notifyListeners();
    }
    );
    }
    else{
      _success ="Already Exist";
      notifyListeners();
    }
  }

  Future<void>updateCategory(Map<String,dynamic> category,int key)async{
    final response = await updateCategoryUsecase.call(UpdateCateGoryParams(category,key));
    response.fold((failure){
      _failure = failure.message;
      notifyListeners();
    }, (r){
      getAllCategory();
      _success = "Successfully Updated";
      notifyListeners();
    }
    );
  }

  Future<void>deleteCategory(int key)async{
    final response = await deleteCategoryUsecase.call(DeleteCategoryParams(key));
    response.fold((failure){
      _failure = failure.message;
      notifyListeners();
    }, (r){
      getAllCategory();
      _success = "Successfully Deleted";
      notifyListeners();
    }
    );
  }
}