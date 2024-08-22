import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/support_email_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:provider/provider.dart';

import '../colors/AppColors.dart';
import '../constants/common_constants.dart';
import '../router/router.dart';
import '../style/app_text_styles.dart';

class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({Key? key}) : super(key: key);

  @override
  State<ContactSupportPage> createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  final _formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  var email = '';
  var name = '';
  var isComingFromSignUpPage=false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final provider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );
    if(arguments!=null){
      final email = arguments[Constants.email] as String;
       isComingFromSignUpPage = arguments[Constants.isComingFromSignUpPage] as bool;
    }
    email = provider.userInfo!.response!.userDetails!.email!;
    name = provider.userInfo!.response!.userDetails!.firstName!;

    subjectController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    messageController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
              return Form(
                key: _formKey,
                child: Center(
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
                        width: double.infinity,
                        child: Text(
                          'How can we help?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Inter-Bold',
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: AppColors.textDark),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          controller: subjectController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            } else if (value.length < 3) {
                              return 'Address should be more than 2 characters';
                            }
                            return null;
                          },
                          decoration: editTextProperty(hitText: 'Subject'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z0-9'-, ]")),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 148,
                        child: TextFormField(
                          controller: messageController,
                          decoration: editTextMessage(hitText: 'Message'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                          maxLines: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  subjectController.text.isNotEmpty &&
                                          messageController.text.isNotEmpty
                                      ? AppColors.signUpBtnColor
                                      : AppColors.outlineBtnColor,
                              textStyle: TextStyle(
                                  fontFamily: 'Inter-Bold',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppColors.textWhite),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(65)),
                              ),
                            ),
                            onPressed: provider.isLoading
                                ? null
                                : () async {
                                    try {

                                      final provider =
                                          Provider.of<DashBoardProvider>(
                                        context,
                                        listen: false,
                                      );
                                      final req = {
                                        "email": email,
                                        "message": messageController.text,
                                        "subject": subjectController.text,
                                        "name": "app"
                                      };

                                      SupportEmailModel res = await provider
                                          .sendEmailToSupport(data: req);
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      if (res.success!) {
                                        if(isComingFromSignUpPage){
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                              msg:
                                              res.message!);
                                        }else{
                                          Navigator.pushNamed(
                                              context,
                                              RouterConstants
                                                  .supportEmailSuccessRoute,arguments: {
                                            Constants.userFirstName:name,
                                            Constants.isComingFromSignUpPage:isComingFromSignUpPage,
                                          }
                                          );
                                        }

                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text('${res.error?.message}'),
                                        ));
                                      }
                                    } catch (e) {
                                      provider.setLoadingStatus(false);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(e.toString()),
                                      ));
                                    }
                                  },
                            child: provider.isLoading
                                ? const CircularProgressIndicator()
                                : Text("Send",
                                    style: subjectController.text.isNotEmpty &&
                                            messageController.text.isNotEmpty
                                        ? AppTextStyles.enableContinueBtnTxt
                                        : AppTextStyles.disableContinueBtnTxt)),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void showBottomSheetWhyIsThisNeeded() {
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
                Image.asset(AssetsConstant.onBoardPage_first_1st_img),
                SizedBox(height: 30),
                Text(
                  'Verify your account',
                  style: AppTextStyles.boldBottomTitleText,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Get verified and enjoy access to all features available on Monoswift.',
                    style: AppTextStyles.fourteenRegularNavDisableColor,
                    textAlign: TextAlign.center,
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
