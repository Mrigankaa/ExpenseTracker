import 'package:expencetracker/core/utils/utils_function.dart';
import 'package:expencetracker/core/widgets/bottom_nav_bar.dart';
import 'package:expencetracker/core/widgets/custom_button.dart';
import 'package:expencetracker/core/widgets/custom_text_form_field.dart';
import 'package:expencetracker/feature/home/presentation/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBalance extends StatefulWidget {
  const AddBalance({super.key});

  @override
  State<AddBalance> createState() => _AddBalanceState();
}

class _AddBalanceState extends State<AddBalance> {
  final _addBalance = TextEditingController();
  final _userName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width*1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFCE4EC), // Light pink
                    Color(0xFFE1BEE7), // Light purple
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Card(
                   elevation: 3,
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          child: Icon(
                            Icons.account_balance_wallet,
                            size: 60.0,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Text("Add Details",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                        SizedBox(height: 20.0),
                        CustomTextFormField(
                          labelText: "Name",
                          controller: _userName,
                        ),
                        SizedBox(height: 20.0),
                        CustomTextFormField(
                          labelText: "Amount",
                          controller: _addBalance,
                        ),
                        SizedBox(height: 20,),
                        Consumer<HomeProvider>(
                          builder: (context,store,child) {
                            return CustomButton(child:Text("Add",style:TextStyle(color:Colors.white,fontWeight: FontWeight.w500,)), 
                            onTap: ()async{
                              if(_userName.text.isNotEmpty){
                                final Map<String,dynamic> userDetails = {
                                "userName":_userName.text.trim(),
                                "totalBalance":convertStringToDouble(_addBalance.text),
                                "spentAmonut":0.0
                              };
                              await store.addUserDetails(userDetails).then((_){
                                store.getUserDetails().then((_){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
                                });
                              });
                              }
                              else{
                            
                              } 
                            });
                          }
                        )
                     ],),
                   ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}