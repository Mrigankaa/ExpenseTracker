import 'package:expencetracker/core/usecase/usecase.dart';
import 'package:expencetracker/feature/addExpense/domain/usecase/add_expense_usecase.dart';
import 'package:expencetracker/feature/addExpense/domain/usecase/delete_expense.dart';
import 'package:expencetracker/feature/addExpense/domain/usecase/get_all_expense.dart';
import 'package:expencetracker/feature/addExpense/domain/usecase/update_expense.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  final AddExpenseUsecase addExpenseUsecase;
  final GetAllExpense getAllExpenseUseCase;
  final UpdateExpense updateExpenseUseCase;
  final DeleteExpense deleteExpenseUseaCase;
  ExpenseProvider({
    required this.addExpenseUsecase, 
    required this.getAllExpenseUseCase, 
    required this.updateExpenseUseCase, 
    required this.deleteExpenseUseaCase
    });
  
  
 String _selected = "All";
  String get selectd => _selected;

  List<Map<String,dynamic>> _expense = [];

  List<Map<String,dynamic>> get expense => _expense;

  

  Future<void> addExpense(Map<String, dynamic> expense) async{
   
   final response = await addExpenseUsecase.call(ExpenseParams(expense: expense));
   response.fold((l){
    notifyListeners();

   },(r)async{
    notifyListeners();
   });
    getAllExpense();
  }

  Future<void> getAllExpense()async{
    final response = await getAllExpenseUseCase.call(NoPrams());
    response.fold((l){
    notifyListeners();

    }, (r){
      _expense = r;
     _selected = "All";
    notifyListeners();

    });
  }


  Future<void> delete(int key)async{
   final response = await deleteExpenseUseaCase.call(DeleteExpenseParams(key: key));
   response.fold((l){
    notifyListeners();

   }, (r){
    notifyListeners();
    });
    getAllExpense();
  }

  void getTodayExpences(
    ){
       DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);

      List<Map<String, dynamic>> todayExpenses = _expense.where((item) {
        DateTime itemDate = DateTime.parse(item['date']);
        // Strip the time portion of the item date for comparison
        DateTime itemDateOnly = DateTime(itemDate.year, itemDate.month, itemDate.day);
        return itemDateOnly == today;
      }).toList();
      _expense = todayExpenses;
     _selected="Day";
      notifyListeners();
  }

  void getWeekExpences(
  ){

    DateTime now = DateTime.now();

    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1)); 
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    List<Map<String, dynamic>> currentWeekExpenses = _expense.where((item) {
      DateTime itemDate = DateTime.parse(item['date']);
      return itemDate.isAfter(startOfWeek) && itemDate.isBefore(endOfWeek.add(const Duration(days: 1))); 
    }).toList();
    _expense = currentWeekExpenses;
  _selected = "Week";
    notifyListeners();
  }

  void getMonthExpences(){
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    int currentYear = now.year;

  List<Map<String, dynamic>> currentMonthExpenses = _expense.where((item) {
      DateTime itemDate = DateTime.parse(item['date']);
      return itemDate.month == currentMonth && itemDate.year == currentYear;
    }).toList();
    _expense = currentMonthExpenses;
      _selected="Month";
    notifyListeners();
  }

  
Map<String, double> groupExpensesByCategory() {
  Map<String, double> categoryExpenses = {};

  for (var expense in _expense) {
    String category = expense['category'];
    double amount = expense['amount'];

    if (categoryExpenses.containsKey(category)) {
      categoryExpenses[category] = categoryExpenses[category]! + amount;
    } else {
      categoryExpenses[category] = amount;
    }
  }

  return categoryExpenses;
}
}