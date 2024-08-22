import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';

import '../../constants/common_constants.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  DashBoardProvider? provider;
  @override
  void initState() {
    provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
              return Column(
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
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Our Privacy and policies',
                          textAlign: TextAlign.left,
                          style: AppTextStyles.screenTitle,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'PLEASE DO NOT REGISTER OR MAKE ANY TRANSACTIONS'
                          ' WITHOUT READING OUR TERMS AND CONDITIONS. '
                          'WE HAVE MENTIONED OUR AND YOUR OBLIGATIONS AND '
                          'RESPONSIBILITIES IN THESE TERMS AND CONDITIONS.'
                          ' WE HAVE ALSO MENTIONED OUR LIMITATIONS AND '
                          'EXCLUSIONS OF THE TERMS AND CONDITIONS (T&C) '
                          'MONEY TRANSFER.',
                          textAlign: TextAlign.left,
                          style: AppTextStyles.fourteenRegular,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          '1. DEFINITIONS\n'
                          '2. In these Terms and Conditions, the following defined terms shall have the meanings ascribed:\n'
                          '3. "Bank Card "means any Visa or MasterCard credit card, or a debit card.\n'
                          '4. "Business Day" means any working day in the UK and the recipient country.\n'
                          '5. "Card Issuer" means the issuing authority of the bank card.\n'
                          '6. "Payment Method": the way the customer pays for the service. Nation Remit customers are required to pay by bank card only.\n'
                          '7. "Prohibited Purpose" means unlawful activities such as gambling, fraud, etc.\n'
                          '8. "Receiver / Recipient" means the Beneficiary/Beneficiaries of the transactions.\n'
                          '9. "Sender" means an adult who uses Nation Remit online services in transferring the money.\n'
                          '10. "Transaction" means the money transferred using the Nation Remit online services.\n'
                          '11. "Nation Remit", meaning "We", "Our" or "Us" regarding online money transfer services.\n'
                          '12. "Nation Remit Online Service" means the money transfer service using the Nation Remit website and the methods of transferring money.\n'
                          '13. "Nation Remit Website" or "Website" means www.nationremit.com.\n'
                          '14. "You", "Yours" or "Your" means an adult who uses Nation Remit Online Services.\n'
                          '15. A digital money account means a pre-paid account for the Nation Remit service user.\n'
                          '16. Nation Remit Fees means the fees they will charge for every transfer (this will be shown in the Portal).\n'
                          '16. Transaction means any instruction given by the Nation Remit users.\n'
                          '17. Transaction Amount means any money debited to Nation Remit’s digital Money Account.\n'
                          '18. Website means www.nationremit.com',
                          textAlign: TextAlign.left,
                          style: AppTextStyles.sixteenRegularDark,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }


}
