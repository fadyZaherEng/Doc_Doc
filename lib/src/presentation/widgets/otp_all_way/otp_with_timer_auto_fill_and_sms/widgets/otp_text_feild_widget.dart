import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class CustomOtpFieldWidget extends StatefulWidget {
  final void Function(String value) onOtpChange;
  final void Function() verifyAction;
  final bool error;
  final bool isFilledCode;
  final List<TextEditingController> controllers;

  const CustomOtpFieldWidget({
    Key? key,
    required this.onOtpChange,
    required this.verifyAction,
    required this.error,
    required this.isFilledCode,
    required this.controllers,
  }) : super(key: key);

  @override
  State<CustomOtpFieldWidget> createState() => _CustomOtpFieldWidgetState();
}

class _CustomOtpFieldWidgetState extends State<CustomOtpFieldWidget> {
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(4, (index) => FocusNode());
    for (int i = 0; i < 4; i++) {
      _focusNodes[i].addListener(() {
        setState(() {});
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) => _buildOtpField(index),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in widget.controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpField(int index) {
    if (widget.isFilledCode) {
      widget.onOtpChange(_getOtp());
      _focusNodes[widget.controllers.length - 1].requestFocus();
      setState(() {});
    }
    return Container(
      width: 45,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorSchemes.iconBackGround,
              border: Border.all(
                  color: widget.error == true
                      ? ColorSchemes.redError
                      : Colors.transparent),
              boxShadow: [
                BoxShadow(
                  color: ColorSchemes.black.withOpacity(0.2),
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
          TextField(
            controller: widget.controllers[index],
            focusNode: _focusNodes[index],
            maxLength: 1,
            onChanged: (value) {
              widget.onOtpChange(_getOtp());
              if (value.isNotEmpty) {
                if (index < 4 - 1) {
                  _focusNodes[index + 1].requestFocus();
                } else {
                  _focusNodes[index].unfocus();
                  widget.verifyAction();
                }
              } else {
                if (index > 0) {
                  _focusNodes[index - 1].requestFocus();
                }
              }
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorSchemes.primary),
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: "",
              hintText: "",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(50),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getOtp() {
    return widget.controllers.map((controller) => controller.text).join();
  }
}
