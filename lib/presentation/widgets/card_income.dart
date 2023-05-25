import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../assets/color_pallete.dart';
import '../common/formatter_string.dart';

class CardIncome extends StatelessWidget {
  final QueryDocumentSnapshot data;
  final bool statusHidden;
  CardIncome(this.data, this.statusHidden, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['Type'],
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorPrimary),
            ),
            const SizedBox(
              height: 5,
            ),
            statusHidden
                ? const Text(
                    "Total IDR *******",
                    style: TextStyle(fontSize: 16),
                  )
                : Text(
                    "Total ${FormatterString.formatterCurrency(data['Nominal'])}",
                    style: const TextStyle(fontSize: 16),
                  ),
          ],
        ),
      ),
    );
  }
}
