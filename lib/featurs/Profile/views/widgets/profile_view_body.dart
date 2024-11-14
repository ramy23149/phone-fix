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
  String? name, email;
  // String uid = FirebaseAuth.instance.currentUser!.uid;

  getSherdPref() async {
    //  email = await SherdPrefHelper().getUserEmail();
    name = context.read<CustomerDataProvider>().name;
    setState(() {});
  }

  onLoad() async {
    await getSherdPref();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onLoad();
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    if (name == null) {
      return const CustomLoadingIndecator(); // Show loading indicator until data is loaded
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
                  UserInformatoin(
                      icon: const Icon(Icons.person),
                      title: 'Name',
                      subtitle: name!),
                   UserInformatoin(
                      icon: const Icon(Icons.phone),
                      title: 'phone',
                      subtitle:"${context.read<CustomerDataProvider>().phoneNumber}"),
                  UserAction(
                    okBtnText: 'Yes',
                    onCancel: () {},
                    onOk: () {
                      context.push(AppRouter.kAdminView);
                    },
                    dialogTitle: 'Are You Admin ?',
                    title: 'Start as Admin',
                    icon: const Icon(Icons.admin_panel_settings_rounded),
                  ),
                  UserAction(
                    onCancel: () {},
                    title: 'Delete Account',
                    icon: const Icon(Icons.delete),
                    dialogTitle: 'Are You Sure To Delete Your Account ?',
                    okBtnText: 'Delete',
                    onOk: () {
                      DataBaseMethouds().deleteUser();
                      context.go(AppRouter.kSignUpView);
                    },
                  ),
                  UserAction(
                    onCancel: () {},
                    onOk: () {
                      DataBaseMethouds().logOut();
                      context.go(AppRouter.kLogInView);
                    },
                    dialogTitle: 'Are You Sure To Log Out ?',
                    okBtnText: 'Log Out',
                    title: 'Log Out',
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
