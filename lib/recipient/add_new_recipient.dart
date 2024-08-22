import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/common_widget/country_iso.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';

import '../colors/AppColors.dart';
import '../constants/common_constants.dart';
import '../model/partner_source_country_model.dart';
import '../router/router.dart';

class AddNewRecipientPage extends StatefulWidget {
  const AddNewRecipientPage({Key? key}) : super(key: key);

  @override
  State<AddNewRecipientPage> createState() => _AddNewRecipientPageState();
}

class _AddNewRecipientPageState extends State<AddNewRecipientPage> {
  final _formKey = GlobalKey<FormState>();
  SourceCurrency? dropdownValue;
  PayoutBank? _payoutBank;

  DashBoardProvider? provider;

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final accountNumberController = TextEditingController();
  final mobileCodeController = TextEditingController();

  @override
  void initState() {
    provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    String? destinationCurrency;
    String? destinationCountryCode;
    String? destinationMobileCode;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      destinationCountryCode =
          arguments[Constants.showDestinationCountry] as String;
      destinationCurrency = arguments[Constants.currency] as String;
      destinationMobileCode =
          arguments[Constants.beneMobileNumberDialCode] as String;
    }

    print(
        '=============== ${provider!.countryDestinationList!.response!.destinationCurrency![0].countryCode}');

    cityController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    addressController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    mobileController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    lNameController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    fNameController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
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
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(AssetsConstant.icBarSelected),
                                SizedBox(width: 5),
                                Image.asset(AssetsConstant.icBarSelected),
                                SizedBox(width: 5),
                                Image.asset(AssetsConstant.icUnBarSelected),
                              ],
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
                          'Enter their details',
                          textAlign: TextAlign.left,
                          style: AppTextStyles.screenTitle,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'To avoid delays please make sure the information is correct.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Inter-Regular',
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
                          'Mobile number',
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
                                  hitText: destinationMobileCode ?? '',
                                  svg: CountryISOMapping().getCountryISOFlag(
                                      CountryISOMapping().getCountryISO2(
                                          destinationCountryCode ?? ''))),
                              style: const TextStyle(fontSize: 14),
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
                                maxLength: mobileController.text.contains('0')
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
                          'First & middle name',
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
                          controller: fNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          decoration:
                              editTextProperty(hitText: 'Enter your name'),
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
                          'Last name',
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
                          controller: lNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter last name';
                            }
                            return null;
                          },
                          decoration:
                              editTextProperty(hitText: 'Enter last name'),
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
                          'Full address',
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
                         /* validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },*/
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
                          'Postal code',
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
                          /*validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your postal code';
                            }
                            return null;
                          },*/
                          decoration: editTextProperty(hitText: 'Enter'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    fNameController.text.isNotEmpty &&
                                            lNameController.text.isNotEmpty &&
                                            mobileController.text.isNotEmpty &&
                                            addressController.text.isNotEmpty &&
                                            cityController.text.isNotEmpty
                                        ? AppColors.signUpBtnColor
                                        : AppColors.outlineBtnColor,
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
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  /*  final loginProvider =
                                  Provider.of<LoginProvider>(
                                    context,
                                    listen: false,
                                  );
                                  final req = {
                                    'bene_first_name': fNameController.text,
                                    'bene_last_name': lNameController.text,
                                    'bene_city': cityController.text,
                                    'bene_mobile_number': '${dropdownValue
                                        ?.mobileCode}${mobileController.text}',
                                    //  'bene_email': emailController.text,
                                    'remitter_id': loginProvider
                                        .userInfo!.userDetails!.remitterId,
                                    'partner_id': loginProvider
                                        .userInfo!.userDetails!.partnerId,
                                    'benificiary_country': country,
                                    'bene_address': addressController.text,
                                    'bene_card_number': '',
                                  };


                                  try {
                                    await provider.beneficiaryCreate(
                                        data: req);

                                    if (mounted) {
                                      Fluttertoast.showToast(
                                          msg: 'Recipient successfully added!');
                                      Navigator.pop(context);
                                    }
                                  } catch (e) {
                                    provider.setLoadingStatus(false);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(e.toString()),
                                    ));
                                  }
                                }*/
                                  final loginProvider =
                                      Provider.of<LoginProvider>(
                                    context,
                                    listen: false,
                                  );
                                  Navigator.pushNamed(context,
                                      RouterConstants.relationShipWithRecipient,
                                      arguments: {
                                        //Constants.beneEmail: email,
                                        Constants.beneFirstName:
                                            fNameController.text,
                                        Constants.beneLastName:
                                            lNameController.text,
                                        Constants.beneMobileCode:
                                            destinationMobileCode!,
                                        Constants.beneMobileNumber:
                                            mobileController.text,
                                        Constants.beneAddress:
                                            addressController.text,
                                        Constants.beneCity: cityController.text,
                                        Constants.remitterId: loginProvider
                                            .userInfo!.response?.userDetails!.remitterId,
                                        Constants.partnerId: loginProvider
                                            .userInfo!.response?.userDetails!.partnerId,
                                        Constants.usePostalCode:
                                            postalCodeController.text,
                                        Constants.showDestinationCountry:
                                            destinationCountryCode,
                                        Constants.currency: destinationCurrency
                                      });
                                }
                              },
                              child: provider.isLoading
                                  ? const CircularProgressIndicator()
                                  : Text("Continue",
                                      style: fNameController.text.isNotEmpty &&
                                              lNameController.text.isNotEmpty &&
                                              mobileController
                                                  .text.isNotEmpty &&
                                              addressController
                                                  .text.isNotEmpty &&
                                              cityController.text.isNotEmpty
                                          ? AppTextStyles.enableContinueBtnTxt
                                          : AppTextStyles
                                              .disableContinueBtnTxt))),
                      const SizedBox(
                        height: 10,
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
