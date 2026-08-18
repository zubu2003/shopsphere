import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/widgets/button/sElevatedbutton.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/constant/text_strings.dart';
import 'package:shopsphere/utils/validators/validation.dart';

import '../../controllers/change_name_controller.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(ChangeNameController());
    return Scaffold(
      appBar: SAppBar(
        title: Text("Update Name"),
        showLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: SPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Update your name to keep your profile accurate and personalized",style: Theme.of(context).textTheme.labelMedium,),
              SizedBox(height: SSize.spaceBtwSections,),


              /// Form
              Form(
                key:controller.updateNameFormKey,
                  child:Column(
                    children: [
                      TextFormField(
                        controller :controller.firstName ,
                        validator: (value)=> SValidator.validateEmptyText('Firstname', value),
                        decoration: InputDecoration(
                          labelText: STexts.firstName,
                          prefixIcon: Icon(Icons.person)
                        ),
                      ),

                      SizedBox(height: SSize.spaceBtwItems,),

                      TextFormField(
                        controller: controller.lastName,
                        validator: (value)=> SValidator.validateEmptyText('Lastname', value),
                        decoration: InputDecoration(
                            labelText: STexts.lastName,
                            prefixIcon: Icon(Icons.person)
                        ),
                      ),

                    ],
                  )
              ),
              SizedBox(height: SSize.spaceBtwSections,),

              //save button
              SElevatedButton(onPressed: controller.updateUserName, child: Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
