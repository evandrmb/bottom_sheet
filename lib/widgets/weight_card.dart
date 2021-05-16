import 'package:bottom_sheet/functions/format_date_to_string.dart';
import 'package:bottom_sheet/models/weight_model.dart';
import 'package:flutter/material.dart';

class WeightCard extends StatelessWidget {
  final WeightModel model;
  final bool isCurrentWeight;

  const WeightCard({Key? key, required this.model, this.isCurrentWeight = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardSize = size.width * 0.45;
    final weightType = isCurrentWeight ? 'Current' : 'Previous';

    return SizedBox(
      width: cardSize,
      height: cardSize,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$weightType Weight:'),
              Text(
                '${model.value} Kg',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                '${formatDateToString(model.date)}',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
