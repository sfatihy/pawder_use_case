import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawder_use_case/HomeCubit.dart';
import 'package:pawder_use_case/HomeProvider.dart';
import 'package:pawder_use_case/ListCardView.dart';
import 'package:pawder_use_case/homeView.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      home: ListCardView(),
    );
  }
}
