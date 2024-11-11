import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/functions/validate_the_egyption_phone_number.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Core/widgets/custom_text_feild.dart';
import 'district_suggestion_field.dart';

class SignUpStoreOwnerContanier extends StatefulWidget {
  const SignUpStoreOwnerContanier({super.key});

  @override
  State<SignUpStoreOwnerContanier> createState() =>
      _SignUpStoreOwnerContanierState();
}

class _SignUpStoreOwnerContanierState extends State<SignUpStoreOwnerContanier> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  XFile? storeLogo;
  bool sellsSpareParts = false;
  String hint = 'اختار نوع النشاط';

  final ImagePicker _picker = ImagePicker();

  Future<void> pickStoreLogo() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, 
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'بيانات المحل',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: pickStoreLogo,
                    child: storeLogo == null
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10)),
                            height: 100,
                            width: 100,
                            child: const Icon(Icons.add_a_photo),
                          )
                        : Image.file(
                            File(storeLogo!.path),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    textEditingController: nameController,
                    hinttext: 'اسم المحل',
                  ),
                  const SizedBox(height: 20),
                CustomTextField(
                    textEditingController: phoneController,
                    hinttext: 'رقم الهاتف',
                    prefix: const Text(
                      "+20",
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) => validateEgyptianPhoneNumber(value),
                  ),
                  const SizedBox(height: 20),
                  DistrictSuggestionField(
                    controller: areaController,
                  ),
                  const SizedBox(height: 20),
                  DropdownButton(
                      hint: Text(hint),
                      items: const [
                        DropdownMenuItem(
                          value: 'اكسسوارات هاتف',
                          child: Text('اكسسوارات هاتف'),
                        ),
                        DropdownMenuItem(
                          value: 'قطع غيار الهاتف',
                          child: Text('قطع غيار الهاتف'),
                        )
                      ],
                      onChanged: (value) {
                        if(value !=null){
                          setState(() {
                          hint = value;
                        });  
                        }
                      
                      }),
                  const SizedBox(height: 40),
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
                    text: 'تاكيد',
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    borderRadius: BorderRadius.circular(90),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
