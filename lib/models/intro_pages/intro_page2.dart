import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
const IntroPage2({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 5, 46),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 170,),
            SizedBox(width: 450,height: 450, child: Image.asset('assets/images/money.png')),
            Center(
              child: const Text(
                'Track your expenses effortlessly\nwith our intuitive app!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Cera'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}