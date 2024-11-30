import 'package:bmi/bmi_result.dart';
import 'package:bmi/colors.dart';
import 'package:flutter/material.dart';

import 'cutom_Container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isSelectGender;
  double? personHeight;
  int? weight;
  int? age;
  bool disable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary.color,
      appBar: AppBar(
        title: Text(
          "Bmi Calculator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary.color,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            MaleFemale(
              onGenderSelected: (bool isSelected) {
                isSelectGender = isSelected;
                if (isSelectGender != null &&
                    personHeight != null &&
                    weight != null &&
                    age != null) {
                  setState(() {
                    disable = false;
                  });
                }
              },
            ),
            Expanded(
              child: CustomContainer(
                child: PersonHeight(
                  height: (double height) {
                    personHeight = height;
                    if (isSelectGender != null &&
                        personHeight != null &&
                        weight != null &&
                        age != null) {
                      setState(() {
                        disable = false;
                      });
                    }
                  },
                ),
                margen: 10,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CustomContainer(
                        child: AgeWeight(
                          ageOrWeight: "Age",
                          ageWeight: (int value) {
                            age = value;
                            if (isSelectGender != null &&
                                personHeight != null &&
                                weight != null &&
                                age != null) {
                              setState(() {
                                disable = false;
                              });
                            }
                          },
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomContainer(
                        child: AgeWeight(
                          ageOrWeight: "Weight",
                          ageWeight: (int value) {
                            weight = value;
                            if (isSelectGender != null &&
                                personHeight != null &&
                                weight != null &&
                                age != null) {
                              setState(() {
                                disable = false;
                              });
                            }
                          },
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: AppColors.bottom1.color,
                      disabledBackgroundColor: Colors.grey),
                  onPressed: disable ? null : () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return BmiResult(
                          height: personHeight!/100, weight: weight!, age: age!);
                    }));
                  },
                  child: Text(
                    "Calculate",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

Widget maleFemale(bool isMale,) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        isMale ? Icons.male : Icons.female,
        color: Colors.white,
        size: 50,
      ),
      Text(
        isMale ? "Male" : "Female",
        style: TextStyle(color: Colors.white, fontSize: 25),
      )
    ],
  );
}

class MaleFemale extends StatefulWidget {
  final Function(bool isSelected) onGenderSelected;

  const MaleFemale({super.key, required this.onGenderSelected});

  @override
  State<MaleFemale> createState() => _MaleFemaleState();
}

class _MaleFemaleState extends State<MaleFemale> {
  bool? isMale;
  bool? isFemale;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: CustomContainer.gender(
              isClick: isMale,
              child: maleFemale(true),
              onPressed: () {
                setState(() {
                  isMale = true;
                  isFemale = false;
                });
                widget.onGenderSelected(true);
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: CustomContainer.gender(
              isClick: isFemale,
              child: maleFemale(false),
              onPressed: () {
                setState(() {
                  isMale = false;
                  isFemale = true;
                });
                widget.onGenderSelected(true);
              },
            ),
          )
        ],
      ),
    );
  }
}

class PersonHeight extends StatefulWidget {
  final Function(double height) height;

  const PersonHeight({super.key, required this.height});

  @override
  State<PersonHeight> createState() => _PersonHeightState();
}

double height = 150;
bool isSelect = false;

class _PersonHeightState extends State<PersonHeight> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Height",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Text(
          isSelect ? "$height cm" : "Choice Your Height",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Slider(
            divisions: 180,
            max: 220,
            min: 130,
            activeColor: AppColors.bottom1.color,
            inactiveColor: AppColors.bottom2.color,
            value: height,
            onChanged: (value) {
              setState(() {
                height = value;
                widget.height(value);
                isSelect = true;
              });
            })
      ],
    );
  }
}

class AgeWeight extends StatefulWidget {
  final String ageOrWeight;
  final Function(int value) ageWeight;

  const AgeWeight(
      {super.key, required this.ageOrWeight, required this.ageWeight});

  @override
  State<AgeWeight> createState() => _AgeWeightState();
}

class _AgeWeightState extends State<AgeWeight> {
  int counter = 30;
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${widget.ageOrWeight}",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        isSelect
            ? Text(
          "$counter",
          style: TextStyle(color: Colors.white, fontSize: 25),
        )
            : Text(
          "Choice Your ${widget.ageOrWeight}",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  counter--;
                  widget.ageWeight(counter);
                  isSelect = true;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.bottom2.color,
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  counter++;
                  widget.ageWeight(counter);
                  isSelect = true;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.bottom2.color,
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
