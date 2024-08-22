import 'package:flutter/material.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/onboarding/size_config.dart';
import 'package:nationremit/style/app_text_styles.dart';

import '../model/onboard_slider_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'onboarding_contents.dart';

/*class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  List<OnboardSliderModel> slides = <OnboardSliderModel>[];
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
    slides = getSlides();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  // contents of slider
                  return Slider(
                    image: slides[index].getImage(),
                  );
                }),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 10),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      // Add your on pressed event here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.loginBtnColor,
                      padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: AppTextStyles.loginTxt,
                    ),
                  )),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your on pressed event here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.signUpBtnColor,
                        padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        'Signup',
                        style: AppTextStyles.signupText,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              )),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

// container created for dots
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.textDark,
      ),
    );
  }

  void onPressed() {}
}

// ignore: must_be_immutable
// slider declared
class Slider extends StatelessWidget {
  String? image;

  Slider({this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // contains container
      child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
          Color.fromARGB(196, 255, 255, 255),
          Color.fromARGB(44, 255, 255, 255)
        ], radius: .75
                //begin: Alignment.topLeft,
                // end: Alignment.bottomRight,
                )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // image given in slider
            Image(image: AssetImage(image!),fit: BoxFit.fitWidth,),
            Text('Hello Gradient!',
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}*/



class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List colors = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xFF000000),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: SizeConfig.blockV! * 35,
                        ),
                        SizedBox(
                          height: (height >= 840) ? 60 : 30,
                        ),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            fontSize: (width <= 550) ? 30 : 35,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          contents[i].desc,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w300,
                            fontSize: (width <= 550) ? 17 : 25,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                          (int index) => _buildDots(
                        index: index,
                      ),
                    ),
                  ),
                  _currentPage + 1 == contents.length
                      ? Padding(
                    padding: const EdgeInsets.all(30),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("START"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: (width <= 550)
                            ? const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 20)
                            : EdgeInsets.symmetric(
                            horizontal: width * 0.2, vertical: 25),
                        textStyle:
                        TextStyle(fontSize: (width <= 550) ? 13 : 17),
                      ),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _controller.jumpToPage(2);
                          },
                          child: const Text(
                            "SKIP",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: TextButton.styleFrom(
                            elevation: 0,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: (width <= 550) ? 13 : 17,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                          child: const Text("NEXT"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 0,
                            padding: (width <= 550)
                                ? const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20)
                                : const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 25),
                            textStyle: TextStyle(
                                fontSize: (width <= 550) ? 13 : 17),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}