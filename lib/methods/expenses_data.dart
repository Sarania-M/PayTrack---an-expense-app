import 'package:expenseapp/database/hive_database.dart';
import 'package:expenseapp/methods/date_converter.dart';

import 'package:expenseapp/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesData extends ChangeNotifier{
  
  List<ExpenseItem> allExpenseList = [];

  final dBase = HiveDatabase();

  void addExpense(ExpenseItem newItem){
    allExpenseList.add(newItem);
    notifyListeners();
    dBase.saveData(allExpenseList);
  }

  void removeExpense(ExpenseItem removeItem){
    allExpenseList.remove(removeItem);
    notifyListeners();
    dBase.saveData(allExpenseList);
  }
  
  //Prepare data to show

  void prepare(){
    if(dBase.readData().isNotEmpty){
       allExpenseList = dBase.readData();
    }
  }
  
  //getting the daily expenses
  double getDailyExpense() {
    final DateTime today = DateTime.now();
    double todayExpense = 0.0;

    for (var expense in allExpenseList) {
      if (_isSameDay(expense.dateTime, today)) {
        todayExpense += double.parse(expense.amount);
      }
    }

    return todayExpense;

  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  
  
  List<ExpenseItem> getAllExpenses() {
    return allExpenseList;
  }

  String getDayName(DateTime dateTime){
  switch (dateTime.weekday) {
    case 1:
        return 'Monday';
    case 2:
        return 'Tuesday';
    case 3:
        return 'Wednesday';
    case 4:
        return 'Thursday';
    case 5:
        return 'Friday';
    case 6:
        return 'Saturday';
    case 7:
        return 'Sunday';
    
    default:
      return '';
  }
}

DateTime firstDayofWeek() {
  DateTime? firstDayofWeek;

  DateTime today  = DateTime.now();

  for(int i=0; i<7 ; i++)
  {
    if(getDayName(today.subtract(Duration(days: i)))=='Sunday'){

      firstDayofWeek = today.subtract(Duration(days: i));

    }
  }
  return firstDayofWeek!;
}






Map<String , double>  calculateexpenses() {
Map<String , double> dailyExpenses = {

  };

for(var expense in allExpenseList){
    String date = converter(expense.dateTime);
    double amount = double.parse(expense.amount);

    if(dailyExpenses.containsKey(date)){
      double currentExpense = dailyExpenses[date]!;
      currentExpense += amount;
      dailyExpenses[date] = currentExpense;
    }

    else{
      dailyExpenses.addAll({date: amount});
    }

}

return dailyExpenses;
}

}


