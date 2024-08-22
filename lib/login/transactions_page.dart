import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';

import '../colors/AppColors.dart';
import '../common_widget/common_property.dart';
import '../common_widget/country_iso.dart';
import '../constants/common_constants.dart';
import '../model/transaction_list_model.dart';
import '../provider/dashboard_provider.dart';
import '../style/app_font_styles.dart';
import '../style/app_text_styles.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {

  bool _isSearchExpanded = false;
  TextEditingController _searchController = TextEditingController();

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

  /*Widget transactionItem(TransactionModel model) {
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
          Row(
            children: [
              Expanded(child: Text(model.dateFormat())),
              Text(
                model.transactionStatus ?? '',
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
              width: double.infinity,
              child: Divider(
                color: Colors.black87,
                height: 2,
              )),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Recipient',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                '${model.beneficiaryFirstName} ${model.beneficiaryLastName}'
                    .toUpperCase(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Transaction ID',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                model.transSessionId ?? '',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Currency',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                model.sourceCurrency ?? '',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Amount',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                '${model.sourceAmount ?? 0}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }*/

  /* Widget transactionItem(TransactionModel model) {
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
            Image.asset(
              AssetsConstant.girlImageIcon,
              height: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(model.beneficiaryFirstName!=null && model.beneficiaryFirstName!.isNotEmpty && model.beneficiaryLastName!=null&&model.beneficiaryLastName!.isNotEmpty)
                    Text(
                      '${model.beneficiaryFirstName!.toLowerCase().capitalize()} ${model?.beneficiaryLastName!.toLowerCase().capitalize()}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Paid | ${model?.dateOnlyFormat()}',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
                child: Expanded(
                    child: Text(
              '${model.sourceAmount ?? 0}  ${model.sourceCountry ?? ''}',
              style: AppFontStyle.SemiBold,
            )))
          ]),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }*/

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
                  radius: 28.0,
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
                        width: 20,
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
                      '${model.beneficiaryFirstName!.toLowerCase().isNotEmpty ? model.beneficiaryFirstName!.toLowerCase().capitalize() : null}'
                      ' ${model.beneficiaryLastName!.toLowerCase().isNotEmpty ? model.beneficiaryLastName!.toLowerCase().capitalize() : null}',
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
                model.paymentTypePi!.contains('debit-credit')
                    ? '+ ' +
                    '${model.sourceAmount ?? 0}  ${model.sourceCurrency ?? ''}'
                    : '- ' +
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
                height: 10,
              ),
              Row(
                children: [
                  Align(
                    // These values are based on trial & error method
                    alignment: Alignment(-1.05, 1.05),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                     child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _isSearchExpanded
                                  ? Expanded(
                                child: SizedBox(
                                  height: 48,
                                  child: TextField(
                                    controller: _searchController,
                                    decoration: editTextProperty(
                                      hitText: 'Search...'
                                    ),
                                  ),
                                ),
                              )
                                  : Container(),
                              IconButton(
                                icon: Icon(
                                    Icons.search),
                                onPressed: () {
                                  setState(() {
                                    _isSearchExpanded = !_isSearchExpanded;
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () {
                                  _selectDate(context);
                                },
                              ),
                            ],
                          ),


                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: Text(
                  'Transactions',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.screenTitle,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: SizedBox(
              //         height: 48,
              //         child: TextFormField(
              //           decoration: editTextProperty(hitText: 'Search', icon: Icons.search_rounded),
              //           style: const TextStyle(fontSize: 14),
              //           onChanged: (value) {},
              //         ),
              //       ),
              //     ),
              //     const SizedBox(width: 10,),
              //     ElevatedButton(onPressed: (){}, child: const Text('Filter'))
              //   ],
              // ),
              const SizedBox(
                height: 20,
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

Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null && picked != DateTime.now()) {
    // Handle selected date
    print('Selected date: ${picked.toLocal()}');
  }
}