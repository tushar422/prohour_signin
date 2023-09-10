import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneBox extends StatefulWidget {
  const PhoneBox({
    super.key,
    this.defaultText,
    required this.onSubmit,
  });
  final String? defaultText;
  final void Function(String)? onSubmit;

  @override
  State<PhoneBox> createState() => _PhoneBoxState();
}

class _PhoneBoxState extends State<PhoneBox> {
  final _phoneController = TextEditingController();
  final _disabledButtonColor = const [
    Color.fromARGB(255, 124, 83, 1),
    Color.fromARGB(255, 68, 41, 10),
  ];
  final _enabledButtonColor = const [
    Color.fromARGB(255, 250, 157, 16),
    Color.fromARGB(255, 255, 91, 1),
  ];
  bool _isButtonEnabled = false;

  @override
  void initState() {
    if (widget.defaultText != null) {
      _phoneController.text = widget.defaultText!;
      _isButtonEnabled = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.25,
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
            child: Column(
              children: [
                const Text('enter your 10 digit phone no.'),
                const SizedBox(height: 15),
                TextField(
                  controller: _phoneController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLength: 10,
                  onChanged: _changeButtonState,
                  decoration: InputDecoration(
                    hintText: 'phone number',
                    counter: Container(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 50,
            right: 50,
            // left: 0,
            // right: 0,
            child: GestureDetector(
              onTap: (_isButtonEnabled && widget.onSubmit != null)
                  ? () {
                      widget.onSubmit!(_phoneController.text);
                    }
                  : null,
              child: Container(
                height: 80,
                width: 100,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, -1.00),
                    end: const Alignment(0, 1),
                    colors: (_isButtonEnabled && widget.onSubmit != null)
                        ? _enabledButtonColor
                        : _disabledButtonColor,
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
                child: Center(
                  child: Text(
                    'submit',
                    style: TextStyle(
                      color: (_isButtonEnabled && widget.onSubmit != null)
                          ? Colors.white
                          : Colors.white38,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeButtonState(String value) {
    if (value.length == 10) {
      setState(() {
        _isButtonEnabled = true;
      });
    } else if (_isButtonEnabled == true) {
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
