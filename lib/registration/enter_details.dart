import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:js' as js;
import '../constants.dart';
import '../model/user.dart';
import 'dart:html' as html;

class EnterDetails extends StatefulWidget {
  const EnterDetails({Key? key}) : super(key: key);

  @override
  _EnterDetailsState createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  bool showstep2 = false;
  bool showstep1 = false;
  bool showstep3 = false;
  bool showstep4 = false;
  bool showstep5 = false;

  bool isCreating = false;
  String quote = "";

  TextEditingController nameCont = TextEditingController();
  TextEditingController valentineName = TextEditingController();
  TextEditingController numberCont = TextEditingController();
  TextEditingController quoteCont = TextEditingController();

  int price = 50;
  int selectedIndex = -1;
  String docId = "";
  Future<String> createUserDocument(UserModel user) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('users')
          .add(user.toMap());
      return docRef.id; // Return the document ID
    } catch (e) {
      return "";
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void shuffleAndAddQuote() {
    setState(() {
      romanticQuotes.shuffle(); // Shuffle the list of quotes
      quoteCont.text =
          romanticQuotes.first; // Add the first quote to the text field
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          10.height,

          showstep1
              ? step1()
              : showstep2
                  ? step2()
                  : showstep3
                      ? step3()
                      : showstep4
                          ? step4()
                          : showstep5
                              ? step5()
                              : landingPage() // 20.height,
        ],
      ),
    );
  }

  Widget step5() {
    return isCreating
        ? SizedBox(
            height: height(context),
            width: width(context),
            child: Center(
              child: SpinKitChasingDots(
                color: Colors.white,
              ),
            ),
          )
        : Column(
            children: [
              SizedBox(
                height: height(context) * 0.06,
              ),
              LottieBuilder.asset('assets/gif/email.json'),
              40.height,
              Text(
                "Share this link to casually ask your valentine out",
                textAlign: TextAlign.center,
                style: GoogleFonts.itim(
                    color: Colors.white, fontSize: 22, height: 1),
              ),
              30.height,
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                width: width(context),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "https://valentine.delta-code.com/?id=$docId",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.itim(
                            color: appPinkColor, fontSize: 20, height: 1),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          html.window.navigator.clipboard
                              ?.writeText(
                                  "https://valentine.delta-code.com/?id=$docId")
                              .then((_) {});
                          toast("URL copied");
                        },
                        icon: Icon(
                          Icons.copy,
                          color: appPinkColor,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: height(context) * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  String url =
                      'https://wa.me/?text=${Uri.encodeComponent("This one is for you ${valentineName.text}\nhttps://valentine.delta-code.com/?id=$docId")}';
                  html.window.open(url, '_blank');
                  // showstep5 = false;
                  // showstep4 = false;
                  // showstep3 = false;
                  // showstep2 = false;
                  // showstep1 = false;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: height(context) * 0.06,
                  margin:
                      EdgeInsets.symmetric(horizontal: width(context) * 0.12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.green.shade500),
                  child: Center(
                    child: Text(
                      "Share on Whatsapp",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.itim(
                          color: Colors.white, fontSize: 20, height: 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height(context) * 0.08,
              ),
              GestureDetector(
                onTap: () {
                  showstep5 = false;
                  showstep4 = false;
                  showstep3 = false;
                  showstep2 = false;
                  showstep1 = false;
                  setState(() {});
                },
                child: Text(
                  "Exit",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.itim(
                      color: Colors.white, fontSize: 22, height: 1),
                ),
              ),
            ],
          );
  }

  Widget step4() {
    return FadeIn(
      child: Column(
        children: [
          SizedBox(
            height: height(context) * 0.02,
          ),
          Container(
            height: height(context) * 0.2,
            width: width(context) * 0.5,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Image(
              image: AssetImage(
                'assets/gif/payment.jpeg',
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: height(context) * 0.06,
          ),
          Container(
            height: height(context) * 0.06,
            width: width(context),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Center(
              child: Text(
                "₹ $price",
                textAlign: TextAlign.center,
                style: GoogleFonts.itim(
                    color: appPinkColor, fontSize: 20, height: 1),
              ),
            ),
          ),
          10.height,
          Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  price = 100;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white)),
                  child: Text(
                    "₹ 100",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.itim(
                        color: Colors.white, fontSize: 20, height: 1),
                  ),
                ),
              )),
              10.width,
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      price = 200;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        "₹ 200",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.itim(
                            color: Colors.white, fontSize: 20, height: 1),
                      ),
                    )),
              ),
              10.width,
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  price = 300;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white)),
                  child: Text(
                    "₹ 300",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.itim(
                        color: Colors.white, fontSize: 20, height: 1),
                  ),
                ),
              ))
            ],
          ),
          20.height,
          Text(
            "Help me bridge the distance with love. I'm planning a heartfelt surprise for my girlfriend in Australia. Your generous donation would turn this dream into a beautiful reality and will light up her world and celebrate our love across the miles. Please support me if you can. Thank you",
            textAlign: TextAlign.center,
            style:
                GoogleFonts.itim(color: Colors.white, fontSize: 21, height: 1),
          ),
          SizedBox(
            height: height(context) * 0.08,
          ),
          GestureDetector(
            onTap: () {
              js.context
                  .callMethod('open', ['https://rzp.io/l/Op8ztRNw', '_blank']);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: height(context) * 0.065,
              margin: EdgeInsets.symmetric(horizontal: width(context) * 0.1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: Center(
                child: Text(
                  "Donate $price",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.itim(
                      color: appPinkColor, fontSize: 22, height: 1),
                ),
              ),
            ),
          ),
          20.height,
          GestureDetector(
            onTap: () async {
              showstep4 = false;
              showstep5 = true;
              isCreating = true;
              setState(() {});
              docId = await createUserDocument(UserModel(
                  yourName: nameCont.text,
                  valentineName: valentineName.text,
                  quote: quote,
                  gifNo: selectedIndex));
              isCreating = false;
              setState(() {});
            },
            child: Text(
              "Next",
              textAlign: TextAlign.center,
              style: GoogleFonts.itim(
                  color: Colors.white, fontSize: 20, height: 1),
            ),
          ),
          20.height,
          Text(
            "My tool is completely free to use for your and your loved ones benefit. Forever.",
            textAlign: TextAlign.center,
            style:
                GoogleFonts.itim(color: Colors.white, fontSize: 21, height: 1),
          ),
        ],
      ),
    );
  }

  Widget step3() {
    return FadeIn(
      child: Column(
        children: [
          20.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Enter Quote (Optional)",
              textAlign: TextAlign.center,
              style: GoogleFonts.itim(
                  color: Colors.white, fontSize: 24, height: 1),
            ),
          ),
          15.height,
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: TextField(
              style: GoogleFonts.itim(
                  color: appPinkColor, fontSize: 22, height: 1),
              maxLines: null,
              controller: quoteCont,
              decoration: inputDecoration(
                context,
                borderRadius: 20,
                hint: "ex: I'm more me when I'm with you",
              ),
            ),
          ),
          // AppTextField(
          //   expands: false,
          //   textFieldType: TextFieldType.NAME,
          //   controller: quoteCont,
          //   maxLines: null,
          //   minLines: null,
          //   decoration: inputDecoration(
          //     context,
          //     borderRadius: 20,
          //     hint: "ex: I'm more me when I'm with you",
          //   ),
          //   onChanged: (val) {
          //     setState(() {});
          //   },
          //   textStyle:
          //       GoogleFonts.itim(color: appPinkColor, fontSize: 22, height: 1),
          // ),
          20.height,
          GestureDetector(
            onTap: shuffleAndAddQuote,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: height(context) * 0.07,
              margin: EdgeInsets.symmetric(horizontal: width(context) * 0.1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: Center(
                child: Text(
                  "Generate Quote",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.itim(
                      color: appPinkColor, fontSize: 21, height: 1),
                ),
              ),
            ),
          ),
          30.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select GIF",
              textAlign: TextAlign.center,
              style: GoogleFonts.itim(
                  color: Colors.white, fontSize: 24, height: 1),
            ),
          ),
          10.height,
          SizedBox(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing:
                    20, // Add spacing between items on the main axis (horizontal)
                crossAxisSpacing:
                    20, // Add spacing between items on the cross axis (vertical)
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                bool isSelected =
                    selectedIndex == index; // Check if the item is selected
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedIndex == index) {
                        selectedIndex = -1;
                      } else {
                        selectedIndex = index;
                      } // Update selected index
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: height(context) * 0.18,
                        width: width(context) * 0.4,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Image(
                          image: AssetImage(
                            'assets/gif/${index + 1}.GIF',
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      if (isSelected)
                        Positioned.fill(
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: height(context) * 0.06,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              if (selectedIndex == -1) {
                toast("Please choose GIF");
              } else {
                showstep3 = false;
                showstep4 = true;
                setState(() {});
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: height(context) * 0.065,
              margin: EdgeInsets.symmetric(horizontal: width(context) * 0.15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: Center(
                child: Text(
                  "Proceed",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.itim(
                      color: appPinkColor, fontSize: 23, height: 1),
                ),
              ),
            ),
          ),
          20.height,
          GestureDetector(
            onTap: () {
              showstep2 = true;
              showstep3 = false;
              setState(() {});
            },
            child: Text(
              "Back ",
              textAlign: TextAlign.center,
              style: GoogleFonts.itim(
                  color: Colors.white, fontSize: 20, height: 1),
            ),
          ),
          40.height,
        ],
      ),
    );
  }

  Widget step2() {
    return FadeIn(
      child: Column(
        children: [
          20.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Your Whatsapp Number (Optional)",
              textAlign: TextAlign.center,
              style: GoogleFonts.itim(
                  color: Colors.white, fontSize: 24, height: 1),
            ),
          ),
          8.height,
          Text(
            "To get notified when your valentine responds ",
            style: GoogleFonts.itim(
                color: Colors.grey.shade200, fontSize: 20, height: 1),
          ),
          20.height,
          AppTextField(
            textFieldType: TextFieldType.NUMBER,
            controller: numberCont,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]')), // Only allows numbers
              LengthLimitingTextInputFormatter(
                  10), // Limits input to 10 characters
            ],
            maxLength: 10,
            decoration: inputDecoration(context, borderRadius: 20),
            onChanged: (val) {
              setState(() {});
            },
            textStyle:
                GoogleFonts.itim(color: appPinkColor, fontSize: 26, height: 1),
          ),
          SizedBox(
            height: height(context) * 0.1,
          ),
          GestureDetector(
            onTap: () {
              showstep2 = false;
              showstep3 = true;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: height(context) * 0.07,
              margin: EdgeInsets.symmetric(horizontal: width(context) * 0.15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: Center(
                child: Text(
                  "Proceed",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.itim(
                      color: appPinkColor, fontSize: 25, height: 1),
                ),
              ),
            ),
          ),
          20.height,
          GestureDetector(
            onTap: () {
              showstep1 = true;
              showstep2 = false;
              setState(() {});
            },
            child: Text(
              "Back ",
              textAlign: TextAlign.center,
              style: GoogleFonts.itim(
                  color: Colors.white, fontSize: 20, height: 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget step1() {
    return FadeIn(
      child: Column(
        children: [
          20.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Your name",
              textAlign: TextAlign.center,
              style: GoogleFonts.itim(
                  color: Colors.white, fontSize: 24, height: 1),
            ),
          ),
          8.height,
          AppTextField(
            textFieldType: TextFieldType.NAME,
            controller: nameCont,
            decoration: inputDecoration(context, borderRadius: 20),
            onChanged: (val) {
              setState(() {});
            },
            textStyle:
                GoogleFonts.itim(color: appPinkColor, fontSize: 26, height: 1),
          ),
          20.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Your valentine's name",
              textAlign: TextAlign.center,
              style: GoogleFonts.itim(
                  color: Colors.white, fontSize: 24, height: 1),
            ),
          ),
          8.height,
          AppTextField(
            textFieldType: TextFieldType.NAME,
            controller: valentineName,
            textStyle:
                GoogleFonts.itim(color: appPinkColor, fontSize: 26, height: 1),
            decoration: inputDecoration(context, borderRadius: 20),
            onChanged: (val) {
              setState(() {});
            },
          ),
          SizedBox(
            height: height(context) * 0.1,
          ),
          GestureDetector(
            onTap: () {
              if (nameCont.text.isEmpty || valentineName.text.isEmpty) {
                toast("Please enter details");
              } else {
                showstep1 = false;
                showstep2 = true;
                setState(() {});
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: height(context) * 0.07,
              margin: EdgeInsets.symmetric(horizontal: width(context) * 0.15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: Center(
                child: Text(
                  "Proceed",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.itim(
                      color: appPinkColor, fontSize: 25, height: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget landingPage() {
    return FadeIn(
      child: Column(
        children: [
          20.height,
          Text(
            "They just can’t say no!",
            textAlign: TextAlign.center,
            style:
                GoogleFonts.itim(color: Colors.white, fontSize: 30, height: 1),
          ),
          30.height,
          Container(
            height: height(context) * 0.2,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Image(
              image: AssetImage(
                'assets/gif/landing.GIF',
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
          30.height,
          Text(
            "Want to ask someone out? We got you covered.\nSend them the cutest invite to which they just can't say no.",
            textAlign: TextAlign.center,
            style:
                GoogleFonts.itim(color: Colors.white, fontSize: 25, height: 1),
          ),
          SizedBox(
            height: height(context) * 0.17,
          ),
          GestureDetector(
            onTap: () {
              showstep1 = true;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: height(context) * 0.07,
              margin: EdgeInsets.symmetric(horizontal: width(context) * 0.15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: Center(
                child: Text(
                  "Proceed",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.itim(
                      color: appPinkColor, fontSize: 25, height: 1),
                ),
              ),
            ),
          ),
          15.height,
          Text(
            "This is the cutest way to ask your special one out for this Valentine’s Day",
            textAlign: TextAlign.center,
            style:
                GoogleFonts.itim(color: Colors.white, fontSize: 20, height: 1),
          ),
          5.height,
          Text(
            "-Socrates",
            textAlign: TextAlign.center,
            style:
                GoogleFonts.itim(color: Colors.white, fontSize: 20, height: 1),
          ),
        ],
      ),
    );
  }
}
