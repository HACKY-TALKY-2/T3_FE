import 'package:flutter/material.dart';
import 'result.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class LoadExcusePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Stopwatch stopwatch = new Stopwatch();

    stopwatch.start();
    // 스톱워치 정지

    if (stopwatch.elapsed == 10){
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(),
          )
      );
    }
    stopwatch.stop();
    final phoneUnitHeight = MediaQuery.of(context).size.height/844;
    final phoneUnitWidth = MediaQuery.of(context).size.width/390;
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              SizedBox(height: phoneUnitHeight * 300),
              Image.asset(
                '../assets/images/pinokio.png',
                height: phoneUnitHeight * 200,
                width: phoneUnitWidth * 200,
              ),
              Text(
                '변명 생성 중입니다',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          )
      ),
      );
  }
}
