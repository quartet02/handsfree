import 'package:flutter/material.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';

String? _selected;

class CustomDropDown extends StatefulWidget {
  const CustomDropDown(
      this.items,
      this.hintText, {
        Key? key,
        this.action,
        this.inputType,
        this.maxLine = 1,
        this.margins = const EdgeInsets.all(0),
        this.paddings = const EdgeInsets.symmetric(horizontal: 20.0),
        this.radius = 25,
        this.width = 200,
      }) : super(key: key);

  final List items;
  final EdgeInsets margins;
  final EdgeInsets paddings;
  final double radius;
  final double width;
  final TextInputAction? action;
  final TextInputType? inputType;
  final int? maxLine;
  final Widget hintText;

  String? get getSelected{
    return _selected;
  }
  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: widget.margins,
      padding: widget.paddings,
      decoration: BoxDecoration(
          color: Colors.transparent,
          image: const DecorationImage(
            image: AssetImage('assets/image/text_field.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: const [
            BoxShadow(
              color: kTextShadow,
              offset: Offset(6, 6),
              blurRadius: 6,
            ),
          ]),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: widget.hintText,
          value: _selected,
          items: widget.items
              .map(((e) => DropdownMenuItem<String>(
            child: buildText.textBox(e as String, 0.5, 14,
                FontWeight.w400, TextAlign.start, kText),
            value: e,
          )))
              .toList(),
          onChanged: (val) {
            setState(() {
              _selected = val;
            });
          },
          isExpanded: true,
        ),
      ),
    );
  }
}