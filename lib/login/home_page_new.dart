import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/common_widget/avatar_image_property.dart';
import 'package:nationremit/common_widget/country_iso.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:nationremit/style/app_font_styles.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../model/beneficiary_list_model.dart';
import '../model/get_profile_image_model.dart';
import '../model/transaction_list_model.dart';

class HomePageNew extends StatefulWidget {
  const HomePageNew({super.key});

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  Timer? _debounce;
  String? userName = '';
  int _selectedIndex = -1;
  int iteratorIndex = 3;
  var profileImg = '';
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchRecipientList();
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );

      final req = {
        "action": "Get"
      };
      GetProfileImageModel res = await provider
          .getProfileImage(data: req);

      if(res.response!=null){
        setState(() {
          profileImg= res.response!.avatar!;
        });

      }

      provider.transactionListAPI(data: {
        //'remitter_id': loginProvider.userInfo?.userDetails?.remitterId
        "data": "RemitterId"
      });

      provider.getUserWallet();
      final providerLogin = Provider.of<LoginProvider>(
        context,
        listen: false,
      );
      providerLogin.getUserProfileImg().then((String? getImg) {
        if (getImg != null)
          setState(() {
            profileImg = getImg.toString();
          });
      });
    });

    super.initState();
  }

  Widget getWidget(int id, String imagePath, Data? data) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouterConstants.sendMoneyPageRoute,
                arguments: {
                  Constants.recipientUserDetails: data,
                  Constants.isComingForSetSchedule: false,
                  Constants.isComingFromRecipientPage: true,
                  Constants.isComingFromRecipientDetailsPage: false,
                  Constants.isComingFromPaymentReviewPage: false,
                });
          },
          onTapDown: (_) {
            setState(() {
              _selectedIndex = id;
            });
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (data != null &&
                    data.beneFirstName!.isNotEmpty &&
                    data.beneLastName!.isNotEmpty)
                  Stack(children: [
                    CircleAvatar(
                      backgroundColor: AppColors.circleGreyColor,
                      radius: 28.0,
                      child: SizedBox(
                          child: Text(
                        getInitials(
                            '${data!.beneFirstName!.trim().toLowerCase().isNotEmpty ? data!.beneFirstName!.trim().toLowerCase().capitalize() : null}'
                            ' ${data.beneLastName!.trim().toLowerCase().isNotEmpty ? data.beneLastName!.trim().toLowerCase().capitalize() : null}'),
                        style: AppTextStyles.letterTitle,
                      )),
                    ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          child: SvgPicture.asset(
                            CountryISOMapping().getCountryISOFlag(
                                CountryISOMapping()
                                    .getCountryISO2(data.benificiaryCountry!)),
                            width: 18,
                          ),
                          padding: EdgeInsets.all(0),
                        ))
                  ]),
                SizedBox(
                  height: 2,
                ),
                if (data != null &&
                    data.beneFirstName != null &&
                    data.beneFirstName!.isNotEmpty)
                  Text(
                    data.beneFirstName!.toLowerCase().capitalize(),
                    style: AppTextStyles.closeAccountText,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> fetchRecipientList() async {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );

    final loginProvider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );

    await provider.getBeneficiaryList(
        remitterId: loginProvider.userInfo!.response!.userDetails!.remitterId!);
  }

  void showMemberMenu(BuildContext context) async {
    double s = MediaQuery.of(context).size.width * 95;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(s, 50, 0, 50),
      items: const [
        PopupMenuItem(
          value: 1,
          child: Text(
            'Profile',
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            'Logout',
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        if (value == 1) {
          Navigator.pushNamed(context, RouterConstants.profileRoute);
        } else {
          Navigator.popAndPushNamed(context, RouterConstants.loginRoute);
        }
      }
    });
  }

  bool getUserStatus() {
    /* final loginProvider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );

    if (loginProvider.userInfo?.userDetails?.kycStatus.toUpperCase() !=
            'KYC-SENT' &&
        loginProvider.userInfo?.userDetails?.amlStatus.toUpperCase() !=
            'AML-SENT') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Go and Complete their profile.'),
      ));

      return false;
    }*/

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
            var userList = [];

            if (provider.beneficiaryListModel != null &&
                provider.beneficiaryListModel!.response != null) {
              for (var res in provider.beneficiaryListModel!.response!.data!) {
                //print('transferType======== ${res.transferType}');
                //   print('selectPaymentMode======== ${provider.selectPaymentMode}');
                /* if (provider.selectPaymentMode.toLowerCase() ==
                    res.transferType?.toLowerCase()) {
                  userList.add(res);
                }*/
                userList.add(res);
              }
            }

            userList = userList ?? [];
            return Container(
              color: Color.fromARGB(255, 255, 255, 255),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouterConstants.profileRoute);
                        },
                        child: Image.asset(
                          AssetsConstant.onBoardPage_first_1st_img,
                          height: 70,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 8, 2, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: AppTextStyles.twentyRegular,
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                '${loginProvider.userInfo?.response?.userDetails?.firstName}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Inter-Medium',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouterConstants.notificationBellRoute);
                          },
                          child: SvgPicture.asset(
                            AssetsConstant.svgBellIcon,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          RouterConstants.dashboardRoute,
                          arguments: {Constants.dashboardPageOpen: 1},
                          (Route<dynamic> route) => false);
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 145,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadiusDirectional.only(
                                        topStart: Radius.circular(20),
                                        bottomStart: Radius.circular(20)),
                                color:
                                    const Color.fromRGBO(233, 236, 255, 1.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'GBP balance',
                                  style: AppTextStyles.oneGbpText,
                                ),
                                SizedBox(height: 12),
                                if (provider.getWalletModel?.response != null)
                                  Text(
                                    provider.getWalletModel?.response!.balance!
                                            .toStringAsFixed(2)
                                            .toString() ??
                                        '',
                                    style: AppTextStyles.thirtyTwoMedium,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 145,
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(20),
                                  bottomEnd: Radius.circular(20)),
                              color: const Color.fromRGBO(233, 236, 255, 1.0)),
                          child: SizedBox(
                            width: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  provider
                                      .getCountryFlag(provider.sourceCountry),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 2, 2, 0),
                    child: SizedBox(
                      height: 56,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Quick send',
                              style: AppTextStyles.twentySemiBold,
                            ),
                          ),
                          Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 12),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (getUserStatus()) {
                                      Navigator.pushNamed(context,
                                          RouterConstants.recipientNavRoute,
                                          arguments: {
                                            Constants.isComingFromHomePage: true
                                          });
                                    }
                                  },
                                  child: Text(
                                    'See all',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Inter-Medium',
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.signUpBtnColor),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    child: provider.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: userList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return getWidget(
                                  index,
                                  AssetsConstant.girlImageIcon,
                                  userList[index]);
                            }),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 2, 2, 0),
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Transactions',
                              style: AppTextStyles.twentySemiBold,
                            ),
                          ),
                          Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 12),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (getUserStatus()) {
                                      Navigator.pushNamed(
                                        context,
                                        RouterConstants.transitionRoute,
                                      );
                                    }
                                  },
                                  child: Text(
                                    'See all',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Inter-Medium',
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.signUpBtnColor),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  SizedBox(
                    child: provider.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                for (int i = 0; i < 2; i++)
                                  if (provider.transactionList != null &&
                                      provider.transactionList!.response !=
                                          null &&
                                      provider.transactionList!.response!
                                              .length >
                                          0 &&
                                      i <
                                          provider.transactionList!.response!
                                              .length)
                                    transactionItem(
                                        provider.transactionList!.response![i])
                                /*...?provider.transactionList?.response?.map((e) {
                            return transactionItem(e);
                          })*/
                                ,
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget transactionItem(TransactionModel model) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouterConstants.transactionDetailsRoute,
          arguments: {Constants.transRef: model.transSessionId ?? ''},
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            /* Image.asset(
              AssetsConstant.girlImageIcon,
              height: 50,
            ),*/
            if (model.beneficiaryFirstName != null &&
                model.beneficiaryLastName != null &&
                model.destinationCountry != null)
              Stack(children: [
                CircleAvatar(
                  backgroundColor: AppColors.circleGreyColor,
                  radius: 26.0,
                  child: SizedBox(
                      child: Text(
                    getInitials(
                      '${model.beneficiaryFirstName!.trim().toLowerCase().isNotEmpty ? model.beneficiaryFirstName!.trim().toLowerCase().capitalize() : null}'
                      ' ${model.beneficiaryLastName!.trim().toLowerCase().isNotEmpty ? model.beneficiaryLastName!.trim().toLowerCase().capitalize() : null}',
                    ),
                    style: AppTextStyles.letterTitle,
                  )),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      child: SvgPicture.asset(
                        CountryISOMapping().getCountryISOFlag(
                            CountryISOMapping()
                                .getCountryISO2(model.destinationCountry!)),
                        width: 18,
                      ),
                      padding: EdgeInsets.all(0),
                    ))
              ]),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.beneficiaryFirstName != null &&
                      model.beneficiaryFirstName!.isNotEmpty &&
                      model.beneficiaryLastName != null &&
                      model.beneficiaryLastName!.isNotEmpty)
                    Text(
                      '${model.beneficiaryFirstName!.toLowerCase().capitalize()} ${model?.beneficiaryLastName!.toLowerCase().capitalize()}',
                      style: AppTextStyles.semiBoldSixteen,
                    ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Paid | ${model?.dateOnlyFormat()}',
                    style: AppTextStyles.fourteenMediumGrey,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                model.paymentTypePi!.contains('debit-credit-card') && !model.transferTypePo!.contains("wallet")?'- '
                    ''+'${model.sourceAmount ?? 0}  ${model.sourceCurrency ?? ''}'
                    :'+ '''+'${model.sourceAmount ?? 0}  ${model.sourceCurrency ?? ''}',
                style: AppTextStyles.fourteenBold,
              ),
            )),
          ]),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    try {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    } catch (e) {}
    ;
    return '';
  }
}

String getInitials(String user_name) {
  try {
    return user_name.isNotEmpty
        ? user_name
            .trim()
            .split(' ')
            .map((l) => l[0])
            .take(2)
            .join()
            .toUpperCase()
        : '';
  } catch (e) {}
  return '';
}
