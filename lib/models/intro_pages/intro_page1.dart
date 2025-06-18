import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({ super.key });
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 28, 5, 46),
      body: Center(child: Column(
        children: [
          SizedBox(height: 220,),
          SizedBox(width: 370,height:370, child: Image.asset('assets/images/flying-dollars-set.png')),
          const SizedBox(height: 30,),
          const Text('Spending money recklessly?',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'Cera'
            ),
          ),
        ],
      ),),
    );
  }
}