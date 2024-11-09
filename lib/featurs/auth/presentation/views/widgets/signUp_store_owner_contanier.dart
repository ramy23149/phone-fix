import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Core/widgets/custom_text_feild.dart';

class StoreOwnerContanier extends StatefulWidget {
  const StoreOwnerContanier({super.key});

  @override
  State<StoreOwnerContanier> createState() => _StoreOwnerContanierState();
}

class _StoreOwnerContanierState extends State<StoreOwnerContanier> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  XFile? storeLogo;
  bool sellsSpareParts = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickStoreLogo() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      storeLogo = pickedFile;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(17),
      elevation: 5.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  'Store Information',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                CustomTextField(
                  textEditingController: nameController,
                  hinttext: 'Store Name',
                ),
                const Spacer(),
                CustomTextField(
                  textEditingController: phoneController,
                  hinttext: 'Phone Number',
                  keyboardType: TextInputType.phone,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: pickStoreLogo,
                  child: storeLogo == null
                      ? Container(
                          height: 100,
                          width: 100,
                          color: Colors.grey[200],
                          child: const Icon(Icons.add_a_photo),
                        )
                      : Image.file(
                          File(storeLogo!.path),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                ),
                const Spacer(),
                CustomTextField(
                  textEditingController: addressController,
                  hinttext: 'Address',
                ),
                const Spacer(),
                CustomTextField(
                  textEditingController: areaController,
                  hinttext: 'Area',
                ),
                const Spacer(),
                Row(
                  children: [
                    const Text('Sells Spare Parts'),
                    Switch(
                      value: sellsSpareParts,
                      onChanged: (value) {
                        setState(() {
                          sellsSpareParts = value;
                        });
                      },
                    ),
                  ],
                ),
                const Spacer(flex: 4),
                CustomBotton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle form submission
                      print('Store Name: ${nameController.text}');
                      print('Phone: ${phoneController.text}');
                      print('Address: ${addressController.text}');
                      print('Area: ${areaController.text}');
                      print('Sells Spare Parts: $sellsSpareParts');
                    }
                  },
                  text: 'SUBMIT',
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  borderRadius: BorderRadius.circular(90),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}