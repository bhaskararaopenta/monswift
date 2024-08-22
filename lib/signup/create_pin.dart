import 'package:flutter_svg/svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common_widget/common_property_pin.dart';
import '../style/app_text_styles.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({Key? key}) : super(key: key);

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  String enteredPin = '';
  bool isPinVisible = false;

  /// this widget will be use for each digit
  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (enteredPin.length < 4) {
              enteredPin += number.toString();
            }
          });
        },
        child: Text(
          number.toString(),
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: AppColors.textDark,
              fontFamily: 'Inter-Regular'),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final email = arguments[Constants.email] as String;
    final isFromProfilePage =
        arguments[Constants.isComingFromProfilePage] as bool;
    final isFromLoginPinPage =
        arguments[Constants.isComingFromLoginPinPage] as bool;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
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
                          child: SvgPicture.asset(AssetsConstant.crossIcon),
                        ),
                      ),
                    ),
                    if (!isFromProfilePage)
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(AssetsConstant.icBarSelected),
                            SizedBox(width: 5),
                            Image.asset(AssetsConstant.icUnBarSelected),
                            SizedBox(width: 5),
                            Image.asset(AssetsConstant.icUnBarSelected),
                            SizedBox(width: 5),
                            Image.asset(AssetsConstant.icUnBarSelected),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    isFromProfilePage ? ' Reset PIN' : ' Create your PIN',
                    style: AppTextStyles.createPinTitle,
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                /// pin code area
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 50, 24, 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) {
                        return Container(
                          margin: const EdgeInsets.all(12.0),
                          width: isPinVisible ? 50 : 18,
                          height: isPinVisible ? 50 : 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: index < enteredPin.length
                                ? isPinVisible
                                    ? Colors.green
                                    : AppColors.textDark
                                : AppColors.textDark.withOpacity(0.1),
                          ),
                          child: isPinVisible && index < enteredPin.length
                              ? Center(
                                  child: Text(
                                    enteredPin[index],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              : null,
                        );
                      },
                    ),
                  ),
                ),

                /// visiblity toggle button
                /* IconButton(
                  onPressed: () {
                    setState(() {
                      isPinVisible = !isPinVisible;
                    });
                  },
                  icon: Icon(
                    isPinVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                ),

                SizedBox(height: isPinVisible ? 50.0 : 8.0),*/

                /// digits
                for (var i = 0; i < 3; i++)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (index) => numButton(1 + 3 * i + index),
                      ).toList(),
                    ),
                  ),

                /// 0 digit with back remove
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(
                            () {
                              if (enteredPin.isNotEmpty) {
                                enteredPin = enteredPin.substring(
                                    0, enteredPin.length - 1);
                              }
                            },
                          );
                        },
                        child: Image.asset(AssetsConstant.ic_eraser),
                      ),
                      numButton(0),
                      TextButton(
                        onPressed: () {
                          if(isFromProfilePage || isFromLoginPinPage){
                            Navigator.pushNamed(
                                context, RouterConstants.resetPinRoute,
                                arguments: {
                                  Constants.email: email,
                                  Constants.userPin: enteredPin,
                                  Constants.isComingFromProfilePage:
                                  isFromProfilePage,
                                  Constants.isComingFromLoginPinPage:
                                  isFromLoginPinPage
                                });
                          }else {
                            Navigator.pushNamed(
                                context, RouterConstants.confirmPinRoute,
                                arguments: {
                                  Constants.email: email,
                                  Constants.userPin: enteredPin,
                                  Constants.isComingFromProfilePage:
                                  isFromProfilePage
                                });
                          }
                        },
                        child: Image.asset(AssetsConstant.ic_check),
                      ),
                    ],
                  ),
                ),

                /// reset button
                /*TextButton(
                  onPressed: () {
                    setState(() {
                      enteredPin = '';
                    });
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
