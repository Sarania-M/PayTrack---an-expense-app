import 'package:expenseapp/methods/expenses_data.dart';
import 'package:expenseapp/pages/main_screen.dart';
import 'package:expenseapp/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('database1');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpensesData()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: MainScreen(),
      ), 
    );
}
}
