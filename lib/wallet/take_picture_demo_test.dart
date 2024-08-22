import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
class TakePictureScreenDemo extends StatefulWidget {
  const TakePictureScreenDemo({
    super.key,
  });

  @override
  TakePictureScreenDemoState createState() => TakePictureScreenDemoState();
}

class TakePictureScreenDemoState extends State<TakePictureScreenDemo> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    CameraDescription description =
        await availableCameras().then((cameras) => cameras[0]);
    _controller = CameraController(description, ResolutionPreset.medium);
    _initializeControllerFuture = _controller!.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 15, 15),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
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
                        Image.asset(AssetsConstant.icInfo),
                        SizedBox(width: 5)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview.
                    return Stack(children: <Widget>[
                      CameraPreview(_controller!),
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
              SizedBox(height: 8),
              Column(
                children: [
                  Text(
                    "Center Properly",
                    style: AppTextStyles.signupText,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Place ID on a plain surface Confirm \n entire ID is visible and clear",
                    style: AppTextStyles.cameraInstructions,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          // Provide an onPressed callback.
          onPressed: () async {
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await _initializeControllerFuture;

              // Attempt to take a picture and get the file `image`
              // where it was saved.
              final image = await _controller!.takePicture();

              if (!mounted) return;

              // If the picture was taken, display it on a new screen.
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(imagePath: image.path),
                ),
              );
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
          child: Image.asset(AssetsConstant.icClick),
        ),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen(
      {super.key,
      required this.imagePath,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Image.file(File(imagePath)),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
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
                      "Retake",
                      style: AppTextStyles.retake,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                height: 56,
                child: Consumer<LoginProvider>(builder: (_, provider, __) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        textStyle: TextStyle(
                            fontFamily: 'Inter-Bold',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: AppColors.textWhite),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(65)),
                        ),
                      ),
                      onPressed: provider.isLoading
                          ? null
                          : () async {
                              try {
                                final provider = Provider.of<DashBoardProvider>(
                                  context,
                                  listen: false,
                                );
                                Navigator.pushNamed(
                                      context,
                                      RouterConstants
                                          .successPageProfileDetailsUpdated);

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
                          : const Text("Submit",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Inter-SemiBold',
                                  fontWeight: FontWeight.w600)));
                })),
            SizedBox(height: 25),
            Text("Contact support",
                style: TextStyle(
                  color: AppColors.signUpBtnColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter-Regular',
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                )),
          ]),
        ),
      ),
    );
  }

  String getImagePath() {
    try {
      final bytes = Io.File(imagePath).readAsBytesSync();

      String img64 = base64Encode(bytes);
      // print(img64.substring(0, 100));
      return img64;
    } finally {}
  }
}
