import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gia_pha_so/material_with_theme.dart';
import 'package:gia_pha_so/src/presentation/bloc/app_data_bloc.dart';
import 'package:gia_pha_so/src/presentation/bloc/state/app_data_state.dart';
import 'package:gia_pha_so/src/presentation/bloc/theme_bloc.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIA PHẢ SỐ',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AppDataBloc>(create: (_) => AppDataBloc()),
          BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
        ],
        child: const MaterialWithTheme(),
      ),
    );
  }
}
