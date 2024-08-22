import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';

import '../../constants/common_constants.dart';

class HelpFAQPage extends StatefulWidget {
  const HelpFAQPage({Key? key}) : super(key: key);

  @override
  State<HelpFAQPage> createState() => _HelpFAQPageState();
}

class _HelpFAQPageState extends State<HelpFAQPage> {
  LoginProvider? provider;
  bool _customTileExpanded = false;
  final TextEditingController _searchController = TextEditingController();

  //int _activeMeterIndex = -1;

  final helpQuestion = [
    {
      'question': 'Who are NationRemit?',
      'answer':
          'NationRemit is an international financial services provider Authorised and Regulated by the UK Financial Services Authority (FCA). We provide a simple, fair, and convenient way to send money to an increasing number of nations across the world. You can read more About Us here.'
    },
    {
      'question': 'Is my money safe?',
      'answer':
          'To deposit funds into your wallet, click on the My Wallet tab on the left side menu. You’ll see a Wallet page with your current balance and recent wallet transactions. Here, click on the green “Deposit” button. Select one of the deposit methods. You can load your wallet with money using three methods.'
    },
    {
      'question': 'Is my data safe?',
      'answer':
          'NationRemit is an international financial services provider Authorised and Regulated by the UK Financial Services Authority (FCA). We provide a simple, fair, and convenient way to send money to an increasing number of nations across the world. You can read more About Us here.'
    },
    {
      'question': 'How Can I Send Money?',
      'answer':
          'NationRemit is an international financial services provider Authorised and Regulated by the UK Financial Services Authority (FCA). We provide a simple, fair, and convenient way to send money to an increasing number of nations across the world. You can read more About Us here.'
    },
    {
      'question': 'What Are Your Fees?',
      'answer':
          'NationRemit is an international financial services provider Authorised and Regulated by the UK Financial Services Authority (FCA). We provide a simple, fair, and convenient way to send money to an increasing number of nations across the world. You can read more About Us here.'
    },
  ];

  bool isSearchClicked = false;

  @override
  void initState() {
    provider = Provider.of<LoginProvider>(
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
                  Offstage(
                    offstage: isSearchClicked,
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            'How can we help?',
                            textAlign: TextAlign.left,
                            style: AppTextStyles.screenTitle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isSearchClicked = true;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                        AssetsConstant.icSearch),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !isSearchClicked,
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
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
                  ),
                  ListView.builder(
                    itemCount: helpQuestion.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final question = helpQuestion[index]['question'];
                      final answer = helpQuestion[index]['answer'];
                      return getWidget(index, helpQuestion);
                    },
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 10, 10, 0),
                    child: GestureDetector(
                      onTap: () {
                        showBottomSheetContactInfo();
                      },
                      child: Text(
                        ' Other contact information',
                        style: TextStyle(
                            shadows: [
                              Shadow(
                                  color: AppColors.signUpBtnColor,
                                  offset: Offset(0, -5))
                            ],
                            color: Colors.transparent,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.signUpBtnColor,
                            decorationThickness: 1,
                            fontSize: 16,
                            fontFamily: 'Inter-Regular',
                            fontWeight: FontWeight.w600),
                      ),
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

  Widget getWidget(int index, List<Map<String, String>> helpQuestion) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          helpQuestion[index]['question']!,
          style: AppTextStyles.eighteenMedium,
          textAlign: TextAlign.left,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Text(
              helpQuestion[index]['answer']!,
              style: AppTextStyles.sixteenRegular,
              textAlign: TextAlign.start,
            ),
          ),
        ],
        trailing: Icon(
          _customTileExpanded
              ? Icons.keyboard_arrow_down
              : Icons.keyboard_arrow_right,
          color: AppColors.greyColor,
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            // _activeMeterIndex =index;
            _customTileExpanded = expanded;
          });
        },
      ),
    );
  }

  void _runFilter(String searchKeyword) {
    List<String> results = [];
/*
    if (searchKeyword.isEmpty) {
      results = baseList;
    } else {
      results = baseList
          .where(
            (c) =>
        c.beneFirstName
            .toLowerCase()
            .contains(searchKeyword.toLowerCase()) ||
            c.beneMobileNumber
                .toLowerCase()
                .contains(searchKeyword.toLowerCase()) ||
            c.beneEmail.toLowerCase().contains(searchKeyword.toLowerCase()),
      )
          .toList();
    }

    // refresh the UI
    setState(() {
      filteredList = results;
    });*/
  }

  void showBottomSheetContactInfo() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(15),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10),
                SvgPicture.asset(AssetsConstant.ic_bar, height: 5),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        bottomStart: Radius.circular(20),
                        topEnd: Radius.circular(20),
                        bottomEnd: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 5),
                          SvgPicture.asset(AssetsConstant.icMail),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'support@monoswift.com',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: AppColors.textDark,
                                  fontSize: 18,
                                  fontFamily: 'Inter-Medium',
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        bottomStart: Radius.circular(20),
                        topEnd: Radius.circular(20),
                        bottomEnd: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 5),
                          SvgPicture.asset(AssetsConstant.icPhone),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              '+44 0204 537 9666',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: AppColors.textDark,
                                  fontSize: 18,
                                  fontFamily: 'Inter-Medium',
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        );
      },
    );
  }
}
