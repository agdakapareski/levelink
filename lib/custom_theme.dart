import 'package:flutter/material.dart';

class Colour {
  static Color red = const Color(0xFFCD4236);
  static Color blue = const Color(0xFF1C375B);
}

class TitleText extends StatelessWidget {
  final String text;

  const TitleText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

class SmallerTitleText extends StatelessWidget {
  final String text;

  const SmallerTitleText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}

class MapelButton extends StatelessWidget {
  final Widget? child;
  final void Function()? onTap;
  const MapelButton({this.child, this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: screenHeight * 0.133,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 0.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      color: Colors.grey[200],
    );
  }
}

class GuruDetailRow extends StatelessWidget {
  final String? title;
  final String? value;
  const GuruDetailRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title!,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const Spacer(),
        Text(value!),
      ],
    );
  }
}
