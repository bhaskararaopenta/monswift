import 'package:flutter_svg/flutter_svg.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:flutter/material.dart';
import '../colors/AppColors.dart';
import '../common_widget/common_property.dart';
import '../webview/bottomsheet_webview_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final referralController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final countryController = TextEditingController();

  DashBoardProvider? _provider;
  String _countryCode = 'GBP';
  bool isReferralClicked = false;
  bool _showPassword = true;
  bool _showConfirmPassword = true;

  bool _isEmailEmpty = false;

  bool _isMinimumEightCharacters = false;
  bool _isOneUpperCase = false;
  bool _isOneLowerCase = false;
  bool _isOneNumericCase = false;
  bool _showError = false;
  bool _showInstructions = false;

  @override
  void initState() {
    _provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );

    // passwordController.addListener;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    passwordController.addListener(() {
      setState(() {
        _isMinimumEightCharacters = passwordController.text.isEmpty
            ? false
            : passwordController.text.trim().length > 7;

        _isOneLowerCase = passwordController.text.isEmpty
            ? false
            : passwordController.text.containsLowercase;

        _isOneUpperCase = passwordController.text.isEmpty
            ? false
            : passwordController.text.containsUppercase;

        _isOneNumericCase = passwordController.text.isEmpty
            ? false
            : passwordController.text.trim().containsNumber;

        _showInstructions = passwordController.text.isEmpty ? false : true;
        _showError = passwordController.text.isEmpty
            ? false
            : passwordController.text.trim() !=
            confirmPasswordController.text.trim();
        _formKey.currentState!.validate();
      });
    });
    confirmPasswordController.addListener(() {
      setState(() {
        _showError = passwordController.text.isEmpty
            ? false
            : passwordController.text.trim() !=
                confirmPasswordController.text.trim();
        if(_showError)_formKey.currentState!.validate();
      });
    });

    emailController.addListener(() {
      setState(() {
        _isEmailEmpty = emailController.text.isEmpty
            ? false
            : true;
        if(_isEmailEmpty)_formKey.currentState!.validate();
      });
    });
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Create account',
                      style: AppTextStyles.boldTitleText,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Text(
                          'Have an account?',
                          style: AppTextStyles.subtitleText,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RouterConstants.loginRoute);
                          },
                          child: Text(
                            ' Login',
                            style: AppTextStyles.semiBoldSixteen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Email',
                      style: AppTextStyles.subTitle,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 48,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        // using regular expression
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      decoration: editTextProperty(hitText: 'Enter your email'),
                      style: const TextStyle(fontSize: 14),
                      controller: emailController,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Password',
                      style: AppTextStyles.subTitle,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 48,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: _showPassword,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        errorStyle: TextStyle(height: 0.1, fontSize: 10),
                        errorMaxLines: 2,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              _showPassword
                                  ? AssetsConstant.icVisibilityOn
                                  : AssetsConstant.icVisibilityOff,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        isDense: false,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 219, 222, 228),
                              width: 1.0), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 219, 222, 228),
                              width: 1.0), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 219, 222, 228),
                              width: 1.0), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Confirm password',
                      style: AppTextStyles.subTitle,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 48,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      controller: confirmPasswordController,
                      obscureText: _showConfirmPassword,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        errorStyle: TextStyle(height: 0.1, fontSize: 10),
                        errorMaxLines: 2,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showConfirmPassword = !_showConfirmPassword;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              _showConfirmPassword
                                  ? AssetsConstant.icVisibilityOn
                                  : AssetsConstant.icVisibilityOff,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        isDense: false,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 219, 222, 228),
                              width: 1.0), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 219, 222, 228),
                              width: 1.0), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 219, 222, 228),
                              width: 1.0), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  if (_showError)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            " Password must match",
                            style: AppTextStyles.passwordMismatchError,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (_showInstructions)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Your password must have:',
                                style: AppTextStyles.twelveSemiBold,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Row(
                            children: [
                              _isMinimumEightCharacters
                                  ? Image.asset(AssetsConstant.ic_tick)
                                  : Image.asset(AssetsConstant.ic_dot),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Minimum 8 characters',
                                style: _isMinimumEightCharacters
                                    ? AppTextStyles.greenText
                                    : AppTextStyles.instructions,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              _isOneUpperCase
                                  ? Image.asset(AssetsConstant.ic_tick)
                                  : Image.asset(AssetsConstant.ic_dot),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '1 upper case letter (A-Z)',
                                style: _isOneUpperCase
                                    ? AppTextStyles.greenText
                                    : AppTextStyles.instructions,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              _isOneLowerCase
                                  ? Image.asset(AssetsConstant.ic_tick)
                                  : Image.asset(AssetsConstant.ic_dot),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '1 lower case letter (a-z)',
                                style: _isOneLowerCase
                                    ? AppTextStyles.greenText
                                    : AppTextStyles.instructions,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              _isOneNumericCase
                                  ? Image.asset(AssetsConstant.ic_tick)
                                  : Image.asset(AssetsConstant.ic_dot),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '1 numeric character (0-9)',
                                style: _isOneNumericCase
                                    ? AppTextStyles.greenText
                                    : AppTextStyles.instructions,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (!isReferralClicked)
                              isReferralClicked = true;
                            else
                              isReferralClicked = false;
                          });
                        },
                        child: Text(
                          'Enter your referral code link',
                          style: AppTextStyles.gbpText,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (isReferralClicked)
                    SizedBox(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter';
                          }
                          return null;
                        },
                        decoration: editTextProperty(hitText: 'Enter'),
                        style: const TextStyle(fontSize: 14),
                        controller: referralController,
                        onChanged: (value) {},
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Consumer<LoginProvider>(builder: (_, provider, __) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !_showError &&
                                    _isMinimumEightCharacters &&
                                    _isOneUpperCase &&
                                    _isOneLowerCase &&
                                    _isOneNumericCase && _isEmailEmpty
                                ? AppColors.signUpBtnColor
                                : AppColors.outlineBtnColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(65)),
                            ),
                          ),
                          onPressed: provider.isLoading
                              ? null
                              : () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    if (!_showError &&
                                        _isMinimumEightCharacters &&
                                        _isOneUpperCase &&
                                        _isOneLowerCase &&
                                        _isOneNumericCase) {
                                      final provider =
                                          Provider.of<LoginProvider>(
                                        context,
                                        listen: false,
                                      );
                                      try {
                                        final res = await provider.createUser(
                                          password: passwordController.text,
                                          email: emailController.text,
                                          mobileNo: mobileController.text,
                                          username: nameController.text,
                                          sourceCountry: _countryCode,
                                        );

                                        if (mounted && res.success!) {
                                          Navigator.pushNamed(
                                            context,
                                            RouterConstants.verifyMailRoute,
                                            arguments: {
                                              Constants.email:
                                                  emailController.text,
                                              Constants.forgotPassword: false
                                            },
                                          );
                                        } else if (mounted &&
                                            !res.success! &&
                                            res.error?.statusCode == 420) {
                                          Navigator.pushNamed(
                                            context,
                                            RouterConstants.verifyMailRoute,
                                            arguments: {
                                              Constants.email:
                                                  emailController.text,
                                              Constants.forgotPassword: false
                                            },
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(res.error!.message!),
                                          ));
                                        }
                                      } catch (e) {
                                        provider.setLoadingStatus(false);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(e.toString()),
                                        ));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'Password must match conditions'),
                                      ));
                                    }
                                  }
                                },
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  "Continue",
                                  style: !_showError &&
                                          _isMinimumEightCharacters &&
                                          _isOneUpperCase &&
                                          _isOneLowerCase &&
                                          _isOneNumericCase && _isEmailEmpty
                                      ? AppTextStyles.enableContinueBtnTxt
                                      : AppTextStyles.disableContinueBtnTxt,
                                ));
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                       // Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              _showBottomSheet(context, "https://pub.dev/packages/webview_flutter/install");

                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'By registering, you accept Nation Remit\'s ',
                                  style: AppTextStyles.twelveRegular,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  ' Terms &',
                                  style: AppTextStyles.twelveSemiBold,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Conditions and Privacy Policy',
                            style: AppTextStyles.twelveSemiBold,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _showBottomSheet(BuildContext context, String url) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BottomSheetWebView();
      },
    );
  }
}

extension StringValidators on String {
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));

  bool get containsLowercase => contains(RegExp(r'[a-z]'));

  bool get containsNumber => contains(RegExp(r'[0-9]'));
}
