import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionsSelect extends StatefulWidget {
  int initValue;
  Function(int) onChange;
  SessionsSelect({this.initValue = 0, this.onChange});

  @override
  State<SessionsSelect> createState() => _SessionsSelectState();
}

class _SessionsSelectState extends State<SessionsSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white54),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          plusMinus(Icons.add),
          SizedBox(width: Get.width * 0.05),
          Text(widget.initValue.toString()),
          SizedBox(width: Get.width * 0.05),
          plusMinus(Icons.remove),
        ],
      ),
    );
  }

  Widget plusMinus(IconData icon) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        if (icon == Icons.add)
          widget.initValue++;
        else if (widget.initValue > 1) widget.initValue--;
        setState(() {});
        widget.onChange(widget.initValue);
      },
    );
  }
}
