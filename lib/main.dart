import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohour_asgn_signin/database/helper.dart';
import 'package:prohour_asgn_signin/screen/home.dart';
import 'package:prohour_asgn_signin/screen/input.dart';
import 'package:prohour_asgn_signin/screen/splash.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final number = await DBHelper().getNumber();
  FlutterNativeSplash.remove();

  runApp(
    MyApp(number),
  );
}

class MyApp extends StatelessWidget {
  const MyApp(
    this.number, {
    super.key,
  });
  final String? number;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prohour',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffE99027)),
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black26,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffE99027),
                  width: 0.9,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: number != null ? '/view' : '/input',
      routes: {
        '/input': (context) => InputScreen(),
        '/view': (context) => HomeScreen(
              number: number!,
            ),
      },
    );
  }
}
