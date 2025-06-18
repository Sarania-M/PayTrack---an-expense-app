import 'package:expenseapp/methods/expenses_data.dart';
import 'package:expenseapp/pages/introduction_page.dart';
import 'package:expenseapp/pages/main_screen.dart';
import 'package:expenseapp/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('database1');

  var pageBox = await Hive.openBox('settings');

  bool hasSeenIntro = pageBox.get('hasSeenIntro', defaultValue: false);
  

  runApp(MyApp(showIntro: !hasSeenIntro));
}

class MyApp extends StatelessWidget {
const MyApp({super.key, required this.showIntro});

final bool showIntro;

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
        home: showIntro? MainScreen() : IntroductionPage(),
      ), 
    );
}
}
