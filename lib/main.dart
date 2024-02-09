import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valentine/constants.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valentine',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: appPinkColor),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  String noButtonText = "No";
  double yesButtonWidth = 50;
  bool yesButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/propose.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  void updateButtons() {
    setState(() {
      // Update the text of the "No" button from the provided list in ascending order
      switch (noButtonText) {
        case "No":
          noButtonText = "Are you sure";
          break;
        case "Are you sure":
          noButtonText = "Pookie please";
          break;
        case "Pookie please":
          noButtonText = "Don’t do this to me";
          break;
        case "Don’t do this to me":
          noButtonText = " You’re breaking my heart";
          break;
        case " You’re breaking my heart":
          noButtonText = "Really sure?";
          break;
        case "Really sure?":
          noButtonText = "I’m gonna cry...";
          break;
        case "I’m gonna cry...":
          noButtonText = "But we’d make such a great pair!";
          break;
        case "But we’d make such a great pair!":
          noButtonText = "Not even if I bring you chocolates?";
          break;
        case "Not even if I bring you chocolates?":
          noButtonText = "Are you playing hard to get?";
          break;
        case "Are you playing hard to get?":
          noButtonText = "This feels like a romantic comedy, and I’m losing.";
          break;
        case "This feels like a romantic comedy, and I’m losing.":
          noButtonText = "Is it something I said?";
          break;
        case "Is it something I said?":
          noButtonText = "Can we talk about this over ice cream?";
          break;
        case "Can we talk about this over ice cream?":
          noButtonText = "I thought we had something special!";
          break;
        case "I thought we had something special!":
          noButtonText = "You’ve got to be kitten me!";
          break;
        case "You’ve got to be kitten me!":
          noButtonText = "How about a do-over? Pretty please?";
          break;
        case "How about a do-over? Pretty please?":
          noButtonText = "No"; // Reset back to "No" to repeat the cycle
          break;
        default:
          noButtonText =
              "No"; // Reset back to "No" if all options have been exhausted
          break;
      }

      // Increase the width of the "Yes" button by 15
      yesButtonWidth += 25;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPinkColor,
      body: Container(
        height: height(context),
        width: width(context),
        padding: EdgeInsets.all(15),
        child: DottedBorder(
            color: Colors.white,
            strokeWidth: 2,
            dashPattern: [6, 0, 6],
            child: SizedBox(
              height: height(context),
              width: width(context),
              child: ListView(
                children: [
                  SizedBox(
                    height: height(context) * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Dear Leah,",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sacramento(
                          color: Colors.white, fontSize: 35, height: 1),
                    ),
                  ),
                  SizedBox(
                    height: height(context) * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "I'm more me when I'm with you",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sacramento(
                          color: Colors.white, fontSize: 35, height: 1),
                    ),
                  ),
                  SizedBox(
                    height: height(context) * 0.07,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: _controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            )
                          : Container(),
                    ),
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  yesButtonPressed
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Text(
                                "Yay!",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.sacramento(
                                    color: Colors.white,
                                    fontSize: 45,
                                    height: 1),
                              ),
                              SizedBox(
                                height: height(context) * 0.04,
                              ),
                              Text(
                                "Some guy",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.sacramento(
                                    color: Colors.white,
                                    fontSize: 30,
                                    height: 1),
                              ),
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                              Text(
                                "Leah",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.sacramento(
                                    color: Colors.white,
                                    fontSize: 30,
                                    height: 1),
                              ),
                            ],
                          ))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Will you be my Valentine",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sacramento(
                                color: Colors.white, fontSize: 35, height: 1),
                          ),
                        ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  yesButtonPressed
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    updateButtons();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Text(
                                        noButtonText,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.sacramento(
                                            color: Colors.white,
                                            fontSize: 25,
                                            height: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    yesButtonPressed = true;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: yesButtonWidth,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Yes",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.sacramento(
                                          color: Colors.pinkAccent,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            )),
      ),
    );
  }
}
