import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/login/home_page_new.dart';
import 'package:nationremit/login/payment_type_page.dart';
import 'package:nationremit/recipient/recipient_nav_page.dart';
import 'package:nationremit/login/send_money_page.dart';
import 'package:nationremit/more/more_nav_page.dart';
import 'package:nationremit/payment/select_recipient_sending_money_page.dart';
import 'package:nationremit/login/transactions_page.dart';
import 'package:nationremit/router/router.dart';
import 'package:nationremit/style/app_font_styles.dart';

import '../wallet/wallet_page_nav.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
//  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int i = 0;

  Widget currentScreen() {
    switch (i) {
      case 0:
        {
          return const HomePageNew();
        }
      case 1:
        {
          return const WalletPageNav();
        }
      case 2:
        {
          return const SendMoneyPage();
        }
      case 3:
        {
          return const RecipientNavPage();
        }
      case 4:
        {
          return const MoreNavPage();
        }
      default:
        return const HomePageNew();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final arguments =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        i = arguments[Constants.dashboardPageOpen] as int;
        /* final CurvedNavigationBarState? navBarState =
            _bottomNavigationKey.currentState;
        navBarState?.setPage(i);*/
        setState(() {
          i;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 251, 254),
      body: currentScreen(),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(AssetsConstant.navSendPngIcon),
        mini: false,
        backgroundColor: Colors.transparent,
        tooltip: 'Send',
        onPressed: () {
          setState(() {
            //i=2;
            Navigator.pushNamed(context, RouterConstants.sendMoneyPageRoute,
                arguments: {
                  Constants.isComingForSetSchedule: false,
                  Constants.isComingFromRecipientPage: false,
                  Constants.isComingFromRecipientDetailsPage: false,
                  Constants.isComingFromPaymentReviewPage: false,
                });
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        padding: EdgeInsets.all(0),
        notchMargin: 8,
        child: Container(
          color: const Color.fromARGB(255, 251, 251, 254),
          height: 80,
          child: Row(
            children: <Widget>[
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          i = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AssetsConstant.navHomeIcon,
                              color: i == 0
                                  ? AppColors.navSelectedColor
                                  : AppColors.navDisableColor),
                          SizedBox(height: 2),
                          Text(
                            'Home',
                            style: TextStyle(
                                color: i == 0
                                    ? AppColors.navSelectedColor
                                    : AppColors.navDisableColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          i = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AssetsConstant.navWalletIcon,
                              color: i == 1
                                  ? AppColors.navSelectedColor
                                  : AppColors.navDisableColor),
                          SizedBox(height: 2),
                          Text(
                            'Wallet',
                            style: TextStyle(
                                color: i == 1
                                    ? AppColors.navSelectedColor
                                    : AppColors.navDisableColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //right tabs

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  'Send',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.navDisableColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400),
                ),
              ),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          i = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AssetsConstant.navRecipientIcon,
                              color: i == 3
                                  ? AppColors.navSelectedColor
                                  : AppColors.navDisableColor),
                          SizedBox(height: 2),
                          Text('Recipient',
                              style: TextStyle(
                                  color: i == 3
                                      ? AppColors.navSelectedColor
                                      : AppColors.navDisableColor,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          i = 4;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AssetsConstant.navMoreIcon,
                              color: i == 4
                                  ? AppColors.navSelectedColor
                                  : AppColors.navDisableColor),
                          SizedBox(height: 2),
                          Text(
                            'More',
                            style: TextStyle(
                                color: i == 4
                                    ? AppColors.navSelectedColor
                                    : AppColors.navDisableColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      /*  bottomNavigationBar: BottomNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.transparent,

        onTap: (index) {
          // Handle button tap
          setState(() {
            i = index;
          });
        },
      ),*/
    );
  }
}
