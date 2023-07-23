// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String text;

  final void Function() onTap;

  final double height;
  final double width;
  final bool isLoading;

  final Color color;

  final double radius;

  final TextStyle buttonStyle;

  const RoundButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.height,
    required this.width,
    required this.color,
    required this.radius,
    required this.buttonStyle,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: isLoading
          ? CircularProgressIndicator(
              color: color,
            )
          : Container(
              height: size.height * height,
              width: size.height * width,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(radius)),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: buttonStyle,
                ),
              ),
            ),
    );
  }
}
