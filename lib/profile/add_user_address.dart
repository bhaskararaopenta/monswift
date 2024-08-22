import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';

import '../colors/AppColors.dart';
import '../constants/common_constants.dart';
import '../model/partner_source_country_model.dart';
import '../router/router.dart';

class AddUserAddressPage extends StatefulWidget {
  const AddUserAddressPage({Key? key}) : super(key: key);

  @override
  State<AddUserAddressPage> createState() => _AddUserAddressPageState();
}

class _AddUserAddressPageState extends State<AddUserAddressPage> {
  final _formKey = GlobalKey<FormState>();
  SourceCurrency? dropdownValue;
  PayoutBank? _payoutBank;

  DashBoardProvider? provider;

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final mobileController = TextEditingController();
  final dobController = TextEditingController();
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
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final email = arguments[Constants.email] as String;
    final firstName = arguments[Constants.userFirstName] as String;
    final lastName = arguments[Constants.userLastName] as String;
    final dob = arguments[Constants.userDateOfBirth] as String;
    final mobileNumber = arguments[Constants.userMobileNumber] as String;

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
                            }
                            return null;
                          },
                          decoration:
                              editTextProperty(hitText: 'Enter post code'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context,
                              RouterConstants.addProfileAddressManuallyRoute, arguments: {
                                Constants.email: email,
                                Constants.userFirstName:firstName,
                                Constants.userLastName:lastName,
                                Constants.userDateOfBirth:dob,
                                Constants.userMobileNumber:mobileNumber
                              });
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Enter your address manually',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.retake,
                            ),
                          ),
                        ),
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
