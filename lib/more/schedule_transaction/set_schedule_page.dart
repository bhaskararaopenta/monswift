import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:provider/provider.dart';

import '../../colors/AppColors.dart';
import '../../constants/common_constants.dart';
import '../../router/router.dart';
import '../../style/app_text_styles.dart';

class SetSchedulePage extends StatefulWidget {
  const SetSchedulePage({Key? key}) : super(key: key);

  @override
  State<SetSchedulePage> createState() => _SetSchedulePageState();
}

const List<String> list = <String>[
  'None',
  'Daily',
  'Weekly',
  'Every two weeks',
  'Monthly'
];

class _SetSchedulePageState extends State<SetSchedulePage> {
  final _formKey = GlobalKey<FormState>();
  DashBoardProvider? provider;
  final dobController = TextEditingController();
  String dropdownValue = list.first;
  String? mDeliveryType = '';
  String? purposeCodes;
  bool isComingForSetSchedule = false;

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
    Data data = arguments[Constants.recipientUserDetails] as Data;
    String? sourceOfIncome = arguments[Constants.sourceOfIncome] as String;
    purposeCodes = arguments[Constants.purposeOf] as String;
    mDeliveryType = arguments[Constants.deliveryType] as String?;
    isComingForSetSchedule =
        arguments[Constants.isComingForSetSchedule] as bool;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
            return Form(
              key: _formKey,
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
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Set schedule',
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
                      'Start Date',
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
                      height: 60,
                      child: TextFormField(
                        enabled: false,
                        controller: dobController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select date';
                          }
                          return null;
                        },
                        decoration: editTextProperty(hitText: 'dd/mm/yyyy'),
                        style: const TextStyle(fontSize: 14),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Repeat',
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
                    height: 60,
                    child: InputDecorator(
                      decoration: editTextProperty(hitText: 'None'),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                          ),
                          elevation: 16,
                          style: AppTextStyles.sixteenRegular,
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(
                                    context, RouterConstants.reviewPaymentRoute,
                                    arguments: {
                                      Constants.recipientUserDetails: data,
                                      //Constants.sourceOfIncome: sourceOfIncome?.name,
                                      Constants.sourceOfIncome: 'Salary',
                                      Constants.purposeOf: purposeCodes,
                                      Constants.deliveryType: mDeliveryType,
                                      Constants.isComingForSetSchedule: isComingForSetSchedule,
                                      Constants.scheduledDate: dobController.text,
                                      Constants.scheduledFrequency: dropdownValue,
                                      Constants.isComingFromRecipientDetailsPage:  false,
                                      Constants.isComingFromRecipientPage: false,

                                      //  Constants.purposeOf: purposeCodes?.name
                                    });
                              }
                            },
                            child: provider.isLoading
                                ? const CircularProgressIndicator()
                                : Text("Continue",
                                    style: AppTextStyles.buttonText)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }),
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
