import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:college_tinder/common/components/buttonDesign.dart'; // Import your custom button design

class BottomSheetDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime lastDate; // Add lastDate parameter
  final Function(DateTime) onDateSelected;

  const BottomSheetDatePicker({
    Key? key,
    required this.initialDate,
    required this.lastDate,
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

  void _previousMonth() {
    setState(() {
      if (selectedDate.month == 1) {
        selectedDate = DateTime(selectedDate.year - 1, 12);
      } else {
        selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
      }
      // Check if the new month has a last date beyond lastDate
      if (DateTime(selectedDate.year, selectedDate.month + 1, 0).isAfter(widget.lastDate)) {
        selectedDate = DateTime(widget.lastDate.year, widget.lastDate.month);
      }
    });
  }

  void _nextMonth() {
    setState(() {
      if (selectedDate.month == 12) {
        selectedDate = DateTime(selectedDate.year + 1, 1);
      } else {
        selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
      }
      // Check if the new month has a last date beyond lastDate
      if (DateTime(selectedDate.year, selectedDate.month + 1, 0).isAfter(widget.lastDate)) {
        selectedDate = DateTime(widget.lastDate.year, widget.lastDate.month);
      }
    });
  }

  void _showYearPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Select Year',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 100, // Number of years to display
                  itemBuilder: (context, index) {
                    int year = DateTime.now().year - 50 + index; // Adjust range as needed
                    if (year > widget.lastDate.year) return SizedBox.shrink();
                    return ListTile(
                      title: Text(year.toString()),
                      onTap: () {
                        setState(() {
                          selectedDate = DateTime(year, selectedDate.month, selectedDate.day);
                          if (selectedDate.isAfter(widget.lastDate)) {
                            selectedDate = DateTime(widget.lastDate.year, widget.lastDate.month, widget.lastDate.day);
                          }
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDatePicker() {
    final daysInMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0).day;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Text(
          'Select Date',
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
              IconButton(
                onPressed: _previousMonth,
                icon: Icon(Icons.chevron_left),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: _showYearPicker,
                    child: Text(
                      DateFormat.y().format(selectedDate),
                      style: const TextStyle(
                        fontSize: 40,
                        color: Color(0xffe94057),
                        fontWeight: FontWeight.bold,
                      ),
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
              IconButton(
                onPressed: _nextMonth,
                icon: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: daysInMonth,
            itemBuilder: (context, index) {
              int day = index + 1;
              DateTime date = DateTime(selectedDate.year, selectedDate.month, day);
              bool isSelectable = date.isBefore(widget.lastDate) || date.isAtSameMomentAs(widget.lastDate);

              return InkWell(
                onTap: isSelectable
                    ? () {
                  setState(() {
                    selectedDate = date;
                  });
                }
                    : null,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    day.toString(),
                    style: TextStyle(
                      color: date.day == selectedDate.day ? Colors.white : Colors.black,
                      fontWeight: date.day == selectedDate.day ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: date.day == selectedDate.day ? Color(0xffe94057) : Colors.transparent,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
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

void showBottomSheetDatePicker(BuildContext context, DateTime initialDate, DateTime lastDate, Function(DateTime) onDateSelected) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return BottomSheetDatePicker(
        initialDate: initialDate,
        lastDate: lastDate,
        onDateSelected: onDateSelected,
      );
    },
  );
}
