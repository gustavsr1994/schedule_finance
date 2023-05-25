import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:schedule_finance/presentation/assets/color_pallete.dart';
import 'presentation/controller/bloc/theme_bloc.dart';
import 'presentation/page/list_task_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primaryColorLight: colorPrimary),
          home: const ListTaskPage()),
    );
  }
}
