import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainButtonDesign extends StatelessWidget {
  const MainButtonDesign({super.key, required  this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Color(0xffe94057),
          borderRadius: BorderRadius.circular(15)
      ),
      child:  Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
class SecondaryButtonDesign extends StatelessWidget {
  const SecondaryButtonDesign({super.key, required  this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xffe94057),width: 0.2)
      ),
      child:  Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(

                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xffe94057)),
          ),
        ),
      ),
    );
  }
}
