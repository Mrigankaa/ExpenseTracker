import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeProvider extends ChangeNotifier{


final _userDetails = Hive.box("user_details");
  Map<String,dynamic> _userInfo = {};
  Map<String,dynamic> get userInfo => _userInfo;

  bool _loading = false;
  bool get loading => _loading;


  Future<void> updateTotalBalance(double amount, bool add)async{
    _userInfo = await _userDetails.keys.map((key){
      final item = _userDetails.get(key);
      return{"key":key,"userName":item['userName'],"totalBalance":add?item['totalBalance']+amount:item['totalBalance']-amount,"spentAmonut":add?item['spentAmonut']-amount:item['spentAmonut']+amount};
    }).toList().last;
    _userDetails.put(0,_userInfo);
    notifyListeners();
  }

  Future<void> addUserDetails(Map<String,dynamic> userDetails)async{
    await _userDetails.add(userDetails);              
  }


  Future<bool>getUserDetails()async{
    _loading=true;
    notifyListeners();
    final data = await _userDetails.keys.map((key){
      final item = _userDetails.get(key);
      return{"key":key,"userName":item['userName'],"totalBalance":item['totalBalance'],"spentAmonut":item['spentAmonut']};
    }).toList();
   notifyListeners();
   if(data.isNotEmpty){
    _userInfo = data.last;
    return true;
   }else{
    return false;
   }
  }
}