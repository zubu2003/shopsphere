import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/widgets/button/sElevatedbutton.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/validators/validation.dart';

import '../../controllers/address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(AddressController());

    return Scaffold(
      appBar: SAppBar(
        showLeading: true,
        title: Text("Add New Address",style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child:Padding(
            padding:SPadding.screenPadding,
          child: Form(
            key: controller.addressFormkey,
            child: Column(
              children: [
                //name
                TextFormField(
                  controller: controller.name,
                  validator: (value)=>SValidator.validateEmptyText("Name", value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: "Name"
                  ),
                ),
                SizedBox(height: SSize.spaceBtwItems,),
                //phone number
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value)=>SValidator.validatePhoneNumber(value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: "Phone Number"
                  ),
                ),
                SizedBox(height: SSize.spaceBtwItems,),

                //street ,postal code
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value)=>SValidator.validateEmptyText("Street", value),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.building_31),
                            labelText: "Street"
                        ),
                      ),
                    ),
                    SizedBox(width: SSize.spaceBtwInputFields,),
                    //phone number
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value)=>SValidator.validateEmptyText("Post code", value),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.code),
                            labelText: "Post code"
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SSize.spaceBtwItems,),

                //city state
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value)=>SValidator.validateEmptyText("City", value),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.buildings_2),
                            labelText: "City"
                        ),
                      ),
                    ),
                    SizedBox(width: SSize.spaceBtwInputFields,),
                    //phone number
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value)=>SValidator.validateEmptyText("State", value),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.activity),
                            labelText: "State"
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SSize.spaceBtwItems,),

                //country
                TextFormField(
                  controller: controller.country,
                  validator: (value)=>SValidator.validateEmptyText("Country", value),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.global),
                      labelText: "Country"
                  ),
                ),
                SizedBox(height: SSize.spaceBtwItems,),

                //save button
                SElevatedButton(onPressed:  controller.addNewAddress, child: Text("Save"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
