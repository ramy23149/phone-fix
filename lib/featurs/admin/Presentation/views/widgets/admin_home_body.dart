import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/helper/custom_snakBar.dart';

import 'package:food_delivery_app/featurs/admin/Presentation/manager/cubits/Add_Item_cubit/add_items_cubit.dart';
import 'package:food_delivery_app/featurs/admin/Presentation/views/widgets/admin_text_field.dart';
import 'package:food_delivery_app/featurs/admin/data/models/uploaded_product_model.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:food_delivery_app/featurs/home/data/enums/accessories_enum.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../Core/text_styles/Styles.dart';
import '../../../../home/data/enums/spare_parts_enum.dart';
import 'admin_appbar.dart';
import 'custom_image_contaner.dart';

class AdminHomeBody extends StatefulWidget {
  const AdminHomeBody({super.key});

  @override
  State<AdminHomeBody> createState() => _AdminHomeBodyState();
}

class _AdminHomeBodyState extends State<AdminHomeBody> {
  List<AccessoriesEnum> accsessoriesCategories = [
    AccessoriesEnum.covers,
    AccessoriesEnum.headPhone,
    AccessoriesEnum.phoneCharger,
    AccessoriesEnum.somethingElse
  ];
  List<SparePartsEnum> sparePartsCategories = [
    SparePartsEnum.bettary,
    SparePartsEnum.motherBord,
    SparePartsEnum.phoneScreen,
    SparePartsEnum.someThingElse
  ];
  late bool isPhoneAccessoriesStore;
  String? name;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController detalisController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  File packedImage = File('');
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isPhoneAccessoriesStore =
        context.read<AddItemsCubit>().isAccessoriesStore(context);
  }

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
          packedImage = File('');
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
                            name != null && 
                            nameController.text.isNotEmpty &&
                            priceController.text.isNotEmpty &&
                            detalisController.text.isNotEmpty &&
                            packedImage.existsSync()) {
                          BlocProvider.of<AddItemsCubit>(context).addItem(
                            UploadedProductModel(
                              desc: detalisController.text,
                              name: nameController.text,
                              price: priceController.text,
                              image: packedImage,
                              subCategory:  name!,
                              districte: context
                                  .read<CustomerDataProvider>()
                                  .districte!,
                            ),
                            context,
                          );
                        } else if (name == null) {
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
                          icon: const Icon(Icons.arrow_drop_down,
                              size: 30, color: Colors.black),
                          hint: const Text('النوع'), // Placeholder
                          value: name,
                          items: (isPhoneAccessoriesStore
                                  ? accsessoriesCategories
                                  : sparePartsCategories)
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.name,
                                    child: Text(
                                      isPhoneAccessoriesStore
                                          ? (item as AccessoriesEnum)
                                              .getDisplayName // Correctly cast here
                                          : (item as SparePartsEnum)
                                              .displayName, // Correctly cast here
                                      style: Styles.textStyle14,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (selectedValue) {
                            setState(() {
                              name = selectedValue!;
                            });
                          },
                        ),
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
