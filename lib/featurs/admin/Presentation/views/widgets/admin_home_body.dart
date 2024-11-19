import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/admin/Presentation/views/widgets/drop_down_category.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:food_delivery_app/Core/helper/custom_snakBar.dart';
import 'package:food_delivery_app/featurs/admin/Presentation/manager/cubits/Add_Item_cubit/add_items_cubit.dart';
import 'package:food_delivery_app/featurs/admin/data/models/uploaded_product_model.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:food_delivery_app/featurs/home/data/enums/accessories_enum.dart';
import 'package:food_delivery_app/featurs/home/data/enums/spare_parts_enum.dart';

import '../../../../../Core/text_styles/Styles.dart';
import '../../../helper/dialog_with_text_field.dart';
import 'admin_appbar.dart';
import 'admin_text_field.dart';
import 'custom_image_contaner.dart';
import 'spare_part_type_radio.dart';

class AdminHomeBody extends StatefulWidget {
  const AdminHomeBody({super.key, this.isNeedsToAddService});
  final bool? isNeedsToAddService;
  @override
  State<AdminHomeBody> createState() => _AdminHomeBodyState();
}

class _AdminHomeBodyState extends State<AdminHomeBody> {
  late bool isPhoneAccessoriesStore;
  String? name;
  File packedImage = File('');
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  List<AccessoriesEnum> accsessoriesCategories = AccessoriesEnum.values;
  List<SparePartsEnum> sparePartsCategories = SparePartsEnum.values;

  @override
  void initState() {
    super.initState();
    isPhoneAccessoriesStore =
        context.read<AddItemsCubit>().isAccessoriesStore(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context) {
    if (key.currentState!.validate() &&
        name != null &&
        packedImage.existsSync() &&
        nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        detailsController.text.isNotEmpty) {
      context.read<AddItemsCubit>().addItem(
            UploadedProductModel(
              desc: detailsController.text,
              name: nameController.text,
              price: int.parse(priceController.text),
              image: packedImage,
              subCategory: name!,
              districte: context.read<CustomerDataProvider>().districte!,
            ),
            context,
          );
    } else {
      showSnackBar(context,
          name == null ? 'Please select category' : 'Please select image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddItemsCubit, AddItemsState>(
      listener: (context, state) {
        if (state is AddItemsSuccess) {
          _clearFields();
          showSnackBar(context, 'Item added successfully');
        } else if (state is AddItemsError) {
          showSnackBar(context, 'Something went wrong, try later');
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AddItemsLoading,
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AdminAppbar(onPressed: () => _onSubmit(context)),
                      const SizedBox(height: 20),
                      ImageContaner(
                          onImageSelected: (File image) => packedImage = image),
                      const SizedBox(height: 20),
                      AdminTextField(
                        label: 'Item Name',
                        controller: nameController,
                        hint: 'Enter Item Name',
                      ),
                      const SizedBox(height: 20),
                      AdminTextField(
                        label: 'Item Price',
                        controller: priceController,
                        hint: 'Enter Item Price',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      AdminTextField(
                        label: 'Item Details',
                        controller: detailsController,
                        hint: 'Enter Item Details',
                        maxLines: 5,
                      ),
                      const SizedBox(height: 20),
                      DropdownCategory(
                        isNeedsToAddService: widget.isNeedsToAddService,
                        isAccessoriesStore: isPhoneAccessoriesStore,
                        selectedValue: name,
                        onChanged: (String? value) {
                          if (value == AccessoriesEnum.somethingElse.name ||
                              value == SparePartsEnum.someThingElse.name) {
                            showTextFieldDialog(context, newCategoryController,
                                () {
                              setState(() {
                                name = newCategoryController.text;
                              });
                              context.pop(); //close dialog
                            }, key);
                          } else {
                            setState(() {
                              name = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      if(widget.isNeedsToAddService!)
                      const Text(
                        ":حدد نوع الخدمه",
                        style: Styles.textStyle18,
                      ),
                      if (!isPhoneAccessoriesStore && widget.isNeedsToAddService!) SparePartsSelector(),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }

  void _clearFields() {
    nameController.clear();
    priceController.clear();
    detailsController.clear();
    packedImage = File('');
  }
}
