import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final GestureTapCallback? onPressed;
  const PrimaryButton({ super.key, required this.text, required this.onPressed });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12.0)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: const BorderSide(color: Colors.deepPurple)
            )
          )
        ),
        onPressed: onPressed,
        child: Text(text, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
      ),
    );
  }
}