import 'package:flutter/material.dart';
import 'package:prohour_asgn_signin/screen/input.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.number,
  });

  final String number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 0),
            child: Image.asset('asset/banner.jpg'),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            padding: const EdgeInsets.all(50),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text(
                  'your saved number:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  enabled: false,

                  // enabled: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),

                    hintText: number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    // hintText: _number,
                  ),
                ),
                const SizedBox(height: 80),
                GestureDetector(
                  onTap: () {
                    _changeNumber(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 30,
                    ),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      gradient: const LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [
                          Color.fromARGB(255, 250, 157, 16),
                          Color.fromARGB(255, 255, 91, 1),
                        ],
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: const Text(
                      'update / change',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void _changeNumber(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return InputScreen(
        number: number,
      );
    }));
  }
}
