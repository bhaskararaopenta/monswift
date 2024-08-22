import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';

import '../../colors/AppColors.dart';
import '../../common_widget/country_iso.dart';
import '../../model/transaction_list_model.dart';
import '../../provider/dashboard_provider.dart';
import '../../style/app_text_styles.dart';



class ActiveScheduleTransactionPage extends StatefulWidget {
  const ActiveScheduleTransactionPage({Key? key}) : super(key: key);

  @override
  State<ActiveScheduleTransactionPage> createState() => _ActiveScheduleTransactionPageState();
}

class _ActiveScheduleTransactionPageState extends State<ActiveScheduleTransactionPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      final loginProvider = Provider.of<LoginProvider>(
        context,
        listen: false,
      );
      provider.transactionListAPI(data: {
        //'remitter_id': loginProvider.userInfo?.userDetails?.remitterId
        "data": "RemitterId"
      });
    });
    super.initState();
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
            if(model.beneficiaryFirstName !=null && model.beneficiaryLastName!=null && model.destinationCountry!=null)
            Stack(children: [
              CircleAvatar(
                backgroundColor: AppColors.circleGreyColor,
                radius: 30.0,
                child: SizedBox(
                    child: Text(
                      getInitials(
                        '${model.beneficiaryFirstName!.trim().toLowerCase().isNotEmpty ? model.beneficiaryFirstName!.trim().toLowerCase().capitalize() :null}'
                            ' ${model.beneficiaryLastName!.trim().toLowerCase().isNotEmpty?model.beneficiaryLastName!.trim().toLowerCase().capitalize() :null}',
                      ),
                      style: AppTextStyles.letterTitle,
                    )),
              ),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    child: SvgPicture.asset(CountryISOMapping().getCountryISOFlag(CountryISOMapping().getCountryISO2(model.destinationCountry!)),width: 20,),
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
                      '${model.beneficiaryFirstName!.toLowerCase().isNotEmpty ? model.beneficiaryFirstName!.toLowerCase().capitalize() :null}'
                          ' ${model.beneficiaryLastName!.toLowerCase().isNotEmpty?model.beneficiaryLastName!.toLowerCase().capitalize() :null}',
                      style: AppTextStyles.semiBoldSixteen,
                    ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Weekly to ${model?.dateOnlyFormat()}',
                    style: AppTextStyles.fourteenRegular,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${model.sourceAmount ?? 0}  ${model.sourceCurrency ?? ''}',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),

              Consumer<DashBoardProvider>(builder: (_, provider, __) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (provider.transactionList == null ||
                    provider.transactionList!.response!.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text('No transaction list found...'),
                    ),
                  );
                }
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...?provider.transactionList?.response?.map((e) {
                          return transactionItem(e);
                        }),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    try{
    return "${this[0].toUpperCase()}${this.substring(1)}";
    }catch(e){};
    return '';
  }
}
String getInitials(String user_name) {
  try {
    return user_name.isNotEmpty
        ? user_name.trim().split(' ').map((l) => l[0]).take(2)
        .join()
        .toUpperCase()
        : '';
  }catch(e){}
  return '';
}