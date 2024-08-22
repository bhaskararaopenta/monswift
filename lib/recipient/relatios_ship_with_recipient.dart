import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:nationremit/style/outline_button_styles.dart';
import 'package:provider/provider.dart';
import '../colors/AppColors.dart';
import '../constants/common_constants.dart';
import '../constants/constants.dart';
import '../provider/dashboard_provider.dart';
import '../provider/login_provider.dart';
import '../router/router.dart';

class RelationShipWithRecipient extends StatefulWidget {
  const RelationShipWithRecipient({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RelationShipWithRecipient();
}

class _RelationShipWithRecipient extends State<RelationShipWithRecipient> {
  final fNameController = TextEditingController();
  int? _value = -1;
  String? selectedRelation = '';

  List<String> relationShipList = [
    'Brother',
    'Sister',
    'Father',
    'Mother',
    'Cousin',
    'Friend',
    'Sibling',
    'Spouse',
    'Partner',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final beneFirstName = arguments[Constants.beneFirstName] as String;
    ;
    final beneLastName = arguments[Constants.beneLastName] as String;
    final beneMobileNumber = arguments[Constants.beneMobileNumber] as String;
    final beneMobileCode = arguments[Constants.beneMobileCode] as String;
    final beneAddress = arguments[Constants.beneAddress] as String;
    final beneCity = arguments[Constants.beneCity] as String;
    final remitterId = arguments[Constants.remitterId] as int;
    final partnerId = arguments[Constants.partnerId] as int;
    final destinationCountryCode =
        arguments[Constants.showDestinationCountry] as String;
    final destinationCurrency = arguments[Constants.currency] as String;
    final benePostalCode = arguments[Constants.usePostalCode] as String;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Align(
                      // These values are based on trial & error method
                      alignment: Alignment(-1.05, 1.05),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset(AssetsConstant.icBack),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(AssetsConstant.icBarSelected),
                          SizedBox(width: 5),
                          Image.asset(AssetsConstant.icBarSelected),
                          SizedBox(width: 5),
                          Image.asset(AssetsConstant.icBarSelected),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Text(
                    'Relationship with the recipient',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'Inter-SemiBold',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.textDark),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    height: 500,
                    child:
                        Consumer<DashBoardProvider>(builder: (_, provider, __) {
                      return GridView.count(
                          crossAxisCount: 3,
                          primary: false,
                          padding: const EdgeInsets.all(0),
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 6.0,
                          childAspectRatio: 2.5,
                          children: List.generate(
                            relationShipList.length,
                            (index) {
                              return getWidget(
                                  provider, relationShipList[index], index);
                            },
                          ));
                    }),
                  ),
                ),
                if (selectedRelation == 'Others')
                  SizedBox(
                    child: TextFormField(
                      controller: fNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      decoration:
                          editTextProperty(hitText: 'Enter other relationship'),
                      style: const TextStyle(fontSize: 14),
                      onChanged: (value) {},
                    ),
                  ),
                /*  Row(
              children: [
                OutlinedButton(
                    style: OutlineDecoration.outLineStyle,
                    onPressed: () {},
                    child: Text('Parent', style: AppTextStyles.outlineText)),
                SizedBox(width: 10),
                OutlinedButton(
                    style: OutlineDecoration.outLineStyle,
                    onPressed: () {},
                    child: Text('Spouse', style: AppTextStyles.outlineText)),
                SizedBox(width: 10),
                OutlinedButton(
                    style: OutlineDecoration.outLineStyle,
                    onPressed: () {},
                    child: Text('Children', style: AppTextStyles.outlineText))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                OutlinedButton(
                    style: OutlineDecoration.outLineStyle,
                    onPressed: () {},
                    child: Text('Friend', style: AppTextStyles.outlineText)),
                SizedBox(width: 10),
                OutlinedButton(
                    style: OutlineDecoration.outLineStyle,
                    onPressed: () {},
                    child: Text('Other Family Member',
                        style: AppTextStyles.outlineText)),
              ],
            ),
            SizedBox(height: 20),*/
                /*  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedButton(
                    style: OutlineDecoration.outLineStyle,
                    onPressed: () {},
                    child: Text('Others', style: AppTextStyles.outlineText)),
                SizedBox(height: 20),
                SizedBox(
                  child: TextFormField(
                    controller: fNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    decoration:
                        editTextProperty(hitText: 'Enter other relationship'),
                    style: const TextStyle(fontSize: 14),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),*/
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child:
                        Consumer<DashBoardProvider>(builder: (_, provider, __) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.signUpBtnColor,
                            textStyle: TextStyle(
                                fontFamily: 'Inter-Bold',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: AppColors.textWhite),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(65)),
                            ),
                          ),
                          onPressed: provider.isLoading
                              ? null
                              : () async {
                                  final req = {
                                    Constants.beneFirstName: beneFirstName,
                                    Constants.beneLastName: beneLastName,
                                    Constants.beneCity: beneCity,
                                    Constants.beneMobileCode: beneMobileCode,
                                    Constants.beneMobileNumber:
                                        beneMobileNumber,
                                    //  'bene_email': emailController.text,
                                    Constants.remitterId: remitterId,
                                    Constants.partnerId: partnerId,
                                    Constants.beneCountry:
                                        destinationCountryCode,
                                    Constants.beneAddress: beneAddress,
                                    Constants.beneCardNumber: '',
                                    Constants.beneRelation: selectedRelation,
                                    Constants.benePostalCode: benePostalCode,
                                  };

                                  try {
                                    final res = await provider
                                        .beneficiaryCreate(data: req);

                                    if (mounted && res.success!) {
                                      Fluttertoast.showToast(
                                          msg: 'Recipient successfully added!');

                                      Navigator.pushNamed(context,
                                          RouterConstants.recipientDetailsRoute,
                                          arguments: {
                                            Constants.beneFirstName:
                                                beneFirstName,
                                            Constants.beneLastName:
                                                beneLastName,
                                            Constants.beneCity: beneCity,
                                            Constants.beneMobileNumber:
                                                beneMobileNumber,
                                            Constants.beneMobileCode:
                                                beneMobileCode,
                                            //  'bene_email': emailController.text,
                                            Constants.remitterId: remitterId,
                                            Constants.partnerId: partnerId,
                                            Constants.beneCountry:
                                                destinationCountryCode,
                                            Constants.beneAddress: beneAddress,
                                            Constants.beneCardNumber: '',
                                            Constants.beneId: res.response!.beneficiaryDetails?.beneId,
                                            Constants.beneRelation:
                                                selectedRelation,
                                            Constants.benePostalCode:
                                                benePostalCode,
                                          });
                                    } else {
                                      if (res.success != null && !res.success!) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(res.error!.message),
                                        ));
                                      }
                                    }
                                  } catch (e) {
                                    provider.setLoadingStatus(false);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(e.toString()),
                                    ));
                                  }
                                },
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Save & continue",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Inter-SemiBold',
                                      fontWeight: FontWeight.w600)));
                    }),
                  ),
                )),
                const SizedBox(
                  height: 5,
                ),
              ]),
        ),
      ),
    );
  }

  /* Widget getWidget(DashBoardProvider provider, String name, int index) {
    return GestureDetector(
      onTap: () {
        selectedRelation = name;
      },
      onTapDown: (_) {
        selectedRelation = name;
      },
      onTapCancel: () {
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Column(
          children: [
            ChoiceChip(
              elevation:_value == index ? 10 :  0,
              padding: EdgeInsets.all(8),
              backgroundColor: Colors.white,
              shadowColor: AppColors.outlineBtnColor,
              shape: StadiumBorder(
                side: BorderSide(
                  color: _value == index
                      ? AppColors.signUpBtnColor
                      : AppColors.outlineBtnColor,
                  width: 1.0,
                ),
              ),
              //CircleAvatar
              selected: _value == index,
              label: Text(
                name,
                style: AppTextStyles.choiceChip,
              ),
              //Text
              selectedColor: Colors.white,
              selectedShadowColor: AppColors.signUpBtnColor,
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? index : null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }*/
  Widget getWidget(DashBoardProvider provider, String name, int index) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: ChoiceChip(
        elevation: _value == index ? 10 : 0,
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        backgroundColor: Colors.white,
        shadowColor: AppColors.outlineBtnColor,
        shape: StadiumBorder(
          side: BorderSide(
            color: _value == index
                ? AppColors.signUpBtnColor
                : AppColors.outlineBtnColor,
            width: 1.0,
          ),
        ),
        //CircleAvatar
        selected: _value == index,
        label: Text(
          name,
          style: AppTextStyles.choiceChip,
        ),
        //Text
        selectedColor: Colors.white,
        selectedShadowColor: AppColors.signUpBtnColor,
        onSelected: (bool selected) {
          setState(() {
            _value = selected ? index : null;
            selectedRelation = name;
            print(name + '----' + selectedRelation!);
          });
        },
      ),
    );
  }
}
