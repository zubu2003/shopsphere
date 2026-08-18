import 'package:flutter/material.dart';

import '../../utils/helper/helper_functions.dart';
import '../custom_shapes/circular_shape.dart';

class SChoiceChip extends StatelessWidget {
  const SChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onSelected,
  });

  final String text;
  final bool selected;
  final Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    bool isColor = SHelperFunctions.getColor(text) != null;
    return ChoiceChip(
      label:isColor? SizedBox(): Text(text),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(
        color: selected? Colors.white: null,
      ),
      shape: isColor? CircleBorder(): null,
      padding: isColor ? EdgeInsets.zero : null,
      labelPadding: isColor ? EdgeInsets.zero : null,
      avatar: isColor ? SCircularShape(width: 50.0, height: 50.0, backgroundColor:SHelperFunctions.getColor(text)! ): null,
          backgroundColor: isColor ? SHelperFunctions.getColor(text) : null,
    );
  }
}
