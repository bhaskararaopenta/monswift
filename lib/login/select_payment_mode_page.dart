import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';

class SelectPaymentModePage extends StatefulWidget {
  const SelectPaymentModePage({Key? key}) : super(key: key);

  @override
  State<SelectPaymentModePage> createState() => _SelectPaymentModePageState();
}

class _SelectPaymentModePageState extends State<SelectPaymentModePage> {

  @override
  void initState() {
    super.initState();
  }

  Widget getWidget(DashBoardProvider provider, String imagePath, PaymentMethodCodes data) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, data.description);
      },
      onTapDown: (_){
         provider.selectPaymentMode = data.description!;
      },
      onTapCancel: (){
        provider.selectPaymentMode = data.description!;
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 243, 245, 248)),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SvgPicture.asset(AssetsConstant.navWalletIcon),
            SizedBox(height: 5,),
            Text(
              data.description!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:AppColors.greyColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter-SemiBold',
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Container(
          height: 160,
          padding: const EdgeInsets.all(16),
          child: Consumer<DashBoardProvider>(
                    builder: (_, provider, __) {
                      return ListView.builder(
                        itemCount: provider.partnerTransactionSettingsModel?.response!.paymentMethodCodes == null ? 0
                            : provider.partnerTransactionSettingsModel?.response!.paymentMethodCodes!.length,
                          itemBuilder: (context, index){
                            return getWidget(provider, AssetsConstant.rwandaFlagIcon, provider.partnerTransactionSettingsModel!.response!.paymentMethodCodes![index]);
                      },
                        scrollDirection: Axis.horizontal,
                      );
                  }
                ),


        ),
      ),
    );
  }
}
