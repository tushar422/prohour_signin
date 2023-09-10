import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:prohour_asgn_signin/database/helper.dart';
import 'package:prohour_asgn_signin/screen/home.dart';
import 'package:prohour_asgn_signin/widget/phonebox.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({
    super.key,
    this.number,
  });

  final String? number;

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LottieBuilder.asset('asset/time-anim.json'),
              if (MediaQuery.of(context).viewInsets.bottom < 10)
                LottieBuilder.asset(
                  'asset/time-anim2.json',
                ),

              StreamBuilder(
                  stream: Connectivity().onConnectivityChanged,
                  builder: (context, snapshot) {
                    final connection =
                        (snapshot.data == ConnectivityResult.mobile ||
                            snapshot.data == ConnectivityResult.wifi ||
                            snapshot.data == ConnectivityResult.ethernet);

                    return Column(
                      children: [
                        PhoneBox(
                          defaultText: widget.number,
                          onSubmit: (connection)
                              ? (value) {
                                  _updateNumber(value);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          settings: const RouteSettings(
                                              name: '/home'),
                                          builder: (context) {
                                            return HomeScreen(number: value);
                                          }));
                                }
                              : null,
                        ),
                        if (!connection)
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color:
                                  Theme.of(context).colorScheme.errorContainer,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                  'please check your internet connection.'),
                            ),
                          ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _updateNumber(String value) async {
    final helper = DBHelper();
    await helper.updateNumber(value);
  }

  getConnectivity() {
    return Connectivity().onConnectivityChanged.listen((event) {});
  }
}
