import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_finance/presentation/assets/color_pallete.dart';
import 'package:schedule_finance/presentation/common/formatter_string.dart';
import 'package:schedule_finance/presentation/controller/bloc/theme_bloc.dart';
import 'package:schedule_finance/presentation/page/form_page.dart';
import 'package:schedule_finance/presentation/widgets/card_finance.dart';
import 'package:schedule_finance/presentation/widgets/card_income.dart';

class ListTaskPage extends StatefulWidget {
  const ListTaskPage({Key? key}) : super(key: key);

  @override
  State<ListTaskPage> createState() => _ListTaskPageState();
}

class _ListTaskPageState extends State<ListTaskPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<ThemeBloc>()
        .add(InitialPage(statusHidden: true, statusThemeDark: false));
    // getIncome();
  }

  // void getIncome() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   CollectionReference listFinance = firestore.collection('task');
  //   var item = await listFinance.get();
  //   print(item.docs.length);
  // }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference listFinance = firestore.collection('task');

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: state is ThemeSuccess
                ? state.statusThemeDark
                    ? colorWhite
                    : colorPrimary
                : colorPrimary,
            title: Text('Schedule My Finance',
                style: TextStyle(
                  color: state is ThemeSuccess
                      ? state.statusThemeDark
                          ? colorPrimary
                          : colorWhite
                      : colorWhite,
                )),
          ),
          body: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Container(
                color: state is ThemeSuccess
                    ? state.statusThemeDark
                        ? colorPrimary
                        : colorWhite
                    : colorWhite,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            color: colorPrimary,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: state is ThemeSuccess
                                      ? state.statusThemeDark
                                          ? colorWhite
                                          : colorPrimary
                                      : colorPrimary,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '6 May 2023',
                                    style: TextStyle(
                                        color: colorWhite, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: listFinance.snapshots(),
                                      builder: (_, snapshot) {
                                        if (snapshot.hasData) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Complete : ${snapshot.data!.docs.where((element) => element['Status'] == true).length} / ${snapshot.data!.docs.length}",
                                                style: const TextStyle(
                                                    color: colorWhite,
                                                    fontSize: 20),
                                              ),
                                              state is ThemeSuccess
                                                  ? state.statusHidden
                                                      ? const Text(
                                                          "Total : IDR ***",
                                                          style: TextStyle(
                                                              color: colorWhite,
                                                              fontSize: 20))
                                                      : Text(
                                                          "Total : ${FormatterString.formatterCurrency(snapshot.data!.docs.map((element) => element['Amount']).reduce((value, element) => value + element))}",
                                                          style: const TextStyle(
                                                              color: colorWhite,
                                                              fontSize: 20),
                                                        )
                                                  : const Text(
                                                      "Total : IDR xxx",
                                                      style: TextStyle(
                                                          color: colorWhite,
                                                          fontSize: 20),
                                                    )
                                            ],
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      })
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
                            onTap: () => Get.to(FormPage('Insert')),
                            child: Card(
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: colorPrimaryDark),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Create New Finance',
                                      style: TextStyle(
                                          color: colorPrimary, fontSize: 18),
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
                    BlocBuilder<ThemeBloc, ThemeState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                                side: BorderSide(color: colorPrimaryDark),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Hide Data",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: colorPrimaryDark,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.visibility,
                                                color: state is ThemeSuccess
                                                    ? state.statusHidden
                                                        ? colorGray
                                                        : colorPrimaryDark
                                                    : colorGray),
                                            Switch(
                                              value: state is ThemeSuccess
                                                  ? state.statusHidden
                                                  : true,
                                              activeColor: colorPrimary,
                                              inactiveTrackColor: colorGray,
                                              onChanged: (value) => context
                                                  .read<ThemeBloc>()
                                                  .add(ChangeHiddenValue(
                                                    statusHidden:
                                                        state is ThemeSuccess
                                                            ? state.statusHidden
                                                            : true,
                                                    statusThemeDark: state
                                                            is ThemeSuccess
                                                        ? state.statusThemeDark
                                                        : false,
                                                  )),
                                            ),
                                            Icon(Icons.visibility_off,
                                                color: state is ThemeSuccess
                                                    ? state.statusHidden
                                                        ? colorPrimaryDark
                                                        : colorGray
                                                    : colorGray),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Dark Mode",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: colorPrimaryDark,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.sunny,
                                                color: state is ThemeSuccess
                                                    ? state.statusThemeDark
                                                        ? colorGray
                                                        : colorPrimaryDark
                                                    : colorGray),
                                            Switch(
                                              value: state is ThemeSuccess
                                                  ? state.statusThemeDark
                                                  : true,
                                              activeColor: colorPrimary,
                                              inactiveTrackColor: colorGray,
                                              onChanged: (value) => context
                                                  .read<ThemeBloc>()
                                                  .add(ChangeThemeDarkValue(
                                                    statusHidden:
                                                        state is ThemeSuccess
                                                            ? state.statusHidden
                                                            : true,
                                                    statusThemeDark: state
                                                            is ThemeSuccess
                                                        ? state.statusThemeDark
                                                        : false,
                                                  )),
                                            ),
                                            Icon(Icons.nightlight,
                                                color: state is ThemeSuccess
                                                    ? state.statusThemeDark
                                                        ? colorPrimaryDark
                                                        : colorGray
                                                    : colorGray),
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: BlocBuilder<ThemeBloc, ThemeState>(
                    //     builder: (context, state) {
                    //       return StreamBuilder<QuerySnapshot>(
                    //           stream: listIncome.snapshots(),
                    //           builder: (_, snapshot) {
                    //             if (snapshot.hasData) {
                    //               return ListView.builder(
                    //                   itemCount: snapshot.data!.docs.length,
                    //                   shrinkWrap: true,
                    //                   itemBuilder: (context, index) =>
                    //                       CardIncome(
                    //                           snapshot.data!.docs[index],
                    //                           state is ThemeSuccess
                    //                               ? state.statusHidden
                    //                               : true));
                    //             } else {
                    //               return Text("${snapshot.error}");
                    //             }
                    //           });
                    //     },
                    //   ),
                    // ),
                    Expanded(
                      flex: 2,
                      child: BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          return StreamBuilder<QuerySnapshot>(
                              stream: listFinance.snapshots(),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          CardFinance(
                                              snapshot.data!.docs[index],
                                              state is ThemeSuccess
                                                  ? state.statusHidden
                                                  : true));
                                } else {
                                  return Text("${snapshot.error}");
                                }
                              });
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
