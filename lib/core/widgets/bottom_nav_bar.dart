import 'package:expencetracker/core/theme/app_colors.dart';
import 'package:expencetracker/feature/addExpense/presentation/add_expense.dart';
import 'package:expencetracker/feature/addExpense/presentation/provider/add_expense_provider.dart';
import 'package:expencetracker/feature/expenses/presentation/expenses.dart';
import 'package:expencetracker/feature/home/presentation/home.dart';
import 'package:expencetracker/feature/home/presentation/provider/home_provider.dart';
import 'package:expencetracker/feature/settings/presentation/settings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  

  int _currentIndex = 0;
  final _pageController = PageController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    
    _pageController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 5,bottom: 5),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border: Border.all(width: 0.4)),
            child: LottieBuilder.asset(
            'assets/user.json',
            fit: BoxFit.contain,
          )),
        ),
        title: Consumer<HomeProvider>(
          builder: (context,store,child) {
            return Text("Welcome ${store.userInfo['userName']}",style: TextStyle(fontWeight: FontWeight.w600),);
          }
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.notification_important,color: AppColors.buttonColor,),
          )
        ],
      ),
      body:  SafeArea(
            child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const [
            Home(),
            Expenses(),
            Settings()
          ],
        ),),
      bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
        canvasColor: Colors.white
      ), child: BottomNavigationBar(
        
            iconSize: 25,
              selectedFontSize: 14,
              unselectedFontSize: 10,
              unselectedItemColor: Colors.black,
              showUnselectedLabels: false,
              elevation: 5,
              currentIndex: _currentIndex,
         onTap: (val) {
                _onItemTapped(val);
              },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart),label: "expenses"),
        BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
      ]),),
      floatingActionButton: _currentIndex==0?FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 178, 132, 157),
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddExpense())).then((_){
          getAllExpense();
        });
      },child: Icon(Icons.add,color: Colors.white,),):null,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  } 


  Future<void> getAllExpense()async{
  final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    expenseProvider.getAllExpense();
  }
}