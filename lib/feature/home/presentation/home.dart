import 'package:expencetracker/core/theme/app_colors.dart';
import 'package:expencetracker/core/widgets/spacer.dart';
import 'package:expencetracker/feature/addExpense/presentation/provider/add_expense_provider.dart';
import 'package:expencetracker/feature/home/presentation/provider/home_provider.dart';
import 'package:expencetracker/feature/home/presentation/widgets/chip.dart';
import 'package:expencetracker/feature/home/presentation/widgets/home_header_card.dart';
import 'package:expencetracker/feature/home/presentation/widgets/secondery_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  Future<void>getExpense()async{
    final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    expenseProvider.getAllExpense();
  }

  @override
  void initState() {
    super.initState();
    getExpense();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer2<ExpenseProvider,HomeProvider>(
      builder: (context,store,storeTwo,child) {
        print(store.expense);
        return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:storeTwo.userInfo.isEmpty?Center(child: CircularProgressIndicator()):
         SingleChildScrollView(
           child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ETSpacer(height: 30),
              HeaderCard(balance: storeTwo.userInfo['totalBalance'],),
              ETSpacer(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                SeconderyCard(
                  text: "Income",
                  amount: "25000.00",
                  color: Color(0xFFE4F4E1),
                  icon: Icon(Icons.archive,color: Colors.white,),
                ),
                SeconderyCard(
                  amount: "${storeTwo.userInfo['spentAmonut'].toStringAsFixed(2)}", 
                  text: "Expenses",
                  color: Color(0xFFF5E8F0),
                  icon: Icon(Icons.unarchive,color: Colors.white,),
                  ),
              ],),
              ETSpacer(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                  onTap: (){
                    store.getAllExpense();
                  },
                  child: HomeChip(text: "All",color: store.selectd=="All"?AppColors.buttonColor:null,)
                ),
                GestureDetector(
                  onTap: (){
                    store.getAllExpense().then((_){
                      store.getTodayExpences();
                    });
                  },
                  child: HomeChip(text: "Today",color: store.selectd=="Day"?AppColors.buttonColor:null,),
                ),
                GestureDetector(
                  onTap: (){
                    store.getAllExpense().then((_){
                      store.getWeekExpences();
                    });
                  },
                  child: HomeChip(text: "Weekly",color: store.selectd=="Week"?AppColors.buttonColor:null,),
                
                ),
                GestureDetector(
                  onTap: (){
                    store.getAllExpense().then((_){
                      store.getMonthExpences();
                    });
                  },
                  child: HomeChip(text: "Monthly",color: store.selectd=="Month"?AppColors.buttonColor:null,),
                  
                )
              ],),
              ETSpacer(height: 20),
              if(store.expense.isEmpty) Container(
                height: MediaQuery.of(context).size.height*0.2,
                width: MediaQuery.of(context).size.width*0.9,
                child: Center(child: Text("No Expense Added"),),
              ),
              ...store.expense.map((e){
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Icon(Icons.category),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("-${e['amount']}₹",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.expenseColor),),
                      IconButton(onPressed: (){
                        store.delete(e['key']);
                        storeTwo.updateTotalBalance(e['amount'], true);
                      }, icon: Icon(Icons.delete,color: AppColors.expenseColor,))
                    ],
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(width: 0.05)),
                  title: Text(e['category'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),),
              );
              }),
           
            ],
                   ),
         ),
                );
      }
    );
  }
}

