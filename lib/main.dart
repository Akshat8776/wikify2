
import 'package:blocimplement/cubits/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'global/global.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'enums/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cacheDirectory = (await getTemporaryDirectory()).path;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return BlocProvider<LoadingCubit>(
      lazy: false,
      create: (context) => LoadingCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyCustomSplashScreen(),

      ),
    );
  }
}
