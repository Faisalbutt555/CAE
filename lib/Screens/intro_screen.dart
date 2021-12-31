import 'package:cae/Constants/Constants.dart';
import 'package:cae/Constants/Styles.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Screens/compare_at.dart';
import 'package:cae/Screens/login_screen.dart';
import 'package:cae/Screens/splash_screen.dart';
import 'package:cae/Widgets/CAEButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController controller = PageController();
  int slideIndex = 0;
  String titleNext = 'Next';
  List<Map<String, String>> splashData = [
    {
      "heading": "Challenge Yourself and Others",
      "text":
          "Challenge yourself and your friends to hit your goal or challenge your friend to a competition",
      "image": imageBaseAddress + "intro1.png",
    },
    {
      "heading": "To Our App",
      "text":
          "We help people conect with store \naround United State of America",
      "image": imageBaseAddress + "intro2.png",
    },
    {
      "heading": "Here you go",
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": imageBaseAddress + "intro1.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    var appConstants = Provider.of<AppConstants>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: black,
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  slideIndex = value;
                  print('index is:$slideIndex');
                  if (slideIndex >= 1) {
                    titleNext = 'Start';
                    setState(() {});
                  }
                  if (slideIndex < 2) {
                    titleNext = 'Next';
                    setState(() {});
                  }
                });
              },
              itemCount: splashData.length,
              itemBuilder: (context, index) => Column(
                //  splashData[index]["image"],
                //  splashData[index]['text'],
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.15,
                        ),
                        Image.asset(splashData[index]["image"]!),
                        CustomSizedBox(height: height + height),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(splashData[index]["heading"]!,
                                textAlign: TextAlign.center,
                                style: textStyleHeading1(width * 0.75,
                                    whiteColor: 1)),
                          ],
                        ),
                        CustomSizedBox(height: height),
                        Text(splashData[index]["text"]!,
                            textAlign: TextAlign.center,
                            style:
                                textStyleHeading2(width * 0.6, whiteColor: 1)),
                        CustomSizedBox(height: height),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: height * 0.1,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: SlideEffect(
                          spacing: 8.0,
                          radius: 2.0,
                          dotWidth: 12.0,
                          dotHeight: 8.0,
                          paintStyle: PaintingStyle.stroke,
                          strokeWidth: 1,
                          dotColor: Colors.white,
                          activeDotColor: primaryColor),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 12),
                    child: CAEButton(
                      onPressed: () {
                        if (titleNext == 'Start') {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        }
                        if (slideIndex >= 1) {
                          titleNext = 'Start';
                          setState(() {});
                        }
                        setState(() {
                          controller.animateToPage(slideIndex + 1,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.linear);

                          // slideIndex = slideIndex<=2? slideIndex+1:slideIndex;
                          // print('index is:$slideIndex');
                        });
                      },
                      backGroundColor: primaryColor,
                      height: height * 0.068,
                      textColor: 1,
                      width: width,
                      title: titleNext,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: TextButton(
                      child: Text(
                        'Skip',
                        style: textStyleHeading2(width * 0.6, whiteColor: 1),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
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
