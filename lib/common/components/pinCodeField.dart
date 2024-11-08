import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/material.dart';

/// PinCodeField
class PinCodeField extends StatelessWidget {
  const PinCodeField({
    Key? key,
    required this.pin,
    required this.pinCodeFieldIndex,
    required this.theme,
  }) : super(key: key);

  /// The pin code
  final String pin;

  /// The the index of the pin code field
  final PinTheme theme;

  /// The index of the pin code field
  final int pinCodeFieldIndex;

  Color get getFillColorFromIndex {
    if (pin.length > pinCodeFieldIndex) {
      return Color(0xffe94057);
    } else if (pin.length == pinCodeFieldIndex) {
      return Colors.white;
    }
    return Colors.white;
  }

  Color get getBorderColorFromIndex {
    if (pin.length > pinCodeFieldIndex) {
      return Color(0xffe94057);
    } else if (pin.length == pinCodeFieldIndex) {
      return Color(0xffe94057);
    }
    return Colors.grey.shade200;
  }

  Color get getTextFillColorFromIndex {
    if (pin.length > pinCodeFieldIndex) {
      return Colors.white;
    } else if (pin.length == pinCodeFieldIndex) {
      return Color(0xffe94057).withOpacity(0.5);
    }
    return Colors.grey.shade200;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50,
      width: 50,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: getFillColorFromIndex,
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: getBorderColorFromIndex,
          width: 2,
        ),
      ),
      duration: const Duration(microseconds: 40000),
      child: pin.length > pinCodeFieldIndex
          ? Center(
              child: Text(
                pin[pinCodeFieldIndex],
                style: TextStyle(color: getTextFillColorFromIndex,fontSize: 30,fontWeight: FontWeight.bold),
              ),
            )
          :  Center(
        child: Text(
          "0",
          style: TextStyle(color: getTextFillColorFromIndex,fontSize: 30,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
