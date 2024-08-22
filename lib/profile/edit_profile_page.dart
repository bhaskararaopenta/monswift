import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors/AppColors.dart';
import '../common_widget/country_iso.dart';
import '../common_widget/mobileLengthValidator.dart';
import '../common_widget/profileImageUpload.dart';
import '../constants/common_constants.dart';
import '../model/is_success_model.dart';
import '../model/partner_source_country_model.dart';
import '../style/app_text_styles.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  SourceCurrency? dropdownValue;
  PayoutBank? _payoutBank;

  DashBoardProvider? provider;

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
  final ProfileImageUpload _imageUpload = ProfileImageUpload();

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

        final userFirstName = arguments[Constants.userFirstName] as String;
        final userLastName = arguments[Constants.userLastName] as String;
        final userMobileNumber =
            arguments[Constants.userMobileNumber] as String;
        final userAddress = arguments[Constants.userAddress1] as String;
        final userCity = arguments[Constants.userCity] as String;
        final remitterId = arguments[Constants.remitterId] as int;
        final partnerId = arguments[Constants.partnerId] as int;
        final postalCode = arguments[Constants.usePostalCode] as String;

        // countryController.text = userCountry;
        mobileController.text =
            userMobileNumber.toString().replaceRange(0, 3, '');
        cityController.text = userCity;
        addressController.text = userAddress;
        postalCodeController.text = postalCode;
      }
    });
//    mobileController.addListener(_updateMaxLength);
    super.initState();

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    mobileController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final userFirstName = arguments[Constants.userFirstName] as String;
    final userLastName = arguments[Constants.userLastName] as String;
    final userMobileNumber = arguments[Constants.userMobileNumber] as String;
    final userAddress = arguments[Constants.userAddress1] as String;
    final userCity = arguments[Constants.userCity] as String;
    final remitterId = arguments[Constants.remitterId] as int;
    final partnerId = arguments[Constants.partnerId] as int;
    final postalCode = arguments[Constants.usePostalCode] as String;

    countryController.text = 'GBR';
    mobileController.text = userMobileNumber.toString().replaceRange(0, 3, '');
    cityController.text = userCity;
    addressController.text = userAddress;
    postalCodeController.text = postalCode;
    svgCountryPath = CountryISOMapping().getCountryISOFlag(
        CountryISOMapping().getCountryISO2(countryController.text ?? ''));
    countryName = CountryISOMapping().getCountryName(
        CountryISOMapping().getCountryISO2(countryController.text ?? ''));
    countryController.text = '  ' + countryName;
    //print("=== country =="+countryName+"  --------  "+countryController.text);
    /* print(
        '=============== ${provider!.countryDestinationList!.response[0].destinationCurrency[0].countryCode}');
*/
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
                            child: Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                height: 32,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.textDark,
                                      textStyle: TextStyle(
                                          fontFamily: 'Inter-SemiBold',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: AppColors.textWhite),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(29)),
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
                                          Constants.userFirstName:
                                              userFirstName,
                                          Constants.userLastName: userLastName,
                                          Constants.userCity:
                                              cityController.text,
                                          Constants
                                                  .userMobileNumber: /*'${dropdownValue?.mobileCode}*/
                                              '+44' +
                                                  '${mobileController.text}',
                                          Constants.remitterId: loginProvider
                                              .userInfo!
                                              .response!
                                              .userDetails!
                                              .remitterId,
                                          Constants.partnerId: loginProvider
                                              .userInfo!
                                              .response
                                              ?.userDetails!
                                              .partnerId,
                                          Constants.userAddress1:
                                              addressController.text,
                                          Constants.usePostalCode:
                                              postalCodeController.text,
                                          Constants.email: loginProvider
                                              .userInfo!
                                              .response
                                              ?.userDetails!
                                              .email,
                                        };

                                        try {
                                          var res = await provider
                                              .userDetailUpdateAPI(data: req);
                                          if (mounted && res.success!) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'User details successfully updated!');
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          } else {
                                            if (!res.success!) {
                                              provider.setLoadingStatus(false);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    Text(res.error!.message!),
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
                                        ? SizedBox(
                                            child: CircularProgressIndicator(),
                                            height: 20.0,
                                            width: 20.0,
                                          )
                                        : const Text("Save",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Inter-SemiBold',
                                                fontWeight: FontWeight.w600))),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 358,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              Stack(children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.circleGreyColor,
                                  radius: 45.0,
                                  child: _imageUpload.imageFile != null
                                      ? ClipOval(
                                          child: Image.file(
                                          _imageUpload.imageFile!, width: 160,
                                          // Adjust the width and height to make it circular

                                          fit: BoxFit.cover,
                                        ))
                                      : SizedBox(
                                          child: Text(
                                          getInitials(
                                              '${provider.profileDetailsModel!.response[0].firstName.trim().isNotEmpty ? provider.profileDetailsModel!.response[0].firstName.trim().toLowerCase().capitalize() : null}'
                                              ' ${provider.profileDetailsModel!.response[0].lastName.trim().isNotEmpty ? provider.profileDetailsModel!.response[0].lastName.trim().toLowerCase().capitalize() : null}'),
                                          style: AppTextStyles.letterTitle,
                                        )),
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: GestureDetector(
                                      onTap: () async {
                                        // Select image from gallery
                                        final pickedFile = await ImagePicker()
                                            .getImage(
                                            source: ImageSource.gallery);


                                        setState(() {

                                          if (pickedFile != null) {
                                            _imageUpload.setImageFile(
                                                File(pickedFile.path));
                                          }
                                        });
                                        if(pickedFile!=null){

                                          Uint8List imageBytes = await pickedFile.readAsBytes(); //convert to bytes
                                          String?  base64string =
                                              base64.encode(imageBytes);


                                        final req = {
                                          "action": "Add",
                                          "avatar":'data:image/jpg;base64,' +base64string
                                        };
                                        IsSuccessModel res = await provider
                                            .saveProfileImage(data: req);
                                        }

                                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.setString(Constants.ProfileImage, pickedFile!.path);
                                      },
                                      child: Container(
                                        // child: Image.asset(AssetsConstant.miniFlag),
                                        child: SvgPicture.asset(
                                          AssetsConstant.icEditIconForProfile,
                                          width: 30,
                                        ),

                                        padding: EdgeInsets.all(0),
                                      ),
                                    )),
                              ]),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    provider.profileDetailsModel!.response[0]
                                        .firstName,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Inter-SemiBold'),
                                  ),
                                  Text(
                                    //   '${data.beneFirstName} ${data.beneLastName}'bene,
                                    provider
                                        .profileDetailsModel!.response[0].email,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Inter-Medium'),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                                  hitText: '+44', svg: svgCountryPath),
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
                                    /* if (value.length != 11)
                                      return 'Mobile Number must be of 10 digit';*/
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
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  DynamicLengthLimitingTextInputFormatter(),
                                ]
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Address',
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
                        height: 8,
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
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Post code',
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
                          controller: postalCodeController,
                          validator: null,
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
                          'Country',
                          style: TextStyle(
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.greyColor),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
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
                          decoration: editTextFadeProperty(
                              hitText: 'Enter country name'),
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.fadeText,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
