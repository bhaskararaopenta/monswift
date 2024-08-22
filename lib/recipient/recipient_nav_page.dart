import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:flutter/src/material/dropdown.dart';

import '../common_widget/country_iso.dart';

class RecipientNavPage extends StatefulWidget {
  const RecipientNavPage({super.key});

  @override
  State<RecipientNavPage> createState() => _RecipientNavPageState();
}

// List of items in our dropdown menu

const List<String> list = <String>['Sort', 'All', 'Recent', 'Favorite'];

class _RecipientNavPageState extends State<RecipientNavPage> {
  int _selectedIndex = -1;
  String dropdownValue = list.first;
  final TextEditingController _searchController = TextEditingController();
  late List<Data> baseList = List.empty(growable: true);
  late List<Data> filteredList = List.empty(growable: true);

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

    if (provider.beneficiaryListModel != null && provider.beneficiaryListModel!.response!=null) {
      for (var res in provider.beneficiaryListModel!.response!.data!) {
        //print('transferType======== ${res.transferType}');
        // print('selectPaymentMode======== ${provider.selectPaymentMode}');
        /*if (provider.selectPaymentMode.toLowerCase() ==
                    res.transferType?.toLowerCase()) {
                  userList.add(res);
                }*/
        if (!baseList.contains(res)) {
          baseList.add(res);
        }
        if (!filteredList.contains(res)) {
          filteredList.add(res);
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
                    radius: 28.0,
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
                        // child: Image.asset(AssetsConstant.miniFlag),
                        child: SvgPicture.asset(
                          CountryISOMapping().getCountryISOFlag(
                              CountryISOMapping()
                                  .getCountryISO2(data!.benificiaryCountry!)),
                          width: 18,
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
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouterConstants.recipientDetailsRoute,
                              arguments: {
                                Constants.beneFirstName: data!.beneFirstName,
                                Constants.beneLastName: data.beneLastName,
                                Constants.beneCity: data.beneCity,
                                Constants.beneMobileNumber:
                                    data.beneMobileNumber,
                                Constants.beneMobileCode: data.beneMobileCode,
                                //  'bene_email': emailController.text,
                                Constants.remitterId: data.remitterId,
                                Constants.partnerId: data.partnerId,
                                Constants.beneCountry: data.benificiaryCountry,
                                Constants.beneAddress: data.beneAddress,
                                Constants.beneCardNumber: '',
                                Constants.beneId: data.beneId,
                                Constants.beneRelation:
                                    data.remitterBeneficiaryRelation,
                                Constants.benePostalCode: data.benePostCode,
                              });
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
                        //  Image.asset(AssetsConstant.icStarGrey,),

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
              Container(
                  height: 30,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 219, 222, 228)),
                  padding: EdgeInsets.zero,
                  child: TextButton(
                    onPressed: () {
                      if (getUserStatus()) {
                        Navigator.pushNamed(
                            context, RouterConstants.sendMoneyPageRoute,
                            arguments: {
                              Constants.recipientUserDetails: data,
                              Constants.isComingForSetSchedule: false,
                              Constants.isComingFromRecipientPage: true,
                              Constants.isComingFromRecipientDetailsPage: false,
                              Constants.isComingFromPaymentReviewPage: false,
                            });
                      }
                    },
                    child: Text(
                      'Send',
                      style: AppTextStyles.twelveMedium,
                    ),
                  )),
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
    final loginProvider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );

    /*if (loginProvider.userInfo?.userDetails?.kycStatus.toUpperCase() !=
            'KYC-SENT' &&
        loginProvider.userInfo?.userDetails?.amlStatus.toUpperCase() !=
            'AML-SENT') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Go and Complete their profile.'),
      ));

      return false;
    }
*/
    return true;
  }

  @override
  Widget build(BuildContext context) {
    bool isComingFromHomePage = false;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      try {
        final arguments =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        isComingFromHomePage =
            arguments[Constants.isComingFromHomePage] as bool;
      } catch (e) {}
      ;
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
                if (isComingFromHomePage)
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
                  'Recipients',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                const SizedBox(
                  height: 30,
                ),
                /*    Container(
                  height: 48,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 10),
                      Text(
                        'Name, ',
                        style: AppTextStyles.searchHintText,
                      ),
                      Text('email, ', style: AppTextStyles.searchHintText),
                      Text('phone number', style: AppTextStyles.searchHintText),
                    ],
                  ),
                ),*/
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
                            style: AppTextStyles.eighteenMedium,
                            underline: Container(
                              height: 2,
                              color: Colors.white,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                getSortedRecipient(value!);
                                dropdownValue = value;
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
                                  if (/*getUserStatus()*/ true) {
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
    print('searchKeyword :' +
        searchKeyword +
        '  --  ' +
        filteredList.length.toString());
    List<Data> results = [];
    // filteredList.clear();
    if (searchKeyword.isEmpty) {
      results = baseList;
      print('searchKeyword if :' +
          searchKeyword +
          '  --  ' +
          filteredList.length.toString() +
          ' base ' +
          baseList.length.toString());
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
                c.beneEmail!
                    .toLowerCase()
                    .contains(searchKeyword.toLowerCase()),
          )
          .toList();

      print('searchKeyword else:' +
          searchKeyword +
          '  --  ' +
          filteredList.length.toString() +
          ' base ' +
          baseList.length.toString());
    }

    // refresh the UI
    setState(() {
      filteredList = results;
      print('searchKeyword set:' +
          searchKeyword +
          '  --  ' +
          filteredList.length.toString() +
          ' base ' +
          baseList.length.toString());
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
/* @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    var userList = [];

    if (provider.beneficiaryListModel != null) {
      for (var res in provider.beneficiaryListModel!.data) {
        if (res.beneFirstName
            .toLowerCase()
            .contains(_searchController.text.toString().toLowerCase())) {
          matchQuery.add(res.beneFirstName);
          userList.add(res);
        } else if (res.beneMobileNumber
            .contains(_searchController.text.toString())) {
          matchQuery.add(res.beneMobileNumber);
          userList.add(res);
        } else if (res.beneEmail
            .toLowerCase()
            .contains(_searchController.text.toString().toLowerCase())) {
          matchQuery.add(res.beneEmail);
          userList.add(res);
        }
      }
    }
    return ListView.builder(
        itemCount: userList == null ? 0 : userList.length,
        itemBuilder: (BuildContext context, int index) {
          return getWidget(
              index, AssetsConstant.girlImageIcon, userList[index]);
        });
    setState(() {});
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    var userList = [];
    if (provider.beneficiaryListModel != null) {
      for (var res in provider.beneficiaryListModel!.data) {
        if (res.beneFirstName
            .toLowerCase()
            .contains(_searchController.text.toString().toLowerCase())) {
          matchQuery.add(res.beneFirstName);
          userList.add(res);
        } else if (res.beneMobileNumber
            .contains(_searchController.text.toString())) {
          matchQuery.add(res.beneMobileNumber);
          userList.add(res);
        } else if (res.beneEmail
            .toLowerCase()
            .contains(_searchController.text.toString().toLowerCase())) {
          matchQuery.add(res.beneEmail);
          userList.add(res);
        }
      }
    }
    return ListView.builder(
        itemCount: userList == null ? 0 : userList.length,
        itemBuilder: (BuildContext context, int index) {
          return getWidget(
              index, AssetsConstant.girlImageIcon, userList[index]);
        });
  }*/
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
