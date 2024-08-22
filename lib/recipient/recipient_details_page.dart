import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/common_widget/country_iso.dart';
import 'package:nationremit/model/get_beneficiary_by_id_model.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';

class RecipientDetailsPage extends StatefulWidget {
  const RecipientDetailsPage({Key? key}) : super(key: key);

  @override
  State<RecipientDetailsPage> createState() => _RecipientDetailsPageState();
}

class _RecipientDetailsPageState extends State<RecipientDetailsPage> {
  var beneFirstName = '';
  var beneLastName = '';
  var beneMobileNumber = '';
  var beneMobileCodeNumber = '';
  var beneAddress = '';
  var beneCity = '';
  int beneId = 0;
  int remitterId = 0;
  int partnerId = 0;
  var beneCountry = '';
  var beneRelation = '';
  var benePostalCode = '';
  bool isUpdated = false;

  late BeneficiaryListModel res;

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchRecipientList(String id) async {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );

    res = await provider.getBenificiaryByIdAPI(id: id);
    if (res != null && res.success!) {
      setState(() {
        beneFirstName = res.response!.data![0].beneFirstName!;
        beneLastName = res.response!.data![0].beneLastName!;
        beneMobileNumber = res.response!.data![0].beneMobileNumber!;
        beneMobileCodeNumber = res.response!.data![0].beneMobileCode!;
        beneAddress = res.response!.data![0].beneAddress!;
        beneCity = res.response!.data![0].beneCity!;
        beneCountry = res.response!.data![0].benificiaryCountry!;
        beneRelation = res.response!.data![0].remitterBeneficiaryRelation!;
        benePostalCode = res.response!.data![0].benePostCode!;
        isUpdated =true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (arguments != null && !isUpdated) {
      try {
        beneFirstName = arguments[Constants.beneFirstName] as String;
        beneLastName = arguments[Constants.beneLastName] as String;
        beneMobileNumber = arguments[Constants.beneMobileNumber] as String;
        beneMobileCodeNumber = arguments[Constants.beneMobileCode] as String;
        beneAddress = arguments[Constants.beneAddress] as String;
        beneCity = arguments[Constants.beneCity] as String;
        beneId = arguments[Constants.beneId] as int;
        remitterId = arguments[Constants.remitterId] as int;
        partnerId = arguments[Constants.partnerId] as int;
        beneCountry = arguments[Constants.beneCountry] as String;
        beneRelation = arguments[Constants.beneRelation] as String;
        benePostalCode = arguments[Constants.benePostalCode] as String;
      }catch(e){}
    }

    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
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
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              RouterConstants.dashboardRoute,
                              arguments: {
                                Constants.isComingForSetSchedule: false,
                                Constants.dashboardPageOpen: 3
                              },
                              (Route<dynamic> route) => false);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset(AssetsConstant.icBack),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.0)),
                                ),
                                builder: (BuildContext context) {
                                  return Container(
                                    margin: EdgeInsets.all(15),
                                    child: SizedBox(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                            SvgPicture.asset(
                                                AssetsConstant.ic_bar,
                                                height: 5),
                                            SizedBox(height: 30),
                                            SvgPicture.asset(
                                                AssetsConstant.icRemoveRecipient),
                                            SizedBox(height: 30),
                                            Text(
                                              'Are you sure you want to remove the recipient?',
                                              style:
                                                  AppTextStyles.semiBoldTitleText,
                                              textAlign: TextAlign.center,
                                            ),
                                            Container(
                                              child: Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .cancelBtnColor,
                                                                      textStyle: TextStyle(
                                                                          fontFamily:
                                                                              'Inter-Bold',
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w700,
                                                                          fontSize:
                                                                              18,
                                                                          color: AppColors
                                                                              .textDark),
                                                                      shape:
                                                                          const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                                Radius.circular(65)),
                                                                      ),
                                                                      padding:
                                                                          EdgeInsets.fromLTRB(
                                                                              25,
                                                                              10,
                                                                              25,
                                                                              10)),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false);
                                                              },
                                                              child: Text("No",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontFamily:
                                                                          'Inter-SemiBold',
                                                                      fontWeight:
                                                                          FontWeight.w600,
                                                                      color: AppColors.textDark))),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .textDark,
                                                                textStyle: TextStyle(
                                                                    fontFamily:
                                                                        'Inter-Bold',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize: 18,
                                                                    color: AppColors
                                                                        .textWhite),
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              65)),
                                                                ),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                final provider =
                                                                    Provider.of<
                                                                        DashBoardProvider>(
                                                                  context,
                                                                  listen: false,
                                                                );
                                                                final req = {
                                                                  Constants
                                                                          .beneId:
                                                                      beneId,
                                                                };
                                                                final res =
                                                                    await provider
                                                                        .beneficiaryDelete(
                                                                            data:
                                                                                req);
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            'Recipient deleted successfully');
                                                                Navigator.of(context).pushNamedAndRemoveUntil(
                                                                    RouterConstants
                                                                        .dashboardRoute,
                                                                    arguments: {
                                                                      Constants
                                                                          .dashboardPageOpen: 3
                                                                    },
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false);
                                                              },
                                                              child: provider.isLoading
                                                                  ? const CircularProgressIndicator()
                                                                  :  Text(
                                                                      "Yes",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontFamily:
                                                                              'Inter-SemiBold',
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                      color: AppColors.textWhite))),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: SvgPicture.asset(AssetsConstant.icDelete),
                          ),
                          SizedBox(width: 20),
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(context,
                                    RouterConstants.editRecipientDetailsRoute,
                                    arguments: {
                                      Constants.beneFirstName: beneFirstName,
                                      Constants.beneLastName: beneLastName,
                                      Constants.beneCity: beneCity,
                                      Constants.beneMobileNumber:
                                          beneMobileNumber,
                                      Constants.beneMobileCode:
                                          beneMobileCodeNumber,
                                      //  'bene_email': emailController.text,
                                      Constants.remitterId: remitterId,
                                      Constants.partnerId: partnerId,
                                      Constants.beneCountry: beneCountry,
                                      Constants.beneAddress: beneAddress,
                                      Constants.beneCardNumber: '',
                                      Constants.beneId: beneId,
                                      Constants.beneRelation: beneRelation,
                                      Constants.benePostalCode: benePostalCode,
                                    }).then((value) {
                                  if (value != null) {
                                    fetchRecipientList(beneId.toString());
                                  }
                                });
                              },
                              child: SvgPicture.asset(AssetsConstant.icEdit)),
                        ],
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(AssetsConstant.boyImage),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                beneFirstName,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter-SemiBold'),
                              ),
                              Text(
                                //   '${data.beneFirstName} ${data.beneLastName}'bene,
                                beneRelation,
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
                      const SizedBox(
                        height: 30,
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
                              'Telephone number',
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
                            beneMobileNumber,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter-SemiBold'),
                          ),
                          Divider(
                              color: AppColors.resendBtnColor
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
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
                            beneAddress,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter-SemiBold'),
                          ),
                          Divider(
                              color: AppColors.resendBtnColor
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
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
                            beneCity,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter-SemiBold'),
                          ),
                          Divider(
                              color: AppColors.resendBtnColor
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
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
                            benePostalCode,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter-SemiBold'),
                          ),
                          Divider(
                              color: AppColors.resendBtnColor
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
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
                            CountryISOMapping().getCountryName(beneCountry),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter-SemiBold'),
                          ),
                        ],
                      ),
                      Divider(
                          color: AppColors.resendBtnColor
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child:
                          Consumer<DashBoardProvider>(builder: (_, provider, __) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(65)),
                              ),
                            ),
                            onPressed: () async {
                            var response= await fetchRecipientList(beneId.toString());
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouterConstants.sendMoneyPageRoute,
                                  arguments: {
                                    Constants.recipientUserDetails: res.response!.data![0],
                                    Constants.isComingForSetSchedule: false,
                                    Constants.isComingFromRecipientPage :false,
                                    Constants.isComingFromRecipientDetailsPage :true,
                                    Constants.beneCountry:beneCountry,
                                    Constants.isComingFromPaymentReviewPage: false,
                                  },
                                  ModalRoute.withName(
                                      RouterConstants.dashboardRoute));
                            },
                            child: provider.isLoading
                                ? const CircularProgressIndicator()
                                :  Text("Send",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Inter-SemiBold',
                                        fontWeight: FontWeight.w600,
                                    color: AppColors.textWhite)));
                      }),
                    ),
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
