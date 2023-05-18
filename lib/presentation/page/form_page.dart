import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_finance/presentation/assets/color_pallete.dart';

class FormPage extends StatelessWidget {
  final String title;
  FormPage(this.title, {Key? key}) : super(key: key);

  TextEditingController subjectText = TextEditingController();
  FocusNode subjectFocus = FocusNode();

  TextEditingController amountText = TextEditingController();
  FocusNode amountFocus = FocusNode();

  TextEditingController accountBankText = TextEditingController();
  FocusNode accountBankFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimaryDark,
        title: Text(title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: TextField(
              controller: subjectText,
              focusNode: subjectFocus,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                subjectFocus.unfocus();
                FocusScope.of(context).requestFocus(amountFocus);
              },
              decoration: const InputDecoration(
                hintText: 'Insert your subject',
                labelText: 'Subject',
                labelStyle: TextStyle(color: colorPrimary, fontSize: 20),
                hintStyle: TextStyle(color: colorPrimary),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: colorPrimary)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  borderSide: BorderSide(color: colorPrimaryDark),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: TextField(
              controller: amountText,
              focusNode: amountFocus,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                amountFocus.unfocus();
                FocusScope.of(context).requestFocus(accountBankFocus);
              },
              decoration: const InputDecoration(
                hintText: 'Insert your amount',
                labelText: 'Amount',
                labelStyle: TextStyle(color: colorPrimary, fontSize: 20),
                hintStyle: TextStyle(color: colorPrimary),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: colorPrimary)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  borderSide: BorderSide(color: colorPrimaryDark),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: TextField(
              controller: accountBankText,
              focusNode: accountBankFocus,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                accountBankFocus.unfocus();
                insertProcess();
              },
              decoration: const InputDecoration(
                hintText: 'Insert your account bank',
                labelText: 'Account Bank',
                labelStyle: TextStyle(color: colorPrimary, fontSize: 20),
                hintStyle: TextStyle(color: colorPrimary),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: colorPrimary)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  borderSide: BorderSide(color: colorPrimaryDark),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: colorPrimary,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: colorWhite),
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
                onPressed: () => insertProcess(),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18),
                  ),
                )),
          )
        ],
      ),
    );
  }

  void insertProcess() async {
    final CollectionReference _product =
        FirebaseFirestore.instance.collection('task');
    await _product.add({
      'Subject': subjectText.text,
      'Amount': int.parse(amountText.text),
      'AccountBank': accountBankText.text,
      'Status': false
    });
    Get.back();
  }
}
