import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_create_model.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:provider/provider.dart';

import '../colors/AppColors.dart';
import '../common_widget/country_iso.dart';
import '../constants/common_constants.dart';
import '../model/partner_source_country_model.dart';

class EditdNewRecipientPage extends StatefulWidget {
  const EditdNewRecipientPage({Key? key}) : super(key: key);

  @override
  State<EditdNewRecipientPage> createState() => _EditdNewRecipientPageState();
}

const List<String> relationShipList = [
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

class _EditdNewRecipientPageState extends State<EditdNewRecipientPage> {
  final _formKey = GlobalKey<FormState>();
  SourceCurrency? dropdownValue;
  PayoutBank? _payoutBank;

  DashBoardProvider? provider;
  String relationShipType = relationShipList.first;

  final countryController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final accountNumberController = TextEditingController();
  final mobileCodeController = TextEditingController();
  var svgCountryPath = '';
  var countryName = '';

  @override
  void initState() {
    provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final arguments =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

        final beneFirstName = arguments[Constants.beneFirstName] as String;
        final beneLastName = arguments[Constants.beneLastName] as String;
        final beneMobileNumber =
            arguments[Constants.beneMobileNumber] as String;
        final beneMobileCode = arguments[Constants.beneMobileCode] as String;
        final beneDialCode = arguments[Constants.beneMobileCode] as String;
        final beneAddress = arguments[Constants.beneAddress] as String;
        final beneCity = arguments[Constants.beneCity] as String;
        final beneId = arguments[Constants.beneId] as int;
        final remitterId = arguments[Constants.remitterId] as int;
        final partnerId = arguments[Constants.partnerId] as int;
        final postalCode = arguments[Constants.benePostalCode] as String;
        final beneCountry = arguments[Constants.beneCountry] as String;
        final beneRelation = arguments[Constants.beneRelation] as String;

       // countryController.text = beneCountry;
        mobileController.text = beneMobileNumber.toString();
        mobileCodeController.text = beneMobileCode.toString();
        cityController.text = beneCity;
        addressController.text = beneAddress;
        postalCodeController.text = postalCode;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final beneFirstName = arguments[Constants.beneFirstName] as String;
    final beneLastName = arguments[Constants.beneLastName] as String;
    final beneMobileNumber = arguments[Constants.beneMobileNumber] as String;
    final beneAddress = arguments[Constants.beneAddress] as String;
    final beneCity = arguments[Constants.beneCity] as String;
    final beneId = arguments[Constants.beneId] as int;
    final remitterId = arguments[Constants.remitterId] as int;
    final partnerId = arguments[Constants.partnerId] as int;
    final beneCountry = arguments[Constants.beneCountry] as String;
    final beneRelation = arguments[Constants.beneRelation] as String;
    final postalCode = arguments[Constants.benePostalCode] as String;

    countryController.text = beneCountry;
    mobileController.text = beneMobileNumber.toString();
    cityController.text = beneCity;
    addressController.text = beneAddress;
    postalCodeController.text = postalCode;
    svgCountryPath = CountryISOMapping().getCountryISOFlag(
        CountryISOMapping().getCountryISO2(countryController.text ?? ''));
    countryName = CountryISOMapping().getCountryName(
        CountryISOMapping().getCountryISO3(countryController.text ?? ''));
    countryController.text = countryName;
    print("=== country =="+countryName+"  --------  "+countryController.text);
    /* print(
        '=============== ${provider!.countryDestinationList!.response[0].destinationCurrency[0].countryCode}');
*/
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
              return Form(
                key: _formKey,
                child: Center(
                  child: Column(
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
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Edit details',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Inter-Bold',
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: AppColors.textDark),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'To avoid delays please make sure the\n information is correct.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.greyColor),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Country',
                          style: TextStyle(
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.edittextTitle),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          enabled: false,
                          controller: countryController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter country name';
                            }
                            return null;
                          },
                          decoration:
                              editTextMobileCodeProperty(hitText: 'Enter country name',svg: svgCountryPath),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Relationship with the recipient',
                          style: TextStyle(
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.edittextTitle),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            //background color of dropdown button
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Color.fromARGB(255, 219, 222, 228),
                                width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                            child: DropdownButton<String>(
                              value: relationShipType,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              elevation: 16,
                              style: TextStyle(color: AppColors.textDark),
                              underline: Container(),
                              isExpanded: true,
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  relationShipType = value!;
                                });
                              },
                              hint: const Text(''),
                              items: relationShipList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Mobile Number',
                          style: TextStyle(
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.edittextTitle),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 48,
                            child: TextFormField(
                              enabled: false,
                              controller: mobileCodeController,
                              decoration: editTextMobileCodeProperty(
                                  hitText: '', svg: svgCountryPath),
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: TextFormField(
                                controller: mobileController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter mobile number';
                                  } else {
                                    if (value.startsWith('0')) {
                                      if (value.length != 10) {
                                        print("if " +
                                            value +
                                            " " +
                                            value.startsWith('0').toString());
                                        return 'Mobile Number must be of 10 digit';
                                      }
                                    } else {
                                      if (value.length != 9) {
                                        print("else " +
                                            value +
                                            " " +
                                            value.startsWith('0').toString());
                                        return 'Mobile Number must be of 9 digit';
                                      }
                                    }
                                  }
                                  return null;
                                },
                                decoration: editTextProperty(
                                    hitText: 'Enter Mobile number'),
                                style: const TextStyle(fontSize: 14),
                                onChanged: (value) {},
                                keyboardType: TextInputType.phone,
                                maxLength:mobileController.text.contains('0')
                                    ? 10
                                    : 9,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Address line',
                          style: TextStyle(
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.edittextTitle),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          controller: addressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                          decoration: editTextProperty(hitText: 'Enter'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'City',
                          style: TextStyle(
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.edittextTitle),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          controller: cityController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your city';
                            }
                            return null;
                          },
                          decoration: editTextProperty(hitText: 'Enter'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Postal Code',
                          style: TextStyle(
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.edittextTitle),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          controller: postalCodeController,
                          validator: null,
                          decoration: editTextProperty(hitText: 'Enter'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 56,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.cancelBtnColor,
                                        textStyle: TextStyle(
                                            fontFamily: 'Inter-SemiBold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: AppColors.textDark),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(65)),
                                        ),
                                        padding: EdgeInsets.fromLTRB(
                                            25, 10, 25, 10)),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: provider.isLoading
                                        ? const CircularProgressIndicator()
                                        : Text("Cancel",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Inter-SemiBold',
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.textDark))),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 56,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigoAccent,
                                      textStyle: TextStyle(
                                          fontFamily: 'Inter-SemiBold',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: AppColors.textWhite),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(65)),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final loginProvider =
                                            Provider.of<LoginProvider>(
                                          context,
                                          listen: false,
                                        );

                                        final req = {
                                          Constants.beneFirstName:
                                              beneFirstName,
                                          Constants.beneLastName: beneLastName,
                                          Constants.beneCity:
                                              cityController.text,
                                          Constants
                                                  .beneMobileNumber: /*'${dropdownValue?.mobileCode}*/
                                              '${mobileController.text}',
                                          Constants.remitterId: loginProvider
                                              .userInfo!.response!
                                              .userDetails!
                                              .remitterId,
                                          Constants.partnerId: loginProvider
                                              .userInfo!.response?.userDetails!.partnerId,
                                          Constants.beneCountry: beneCountry,
                                          Constants.beneRelation:
                                              relationShipType,
                                          Constants.beneAddress:
                                              addressController.text,
                                          Constants.beneCardNumber: '',
                                          Constants.beneId: beneId,
                                          Constants.benePostalCode:
                                              postalCodeController.text,
                                        };

                                        try {
                                          var res = await provider
                                              .beneficiaryUpdate(data: req);
                                          if (mounted && res.success!) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Recipient successfully updated!');
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            Navigator.pop(context, 'Yes');
                                          } else {
                                            if (!res.success!) {
                                              provider.setLoadingStatus(false);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    Text(res.error!.message),
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
                                      }
                                    },
                                    child: provider.isLoading
                                        ? const CircularProgressIndicator()
                                        :  Text("Save",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Inter-SemiBold',
                                                fontWeight: FontWeight.w600,
                                            color: AppColors.textWhite))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
