import 'package:flutter/material.dart';

class SSectionHeading extends StatelessWidget {
  const SSectionHeading({
    super.key, this.textColor, required this.title, this.buttonTitle="view all", this.onPressed,this.actionButton=true
  });

  final Color? textColor;
  final String title, buttonTitle;
  final void Function()? onPressed;
  final bool actionButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),
            maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if(actionButton) TextButton(onPressed: onPressed, child: Text(buttonTitle)),
      ],
    );
  }
}