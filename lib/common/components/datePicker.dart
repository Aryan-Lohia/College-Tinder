import 'package:college_tinder/common/components/buttonDesign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomSheetDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const BottomSheetDatePicker({
    Key? key,
    required this.initialDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _BottomSheetDatePickerState createState() => _BottomSheetDatePickerState();
}

class _BottomSheetDatePickerState extends State<BottomSheetDatePicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  Widget _buildDatePicker() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 16),
        Text(
          'Birthday',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.chevron_left)),
              Column(
                children: [
                  Text(
                    DateFormat.y().format(selectedDate),
                    style: const TextStyle(
                      fontSize: 40,
                      color: Color(0xffe94057),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.MMMM().format(selectedDate),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xffe94057),
                    ),
                  ),
                ],
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right)),

            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 30),

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: DateTime(selectedDate.year, selectedDate.month + 1, 0).day,
            itemBuilder: (context, index) {
              int day = index + 1;
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedDate = DateTime(selectedDate.year, selectedDate.month, day);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    day.toString(),
                    style: TextStyle(
                      color: day == selectedDate.day ? Colors.white : Colors.black,
                      fontWeight: day == selectedDate.day ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: day == selectedDate.day ? Color(0xffe94057) : Colors.transparent,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
          child: InkWell(
            onTap: () {
              widget.onDateSelected(selectedDate);
              Navigator.pop(context);
            },
            child: const MainButtonDesign(text: "Save"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: _buildDatePicker(),
    );
  }
}