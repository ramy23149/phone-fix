import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/servers/data_base_methouds.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/Profile/views/widgets/curved_contaner.dart';
import 'package:food_delivery_app/featurs/Profile/views/widgets/user_image.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'custom_listile.dart';
import 'user_action.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  String? name, role;

  // String uid = FirebaseAuth.instance.currentUser!.uid;

  getSherdPref() {
    name = context.read<CustomerDataProvider>().name;
    role = context.read<CustomerDataProvider>().userRole;
  }

  @override
  void initState() {
    super.initState();
    getSherdPref();
  }

  @override
  Widget build(BuildContext context) {
    if (name == null) {
      return const CustomLoadingIndecator();
    }

    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              const CurvedContaner(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.2 - 90,
              ),
              Column(
                children: [
                    role == 'صاحب محل'
                      ? const UserAction(
                        goToAdminView: true,
                          title: 'لوحه التحكم',
                          icon: Icon(Icons.admin_panel_settings_rounded),
                        )
                      : const SizedBox(),
                  UserInformatoin(
                      icon: const Icon(Icons.person),
                      title: 'الاسم',
                      subtitle: name!),
                  UserInformatoin(
                      icon: const Icon(Icons.phone),
                      title: 'رقم الجوال',
                      subtitle:
                          "${context.read<CustomerDataProvider>().phoneNumber}"),
                
                  UserAction(
                    title: 'حذف الحساب',
                    icon: const Icon(Icons.delete),
                    dialogTitle: 'هل انت متاكد من حذف حسابك؟',
                    okBtnText: 'حذف',
                    onOk: () {
                      DataBaseMethouds().deleteUser();
                      context.go(AppRouter.kSignUpView);
                    },
                  ),
                  UserAction(
                    onOk: () {
                      DataBaseMethouds().logOut();
                      context.go(AppRouter.kLogInView);
                    },
                    dialogTitle: 'هل انت متاكد من تسجيل الخروج؟',
                    okBtnText: 'تسجيل الخروج',
                    title: 'تسجيل الخروج',
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              right: 0,
              left: 0,
              top: MediaQuery.of(context).size.height / 4.2 - 60,
              child: const UserImage()),
          Positioned(
            right: 0,
            left: 0,
            top: MediaQuery.of(context).size.height * 0.053,
            child: Center(
              child: Text(
                name!,
                style: Styles.textStyle20Extra.copyWith(color: kWhite),
              ),
            ),
          )
        ],
      ),
    );
  }
}
