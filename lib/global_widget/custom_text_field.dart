import 'package:flutter/material.dart';
import 'package:neways_task/config/font_const.dart';
import 'package:neways_task/const/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final String fieldName;
  final bool isRequired;
  final Function saveButtonEnable;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.fieldName,
    required this.isRequired,
    required this.saveButtonEnable,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            spacing: 2,
            children: [
              Flexible(
                child: Text(
                  widget.fieldName,
                  style: TextStyle(
                    fontSize: TextSize.font14(context),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff5E6579),
                  ),
                ),
              ),
              widget.isRequired == true
                  ? Text('*',
                    style: TextStyle(
                      fontSize: TextSize.font14(context),
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.controller.text.isEmpty
                  ? Colors.grey.shade400
                  : AppColor.baseColor,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            textInputAction: TextInputAction.next,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: 'HindSiliguri',
                fontWeight: FontWeight.bold),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: widget.hintText,
              prefixIcon: Icon(
                widget.icon,
                size: TextSize.font18(context),
                color: widget.controller.text.isEmpty
                    ? Colors.grey.shade400
                    : AppColor.baseColor,
              ),
              hintStyle: TextStyle(
                  fontFamily: 'HindSiliguri',
                  color: Colors.grey.shade400,
                  fontSize: TextSize.font14(context)),
            ),
            onChanged: (value) {
              widget.saveButtonEnable();
              setState(() {});
            },
          ),
        ),
        verticalGap(context, 1),
      ],
    );
  }
}
