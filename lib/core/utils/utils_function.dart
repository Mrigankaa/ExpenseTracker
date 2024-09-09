double convertStringToDouble(String? num){
  double newNumber  = num!=null?double.parse(num): 0;
  return newNumber;
}

DateTime utcToLocal(String utc){
  DateTime utcTime = DateTime.parse(utc);
  DateTime localTime = utcTime.toLocal();
  return localTime;
}

List<Map<String,double>> createMonthlyExpense(){
  Map<String, double> monthlyExpenses = {};
  List<Map<String,double>> data=[];
  for(int i=1;i<=12;i++){
    String monthKey = month[i];
    monthlyExpenses[monthKey] = 0.0;
    data.add(monthlyExpenses);
  }
  return data;
}

Map month = {
  1: "Jan",
  2: "Fab",
  3: "Mar",
  4: "April",
  5: "May",
  6: "Jun",
  7: "Jul",
  8: "Aug",
  9: "Sep",
  10: "Oct",
  11: "Nov",
  12: "Dec"
};