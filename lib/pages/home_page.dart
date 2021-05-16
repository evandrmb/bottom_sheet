import 'package:bottom_sheet/functions/format_date_to_string.dart';
import 'package:bottom_sheet/models/weight_model.dart';
import 'package:bottom_sheet/utils/styles.dart';
import 'package:bottom_sheet/widgets/weight_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final weightInputController = TextEditingController();
  final weights = <WeightModel>[];

  var selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    setState(() {
      weights
        ..add(WeightModel(
            value: 66.0, date: selectedDate.subtract(const Duration(days: 7))))
        ..add(WeightModel(
            value: 62.0, date: selectedDate.subtract(const Duration(days: 14))))
        ..add(WeightModel(
            value: 64.5,
            date: selectedDate.subtract(const Duration(days: 32))));
    });
  }

  @override
  void dispose() {
    super.dispose();
    weightInputController.dispose();
  }

  void addWeight() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      )),
      builder: (context) {
        return Container(
          height: 360,
          width: MediaQuery.of(context).size.width,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Register Weight',
                  style: Styles.titleStyle,
                ),
              ),
              TextField(
                controller: weightInputController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (KG)',
                  border: OutlineInputBorder(
                    borderRadius: Styles.borderRadius,
                  ),
                ),
              ),
              Padding(
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
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return OutlinedButton(
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
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Text(
                                        '${formatDateToString(selectedDate)}'),
                                  ),
                                  Icon(Icons.calendar_today_outlined),
                                ],
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
              Expanded(child: Container()),
              ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      // minimumSize: Size(96, 48),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          weights.insert(
                              0,
                              WeightModel(
                                value: double.parse(weightInputController.text),
                                date: selectedDate,
                              ));
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Register')),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addWeight,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Simple WeightTracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
          left: 8.0,
          top: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeightCard(model: weights.first),
                  WeightCard(model: weights[1], isCurrentWeight: false),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 4.0,
                top: 16.0,
                bottom: 8.0,
              ),
              child: Text(
                'History',
                style: Styles.titleStyle,
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: weights.length - 2,
              itemBuilder: (context, index) {
                final model = weights[index + 2];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text('${model.value} KG'),
                    trailing: Text(
                      '${formatDateToString(model.date)}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
