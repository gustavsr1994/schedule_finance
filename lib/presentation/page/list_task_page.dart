import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schedule_finance/presentation/assets/color_pallete.dart';

class ListTaskPage extends StatefulWidget {
  const ListTaskPage({Key? key}) : super(key: key);

  @override
  State<ListTaskPage> createState() => _ListTaskPageState();
}

class _ListTaskPageState extends State<ListTaskPage> {
  // snapshot.data!.docs
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference listFinance = firestore.collection('task');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text('Schedule My Finance'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                child: Card(
                  color: colorPrimary,
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '6 May 2023',
                          style: TextStyle(color: colorWhite, fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Complete : 0 / XX}",
                          style: TextStyle(color: colorWhite, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () => null,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: colorPrimaryDark),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Create New Finance',
                            style: TextStyle(color: colorPrimary, fontSize: 18),
                          ),
                          Icon(
                            Icons.add,
                            color: colorPrimary,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: listFinance.snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            cardFinance(snapshot.data!.docs[index]));
                  } else {
                    return Text("${snapshot.error}");
                  }
                }),
          )
        ],
      ),
    );
  }

  Card cardFinance(QueryDocumentSnapshot data) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: data['Status'],
              checkColor: colorWhite,
              activeColor: colorPrimary,
              shape: CircleBorder(side: BorderSide(color: colorPrimary)),
              onChanged: (value) {},
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['Subject']),
                SizedBox(
                  height: 5,
                ),
                Text("Total ${data['Amount']}"),
                SizedBox(
                  height: 5,
                ),
                Text(data['AccountBank'])
              ],
            )
          ],
        ),
      ),
    );
  }
}
