import 'package:expenseapp/models/expense_item.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDatabase {
  final _myBox = Hive.box("database1");

  void saveData(List<ExpenseItem> allExpenses){

    List<dynamic> allExpensesFiltered = [] ;

    for(var expense in allExpenses){

      List<dynamic> expenseFiltered = [
        expense.name,
        expense.amount,
        expense.dateTime,
        expense.category
      ];
      allExpensesFiltered.add(expenseFiltered);

    }

    _myBox.put("EVERY_EXPENSE", allExpensesFiltered);

  }

  List<ExpenseItem> readData(){
    List savedExpenses = _myBox.get("EVERY_EXPENSE") ?? [];

    List<ExpenseItem> allExpenses = [];

    for(int i=0;i<savedExpenses.length;i++){

      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];
      String category = savedExpenses[i][3];

      ExpenseItem expense = ExpenseItem(name: name, amount: amount, dateTime: dateTime, category: category);

      allExpenses.add(expense);
    }

    return allExpenses;
  }

  //getting the daily budget
  void saveDailyBudget(double budget) {
    _myBox.put("DAILY_BUDGET", budget);
  }

  //reading the daily budget
  double? readDailyBudget() {
    return _myBox.get("DAILY_BUDGET");
  } 
}