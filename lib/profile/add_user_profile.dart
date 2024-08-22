import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';

import '../colors/AppColors.dart';
import '../common_widget/mobileLengthValidator.dart';
import '../constants/common_constants.dart';
import '../model/partner_source_country_model.dart';
import '../model/register_model.dart';
import '../router/router.dart';
import '../style/app_text_styles.dart';

class AddUserProfilePage extends StatefulWidget {
  const AddUserProfilePage({Key? key}) : super(key: key);

  @override
  State<AddUserProfilePage> createState() => _AddUserProfilePageState();
}

class _AddUserProfilePageState extends State<AddUserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  SourceCurrency? dropdownValue;
  PayoutBank? _payoutBank;

  DashBoardProvider? provider;

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final mobileController = TextEditingController();
  final dobController = TextEditingController();
  final mobileCodeController = TextEditingController();
  bool isDOBSelected = false;

  DateTime? selectedDate;

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
    fNameController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    lNameController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    mobileController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    dobController.addListener(() {
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
                                Image.asset(AssetsConstant.icUnBarSelected),
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
                          'Enter your personal details',
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
                          'First name',
                          style: TextStyle(
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.edittextTitle),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          controller: fNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            } else if (value.length < 3) {
                              return 'Name should be more than 2 characters';
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
                        height: 20,
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
                        height: 8,
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
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Date of birth',
                          style: TextStyle(
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.edittextTitle),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          openDatePicker(
                              context: context, controller: dobController);
                        },
                        child: SizedBox(
                          height: 48,
                          child: TextFormField(
                            enabled: false,
                            controller: dobController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter date of birth';
                              }
                              return null;
                            },
                            decoration: editTextProperty(hitText: 'DD/MM/YYYY'),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      if (isDOBSelected && dobController.text.isEmpty)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Text(
                                "Please select date of birth",
                                style: AppTextStyles.passwordMismatchError,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (isDOBSelected && selectedDate != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            isAtLeast18YearsOld(selectedDate!)
                                ? ''
                                : 'You are not 18 years old yet.',
                            style: TextStyle(
                              color: isAtLeast18YearsOld(selectedDate!)
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          textAlign: TextAlign.left,),
                        ),
                      const SizedBox(
                        height: 20,
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
                            height: 48,
                            width: 100,
                            child: TextFormField(
                              enabled: false,
                              controller: mobileCodeController,
                              decoration: editTextProperty(
                                  image: AssetsConstant.miniFlag,
                                  hitText: '+44'),
                              style: TextStyle(
                                  fontFamily: 'Inter-Regular',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColors.edittextTitle),
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
                                      if (value.length != 11) {
                                        print("if " +
                                            value +
                                            " " +
                                            value.startsWith('0').toString());
                                        return 'Mobile Number must be of 11 digit';
                                      }
                                    } else {
                                      if (value.length != 10) {
                                        print("else " +
                                            value +
                                            " " +
                                            value.startsWith('0').toString());
                                        return 'Mobile Number must be of 10 digit';
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
                                inputFormatters: <TextInputFormatter>[
                                  DynamicLengthLimitingTextInputFormatter(),
                                ],
                              ),
                            ),
                          ),
                        ],
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
                                          dobController.text.isNotEmpty &&
                                          mobileController.text.isNotEmpty &&
                                          checkMobileNumber() &&
                                      isAtLeast18YearsOld(selectedDate!)
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
                              setState(() {
                                isDOBSelected = true;
                              });

                              if (_formKey.currentState!.validate()) {
                                fNameController.text.isNotEmpty &&
                                    lNameController.text.isNotEmpty &&
                                    dobController.text.isNotEmpty &&
                                    mobileController.text.isNotEmpty &&
                                    checkMobileNumber() &&
                                    isAtLeast18YearsOld(selectedDate!)?
                                Navigator.pushNamed(
                                    context,
                                    // RouterConstants.addProfileAddressRoute,
                                    RouterConstants
                                        .addProfileAddressManuallyRoute,
                                    arguments: {
                                      Constants.email: email,
                                      Constants.userFirstName:
                                          fNameController.text,
                                      Constants.userLastName:
                                          lNameController.text,
                                      Constants.userDateOfBirth:
                                          dobController.text,
                                      Constants.userMobileNumber:
                                          '+44' + mobileController.text,
                                    }):null;
                              }
                            },
                            child: provider.isLoading
                                ? const CircularProgressIndicator()
                                : Text("Continue",
                                    style: fNameController.text.isNotEmpty &&
                                            lNameController.text.isNotEmpty &&
                                            dobController.text.isNotEmpty &&
                                            mobileController.text.isNotEmpty &&
                                            checkMobileNumber() &&
                                        isAtLeast18YearsOld(selectedDate!)
                                        ? AppTextStyles.enableContinueBtnTxt
                                        : AppTextStyles.disableContinueBtnTxt)),
                      ),
                      const SizedBox(
                        height: 25,
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

  bool checkMobileNumber() {
    return mobileController.text.startsWith('0')
        ? mobileController.text.length == 11
        : mobileController.text.length == 10;
  }

  openDatePicker(
      {required BuildContext context,
      required TextEditingController controller}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: (18 * 365.25).toInt())),
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
        selectedDate = pickedDate;
      });
    } else {
      print("Date is not selected");
    }
  }
}
