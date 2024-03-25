import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/helper/custom_snakBar.dart';

import 'package:food_delivery_app/featurs/admin/Presentation/manager/cubits/Add_Item_cubit/add_items_cubit.dart';
import 'package:food_delivery_app/featurs/admin/Presentation/views/widgets/admin_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../Core/text_styles/Styles.dart';
import 'admin_appbar.dart';
import 'custom_image_contaner.dart';

class AdminHomeBody extends StatefulWidget {
  const AdminHomeBody({super.key});

  @override
  State<AdminHomeBody> createState() => _AdminHomeBodyState();
}

class _AdminHomeBodyState extends State<AdminHomeBody> {
  String? value;
  List<String> items = ['pizza', 'ice_cream', 'Burger', 'Salad'];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController detalisController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  File packedImage = File('');
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    priceController.dispose();
    detalisController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddItemsCubit, AddItemsState>(
      listener: (context, state) {
        if (state is AddItemsSuccess) {
          nameController.clear();
          priceController.clear();
          detalisController.clear();
          packedImage = File(''); //3ayz lama select image el sora t5tafy===================
          showSnackBar(context, 'Item added successfully');
        } else if (state is AddItemsError) {
          showSnackBar(context, 'something went wrong,try later');
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AddItemsLoading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdminAppbar(
                      onPressed: () {
                        if (key.currentState!.validate() &&
                            value != null &&
                            nameController.text != '' &&
                            priceController.text != '' &&
                            detalisController.text != '' &&
                            packedImage != null &&
                            packedImage!.existsSync()) {
                          BlocProvider.of<AddItemsCubit>(context).addItem(
                              packedImage,
                              nameController.text,
                              priceController.text,
                              detalisController.text,
                              value!);
                        } else if (value == null) {
                          showSnackBar(context, 'Please select category');
                        } else {
                          showSnackBar(context, 'Please select image');
                        }
                      },
                    ),
                    const Text(
                      'Upload the Item picture',
                      style: Styles.textStyle18,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ImageContaner(
                      onImageSelected: (File image) {
                        packedImage = image;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Item Name',
                      style: Styles.textStyle18,
                    ),
                    AdminTextField(
                      controller: nameController,
                      hint: 'Enter Item Name',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Item Price',
                      style: Styles.textStyle18,
                    ),
                    AdminTextField(
                      controller: priceController,
                      hint: 'Enter Item Price',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Item Details',
                      style: Styles.textStyle18,
                    ),
                    AdminTextField(
                      controller: detalisController,
                      hint: 'Enter Item Details',
                      maxlines: 5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Select Category',
                      style: Styles.textStyle18,
                    ),
                    Container(
                      color: const Color(0xffE8E8F7),
                      width: double.infinity,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            isExpanded: true,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 30,
                              color: Colors.black,
                            ),
                            hint: const Text('Category'),
                            value: value,
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: Styles.textStyle14,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) => setState(() {
                                  this.value = value;
                                })),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
