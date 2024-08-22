import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/signup/signup_page.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:flutter/material.dart';

class RestPasswordPage extends StatefulWidget {
  const RestPasswordPage({Key? key}) : super(key: key);

  @override
  State<RestPasswordPage> createState() => _RestPasswordPageState();
}

class _RestPasswordPageState extends State<RestPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(ModalRoute
        .of(context)!
        .settings
        .arguments != null) {
      final arguments =
      ModalRoute
          .of(context)!
          .settings
          .arguments as Map<String, dynamic>;
      final email = arguments[Constants.email] as String;
      emailController.text = email;
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  AssetsConstant.logo,
                  height: 80,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Rest Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 29),
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Email',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black87),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    decoration: editTextProperty(
                        svg: AssetsConstant.userIcon,
                        hitText: 'Enter your email'),
                    style: const TextStyle(fontSize: 14),
                    controller: emailController,
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'New Password',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black87),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
                      if (value.length == 8) {
                        return 'New password should be 8 digit';
                      }

                      return null;
                    },
                    decoration: editTextProperty(
                        svg: AssetsConstant.userIcon,
                        hitText: 'Enter your new password'),
                    style: const TextStyle(fontSize: 14),
                    controller: newPasswordController,
                    obscureText: true,
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Confirm Password',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black87),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Confirm password';
                      }
                      if (value != newPasswordController.text) {
                        return 'Confirm password and New password should be same.';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: editTextProperty(
                        svg: AssetsConstant.userIcon,
                        hitText: 'Enter your Confirm password'),
                    style: const TextStyle(fontSize: 14),
                    controller: confirmPasswordController,
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Consumer<LoginProvider>(builder: (_, provider, __) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onPressed: provider.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    final provider = Provider.of<LoginProvider>(
                                      context,
                                      listen: false,
                                    );
                                    await provider.resetPasswordAPI(
                                        email: emailController.text,
                                        newPassword: newPasswordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text);
                                    if (mounted) {
                                      Navigator.pushNamed(
                                        context,
                                        RouterConstants.loginRoute,
                                      );
                                    }
                                  } catch (e) {
                                    provider.setLoadingStatus(false);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(e.toString()),
                                    ));
                                  }
                                }
                              },
                        child: provider.isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Submit"));
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
