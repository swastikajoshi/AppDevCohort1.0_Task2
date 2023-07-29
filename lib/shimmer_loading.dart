import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingShimmer() => Shimmer.fromColors(
  baseColor: Colors.grey,
  highlightColor: Colors.grey[400]!,
  period: const Duration(seconds: 1),
  child: Card(
    clipBehavior: Clip.antiAlias,
    color: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 50,
              height: 100,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 250,
                  height: 10,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 80,
                  height: 5,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 150,
                  height: 5,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Center(
            child: Container(
              height: 25,
              width: 25,
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    ),
  ),
);