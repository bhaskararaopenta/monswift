import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/more/schedule_transaction/active_schedule_transaction_page.dart';
import 'package:nationremit/router/router.dart';
import 'package:nationremit/style/app_text_styles.dart';

import '../../constants/common_constants.dart';

class ScheduleTransactionTabBarPage extends StatefulWidget {
  const ScheduleTransactionTabBarPage({super.key});

  @override
  State<ScheduleTransactionTabBarPage> createState() =>
      _ScheduleTransactionTabBarPageState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _ScheduleTransactionTabBarPageState
    extends State<ScheduleTransactionTabBarPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 180),
        child: AppBar(
          toolbarHeight: 220,
          leading: null,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                SizedBox(height: 50,),
                Row(
                  children: [
                    SizedBox(width: 10,),
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
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '  Schedule transaction',
                    style: AppTextStyles.boldTitleText,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            unselectedLabelColor: AppColors.greyColor,
            labelColor: AppColors.signUpBtnColor,
            labelStyle: AppTextStyles.tabText,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: AppColors.signUpBtnColor, width: 2),
            ),
            tabs: const <Widget>[
              Tab(text: 'Active'),
              Tab(
                text: 'Deactivated',
              )
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: ActiveScheduleTransactionPage(),
          ),
          Center(child: Text("No list found")),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(50.0,5,5,5),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            backgroundColor:  AppColors.signUpBtnColor,
            onPressed: (){
              Navigator.pushNamed(context, RouterConstants.sendMoneyPageRoute,arguments: {
                Constants.isComingForSetSchedule :true,
                Constants.isComingFromRecipientPage :false,
                Constants.isComingFromRecipientDetailsPage :false,
                Constants.isComingFromPaymentReviewPage: false,
              });
            },
            label:  Text(' Add New ',style: AppTextStyles.fourteenMediumWhite),
            icon: const Icon(Icons.add, color: Colors.white, size: 25),
          ),
        ),
      ),
    );
  }
}
