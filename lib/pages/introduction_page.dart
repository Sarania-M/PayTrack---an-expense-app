import 'package:expenseapp/models/intro_pages/intro_page1.dart';
import 'package:expenseapp/models/intro_pages/intro_page2.dart';
import 'package:expenseapp/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({ super.key });

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final PageController _controller = PageController();
  bool onLastPAge = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index){
              setState(() {
                onLastPAge = (index == 1);
              });
            },
            controller: _controller,
            children: [
              IntroPage1(),
              IntroPage2()
            ],
          ),

          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                  _controller.jumpToPage(1);
                  },
                  child: Text(
                  'SKIP',
                  style: TextStyle(
                    fontFamily: 'Cera',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  ),
                ),
                
                SmoothPageIndicator(controller: _controller, count: 2),

                onLastPAge
                  ? GestureDetector(
                    onTap: () async{
                      var pageBox = await Hive.openBox('settings'); 
                      await pageBox.put('hasSeenIntro', true);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen()));
                    },
                    child: Text(
                      'DONE',
                      style: TextStyle(
                        fontFamily: 'Cera',
                        color: Colors.white,
                        fontSize: 16),
                    ),
                    )
                  : GestureDetector(
                    onTap: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                    },
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                        fontFamily: 'Cera',
                        color: Colors.white,
                        fontSize: 16),
                    ),
                    )

              ],
            ),
            )
        ],
      ),
    );
  }
}