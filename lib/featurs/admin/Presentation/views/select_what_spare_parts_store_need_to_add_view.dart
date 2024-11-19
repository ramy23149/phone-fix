import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../Core/constats.dart';
import '../../../../Core/text_styles/Styles.dart';
import 'widgets/select_what_spare_parts_store_need_to_add_contanier.dart';

class SelectWhatSparePartsStoreNeedToAddView extends StatelessWidget {
  const SelectWhatSparePartsStoreNeedToAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              kAppLogo,
              height: 50,
            ),
          ),
        ],
        title: const Text(
          'ماذا تريد ان تضيف؟',
          style: Styles.textStyle18,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [kMainAppColor, Colors.red],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child:  const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SelectWhatSparePartsStoreNeedToAdd(
              lable: "اضافه خدمه",
              isNeedsToAddService: true,
              icon: Symbols.settings_account_box,
            ),
             SelectWhatSparePartsStoreNeedToAdd(
              lable: "اضافه منتج",
              isNeedsToAddService: false,
              icon: Symbols.shopping_cart_checkout,
            ),
          
          ],
        ),
      ),
    );
  }
}
