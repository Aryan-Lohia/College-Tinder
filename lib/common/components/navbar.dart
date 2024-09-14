import 'package:college_tinder/common/global.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final double iconSize=60;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 80,
      color: Color(0xfff3f3f3),
      width: MediaQuery.of(context).size.width,
      child: ValueListenableBuilder(valueListenable: selectedScreen, builder: (context,value,__){
        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: (){
setSelectedScreen(0);
              },
              child: Image.asset(value==0?"assets/navbar/active/1.png":"assets/navbar/inactive/1.png",height: iconSize,width: iconSize,),
            ), InkWell(
              onTap: (){setSelectedScreen(1);
              },
              child: Image.asset(value==1?"assets/navbar/active/2.png":"assets/navbar/inactive/2.png",height: iconSize,width: iconSize,),
            ), InkWell(
              onTap: (){setSelectedScreen(2);
              },
              child: Image.asset(value==2?"assets/navbar/active/3.png":"assets/navbar/inactive/3.png",height: iconSize,width: iconSize,),
            ), InkWell(
              onTap: (){setSelectedScreen(3);
              },
              child: Image.asset(value==3?"assets/navbar/active/4.png":"assets/navbar/inactive/4.png",height: iconSize,width: iconSize,),
            ),
          ],
        );
      }),
    );
  }
}
