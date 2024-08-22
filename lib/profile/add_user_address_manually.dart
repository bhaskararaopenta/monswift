import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:provider/provider.dart';

import '../colors/AppColors.dart';
import '../constants/common_constants.dart';
import '../constants/constants.dart';
import '../model/partner_source_country_model.dart';
import '../model/register_model.dart';
import '../router/router.dart';
import '../style/app_text_styles.dart';

class AddUserAddressManuallyPage extends StatefulWidget {
  const AddUserAddressManuallyPage({Key? key}) : super(key: key);

  @override
  State<AddUserAddressManuallyPage> createState() =>
      _AddUserAddressManuallyPageState();
}

class _AddUserAddressManuallyPageState
    extends State<AddUserAddressManuallyPage> {
  final _formKey = GlobalKey<FormState>();
  SourceCurrency? dropdownValue;
  PayoutBank? _payoutBank;

  DashBoardProvider? provider;

  final fNameController = TextEditingController();
  final cityController = TextEditingController();
  final townController = TextEditingController();
  final addressController = TextEditingController();
  final addressController2 = TextEditingController();
  final postalCodeController = TextEditingController();
  final countryController = TextEditingController();

  @override
  void initState() {
    provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final email = arguments[Constants.email] as String;
    final firstName = arguments[Constants.userFirstName] as String;
    final lastName = arguments[Constants.userLastName] as String;
    final dob = arguments[Constants.userDateOfBirth] as String;
    final mobileNumber = arguments[Constants.userMobileNumber] as String;
    countryController.text ='United Kingdom';
    fNameController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    cityController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    townController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    addressController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    postalCodeController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
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
                                Image.asset(AssetsConstant.icBarSelected),
                                SizedBox(width: 5),
                                Image.asset(AssetsConstant.icUnBarSelected),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Add your address',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Inter-Bold',
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: AppColors.textDark),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Address line 1',
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
                            } else if (value.length < 3) {
                              return 'Address should be more than 2 characters';
                            }
                            return null;
                          },
                          decoration: editTextProperty(hitText: 'Enter'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z0-9'-, ]")),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Address line 2 (optional)',
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
                          controller: addressController2,
                          decoration: editTextProperty(hitText: 'Enter'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z0-9'-, ]")),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Town',
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
                          controller: townController,
                          decoration: editTextProperty(hitText: 'Enter'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                            } else if (value.length < 3) {
                              return 'City name should be more than 2 characters';
                            }
                            return null;
                          },
                          decoration: editTextProperty(hitText: 'Enter'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z0-9'-, ]")),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your postal code';
                            } else if (value.length < 3) {
                              return 'Postal code should be more than 2 characters';
                            }
                            return null;
                          },
                          decoration: editTextProperty(hitText: 'Enter'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z0-9'-, ]")),
                          ],
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
                              color: AppColors.greyColor),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          controller: countryController,
                          enabled: false,
                          validator: (value) {
                            return null;
                          },
                          decoration: editTextFadeProperty(hitText: 'Enter', image: AssetsConstant.miniFlag, ),
                          style:  TextStyle(fontSize: 14,color: AppColors.fadeText),
                          onChanged: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z0-9'-, ]")),
                          ],
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
                                  addressController.text.isNotEmpty &&
                                          cityController.text.isNotEmpty &&
                                          postalCodeController.text.isNotEmpty
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
                                Navigator.pushNamed(context,
                                    RouterConstants.uploadProfileIdentity,
                                    arguments: {
                                      Constants.email: email,
                                      Constants.userFirstName: firstName,
                                      Constants.userLastName: lastName,
                                      Constants.userDateOfBirth: dob,
                                      Constants.userMobileNumber: mobileNumber,
                                      Constants.userAddress1:
                                          addressController.text,
                                      Constants.userAddress2:
                                          addressController2.text,
                                      Constants.userTown: townController.text,
                                      Constants.userCity: cityController.text,
                                      Constants.usePostalCode:
                                          postalCodeController.text,
                                      Constants.isComingFromProfilePage: false,
                                      Constants.isComingFromLoginPinPage: false,
                                    });
                              }
                            },
                            child: provider.isLoading
                                ? const CircularProgressIndicator()
                                : Text("Continue",
                                    style: addressController.text.isNotEmpty &&
                                            cityController.text.isNotEmpty &&
                                            postalCodeController.text.isNotEmpty
                                        ? AppTextStyles.enableContinueBtnTxt
                                        : AppTextStyles.disableContinueBtnTxt)),
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

  openDatePicker(
      {required BuildContext context,
      required TextEditingController controller}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      //get today's date
      firstDate: DateTime(1900),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      print(
          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
      String formattedDate = DateFormat('dd-MM-yyyy').format(
          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
      print(
          formattedDate); //formatted date output using intl package =>  2022-07-04
      //You can format date as per your need

      setState(() {
        controller.text = formattedDate; //set foratted date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }
}
