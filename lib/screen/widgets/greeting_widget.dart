import 'package:breezly/helpers/function.dart';
import 'package:breezly/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good ${greeting()}', style: mediumBoldFont()),
            Text(DateFormat('EE dd MMM ').format(DateTime.now()), style: smallBoldFont().copyWith(color: Colors.grey[500]),)
          ],
        ),
      );
  }
}    