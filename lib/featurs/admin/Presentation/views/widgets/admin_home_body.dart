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
  String? selectedSparePart;
  File packedImage = File('');
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  List<AccessoriesEnum> accsessoriesCategories = AccessoriesEnum.values;
  List<SparePartsEnum> sparePartsCategories = SparePartsEnum.values;
  List<String> dynamicItems = [];

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
            brand: widget.isNeedsToAddService == true ? name : null,
            desc: detailsController.text,
            name: nameController.text,
            price: int.parse(priceController.text),
            image: packedImage,
            subCategory: selectedSparePart ?? name!,
            districte: context.read<CustomerDataProvider>().districte!,
          ),
          context,
          isAccessoriesStore: isPhoneAccessoriesStore,
          isNeedToAddService: widget.isNeedsToAddService);
    } else if (widget.isNeedsToAddService == true &&
        selectedSparePart == null) {
      showSnackBar(context, 'حدد نوع الخدمه');
    } else {
      showSnackBar(context,
          name == null ? 'الرجاء تحديد الفئة' : 'الرجاء اختيار الصورة');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddItemsCubit, AddItemsState>(
      listener: (context, state) {
        if (state is AddItemsSuccess) {
          _clearFields();
          showSnackBar(context, 'تمت إضافة العنصر بنجاح');
        } else if (state is AddItemsError) {
          showSnackBar(context, 'حدث خطأ ما، حاول لاحقًا');
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
                        label: 'اسم العنصر',
                        controller: nameController,
                        hint: 'أدخل اسم العنصر',
                      ),
                      const SizedBox(height: 20),
                      AdminTextField(
                        label: 'سعر السلعة',
                        controller: priceController,
                        hint: 'أدخل سعر السلعة',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      AdminTextField(
                        label: 'تفاصيل السلعة',
                        controller: detailsController,
                        hint: 'أدخل تفاصيل العنصر',
                        maxLines: 5,
                      ),
                      const SizedBox(height: 20),
                      DropdownCategory(
                        dynamicItems: dynamicItems,
                        isNeedsToAddService: widget.isNeedsToAddService,
                        isAccessoriesStore: isPhoneAccessoriesStore,
                        selectedValue: name,
                        onChanged: (String? value) {
                          if (value == "شيء اخر") {
                            showTextFieldDialog(context, newCategoryController,
                                () {
                              setState(() {
                                final newValue =
                                    newCategoryController.text.trim();
                                if (newValue.isNotEmpty &&
                                    !dynamicItems.contains(newValue)) {
                                  dynamicItems.add(newValue);
                                  name = newValue; // Update the selected value
                                }
                              });
                              print(name);

                              context.pop(); // Close the dialog
                            }, isPhoneAccessoriesStore);
                          } else {
                            setState(() {
                              name = value;
                            });
                            print(name);
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      if (widget.isNeedsToAddService == true)
                        const Text(
                          ":حدد نوع الخدمه",
                          style: Styles.textStyle18,
                        ),
                      if (widget.isNeedsToAddService == true)
                        SparePartsSelector(
                          onSelect: (value) {
                            selectedSparePart = value;
                          },
                        ),
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
