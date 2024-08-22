import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:provider/provider.dart';

import '../colors/AppColors.dart';
import '../common_widget/country_iso.dart';
import '../style/app_text_styles.dart';

class SelectRecipientToSendMoneyPage extends StatefulWidget {
  const SelectRecipientToSendMoneyPage({super.key});

  @override
  State<SelectRecipientToSendMoneyPage> createState() =>
      _SelectRecipientToSendMoneyPageState();
}

const List<String> list = <String>['Sort', 'All', 'Recent', 'Favorite'];

class _SelectRecipientToSendMoneyPageState
    extends State<SelectRecipientToSendMoneyPage> {
  int _selectedIndex = -1;
  String dropdownValue = list.first;

  String mAccountHolderNameController = '';
  String mSwiftNameController = '';
  String mAccountNumberController = '';
  String mAccountTypeController = '';
  String mobileNumber = '';
  int mNetworkID = 0;
  String mNetwork = '';
  String mDeliveryType = '';
  int bankId = 0;
  bool isComingForSetSchedule = false;
  bool isComingFromRecipientDetailsPage=  false;
  bool isComingFromRecipientPage=false;
  int collectionPointId = 0;
  String collectionPointName = '';
  String collectionPointCode = '';
  String collectionPointProcBank = '';
  String collectionPointAddress = '';
  String collectionPointCity = '';
  String collectionPointState = '';
  late List<Data> baseList = List.empty(growable: true);
  late List<Data> filteredList = List.empty(growable: true);
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchRecipientList();
    });
    super.initState();
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

    if (provider.beneficiaryListModel != null) {
      for (var res in provider.beneficiaryListModel!.response!.data!) {
        //print('transferType======== ${res.transferType}');
        //  print('selectPaymentMode======== ${provider.selectPaymentMode}');
        if (provider.selectCountryCode.toLowerCase() ==
            res.benificiaryCountry!.toLowerCase()) {
          if (!baseList.contains(res)) {
            baseList.add(res);
          }
          if (!filteredList.contains(res)) {
            filteredList.add(res);
            print('transferType===yui===== ${res.beneFirstName}');
          }
        }
      }
    }
  }

  Future<void> updateRecipient(
      int beneId, String beneCountry, bool isFavorite) async {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );

    final req = {
      Constants.beneId: beneId,
      Constants.beneCountry: beneCountry,
      Constants.isFavorite: isFavorite,
    };
    await provider.beneficiaryMarkFavorite(data: req);
  }

  Widget getWidget(int id, String imagePath, Data? data) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          /*decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: id == _selectedIndex ? Colors.blueAccent : Colors.white),*/
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*Image.asset(
                  imagePath,
                  height: 50,
                ),*/
              if (data != null &&
                  data.beneFirstName!.isNotEmpty &&
                  data.beneLastName!.isNotEmpty)
                Stack(children: [
                  CircleAvatar(
                    backgroundColor: AppColors.circleGreyColor,
                    radius: 30.0,
                    child: SizedBox(
                        child: Text(
                      getInitials(
                          '${data.beneFirstName!.trim().isNotEmpty ? data.beneFirstName!.trim().toLowerCase().capitalize() : null}'
                          ' ${data.beneLastName!.trim().isNotEmpty ? data.beneLastName!.trim().toLowerCase().capitalize() : null}'),
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
                                  .getCountryISO2(data!.benificiaryCountry!)),
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
                    if (data != null &&
                        data.beneFirstName != null &&
                        data.beneFirstName!.isNotEmpty &&
                        data.beneLastName != null &&
                        data.beneLastName!.isNotEmpty)
                      GestureDetector(
                        onTap: () async {
                          if (getUserStatus()) {
                            final provider = Provider.of<DashBoardProvider>(
                              context,
                              listen: false,
                            );
                            var req;
                            //  try {
                            switch (mDeliveryType) {
                              case "Account":
                                req = {
                                  //  Constants.beneMobileNumber: mobileNumber,
                                  Constants.beneId: data!.beneId,
                                  Constants.beneCountry:
                                      data.benificiaryCountry,
                                  Constants.beneCity: '',
                                  "bene_bank_details": {
                                    Constants.accountHolderName:
                                        mAccountHolderNameController,
                                    Constants.accountNumber:
                                        mAccountNumberController,
                                    Constants.swiftCode: mSwiftNameController,
                                    Constants.accountType:
                                        mAccountTypeController,
                                    "bank": "",
                                    // "bank_branch_id": bankId,
                                    "bank_city": "",
                                    "bank_state": "",
                                    "bank_additional_details": "",
                                    //"bank_branch_code":'',
                                    "bank_branch_id":
                                        provider.getDeliveryBankBranch != null
                                            ? provider.getDeliveryBankBranch
                                                ?.response![0].id
                                            : ''
                                  },
                                };
                                break;
                              case "Bank Transfer":
                                req = {
                                  //  Constants.beneMobileNumber: mobileNumber,
                                  Constants.beneId: data!.beneId,
                                  Constants.beneCountry:
                                      data.benificiaryCountry,
                                  Constants.beneCity: '',
                                  "bene_bank_details": {
                                    Constants.accountHolderName:
                                        mAccountHolderNameController,
                                    Constants.accountNumber:
                                        mAccountNumberController,
                                    Constants.swiftCode: mSwiftNameController,
                                    Constants.accountType:
                                        mAccountTypeController,
                                    "bank": "",
                                    //"bank_branch_id": bankId,
                                    "bank_city": "",
                                    "bank_state": "",
                                    "bank_additional_details": "",
                                    "bank_branch_id":
                                        provider.getDeliveryBankBranch != null
                                            ? provider.getDeliveryBankBranch
                                                ?.response![0].id
                                            : ''
                                  },
                                };
                                break;
                              case "Mobile Transfer":
                                req = {
                                  //  Constants.beneMobileNumber: mobileNumber,
                                  Constants.beneId: data!.beneId,
                                  Constants.beneCountry:
                                      data.benificiaryCountry,
                                  "mobile_transfer_number": mobileNumber,
                                  "mobile_transfer_network": mNetwork,
                                  "mobile_transfer_network_id": mNetworkID,
                                  Constants.beneCity: 'london',
                                };
                                break;
                              case "Cash Collection":
                                req = {
                                  Constants.beneId: data!.beneId,
                                  Constants.collectionPointId:
                                      collectionPointId,
                                  Constants.collectionPointName:
                                      collectionPointName,
                                  Constants.collectionPointCode:
                                      collectionPointCode,
                                  Constants.collectionPointProcBank:
                                      collectionPointProcBank,
                                  Constants.collectionPointAddress:
                                      collectionPointAddress,
                                  Constants.collectionPointCity:
                                      collectionPointCity,
                                  Constants.collectionPointState:
                                      collectionPointState,
                                  Constants.collectionPointTel: "",
                                  "is_favorite": false
                                };
                                break;
                              case "Wallet Transfer":
                                break;
                              case "Cash Pickup":
                                req = {
                                  Constants.beneId: data!.beneId,
                                  Constants.collectionPointId:
                                      collectionPointId,
                                  Constants.collectionPointName:
                                      collectionPointName,
                                  Constants.collectionPointCode:
                                      collectionPointCode,
                                  Constants.collectionPointProcBank:
                                      collectionPointProcBank,
                                  Constants.collectionPointAddress:
                                      collectionPointAddress,
                                  Constants.collectionPointCity:
                                      collectionPointCity,
                                  Constants.collectionPointState:
                                      collectionPointState,
                                  Constants.collectionPointTel: "",
                                  "is_favorite": false
                                };
                                break;
                            }

                            /*mDeliveryType == 'Bank Transfer'
                    ? req = {
                        //  Constants.beneMobileNumber: mobileNumber,
                        Constants.beneId: data!.beneId,
                        Constants.beneCountry: data.benificiaryCountry,
                        Constants.beneCity: 'london',
                        "bene_bank_details": {
                          Constants.accountHolderName:
                              mAccountHolderNameController,
                          Constants.accountNumber: mAccountNumberController,
                          Constants.swiftCode: mSwiftNameController,
                          Constants.accountType: mAccountTypeController,
                          "bank": "AXIS",
                          "bank_branch_id": bankId,
                          "bank_city": "London",
                          "bank_state": "Hyderabad",
                          "bank_additional_details": "",
                          "bank_branch_code":
                              provider.getDeliveryBankBranch != null
                                  ? provider
                                      .getDeliveryBankBranch
                                      ?.response
                                      ?.deliveryBankBranches
                                      ?.deliveryBankBranch![0]
                                      .id
                                  : '8395'
                        },
                      }
                    : req = {
                        //  Constants.beneMobileNumber: mobileNumber,
                        Constants.beneId: data!.beneId,
                        Constants.beneCountry: data.benificiaryCountry,
                        "mobile_transfer_number": mobileNumber,
                        "mobile_transfer_network": mNetwork,
                        "mobile_transfer_network_id": mNetworkID,
                        Constants.beneCity: 'london',
                      };*/

                            final res =
                                await provider.beneficiaryUpdate(data: req);
                            if (mounted && res.success!) {
                              Navigator.pushNamed(
                                  context, RouterConstants.transferDetailRoute,
                                  arguments: {
                                    Constants.recipientUserDetails: data,
                                    Constants.deliveryType: mDeliveryType,
                                    Constants.isComingForSetSchedule:
                                        isComingForSetSchedule,
                                    Constants.isComingFromRecipientDetailsPage:  isComingFromRecipientDetailsPage,
                                    Constants.isComingFromRecipientPage: isComingFromRecipientPage,
                                  });
                            } else {
                              if (!res.success!) {
                                provider.setLoadingStatus(false);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(res.error!.message),
                                ));
                              }
                            }
                            /*} catch (e) {
                                provider.setLoadingStatus(false);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(e.toString()),
                                ));
                              }*/
                            /*Navigator.pushNamed(context, RouterConstants.transferDetailRoute,
                  arguments: {
                    Constants.recipientUserDetails: data,
                    Constants.deliveryType: mDeliveryType
                  });*/
                          }
                        },
                        onTapDown: (_) {
                          setState(() {
                            _selectedIndex = id;
                          });
                        },
                        child: Text(
                          '${data?.beneFirstName!.toLowerCase().capitalize()} ${data?.beneLastName!.toLowerCase().capitalize()}',
                          style: AppTextStyles.eighteenMedium,
                        ),
                      ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          '${data?.remitterBeneficiaryRelation} | ',
                          style: AppTextStyles.fourteenMediumGrey,
                        ),
                        // Image.asset(AssetsConstant.icStarGrey)
                        StarButton(
                          isStarred: data!.isFavorite == true ? true : false,
                          iconSize: 38,
                          iconColor: Color.fromARGB(255, 239, 112, 103),
                          //   iconDisabledColor:Color.fromARGB(112, 37, 35, 35),
                          valueChanged: (_isStarred) {
                            updateRecipient(data!.beneId!,
                                data.benificiaryCountry!, _isStarred);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
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
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      mAccountHolderNameController =
          arguments[Constants.accountHolderName] as String;
      mAccountNumberController = arguments[Constants.accountNumber] as String;
      mSwiftNameController = arguments[Constants.swiftCode] as String;
      mAccountTypeController = arguments[Constants.accountType] as String;
      mobileNumber = arguments[Constants.beneMobileNumber] as String;
      mNetwork = arguments[Constants.mobileTransferNetwork] as String;
      mNetworkID = arguments[Constants.mobileTransferNetworkId] as int;
      mDeliveryType = arguments[Constants.deliveryType] as String;
      bankId = arguments[Constants.bankId] as int;
      isComingForSetSchedule =
          arguments[Constants.isComingForSetSchedule] as bool;
      isComingFromRecipientPage =
      arguments[Constants.isComingFromRecipientPage] as bool;
      isComingFromRecipientDetailsPage =
      arguments[Constants.isComingFromRecipientDetailsPage] as bool;

      collectionPointName = arguments[Constants.collectionPointName] as String;
      collectionPointCode = arguments[Constants.collectionPointCode] as String;
      collectionPointProcBank =
          arguments[Constants.collectionPointProcBank] as String;
      collectionPointAddress =
          arguments[Constants.collectionPointAddress] as String;
      collectionPointCity = arguments[Constants.collectionPointCity] as String;
      collectionPointState =
          arguments[Constants.collectionPointState] as String;
      collectionPointId = arguments[Constants.collectionPointId] as int;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const Text(
                  'Who do you want to send to?',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Name, phone number',
                      contentPadding: EdgeInsets.all(10),
                      // Add a search icon or button to the search bar
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onChanged: (query) {
                      _runFilter(query);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 2, 2, 0),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 16,
                            style: TextStyle(
                                color: AppColors.textDark,
                                fontFamily: 'Inter-SemiBold',
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            underline: Container(
                              height: 2,
                              color: Colors.white,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                getSortedRecipient(value!);
                                dropdownValue = value!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (getUserStatus()) {
                                    Navigator.pushNamed(
                                            context,
                                            RouterConstants
                                                .selectCountryForRecipientRoute)
                                        .then((value) {
                                      fetchRecipientList();
                                    });
                                  }
                                },
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColors.textDark),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(8),
                        ),
                      ],
                    ),
                  ),
                ),
                if (filteredList.isEmpty)
                  provider.isLoading
                      ? Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(),
                            height: 50.0,
                            width: 50.0,
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: const Text(
                                'No recipient found for selected country',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        )
                else
                  Expanded(
                    child: provider.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return getWidget(
                                  index,
                                  AssetsConstant.girlImageIcon,
                                  filteredList[index]);
                            }),
                  ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  void _runFilter(String searchKeyword) {
    List<Data> results = [];
    //  filteredList.clear();
    if (searchKeyword.isEmpty) {
      results = baseList;
    } else {
      results = baseList
          .where(
            (c) =>
                c.beneFirstName!
                    .toLowerCase()
                    .contains(searchKeyword.toLowerCase()) ||
                c.beneMobileNumber!
                    .toLowerCase()
                    .contains(searchKeyword.toLowerCase()) ||
                c.beneEmail!.toLowerCase().contains(searchKeyword.toLowerCase()),
          )
          .toList();
    }

    // refresh the UI
    setState(() {
      filteredList = results;
    });
  }

  Future<void> getSortedRecipient(String value) async {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    try {
      final data = {
        "sort": "Beneficiary",
        "action": value // All , Recent , Favorite
      };
      final response = await provider.getSortedRecipient(data: data);
      if (response != null) {
        baseList.clear();
        filteredList.clear();
        for (var res in response.response!.data!) {
          //print('transferType======== ${res.transferType}');
          // print('selectPaymentMode======== ${provider.selectPaymentMode}');
          /*if (provider.selectPaymentMode.toLowerCase() ==
                    res.transferType?.toLowerCase()) {
                  userList.add(res);
                }*/
          baseList.add(res);
        }
      }
      setState(() {
        filteredList = baseList;
      });

      provider.setLoadingStatus(false);
    } catch (e) {
      provider.setLoadingStatus(false);
      /*ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      content: Text(e.toString()),
    ));*/
    }
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
