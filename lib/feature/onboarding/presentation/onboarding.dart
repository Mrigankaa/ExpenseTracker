import 'package:expencetracker/core/widgets/bottom_nav_bar.dart';
import 'package:expencetracker/feature/home/presentation/provider/home_provider.dart';
import 'package:expencetracker/feature/onboarding/presentation/add_balance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {


  Future<void>getUserDetails()async{
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final checkUser = await homeProvider.getUserDetails();
    if(checkUser){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (builder) => BottomNavBar()),
      );
    }
  }
  
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserDetails();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 150.0,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: Icon(
                        Icons.account_balance_wallet,
                        size: 150.0,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    SizedBox(height: 40.0),
              Text(
                "Welcome to E-wallet",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Simple way to manage money transfer\nand receive quickly.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.2),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>AddBalance()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 108, 54, 203), // Purple color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
                ],),
              ),
        );
  }
}