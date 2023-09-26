import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  const AppButton({Key? key, required this.label, required this.onPressed, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 300,
      height: height ?? 45,
      child: ElevatedButton(
        onPressed: onPressed == null ? null : () {
          onPressed!();
        },
        child: Text(label)
      ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  final String label;
  final Function? onPressed;
  final TextStyle? style;
  const AppTextButton({Key? key, required this.label, required this.onPressed, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed == null ? null : () {
        onPressed!();
      },
      child: Text(label,
        style: style,
      )
    );
  }
}
