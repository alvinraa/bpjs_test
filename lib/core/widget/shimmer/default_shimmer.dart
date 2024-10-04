import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DefaultShimmer extends StatelessWidget {
  final double height;
  final double? width;
  final double? borderRadius;
  final Color? baseColor;
  final Color? higlightColor;

  const DefaultShimmer({
    super.key,
    required this.height,
    this.width,
    this.borderRadius,
    this.baseColor,
    this.higlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade300,
        highlightColor: higlightColor ?? Colors.white,
        child: Container(
          height: height,
          width: width ?? double.infinity,
          // need this color for take the size base.
          color: Colors.white,
        ),
      ),
    );
  }
}
