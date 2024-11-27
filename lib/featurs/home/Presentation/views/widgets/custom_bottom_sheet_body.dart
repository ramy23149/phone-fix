import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/store_type_enum.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/product_checkBox.dart';
import 'package:provider/provider.dart';
import '../../../../../Core/widgets/custom_text_feild.dart';
import '../../Manager/providers/change_category_provider.dart';

class FilterBottomsheetBody extends StatefulWidget {
  const FilterBottomsheetBody({super.key});

  @override
  State<FilterBottomsheetBody> createState() => _FilterBottomsheetBodyState();
}

class _FilterBottomsheetBodyState extends State<FilterBottomsheetBody> {
  late ChangeCategoryProvider changeCategoryProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  String hint = "حدد نوع هاتفك";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    changeCategoryProvider = context.read<ChangeCategoryProvider>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    changeCategoryProvider.dropDownColor = kMainAppColor;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 10,
            left: 10,
            right: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Colors.red.shade300)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kMainAppColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<ChangeCategoryProvider>()
                            .hanleFiltieringProcess(
                              minPrice: int.parse(_fromController.text),
                              maxPrice: int.parse(_toController.text),
                                brand: hint, context: context);
                          setState(() {
                            
                          });
                      }
                    },
                    child: const Text(
                      "بحث",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const Text(
                "مجال السعر",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: CustomTextField(
                    onChanged: (_) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.number,
                    hinttext: "الى", // S.of(context).to,
                    textEditingController: _toController,
                    validator: (value) {
                      if (_fromController.text.isNotEmpty &&
                          _isNumeric(value) &&
                          _isNumeric(_fromController.text) &&
                          int.parse(_fromController.text) > int.parse(value!)) {
                        return "from must be less than to";
                      } else if(value == null || value.isEmpty){
                          return "value is required";
                        } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: CustomTextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.number,
                      hinttext: "من", 
                      textEditingController: _fromController,
                      validator: (value) {
                        if (_toController.text.isNotEmpty &&
                            _isNumeric(value) &&
                            _isNumeric(_toController.text) &&
                            int.parse(_toController.text) < int.parse(value!)) {
                          return "from must be less than to";
                        } else if(value == null || value.isEmpty){
                          return "value is required";
                        } else {
                          return null;
                        }
                      },
                    )),
                
              ]),
              const SizedBox(height: 16),
            if(changeCategoryProvider.storeType == StoreTypeEnum.phoneSpareParts)
             Column(
              crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(

                            color: context
                                .watch<ChangeCategoryProvider>()
                                .dropDownColor),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          menuMaxHeight: 150,
                          iconEnabledColor: kMainAppColor,
                          hint: Text(
                            hint,
                            style: const TextStyle(color: Colors.black),
                          ),
                          items: kPhoneTypes
                              .map(
                                  (e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              hint = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "مشكلتك في ايه؟",
                    //  S.of(context).what_did_you_looking_for,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 520,
                      height: 290,
                      child: Row(children: _buildCategoryColumns()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  List<Widget> _buildCategoryColumns() {
    //  if (_categoryEnumValues == null) return [];

    final List<List> chunks = _chunk(kRepairableParts, 6);

    return chunks.map((chunk) {
      return Expanded(
        child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _buildProductsCheckBoxes(chunk),
              ),
            ]),
      );
    }).toList();
  }

  List<List<T>> _chunk<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(
          i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
  }

  List<Widget> _buildProductsCheckBoxes(List categoryEnumValues) {
    return categoryEnumValues
        .map((e) => ProductCheckBox(categoryEnum: e))
        .toList();
  }

  bool _isNumeric(String? str) {
    return str != null && int.tryParse(str) != null;
  }
}
