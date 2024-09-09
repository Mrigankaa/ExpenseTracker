import 'package:expencetracker/feature/addExpense/presentation/provider/add_expense_provider.dart';
import 'package:expencetracker/feature/home/presentation/provider/home_provider.dart';
import 'package:expencetracker/feature/onboarding/presentation/onboarding.dart';
import 'package:expencetracker/feature/settings/presentation/provider/category_provider.dart';
import 'package:expencetracker/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await Hive.initFlutter();
  await Hive.openBox("user_details");
  await Hive.openBox("expense_tracker");
  await Hive.openBox("category");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>ExpenseProvider( 
          addExpenseUsecase:servicLocator(),
          getAllExpenseUseCase:servicLocator(),
          updateExpenseUseCase:servicLocator(),
          deleteExpenseUseaCase:servicLocator()
          )),
      ChangeNotifierProvider(create: (context)=>CategoryProvider(
        addCategoryUsecase: servicLocator(), 
        getCategoryUsecase: servicLocator(), 
        updateCategoryUsecase: servicLocator(), 
        deleteCategoryUsecase: servicLocator())),
        ChangeNotifierProvider(create: (context)=>HomeProvider())
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Nunito Sans",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Onboarding()
    );
  }
}

