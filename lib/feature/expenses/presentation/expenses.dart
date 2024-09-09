import 'package:expencetracker/core/theme/app_colors.dart';
import 'package:expencetracker/feature/addExpense/presentation/provider/add_expense_provider.dart';
import 'package:expencetracker/feature/home/presentation/provider/home_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

  late Map<String, double> categoryExpenses;

  void getMonthlyData(){
    final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    categoryExpenses = expenseProvider.groupExpensesByCategory();    
  }

  @override
  void initState() {
    super.initState();
    getMonthlyData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ExpenseProvider,HomeProvider>(
      builder: (context,store,storeTwo,child) {
        return SingleChildScrollView(
          child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.4,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sections: getSections(),
                          centerSpaceRadius: 100, 
                          sectionsSpace: 2, 
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Spent this Month',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${storeTwo.userInfo['spentAmonut']}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.expenseColor
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Tab bar
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(text: 'Week'),
                            Tab(text: 'Month'),
                            Tab(text: 'Year'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 1.2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      ...getSections().map((e){
                        return buildCategoryCard(e.title, 36, e.value,e.color);
                      })
                  
                    ],
                  ),
                ),
              ],
            ),
        );
      }
    );
  }

  List<PieChartSectionData> getSections() {
    List<PieChartSectionData> sections = [];
    int index = 0;

    categoryExpenses.forEach((category, totalAmount) {
      sections.add(
        PieChartSectionData(
          value: totalAmount,
          title: category, 
          color: getColorForIndex(index), 
          radius: 50, 
          titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
      index++;
    });

    return sections;
  }

  buildCategoryCard(String title, double percentage, double amount, Color color) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.1),  
            child: Icon(Icons.circle, color: color),  
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\$${amount.toStringAsFixed(2)}', 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '$percentage% $title', 
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),  
              ),
            ],
          ),
        ],
      ),
    ),
  );
  }


  Color getColorForIndex(int index) {
    List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.yellow,
      Colors.brown,
    ];
    return colors[index % colors.length]; 
  }
}