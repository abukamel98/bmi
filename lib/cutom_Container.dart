import 'package:bmi/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final Widget child;

  double margen;
  double width;
  GestureTapCallback? onPressed;

  bool? isClick;

  CustomContainer(
      {super.key,
      required this.child,
      this.margen = 0,
      this.width = double.infinity});

  CustomContainer.gender(
      {super.key,
      required this.child,
      this.margen = 0,
      this.width = double.infinity,
      required this.onPressed,
      required this.isClick});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: widget.width,
        margin: EdgeInsets.symmetric(vertical: widget.margen),
        decoration: BoxDecoration(
          color: widget.isClick == true
              ? AppColors.bottom1.color
              : AppColors.secondary.color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: widget.child,
      ),
    );
  }
}
