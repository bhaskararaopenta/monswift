import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';

import '../colors/AppColors.dart';
import '../constants/common_constants.dart';
import '../constants/constants.dart';
import '../model/register_model.dart';
import '../provider/login_provider.dart';
import '../router/router.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreenForPassport extends StatefulWidget {
  const TakePictureScreenForPassport({
    super.key,
  });

  @override
  TakePictureScreenForPassportState createState() => TakePictureScreenForPassportState();
}

class TakePictureScreenForPassportState extends State<TakePictureScreenForPassport> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  FlashMode? _currentFlashMode;
  final ImagePicker _picker = ImagePicker();
  String? base64string;
  String? fileName;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    //Constants.capturedImagePaths.clear();
  }

  void _initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    CameraDescription description =
        await availableCameras().then((cameras) => cameras[0]);
    _controller = CameraController(description, ResolutionPreset.medium);
    _initializeControllerFuture = _controller!.initialize();
    _currentFlashMode = _controller!.value.flashMode;
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller?.dispose();
    Constants.capturedImagePaths.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final email = arguments[Constants.email] as String;
    final firstName = arguments[Constants.userFirstName] as String;
    final lastName = arguments[Constants.userLastName] as String;
    final dob = arguments[Constants.userDateOfBirth] as String;
    final mobileNumber = arguments[Constants.userMobileNumber] as String;
    final userAddress1 = arguments[Constants.userAddress1] as String;
    final userAddress2 = arguments[Constants.userAddress2] as String;
    final town = arguments[Constants.userTown] as String;
    final city = arguments[Constants.userCity] as String;
    final postalCode = arguments[Constants.usePostalCode] as String;
    final userDocumentType = arguments[Constants.userDocumentType] as String;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 15, 15),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
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
                          child: SvgPicture.asset(AssetsConstant.icBack),
                        ),
                      ),
                    ),

                /*    Expanded(
                      child: Center(
                        child: Constants.capturedImagePaths.length ==1
                            ? Text(
                                "Back",
                                style: AppTextStyles.sixteenRegularWhite,
                              )
                            : Text(
                                "Front",
                                style: AppTextStyles.sixteenRegularWhite,
                              ),
                      ),
                    ),*/
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                showBottomSheetWhyIsThisNeeded();
                              },
                              child: Image.asset(
                                AssetsConstant.icInfo,
                                width: 40,
                                height: 48,
                              )),
                          SizedBox(width: 5)
                        ],
                      ),
                    ),
                  ],
                ),
                FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the Future is complete, display the preview.
                      return Stack(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Card(
                            elevation: 50,
                            shadowColor: Color.fromRGBO(
                                203, 137, 137, 0.9019607843137255),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                            ),
                            child: CameraPreview(_controller!),
                          ),
                        ),
                        new Positioned.fill(
                          child: new Opacity(
                            opacity: 0.8,
                            child: Image.asset(AssetsConstant.icFrameCamera),
                          ),
                        ),
                      ]);
                    } else {
                      // Otherwise, display a loading indicator.
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(height: 5),
                Column(
                  children: [
                    Text(
                      "Center Properly",
                      style: AppTextStyles.twentyBold,
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Place ID on a plain surface\n Confirm entire ID is visible and clear",
                      style: AppTextStyles.cameraInstructions,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                if (_controller!.value.flashMode == FlashMode.off) {
                  await _controller!.setFlashMode(FlashMode.torch);
                  isFlashOn = true;
                } else {
                  await _controller!.setFlashMode(FlashMode.off);
                  isFlashOn = false;
                }
                setState(() {});
              },
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 0, 5),
                  child: SvgPicture.asset(
                    AssetsConstant.icFlash,
                    color: isFlashOn ? Colors.amber : Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                // Provide an onPressed callback.
                backgroundColor: AppColors.textDark,
                onPressed: () async {
                  // Take the Picture in a try / catch block. If anything goes wrong,
                  // catch the error.
                  try {
                    // Ensure that the camera is initialized.
                    await _initializeControllerFuture;

                    // Attempt to take a picture and get the file `image`
                    // where it was saved.
                    final image = await _controller!.takePicture();
                    Constants.capturedImagePaths.add(image.path);
                    if (!mounted) return;

                    // If the picture was taken, display it on a new screen.
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(
                            // Pass the automatically generated path to
                            // the DisplayPictureScreen widget.
                            imagePath: image.path,
                            email: email,
                            firstName: firstName,
                            lastName: lastName,
                            dob: dob,
                            mobileNumber: mobileNumber,
                            userAddress1: userAddress1,
                            userAddress2: userAddress2,
                            town: town,
                            city: city,
                            postalCode: postalCode,
                            documentType: userDocumentType,
                            isPickedFromPhone: false,
                            base64string: ''),
                      ),
                    );
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    print(e);
                  }
                },
                child: Image.asset(
                  AssetsConstant.icClick,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                  onTap: () async {
                    // Take the Picture in a try / catch block. If anything goes wrong,
                    // catch the error.
                    try {
                      uploadImage(
                          email,
                          firstName,
                          lastName,
                          dob,
                          mobileNumber,
                          userAddress1,
                          userAddress2,
                          town,
                          city,
                          postalCode,
                          userDocumentType);
                    } catch (e) {
                      // If an error occurs, log the error to the console.
                      print(e);
                    }
                  },
                  child: SvgPicture.asset(
                    AssetsConstant.icUpload,
                  )),
            ),
          ],
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Guidelines',
                    style: AppTextStyles.boldBottomTitleText,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '• Place ID on a plain surface\n• ID must be valid and not expired\n'
                      '• ID must be in colour\n• All four corners must be visible\n'
                      '• Only EEA passport accepted',
                      style: AppTextStyles.sixteenRegular,
                      textAlign: TextAlign.start,
                    ),
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

  Future<void> uploadImage(
      String email,
      String firstName,
      String lastName,
      String dob,
      String mobileNumber,
      String userAddress1,
      String userAddress2,
      String town,
      String city,
      String postalCode,
      String userDocumentType) async {
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
        setState(() {});
        // If the picture was taken, display it on a new screen.
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DisplayPictureScreen(
                // Pass the automatically generated path to
                // the DisplayPictureScreen widget.
                imagePath: pickedFile.path,
                email: email,
                firstName: firstName,
                lastName: lastName,
                dob: dob,
                mobileNumber: mobileNumber,
                userAddress1: userAddress1,
                userAddress2: userAddress2,
                town: town,
                city: city,
                postalCode: postalCode,
                documentType: userDocumentType,
                isPickedFromPhone: true,
                base64string: base64string! ?? ''),
          ),
        );
      }
    } finally {}
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String email;
  final String firstName;
  final String lastName;
  final String dob;
  final String mobileNumber;
  final String userAddress1;
  final String userAddress2;
  final String town;
  final String city;
  final String postalCode;
  final String documentType;
  final String base64string;
  final bool isPickedFromPhone;

  const DisplayPictureScreen(
      {super.key,
      required this.imagePath,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.dob,
      required this.mobileNumber,
      required this.userAddress1,
      required this.userAddress2,
      required this.town,
      required this.city,
      required this.postalCode,
      required this.documentType,
      required this.isPickedFromPhone,
      required this.base64string});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.8,
              child: Column(
                children: [
                  Card(
                      elevation: 1.0,
                      color: AppColors.textWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Constants.capturedImagePaths.length==1
                          ? Image.file(
                              File(Constants.capturedImagePaths[0]),
                              height: MediaQuery.of(context).size.height / 2,
                            )
                          : Image.file(
                              File(Constants.capturedImagePaths[1]),
                              height: MediaQuery.of(context).size.height / 2,
                            )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        if (Constants.capturedImagePaths.length==1)
                          Constants.capturedImagePaths.removeAt(0);
                        else
                          Constants.capturedImagePaths.removeAt(1);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetsConstant.icRefresh),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Retake',
                            style: AppTextStyles.retake,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
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
                            backgroundColor: AppColors.signUpBtnColor,
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
                                    List<Map<String, dynamic>> jsonArray = [];
                                    Map<String, dynamic> jsonObject  = {
                                            "document_type": documentType,
                                            "document_expiry_date": "21-08-2025",
                                            "document_number": getRandomNumber(email),
                                            "document_section":"document-front",
                                            "image": isPickedFromPhone
                                                ? base64string
                                                : 'data:image/jpg;base64,' +
                                                getImagePath(
                                                    isPickedFromPhone,
                                                    Constants
                                                        .capturedImagePaths[0])
                                        };
                                          jsonArray.add(jsonObject);

                                      final req = {
                                        "updated_by": "Remitter",
                                        "email": email,
                                        "first_name": firstName,
                                        "middle_name": "",
                                        "last_name": lastName,
                                        "gender": "M",
                                        "nationality": "USA",
                                        "date_of_birth": "21-05-1992",
                                        "mobile_number": mobileNumber,
                                        "address1": userAddress1,
                                        "address2": userAddress2,
                                        "city": city,
                                        "postal_code": postalCode,
                                        "documents": jsonArray
                                      };
                                      print(req);
                                      RegisterModel res = await provider
                                          .userDetailUpdateAPI(data: req);

                                      if (res.success!) {
                                        Navigator.pushNamed(
                                            context,
                                            RouterConstants
                                                .successPageProfileDetailsUpdated,
                                            arguments: {
                                              Constants.userFirstName: firstName
                                            });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              '${res.error?.message}'),
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
                              :Text("Submit",
                              style: AppTextStyles.buttonText));
                    })),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, RouterConstants.contactSupportPageRoute,
                    arguments: {Constants.email: email,
                    Constants.isComingFromSignUpPage :true});
              },
              child: Text(
                "Contact support",
                style: AppTextStyles.retake,
              ),
            ),
            SizedBox(height: 10),
          ]),
        ),
      ),
    );
  }

  String getImagePath(bool isPickedFromPhone, String capturedImagePath) {
    try {
      String img64 = '';
      if (isPickedFromPhone) {
      } else {
        final bytes = Io.File(capturedImagePath).readAsBytesSync();

        //img64 = base64Encode(bytes);
        img64 = base64Encode(bytes);
        // print(img64.substring(0, 100));
      }
      return img64;
    } finally {}
  }

  String getRandomNumber(String input) {
    // Hash the input string using a hash function (e.g., hashCode)
    int seed = input.hashCode;

    // Initialize Random class with the hashed seed
    Random random = Random(seed);

    // Generate a random number between 0 and 999 (adjust range as needed)
    int randomNumber = random.nextInt(1000);

    return randomNumber.toString();
  }
}
