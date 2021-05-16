import 'package:bottom_sheet/functions/format_date_to_string.dart';
import 'package:flutter/material.dart';

import '../utils/styles.dart';

class SelectDateWidget extends StatefulWidget {
  final ValueChanged<DateTime> onChanged;

  const SelectDateWidget({Key? key, required this.onChanged}) : super(key: key);

  @override
  _SelectDateWidgetState createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Select a date',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 36,
            decoration: BoxDecoration(
              borderRadius: Styles.borderRadius,
            ),
            child: OutlinedButton(
              onPressed: () async {
                final now = DateTime.now();

                final result = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now.subtract(
                      const Duration(
                        days: 90,
                      ),
                    ),
                    lastDate: now);

                if (result != null) {
                  setState(() {
                    selectedDate = result;
                  });

                  widget.onChanged(selectedDate);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text('${formatDateToString(selectedDate)}'),
                  ),
                  Icon(Icons.calendar_today_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
