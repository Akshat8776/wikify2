
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
  sharedPreferences = await SharedPreferences.getInstance();
  String? theme= sharedPreferences!.getString('theme');
  if(theme==null){

    sharedPreferences!.setString('theme', 'LIGHT');
    globaltheme.value=Themes.LIGHT;
  }else {
    globaltheme.value=theme=="LIGHT"?Themes.LIGHT:Themes.DARK;
  }
  String? languagepref= sharedPreferences!.getString('lang');
  if(languagepref==null){
    sharedPreferences!.setString('lang', 'en');
  }
  else {
    lang.value=languagepref;
  }
  col.value=globaltheme.value==Themes.LIGHT?Colors.white:Colors.black;
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
