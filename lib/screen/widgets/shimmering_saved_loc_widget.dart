import 'package:breezly/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringSavedLocWidget extends StatelessWidget {
  const ShimmeringSavedLocWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              width: 160.0,
              decoration: circleRadius(8).copyWith(
                color: Colors.white,
              ),
            ),
          ),
          itemCount: 3,
        ),
      ),
    );
  }
}
