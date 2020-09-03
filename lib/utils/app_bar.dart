import 'package:flutter/material.dart';
import 'package:brahimdb/screens/project_tasks.dart';

import 'about.dart';
import 'constants_timer_screen.dart';

AppBarCustmize(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Builder(
        builder: (context) {
          return IconButton(
            icon: Image.asset("assets/icons/menu.png", height: height * 0.015),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      IconButton(
        icon: Image.asset("assets/icons/more.png", height: height * 0.03),
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return BackdropFilter(
                  filter: kBlurFilter,
                  child: aboutBrahim(_),
                );
              });
        },
      ),
    ],
  );
}
