import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/store_type_enum.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/change_category_provider.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/home_view_body.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  late ChangeCategoryProvider changeCategoryProvider;
  @override
  void initState() {
    super.initState();
  //  context.read<CustomerDataProvider>().fetchCustomerData();

    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _onTabChanged(_tabController.index);
      }
    });
  }

  void _onTabChanged(int index) {
    context.read<ChangeCategoryProvider>().changeCategorys(index);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    changeCategoryProvider = context.read<ChangeCategoryProvider>();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    changeCategoryProvider.selectedKey = 0;
    changeCategoryProvider.selectedSparePartsSubCategorys.clear();
    changeCategoryProvider.storeType = StoreTypeEnum.phoneAccessories;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerDataProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Image.asset(
              kAppLogo2,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value.name != null ? '${value.name} مرحبا' : 'جاري التحميل...',
              style: Styles.textStyle20,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.push(AppRouter.kSearchView);
                },
                icon: const Icon(Icons.search)),
          ],
          bottom: TabBar(
            indicatorColor: kMainAppColor,
            labelColor: kMainAppColor,
            dividerColor: kMainAppColor,
            controller: _tabController,
            onTap: (index) {
              _onTabChanged(index);
            },
            tabs: [
              Text(StoreTypeEnum.phoneAccessories.getDisplayName),
              Text(StoreTypeEnum.phoneSpareParts.getDisplayName),
            ],
          ),
          toolbarHeight: 60,
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            _tabController.animateTo(index);
          },
          children: const [
            HomeViewBody(storeType: StoreTypeEnum.phoneAccessories),
            HomeViewBody(storeType: StoreTypeEnum.phoneSpareParts),
          ],
        ),
      ),
    );
  }
}
