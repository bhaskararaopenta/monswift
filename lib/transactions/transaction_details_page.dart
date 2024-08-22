import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/transaction_details_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../colors/AppColors.dart';
import '../constants/common_constants.dart';
import '../router/router.dart';
import '../style/app_text_styles.dart';

class TransactionDetailsPage extends StatefulWidget {
  const TransactionDetailsPage({super.key});

  @override
  State<TransactionDetailsPage> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  String? changeDate(String? date) {
    DateTime now = DateTime.parse(date ?? '');
    String formattedDate =
        DateFormat('dd/MM/yyyy, hh:mm a').format(now.toLocal());
    return formattedDate;
  }

  Widget getDetails({required String? title, required String? value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '$value',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  void initState() {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );

    provider.transactionDetailsModel = null;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final arguments =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        String transRef = arguments[Constants.transRef] as String;
        provider.transactionDetailsAPI(transactionId: transRef);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
          TransactionDetailsModel? transactionDetailsModel =
              provider.transactionDetailsModel;
          if (transactionDetailsModel == null) {
            return Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        // These values are based on trial & error method
                        alignment: Alignment(-1.05, 1.05),
                        child: InkWell(
                          onTap: () {
                            /* Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouterConstants.dashboardRoute,arguments: {
                                Constants
                                    .dashboardPageOpen: 1
                              }, (Route<dynamic> route) => false);*/
                            Navigator.pop(context);
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
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            );
          }
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Align(
                      // These values are based on trial & error method
                      alignment: Alignment(-1.05, 1.05),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              RouterConstants.dashboardRoute,
                              arguments: {Constants.dashboardPageOpen: 1},
                              (Route<dynamic> route) => false);
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
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, RouterConstants.transferStatusScreen,
                          arguments: {
                            Constants.transRef:transactionDetailsModel
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadiusDirectional.only(
                                  topStart: Radius.circular(20),
                                  bottomStart: Radius.circular(20),
                                  topEnd: Radius.circular(20),
                                  bottomEnd: Radius.circular(20)),
                              color: const Color.fromRGBO(233, 236, 255, 1.0)),
                          child: Row(children:[
                            CircleAvatar(
                              backgroundColor: AppColors.circleGreyColor,
                              radius: 40.0,
                              child: SizedBox(
                                  child: Text(
                                    getInitials(
                                        '${transactionDetailsModel.response!.beneficiaryFirstName!.trim().isNotEmpty ? transactionDetailsModel.response!.beneficiaryFirstName!.trim().toLowerCase().capitalize() : null}'
                                            ' ${transactionDetailsModel.response!.beneficiaryLastName!.trim().isNotEmpty ? transactionDetailsModel.response!.beneficiaryLastName!.trim().toLowerCase().capitalize() : null}'),
                                    style: AppTextStyles.letterTitle,
                                  )),
                            ),
                            SizedBox(width: 20,),
                            Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12),
                              Text(
                                '+' +
                                    '${transactionDetailsModel.response?.sourceAmount}' +
                                    ' ${transactionDetailsModel.response?.sourceCurrency}',
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Inter-SemiBold',
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                'Received from '+'${transactionDetailsModel.response!.remitterFirstName}',
                                style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 16,
                                    fontFamily: 'Inter-Regular',
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),]
                        ),),
                      )
                    ),
                  /*  Container(
                      height: 132,
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
                              provider.getCountryFlag(provider.sourceCountry),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                      ),
                    ),*/
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Details',
                  style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 24,
                      fontFamily: 'Inter-SemiBold',
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 56,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(20),
                          bottomStart: Radius.circular(20),
                          topEnd: Radius.circular(20),
                          bottomEnd: Radius.circular(20)),
                      color: const Color.fromRGBO(233, 236, 255, 1.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You Received',
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
                          '${transactionDetailsModel.response?.sourceAmount}'+' GBP',
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
                            'Reference Number',
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
                              '#'+'${transactionDetailsModel.response?.transSessionId}',
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
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Received on',
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
                              '${changeDate(transactionDetailsModel.response?.createdAt)}',
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
          );
        }),
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
    print(user_name);
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