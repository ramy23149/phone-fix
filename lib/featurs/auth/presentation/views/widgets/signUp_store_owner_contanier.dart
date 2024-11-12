import 'dart:io';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/functions/validate_the_egyption_phone_number.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/store_type_enum.dart';
import 'package:food_delivery_app/featurs/auth/data/models/store_info_model.dart';
import 'package:food_delivery_app/featurs/auth/data/models/verificatoin_data_model.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../Core/widgets/custom_text_feild.dart';
import '../../../data/enums/user_role_enum.dart';
import '../../manager/cubits/ceck_user_existeince_cubit/ceck_user_existeince_cubit.dart';
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
  final TextEditingController passwordController = TextEditingController();
  XFile? storeLogo;
  bool sellsSpareParts = false;
  String hint = 'اختار نوع النشاط';
  StoreTypeEnum? storeType;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickStoreLogo() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      storeLogo = pickedFile;
    });
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    areaController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckUserExisteniceCubit, CheckUserExisteniceState>(
      listener: (context, state) {
        if (state is ThisIsNewUser) {
          context.push(AppRouter.kVerifyView,
              extra: VerificatoinDataModel(
                  data: dartz.Right(StoreInfoModel(
                    password: passwordController.text,
                      storeName: nameController.text,
                      storeAddress: addressController.text,
                      storePhoneNumber: phoneController.text,
                      storeLogoUrl: storeLogo==null?'':storeLogo!.path,
                      storeType: storeType!,)),
                  isForgotPasswordCase: false,
                  phone: phoneController.text,
                  isNew: true));
        }
      },
      child: Material(
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
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                      CustomTextField(
                          textEditingController: passwordController,
                          hinttext: 'كلمة المرور',
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'يجب ادخال كلمة المرور';
                            }else if (value.length < 6) {
                              return 'كلمة المرور يجب ان تكون على الاقل 6 حروف';
                            }
                            return null;
                          },
                        ),
                    const SizedBox(height: 20),
                    DistrictSuggestionField(
                      controller: areaController,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton(
                          hint: Text(hint),
                          items: const [
                            DropdownMenuItem(
                              value: StoreTypeEnum.phoneAccessories,
                              child: Text('اكسسوارات هاتف'),
                            ),
                            DropdownMenuItem(
                              value: StoreTypeEnum.phoneSpareParts,
                              child: Text('قطع غيار الهاتف'),
                            )
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                hint = value.getDisplayName;
                              });
                              storeType = value;
                            }
                          }),
                    ),
                    const SizedBox(height: 40),
                    CustomBotton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()&&storeType!=null) {
                          BlocProvider.of<CheckUserExisteniceCubit>(context)
                              .checkUserExistence(
                            role: UserRoleEnum.storeOwner,
                            phone: phoneController.text,
                          );
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
      ),
    );
  }
}
