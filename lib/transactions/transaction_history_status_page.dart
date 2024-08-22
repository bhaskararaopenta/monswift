import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors/AppColors.dart';
import '../common_widget/common_property.dart';
import '../constants/common_constants.dart';
import '../constants/constants.dart';
import '../model/transaction_details_model.dart';
import '../style/app_text_styles.dart';

class TransferStatusScreen extends StatefulWidget {
  @override
  _TransferStatusScreenState createState() => _TransferStatusScreenState();
}

class _TransferStatusScreenState extends State<TransferStatusScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TransactionDetailsModel? transactionDetailsModel;

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
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      transactionDetailsModel = arguments[Constants.transRef];
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment(-1.05, 1.05),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: SvgPicture.asset(AssetsConstant.icBack),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadiusDirectional.only(
                              topStart: Radius.circular(20),
                              bottomStart: Radius.circular(20),
                              topEnd: Radius.circular(20),
                              bottomEnd: Radius.circular(20)),
                          color: const Color.fromRGBO(233, 236, 255, 1.0)),
                      child: Row(children: [
                        CircleAvatar(
                          backgroundColor: AppColors.circleGreyColor,
                          radius: 40.0,
                          child: SizedBox(
                              child: Text(
                            getInitials(
                                '${transactionDetailsModel!.response!.beneficiaryFirstName!.trim().isNotEmpty ? transactionDetailsModel!.response!.beneficiaryFirstName!.trim().toLowerCase().capitalize() : null}'
                                ' ${transactionDetailsModel!.response!.beneficiaryLastName!.trim().isNotEmpty ? transactionDetailsModel!.response!.beneficiaryLastName!.trim().toLowerCase().capitalize() : null}'),
                            style: AppTextStyles.letterTitle,
                          )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12),
                            Text(
                              '+' +
                                  '${transactionDetailsModel!.response?.sourceAmount}' +
                                  ' ${transactionDetailsModel!.response?.sourceCurrency}',
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Inter-SemiBold',
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Received from ' +
                                  '${transactionDetailsModel!.response!.remitterFirstName}',
                              style: TextStyle(
                                  color: AppColors.greyColor,
                                  fontSize: 16,
                                  fontFamily: 'Inter-Regular',
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Status'),
                Tab(text: 'Details'),
              ],
              labelColor: AppColors.signUpBtnColor,
              unselectedLabelColor: AppColors.greyColor,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  StatusTab(),
                  DetailsTab(transactionDetailsModel),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    primary: AppColors.signUpBtnColor, // button color
                  ),
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  child: Text(
                    'Send again',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StatusItem(
          time: '10:30 AM',
          date: '27th October',
          description: 'You set up your transfer',
          isCompleted: true,
        ),
        StatusItem(
          time: '10:30 AM',
          date: '27th October',
          description: 'You used your GBP Balance',
          isCompleted: true,
        ),
        StatusItem(
          time: '10:35 AM',
          date: '27th October',
          description: 'We paid out your GBP',
          isCompleted: true,
        ),
        StatusItem(
          time: '11:30 AM',
          date: '27th October',
          description: 'Your transfer is complete',
          isCompleted: true,
          isFinal: true,
        ),
      ],
    );
  }
}

class DetailsTab extends StatelessWidget {
  TransactionDetailsModel? transactionDetailsModel;

  DetailsTab(TransactionDetailsModel? this.transactionDetailsModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.circular(20),
                      bottomStart: Radius.circular(20),
                      topEnd: Radius.circular(20),
                      bottomEnd: Radius.circular(20)),
                  color: const Color.fromRGBO(233, 236, 255, 1.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You sent',
                        style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 16,
                            fontFamily: 'Inter-Regular',
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '- ' +
                              '${transactionDetailsModel!.response?.sourceAmount}' +
                              ' GBP',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 16,
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fee',
                        style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 16,
                            fontFamily: 'Inter-Regular',
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '- ' +
                              '${transactionDetailsModel!.response?.agentFee}' +
                              ' GBP',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 16,
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total paid',
                        style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 16,
                            fontFamily: 'Inter-Regular',
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '- ' +
                              '${transactionDetailsModel!.response?.amountPaid}' +
                              ' GBP',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 16,
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.circular(20),
                      bottomStart: Radius.circular(20),
                      topEnd: Radius.circular(20),
                      bottomEnd: Radius.circular(20)),
                  color: const Color.fromRGBO(233, 236, 255, 1.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recipient received',
                        style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 16,
                            fontFamily: 'Inter-Regular',
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '- ' +
                              '${transactionDetailsModel!.response?.sourceAmount}' +
                              ' GBP',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 16,
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.circular(20),
                      bottomStart: Radius.circular(20),
                      topEnd: Radius.circular(20),
                      bottomEnd: Radius.circular(20)),
                  color: const Color.fromRGBO(233, 236, 255, 1.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Method of sending',
                        style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 16,
                            fontFamily: 'Inter-Regular',
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '- ' +
                              '${transactionDetailsModel!.response?.sourceAmount}' +
                              ' GBP',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 16,
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.circular(20),
                      bottomStart: Radius.circular(20),
                      topEnd: Radius.circular(20),
                      bottomEnd: Radius.circular(20)),
                  color: const Color.fromRGBO(233, 236, 255, 1.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction number',
                        style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 16,
                            fontFamily: 'Inter-Regular',
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '#' +
                              '${transactionDetailsModel!.response?.transSessionId}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 16,
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Relationship to recipient',
                        style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 16,
                            fontFamily: 'Inter-Regular',
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '${transactionDetailsModel!.response?.sourceOfIncome}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 16,
                              fontFamily: 'Inter-Regular',
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Purpose of sending',
                        style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 16,
                            fontFamily: 'Inter-Regular',
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '${transactionDetailsModel!.response?.purpose}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 16,
                              fontFamily: 'Inter-Regular',
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusItem extends StatelessWidget {
  final String time;
  final String date;
  final String description;
  final bool isCompleted;
  final bool isFinal;

  const StatusItem({
    required this.time,
    required this.date,
    required this.description,
    this.isCompleted = false,
    this.isFinal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Column(
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isCompleted
                    ? (isFinal ? Colors.green : AppColors.outlineBtnColor)
                    : Colors.grey,
              ),
              if (!isFinal)
                Container(
                  width: 1,
                  height: 50,
                  color: Colors.grey,
                ),
            ],
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: isFinal ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
