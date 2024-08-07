import 'package:brahimdb/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:brahimdb/screens/home_screen.dart';

import 'about.dart';

AppBarCustmize(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Builder(
          builder: (context) {
            return IconButton(
              icon: Image.asset("assets/icons/menu.png", height: width * 0.03),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        IconButton(
          icon: Image.asset("assets/icons/more.png", height: width * 0.05),
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
    ),
  );
}
