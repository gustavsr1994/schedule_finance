import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schedule_finance/presentation/assets/color_pallete.dart';
import 'package:schedule_finance/presentation/common/formatter_string.dart';

class CardFinance extends StatelessWidget {
  final QueryDocumentSnapshot data;
  final bool statusHidden;
  const CardFinance(this.data, this.statusHidden, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: data['Status'] ? Colors.blueGrey[500] : colorWhite,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: data['Status'],
              checkColor: colorWhite,
              activeColor: colorPrimary,
              shape: const CircleBorder(side: BorderSide(color: colorPrimary)),
              onChanged: (value) {},
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['Subject'],
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
                        "Total ${FormatterString.formatterCurrency(data['Amount'])}",
                        style: const TextStyle(fontSize: 16),
                      ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data['AccountBank'],
                  style: const TextStyle(fontSize: 18),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
