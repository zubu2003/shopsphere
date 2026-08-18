import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/features/personalization/screens/edit_profile/widgets/profile_with_edit_icon.dart';
import 'package:shopsphere/utils/constant/size.dart';

import '../../controllers/user_controller.dart';
import '../change_name/change_name.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=UserController.instance;

    return Scaffold(
      appBar: SAppBar(
        title: Text("Edit Profile",style: Theme.of(context).textTheme.labelMedium,),
        showLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSize.defaultSpace),
          child: Column(
            children: [
              //profil and icon
              SUserProfileWithEditIcon(),
              SizedBox(height: SSize.spaceBtwSections,),

              //account settings modifying
              Divider(),
              SSectionHeading(title: "Account Settings"),
              SUserDetailRow(title: 'Name', value: controller.user.value.fullName, onTap: () => Get.to(()=> ChangeNameScreen()),),
              SUserDetailRow(title: 'Username', value: controller.user.value.username, onTap: () {  },),
              SizedBox(height: SSize.spaceBtwSections,),

              //profile setting
              Divider(),
              SSectionHeading(title: "Profile Settings",actionButton: false,),
              SUserDetailRow(title: "User id", value: controller.user.value.id, onTap: () {  },),
              SUserDetailRow(title: "Email", value: controller.user.value.email, onTap: () {  },),
              SUserDetailRow(title: "Phone", value: controller.user.value.phoneNumber, onTap: () {  },),
              SizedBox(height: SSize.spaceBtwItems),

              /// Divider
              Divider(),
              SizedBox(height: SSize.spaceBtwItems),

              TextButton(onPressed: controller.deleteAccountPopoup, child: Text('Close Account', style: TextStyle(color: Colors.red),)),

            ],
          ),
        ),
      ),
    );
  }
}

class SUserDetailRow extends StatelessWidget {
  const SUserDetailRow({
    super.key, required this.title, required this.value,
    this.icon=Iconsax.arrow_right_34, required this.onTap,
  });
  final String title,value;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(SSize.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(flex:3,child: Text(title, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis)),
            Expanded(flex:5,child: Text(value, style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow. ellipsis)),
            Expanded(child: Icon(icon, size: SSize.iconSm))
          ],
        ),
      ),
    );
  }
}




