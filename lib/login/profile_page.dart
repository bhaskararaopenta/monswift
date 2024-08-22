import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/model/register_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';

import '../model/partner_source_country_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final documentType = [
    'Please Select',
    'Passport',
    'Driving License',
    'National identity card(with photo)',
    'UK Residence permit'
  ];

  String docType = 'Please Select';

  SourceCurrency? dropdownValue;
  PayoutBank? _payoutBank;

  final ImagePicker _picker = ImagePicker();

  final fNameController = TextEditingController();
  final mNameController = TextEditingController();
  final lNameController = TextEditingController();
  final mobileController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final postcodeController = TextEditingController();
  final dobController = TextEditingController();
  final docExpiryController = TextEditingController();
  final uploadDocumentController = TextEditingController();
  final docNumberController = TextEditingController();

  String? base64string;
  String? fileName;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      provider.getProfileDetails();
      provider.getPayoutsBanksList(countryCode: provider.destinationCountry);

    });
    super.initState();
  }

  openDatePicker(
      {required BuildContext context,
      required TextEditingController controller}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      //get today's date
      firstDate: DateTime(1900),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      print(
          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
      String formattedDate = DateFormat('dd-MM-yyyy').format(
          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
      print(
          formattedDate); //formatted date output using intl package =>  2022-07-04
      //You can format date as per your need

      setState(() {
        controller.text = formattedDate; //set foratted date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> uploadImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        fileName = pickedFile.name;
        Uint8List imageBytes = await imageFile.readAsBytes(); //convert to bytes
        base64string =
            base64.encode(imageBytes); //convert bytes to base64 string
        setState(() {
          uploadDocumentController.text = fileName!;
        });
      }
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
      body: SafeArea(
        child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
          if (provider.profileDetailsModel == null) {
            return Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'My details',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 300,
                    child: Text(
                      'Your profile details are displayed below. Changing the details may require you to re-verify your account.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black45, fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ))
                ],
              ),
            );
          }

          fNameController.text = provider.profileDetailsModel?.response[0].firstName ?? '';
          lNameController.text = provider.profileDetailsModel?.response[0].lastName ?? '';
          dobController.text = provider.profileDetailsModel?.response[0].dateOfBirth.replaceAll('-', '/') ?? '';
          addressController.text = provider.profileDetailsModel?.response[0].address1 ?? '';
          cityController.text = provider.profileDetailsModel?.response[0].city ?? '';
          postcodeController.text = provider.profileDetailsModel?.response[0].postalCode ?? '';
          mobileController.text = provider.profileDetailsModel?.response[0].mobileNumber ?? '';
          docNumberController.text = provider.profileDetailsModel?.response[0].documentNumber ?? '';
          docExpiryController.text = provider.profileDetailsModel?.response[0].documentExpiryDate.replaceAll('-', '/') ?? '';

          try {
            final dType = documentType.where((element) =>
            element.toUpperCase() ==
                provider.profileDetailsModel?.response[0].documentType
                    .toUpperCase());
            docType = dType.first;
          }catch(e){}

          final countryList = provider.countryModel!
              .response[0].sourceCurrency.where((element) {
                return element.countryCode == provider.profileDetailsModel!.response[0].sourceCountry;
          }).toList();
          dropdownValue = countryList.isNotEmpty ? countryList.first : provider.countryModel!.response[0].sourceCurrency[0];

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
                return Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'My details',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: 300,
                          child: Text(
                            'Your profile details are displayed below. Changing the details may require you to re-verify your account.',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black45, fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'First Name',
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
                            controller: fNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                            decoration:
                                editTextProperty(hitText: 'Enter your name'),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Middle Name',
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
                            controller: mNameController,
                            validator: (value) {
                              return null;
                            },
                            decoration: editTextProperty(
                                hitText: 'Enter your middle name'),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Surname',
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
                            controller: lNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please surname name';
                              }
                              return null;
                            },
                            decoration:
                                editTextProperty(hitText: 'Enter last name'),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Date of birth',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black87),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            openDatePicker(
                                context: context, controller: dobController);
                          },
                          child: SizedBox(
                            child: TextFormField(
                              enabled: false,
                              controller: dobController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please date of birth';
                                }
                                return null;
                              },
                              decoration:
                                  editTextProperty(hitText: 'dd/mm/yyyy'),
                              style: const TextStyle(fontSize: 14),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Nationality',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black87),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            //background color of dropdown button
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: DropdownButton<SourceCurrency>(
                              value: dropdownValue,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(),
                              isExpanded: true,
                              onChanged: (SourceCurrency? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                  //_paymentMethodCode = null;
                                  _payoutBank = null;
                                });
                                provider.getPayoutsBanksList(
                                    countryCode: value!.countryCode);
                              },
                              hint: const Text(''),
                              items: provider.countryModel!
                                  .response[0].sourceCurrency
                                  .map<DropdownMenuItem<SourceCurrency>>(
                                      (SourceCurrency value) {
                                return DropdownMenuItem<SourceCurrency>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Image.asset(provider.getCountryFlag(
                                          value.currencySupported[0].currency)),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(value.countryName),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Contact Details',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black87),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Address',
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
                            controller: addressController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please your address';
                              }
                              return null;
                            },
                            decoration:
                                editTextProperty(hitText: 'Enter address'),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'City',
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
                            controller: cityController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please your city';
                              }
                              return null;
                            },
                            decoration:
                                editTextProperty(hitText: 'Enter your city'),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Postcode',
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
                            controller: postcodeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please your postcode';
                              }
                              return null;
                            },
                            decoration: editTextProperty(
                                hitText: 'Enter your postcode'),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Mobile Number',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black87),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: mobileController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter mobile number';
                                  }
                                  else {
                                    if (value.length != 11)
                                      return 'Mobile Number must be of 10 digit';
                                  }
                                  return null;
                                },
                                decoration: editTextProperty(
                                    hitText: 'Enter Mobile number'),
                                style: const TextStyle(fontSize: 14),
                                onChanged: (value) {},
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Proof of ID',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black87),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Document type',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black87),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            //background color of dropdown button
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: DropdownButton<String>(
                              value: docType,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(),
                              isExpanded: true,
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  docType = value!;
                                });
                              },
                              hint: const Text(''),
                              items: documentType.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Document number',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black87),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: docNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter document number';
                                  }
                                  return null;
                                },
                                decoration: editTextProperty(
                                    hitText: 'Enter document number'),
                                style: const TextStyle(fontSize: 14),
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Document expiry date',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black87),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            openDatePicker(
                                controller: docExpiryController,
                                context: context);
                          },
                          child: SizedBox(
                            child: TextFormField(
                              enabled: false,
                              controller: docExpiryController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please document expiry date';
                                }
                                return null;
                              },
                              decoration:
                                  editTextProperty(hitText: 'dd/mm/yyyy'),
                              style: const TextStyle(fontSize: 14),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Upload Document',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black87),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () async {
                            uploadImage();
                          },
                          child: SizedBox(
                            child: TextFormField(
                              enabled: false,
                              controller: uploadDocumentController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please upload document';
                                }
                                return null;
                              },
                              decoration:
                                  editTextProperty(hitText: 'No file chosen'),
                              style: const TextStyle(fontSize: 14),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigoAccent,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    if (dobController.text.isEmpty ||
                                        dropdownValue == null ||
                                        docType == 'Please Select' ||
                                        docExpiryController.text.isEmpty ||
                                        uploadDocumentController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            'Please fill or select all filed'),
                                      ));
                                      return;
                                    }
                                    final loginProvider =
                                        Provider.of<LoginProvider>(
                                      context,
                                      listen: false,
                                    );
                                    final req = {
                                      'partner_id': loginProvider
                                          .userInfo?.response?.userDetails?.partnerId,
                                      'remitter_id': loginProvider
                                          .userInfo?.response?.userDetails?.remitterId,
                                      'first_name': fNameController.text,
                                      'middle_name': mNameController.text,
                                      'last_name': lNameController.text,
                                      'date_of_birth': dobController.text,
                                      'nationality':
                                          dropdownValue?.currencySupported[0] ??
                                              '',
                                      'address1': addressController.text,
                                      'city': cityController.text,
                                      'postal_code': postcodeController.text,
                                      'mobile_number':
                                          '${dropdownValue?.mobileCode}${mobileController.text}',
                                      'document_type': docType,
                                      'document_number':
                                          docNumberController.text,
                                      'document_expiry_date':
                                          docExpiryController.text,
                                      'image': base64string
                                    };

                                    RegisterModel res = await provider
                                        .userDetailUpdateAPI(data: req);

                                    if (mounted) {
                                      if (res.success!) {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Recipient successfully added!');
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text('${res.error?.message}'),
                                        ));
                                      }
                                    }
                                  } catch (e) {
                                    provider.setLoadingStatus(false);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(e.toString()),
                                    ));
                                  } finally {
                                    provider.setLoadingStatus(false);
                                  }
                                }
                              },
                              child: provider.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text("Save Changes")),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}
