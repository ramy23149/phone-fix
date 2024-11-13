import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/store_type_enum.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/change_category_provider.dart';
import 'package:provider/provider.dart';

class CustomTypeItem extends StatelessWidget {
  const CustomTypeItem({
    super.key,
    required this.keyIdentefair,
  });

  final int keyIdentefair;
  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeCategoryProvider>(
      builder: (context, provider, child) => InkWell(
        onTap: () {
          provider.selectKey(keyIdentefair);
        },
        child: Container(
          decoration: BoxDecoration(
            color: provider.isSelected(keyIdentefair)
                ? kMainAppColor
                : Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 70,
          width: 70,
          child: Card(
            //  color: isSelected ? kMainAppColor : Colors.white,
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                provider.storeType ==StoreTypeEnum.phoneAccessories?provider.phoneAccessoriesImages[keyIdentefair]:  provider.phoneSparePartsImages[keyIdentefair],
                  height: 60,
                  width: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
