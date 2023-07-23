// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mvvm/utils/round_button.dart';

class RetryException extends StatefulWidget {
  const RetryException({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  State<RetryException> createState() => _RetryExceptionState();
}

class _RetryExceptionState extends State<RetryException> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline_rounded,
          size: 50,
          color: Colors.red,
        ),
        const Center(
          child: Text(
            'Error 404',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        const Text(
          'Please Try again',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(height: 30),
        RoundButton(
            text: "Retry",
            onTap: widget.onTap,
            height: 0.07,
            width: 0.2,
            color: Colors.red,
            radius: 10,
            buttonStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w400))
      ],
    ));
  }
}
