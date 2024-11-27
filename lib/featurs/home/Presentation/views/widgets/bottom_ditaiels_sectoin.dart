import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/constats.dart';
import '../../../../../Core/text_styles/Styles.dart';
import '../../../../../Core/widgets/custom_bottom.dart';
import '../../../../auth/data/enums/user_role_enum.dart';
import '../../Manager/cubits/add_to_curt_cubit/add_to_curt_cubit.dart';
import '../../Manager/providers/customer_data_provider.dart';
import 'products_detalis_body.dart';

class BottomDetailesSectoin extends StatelessWidget {
  const BottomDetailesSectoin({
    super.key,
    required this.curantprice,
    required this.widget,
    required this.count,
  });

  final int curantprice;
  final ProductDetalisBody widget;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(':المجموع', style: Styles.textStyle18),
                      Text('$curantprice EGP',
                          style: Styles.textStyle20),
                    ],
                  ),
                ],
              ),
        context.read<CustomerDataProvider>().userRole == UserRoleEnum.user.getDisplayName ?   CustomBotton(
            onPressed: () {
              BlocProvider.of<AddToCurtCubit>(context).addToCurt(
                productModel: widget.productModel,
                count: count,
                totalPrice: curantprice,
                context: context,
              );
            },
            borderRadius: BorderRadius.circular(16),
            textColor: kWhite,
            backgroundColor: kMainAppColor,
            text: 'إضافة إلى العربة 🛒',
          ):const SizedBox() ,
        ],
      ),
    );
  }
}
