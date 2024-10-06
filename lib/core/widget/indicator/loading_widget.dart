import 'package:bpjs_test/core/widget/indicator/three_bouncher_loading.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  final EdgeInsets padding;
  final double size;
  const LoadingWidget({
    super.key,
    this.padding = const EdgeInsets.only(top: 30, bottom: 30),
    this.size = 18,
  });

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Center(
        child: ThreeBounceLoading(
          size: widget.size,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
