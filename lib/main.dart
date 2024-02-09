import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:valentine/constants.dart';
import 'package:valentine/model/user.dart';
import 'package:valentine/registration/enter_details.dart';
import 'dart:html' as html;
import 'dart:js' as js;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyA2pD7vT-NwV847qBjnvK5vMWRThsxlKkk",
        authDomain: "valentine-b9ac9.firebaseapp.com",
        projectId: "valentine-b9ac9",
        storageBucket: "valentine-b9ac9.appspot.com",
        messagingSenderId: "711544376569",
        appId: "1:711544376569:web:88eaeab450170b4b87a628",
        measurementId: "G-GXPGY0JL2Q"),
  );
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
  String noButtonText = "No";
  double yesButtonWidth = 50;
  bool yesButtonPressed = false;
  bool isLoading = true;

  UserModel? valentineUser;
  @override
  void initState() {
    super.initState();
    getQuery();
  }

  getQuery() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Uri uri = Uri.parse(html.window.location.href);
    String id = uri.queryParameters['id'] ?? '';

    if (id.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(id).get();
      if (snapshot.exists) {
        valentineUser = UserModel.fromSnapshot(snapshot);
        isLoading = false;
        setState(() {});
      }
    }

    isLoading = false;
    setState(() {});
  }

  void updateButtons() {
    setState(() {
      switch (noButtonText) {
        case "No":
          noButtonText = "Are you sure";
          break;
        case "Are you sure":
          noButtonText = "Pookie please";
          break;
        case "Pookie please":
          noButtonText = "Don't do this to me";
          break;
        case "Don't do this to me":
          noButtonText = " You're breaking my heart";
          break;
        case " You're breaking my heart":
          noButtonText = "Really sure?";
          break;
        case "Really sure?":
          noButtonText = "I'm gonna cry...";
          break;
        case "I'm gonna cry...":
          noButtonText = "But we'd make such a great pair!";
          break;
        case "But we'd make such a great pair!":
          noButtonText = "Not even if I bring you chocolates?";
          break;
        case "Not even if I bring you chocolates?":
          noButtonText = "Are you playing hard to get?";
          break;
        case "Are you playing hard to get?":
          noButtonText = "This feels like a romantic comedy, and I'm losing.";
          break;
        case "This feels like a romantic comedy, and I'm losing.":
          noButtonText = "Is it something I said?";
          break;
        case "Is it something I said?":
          noButtonText = "Can we talk about this over ice cream?";
          break;
        case "Can we talk about this over ice cream?":
          noButtonText = "I thought we had something special!";
          break;
        case "I thought we had something special!":
          noButtonText = "You've got to be kitten me!";
          break;
        case "You've got to be kitten me!":
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
        child: isLoading
            ? Center(
                child: SpinKitChasingDots(
                color: Colors.white,
              ))
            : DottedBorder(
                color: Colors.white,
                strokeWidth: 2,
                dashPattern: [6, 0, 6],
                child: SizedBox(
                  height: height(context),
                  width: width(context),
                  child: valentineUser == null
                      ? EnterDetails()
                      : ListView(
                          children: [
                            SizedBox(
                              height: height(context) * 0.06,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Dear ${valentineUser?.valentineName ?? "N/A"},",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.itim(
                                    color: Colors.white,
                                    fontSize: 30,
                                    height: 1),
                              ),
                            ),
                            SizedBox(
                              height: height(context) * 0.02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                valentineUser?.quote ?? "",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.itim(
                                    color: Colors.white,
                                    fontSize: 30,
                                    height: 1),
                              ),
                            ),
                            SizedBox(
                              height: (valentineUser?.quote.isEmpty ?? false)
                                  ? height(context) * 0.00
                                  : height(context) * 0.07,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height(context) * 0.3,
                                  width: width(context) * 0.6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image(
                                      image: AssetImage(
                                        yesButtonPressed
                                            ? 'assets/gif/afteryes.GIF'
                                            : 'assets/gif/${valentineUser?.gifNo ?? 1}.GIF',
                                      ),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                // Container(
                                //   padding: EdgeInsets.all(5),
                                //   decoration: BoxDecoration(
                                //     shape: BoxShape.circle,
                                //     color: Colors.white,
                                //   ),
                                //   child: ClipOval(
                                //     child: Image(
                                //       height: height(context) * 0.3,
                                //       image: AssetImage(
                                //         yesButtonPressed
                                //             ? 'assets/gif/afteryes.GIF'
                                //             : 'assets/gif/2.GIF',
                                //       ),
                                //       fit: BoxFit.fitHeight,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: height(context) * 0.07,
                            ),
                            yesButtonPressed
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Yay!",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.itim(
                                              color: Colors.white,
                                              fontSize: 45,
                                              height: 1),
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.04,
                                        ),
                                        Text(
                                          valentineUser?.yourName ?? "",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.itim(
                                              color: Colors.white,
                                              fontSize: 30,
                                              height: 1),
                                        ),
                                        5.height,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          valentineUser?.valentineName ?? "",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.itim(
                                              color: Colors.white,
                                              fontSize: 30,
                                              height: 1),
                                        ),
                                      ],
                                    ))
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      "Will you be my Valentine",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.itim(
                                          color: Colors.white,
                                          fontSize: 30,
                                          height: 1),
                                    ),
                                  ),
                            SizedBox(
                              height: height(context) * 0.05,
                            ),
                            yesButtonPressed
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
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
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  noButtonText,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.itim(
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
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Yes",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.itim(
                                                    color: Colors.pinkAccent,
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: height(context) * 0.04,
                            ),
                            !yesButtonPressed
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          String shareNews = valentineUser ==
                                                  null
                                              ? "Visit https://valentine.delta-code.com to ask out your valentine"
                                              : "${valentineUser?.valentineName} said YES!\nCheckout https://valentine.delta-code.com to ask out your valentine";
                                          String url =
                                              'https://wa.me/?text=${Uri.encodeComponent(shareNews)}';
                                          html.window.open(url, '_blank');
                                          // showstep5 = false;
                                          // showstep4 = false;
                                          // showstep3 = false;
                                          // showstep2 = false;
                                          // showstep1 = false;
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          height: height(context) * 0.06,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.green.shade500),
                                          child: Center(
                                            child: Text(
                                              "Share the news",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.itim(
                                                  color: Colors.white,
                                                  fontSize: 21,
                                                  height: 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      20.width,
                                      GestureDetector(
                                        onTap: () {
                                          js.context.callMethod('open', [
                                            'https://rzp.io/l/Op8ztRNw',
                                            '_blank'
                                          ]);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          height: height(context) * 0.06,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: appPinkColor),
                                          child: Center(
                                            child: Text(
                                              "Donate",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.itim(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  height: 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                )),
      ),
    );
  }
}
