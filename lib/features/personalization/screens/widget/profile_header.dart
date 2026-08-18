import 'package:flutter/material.dart';

import '../../../../common/custom_shapes/primary_header.dart';
import '../../../../common/images/user_logo.dart';
import '../../../../utils/constant/size.dart';

class SProfileHeader extends StatelessWidget {
  const SProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: SSize.profilePrimaryHeaderHeight+60,),

        SHomePrimaryHeader(
          height: SSize.profilePrimaryHeaderHeight,
          child: Container(),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Center(
            child: SUserProfileLogo(),
          ),
        )

      ],
    );
  }
}






