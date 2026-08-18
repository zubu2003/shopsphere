import 'package:flutter/material.dart';
import 'package:shopsphere/common/custom_shapes/clipper/custom_round_clipper.dart';

class SRoundedEdgesContainer extends StatelessWidget {
  const SRoundedEdgesContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SCustomClipPath(),
      child: child,
    );
  }
}
