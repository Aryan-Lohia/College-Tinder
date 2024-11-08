import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterBottomSheet({super.key, required this.onApplyFilters});

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int interestedIn = 0;
  double distance = 40.0;
  RangeValues ageRange = const RangeValues(18, 27);
  String location = "Chicago, USA";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filters',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () async {
                  // Logic to clear filters (set default values)
                  interestedIn = 0;
                  distance = 40.0;
                  ageRange = const RangeValues(18, 27);
                  location = "Chicago, USA";
                  setState(() {

                  });
                  Map<String, dynamic> filters = {
                    "interestedIn": interestedIn,
                    "distance": distance,
                    "ageRange": ageRange,
                    "location": location,
                  };
                  await widget.onApplyFilters(filters);
                  Navigator.pop(context);
                  },
                child: const Text(
                  'Clear',
                  style: TextStyle(color: Color(0xffe94057)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // "Interested in" Section
          const Text(
            'Interested in',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                labelPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                ),
                label: const Text('Women'),
                selected: interestedIn == 0,
                selectedColor: const Color(0xffe94057),
                onSelected: (isSelected) {
                  setState(() {
                    interestedIn = 0;
                  });
                },
              ),
              ChoiceChip(
                labelPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                shape: RoundedRectangleBorder(),
                label: const Text('Men'),
                selected: interestedIn ==1,
                selectedColor: const Color(0xffe94057),
                onSelected: (isSelected) {
                  setState(() {
                    interestedIn = 1;
                  });
                },
              ),
              ChoiceChip(
                labelPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))
                ),
                label: const Text('Both'),
                selected: interestedIn == 2,
                selectedColor: const Color(0xffe94057),
                onSelected: (isSelected) {
                  setState(() {
                    interestedIn = 2;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Location Section
          const Text(
            'Location',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // Logic to choose location
              print('Change location');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(location),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Distance Slider Section
          const Text(
            'Distance',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Slider(
                  activeColor: const Color(0xffe94057),
                  value: distance,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: "${distance.toInt()}km",
                  onChanged: (double value) {
                    setState(() {
                      distance = value;
                    });
                  },
                ),
              ),
              Text("${distance.toInt()}km"),
            ],
          ),

          const SizedBox(height: 20),

          // Age Range Slider Section
          const Text(
            'Age',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RangeSlider(
                  activeColor: const Color(0xffe94057),
                  values: ageRange,
                  min: 18,
                  max: 27,
                  divisions: 10,
                  labels: RangeLabels(
                    ageRange.start.toInt().toString(),
                    ageRange.end.toInt().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      ageRange = values;
                    });
                  },
                ),
              ),
              Text("${ageRange.start.toInt()}-${ageRange.end.toInt()}"),
            ],
          ),

          const SizedBox(height: 30),

          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xffe94057),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Call API with filters
                Map<String, dynamic> filters = {
                  "interestedIn": interestedIn,
                  "distance": distance,
                  "ageRange": ageRange,
                  "location": location,
                };
                widget.onApplyFilters(filters);
                Navigator.pop(context);
              },
              child: const Text('Continue',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
    );
  }
}
