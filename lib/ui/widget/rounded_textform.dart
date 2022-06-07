import 'package:basic_flutter/mixins/constant/constant.dart';
import 'package:basic_flutter/mixins/style/color.dart';
import 'package:basic_flutter/mixins/style/text.dart';
import 'package:flutter/material.dart';

class RoundedTextForm extends StatelessWidget {
  const RoundedTextForm({Key? key, required this.textEditingController, required this.hint}) : super(key: key);
  final TextEditingController textEditingController;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding/5),
      decoration: BoxDecoration(
        color: kColorWhiteSmoke,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kColorWhite),
      ),
      child: TextFormField(
        controller: textEditingController,
        decoration:  InputDecoration(
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          isDense: true,
          hintStyle: kTextAveRom12,
          hintText: hint,
        ),
      ),
    );
  }
}
