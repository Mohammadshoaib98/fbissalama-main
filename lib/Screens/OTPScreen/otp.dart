import 'dart:ui';
import 'package:fbissalama/Screens/MainHomeScreen/MainHomeScreen.dart';
import 'package:fbissalama/Widgets/OTP/timer.dart';
import 'package:fbissalama/utilities/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTP extends StatefulWidget {
  final String number;

  const OTP({required this.number, Key? key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  String verificationIdFinal = "";
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFoucus = FocusNode();
  String? varificationCode;
  String codeValue = "";
  late TextEditingController textEditingController1;

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
      color: const Color(0xFFA6A6A6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color:const Color(0xFFFFC727)));

  void initState() {
    super.initState();
    verifyPhoneNumber();
    textEditingController1 = TextEditingController();
    // initSmsListener();
  }

  Future<void> initSmsListener() async {
    String? commingSms;
    try {
      commingSms = await AltSmsAutofill().listenForSms;
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;

    setState(() {
      textEditingController1.text = commingSms.toString();
    });
  }

  @override
  void dispose() {
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  verifyPhoneNumber() async {
    print("async number");
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${widget.number}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          // print("The verifying Data is: ${value.credential!.token}");
          // Auth().storeTokenAndData(value);
          if (value.user != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MainHome(),
              ),
            );
          }
        });
      },
      verificationFailed: (FirebaseException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: const Duration(seconds: 3)));
      },
      codeSent: (String vID, int? resendToken) async {
        setState(() {
          varificationCode = vID;
        });
        String? code;
        try {
          code = await AltSmsAutofill().listenForSms;
        } catch (e) {
          print(e.toString());
        }
        if (!mounted) return;
        setState(() {
          textEditingController1.text = code.toString();
        });
      },
      codeAutoRetrievalTimeout: (String vID) {
        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
                      content: Text('Timed out'),
                      duration: Duration(seconds: 60)));
      },
      timeout: const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppAssets.backgroundOtp2,
                ),
              ),
            ),
            height: size.height,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
              child: Column(
                children:  [
                 const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin:  const EdgeInsets.only(top: 35),
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            'Verifying:',
                            style: GoogleFonts.sahitya(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Color(0xFF37474F))),
                          ),
                        const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${widget.number}',
                            style: GoogleFonts.sahitya(
                                textStyle:const  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Color(0xFFFFC727))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TimerApp(),
              const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child:
                                  PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 6,
                                obscureText: false,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(10),
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  inactiveFillColor: Colors.white,
                                  inactiveColor: Colors.grey,
                                  selectedColor: Colors.grey,
                                  selectedFillColor: Colors.white,
                                  activeFillColor: Colors.white,
                                  activeColor: Colors.grey,
                                ),
                                cursorColor: Colors.black,
                                animationDuration:const  Duration(milliseconds: 300),
                                enableActiveFill: true,
                                controller: textEditingController1,
                                keyboardType: TextInputType.number,
                                boxShadows:const [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ],
                                onCompleted: (v) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MainHome()));
                                },
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    print('$value');
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child:const  Text(
                                  "Didn't you receive any code?",
                                  style: TextStyle(
                                    backgroundColor: Color(0xFFFFFFFF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFC727),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child:const  Text(
                                  "Resend New Code?",
                                  style: TextStyle(
                                    backgroundColor: Color(0xFFFFFFFF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFC727),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
