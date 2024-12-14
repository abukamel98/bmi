import 'package:bmi/colors.dart';
import 'package:flutter/material.dart';

class BmiResult extends StatelessWidget {
  final double height;
  final int weight;
  final int age;

  const BmiResult(
      {super.key,
      required this.height,
      required this.weight,
      required this.age});

  @override
  Widget build(BuildContext context) {
    double bmi = weight / (height * height);
    String formattedNumber = bmi.toStringAsFixed(1);
    return Scaffold(
      backgroundColor: AppColors.primary.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your result is",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Text(
              formattedNumber,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            getStatus(bmi: bmi),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bottom1.color),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Back To Home Screen",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Text getStatus({required double bmi}) {
  String status = "";
  late Color textColor;
  if (bmi < 18) {
    status = "Under Weight";
    textColor = Colors.green;
  } else if (18 <= bmi && bmi <= 24.9) {
    status = "Normal";
    textColor = Colors.green.shade700;
  } else if (25 <= bmi && bmi <= 29.9) {
    status = "Over Weight";
    textColor = Colors.yellow;
  } else if (30 <= bmi && bmi <= 34.9) {
    status = "Obese";
    textColor = Colors.orange;
  } else if (35 <= bmi) {
    status = "Extremely Obese";
    textColor = Colors.red;
  }
  return Text(
    status,
    style: TextStyle(
      color: textColor,
      fontSize: 25,
    ),
  );
}
