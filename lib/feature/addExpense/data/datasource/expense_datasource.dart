import 'package:hive/hive.dart';

abstract interface class ExpenseDatasource {

Future<List<Map<String,dynamic>>> getAllExpense();

Future<void> addExpense(Map<String,dynamic> expense);

Future<void> updateExpense(Map<String,dynamic>expense,int key);

Future<void> deleteExpense(int key);
  
}

class ExpenseDatasourceImpl implements ExpenseDatasource{
  final _expenseBox = Hive.box("expense_tracker");
  
 

  @override
  Future<void> addExpense(Map<String ,dynamic> expense)async {
    await _expenseBox.add(expense);
  }
  
  @override
  Future<void> deleteExpense(int key)async {
    await _expenseBox.delete(key);
  }
  
  @override
  Future<List<Map<String, dynamic>>> getAllExpense() async{
    final data = await _expenseBox.keys.map((key){
      final item = _expenseBox.get(key);
      return {"key":key,"category":item['category'],"amount":item['amount'],"photo":item['photo'],"note":item['note'],"date":item['date']};
    }).toList();
    return data;
  }
  
  @override
  Future<void> updateExpense(Map<String, dynamic> expense, int key) async{
    await _expenseBox.put(key, expense);
  }
  
  

}