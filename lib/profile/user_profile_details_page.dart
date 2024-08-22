import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';

import '../common_widget/common_property.dart';
import '../common_widget/country_iso.dart';

class UserProfileDetailsPage extends StatefulWidget {
  const UserProfileDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserProfileDetailsPage> createState() => _UserProfileDetailsPageState();
}

class _UserProfileDetailsPageState extends State<UserProfileDetailsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){

      fetchUserProfileList();

    });

    super.initState();
  }

  Future<void> fetchUserProfileList() async {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );


    await provider.getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 50,
                        shadowColor: Color.fromRGBO(0, 0, 0, 0.9),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        color: Color.fromRGBO(255, 255, 255, 1),
                        child: Container(
                          width: 358,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                Stack(children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.circleGreyColor,
                                    radius: 30.0,
                                    child: SizedBox(
                                        child: Text(
                                          getInitials(
                                              '${provider.profileDetailsModel!.response[0].firstName.trim().isNotEmpty ?  provider.profileDetailsModel!.response[0].firstName.trim().toLowerCase().capitalize() : null}'
                                                  ' ${ provider.profileDetailsModel!.response[0].lastName.trim().isNotEmpty ? provider.profileDetailsModel!.response[0].lastName.trim().toLowerCase().capitalize() : null}'),
                                          style: AppTextStyles.letterTitle,
                                        )),
                                  ),
                                  Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        // child: Image.asset(AssetsConstant.miniFlag),
                                        child: SvgPicture.asset(
                                          AssetsConstant.ukFlagIcon_,
                                          width: 18,
                                        ),

                                        padding: EdgeInsets.all(0),
                                      ))
                                ]),
                                const SizedBox(
                                  height:15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                    provider.profileDetailsModel!.response[0].firstName,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Inter-SemiBold'),
                                    ),
                                    Text(
                                      //   '${data.beneFirstName} ${data.beneLastName}'bene,
                                      provider.profileDetailsModel!.response[0].email,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Inter-Medium'),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18,),
                                SizedBox(
                                    width: double.infinity,
                                    height: 38,
                                    child: FilledButton.tonal(
                                        style: FilledButton.styleFrom(
                                          backgroundColor: AppColors.cancelBtnColor,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(65),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              RouterConstants.editProfilePage,
                                              arguments: {
                                                Constants.userFirstName: provider.profileDetailsModel!.response[0].firstName,
                                                Constants.userLastName: provider.profileDetailsModel!.response[0].lastName,
                                                Constants.userCity: provider.profileDetailsModel!.response[0].city,
                                                Constants.userMobileNumber: provider.profileDetailsModel!.response[0].mobileNumber,
                                                Constants.remitterId: provider.profileDetailsModel!.response[0].remitterId,
                                                Constants.partnerId: provider.profileDetailsModel!.response[0].partnerId,
                                                Constants.userAddress1: provider.profileDetailsModel!.response[0].address1,
                                                Constants.usePostalCode: provider.profileDetailsModel!.response[0].postalCode,
                                              });
                                        },
                                        child: Text(
                                          'Edit Profile',
                                          style: TextStyle(
                                              fontFamily: 'Inter-SemiBold',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: AppColors.signUpBtnColor),
                                        ))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Icon(
                          //   FontAwesomeIcons.locationPin,
                          // ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Mobile Number',
                              style: TextStyle(
                                  color: AppColors.greyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Inter-Regular'),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            provider.profileDetailsModel!.response[0].mobileNumber,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter-SemiBold'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Icon(
                          //   FontAwesomeIcons.locationPin,
                          // ),
                          SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Address',
                                style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter-Regular'),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            provider.profileDetailsModel!.response[0].address1,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter-SemiBold'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Icon(
                          //   FontAwesomeIcons.locationPin,
                          // ),
                          SizedBox(
                              width: 110,
                              child: Text(
                                'City',
                                style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter-Regular'),
                              )),
                          const SizedBox(
                            height: 5,
                          ),

                          Text(
                            provider.profileDetailsModel!.response[0].city,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter-SemiBold'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Icon(
                          //   FontAwesomeIcons.locationPin,
                          // ),
                          SizedBox(
                              width: 110,
                              child: Text(
                                'Post code',
                                style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter-Regular'),
                              )),
                          const SizedBox(
                            height: 5,
                          ),

                          Text(
                            //data.beneCity ?? '',
                            provider.profileDetailsModel!.response[0].postalCode,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter-SemiBold'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Icon(
                          //   FontAwesomeIcons.locationPin,
                          // ),
                          SizedBox(
                              width: 110,
                              child: Text(
                                'Country',
                                style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter-Regular'),
                              )),
                          const SizedBox(
                            height: 5,
                          ),

                          Text(
                            //data.beneCity ?? '',
                            'United Kingdom',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter-SemiBold'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
