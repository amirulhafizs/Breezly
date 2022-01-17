
import 'package:flutter/material.dart';

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/server_error.png'),
            const Text('Opps, seems like you are offline')
          ],
        ),
      )),
    );
  }
}