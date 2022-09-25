import 'dart:ui';
import 'package:fbissalama/Screens/OTPScreen/otp.dart';
import 'package:fbissalama/Services/auth.dart';
import 'package:fbissalama/Widgets/Login/CountryPicker.dart';
import 'package:fbissalama/Widgets/Login/DropDown.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassLogin extends StatefulWidget {
  const GlassLogin({Key? key}) : super(key: key);

  @override
  State<GlassLogin> createState() => _GlassLoginState();
}

class _GlassLoginState extends State<GlassLogin> {
  final TextEditingController number = TextEditingController();

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.width / 30,
                  bottom: size.width / 30,
                ),
                child: Text(
                  'LOGIN',
                  style: GoogleFonts.davidLibre(
                    textStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(.8),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_pin_circle_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Dropdown(),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                height: size.width / 4.5,
                width: size.width / 1.10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: number,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.9),
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: CountryPicker(),
                    border: InputBorder.none,
                    hintMaxLines: 1,
                    hintText: 'Phone Number...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(.9),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: size.width / 4.5,
                width: size.width / 1.10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: password,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.9),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: SizedBox(
                      width: 113,
                      child: Icon(
                        Icons.lock_outline,
                        color: Colors.white.withOpacity(.8),
                      ),
                    ),
                    border: InputBorder.none,
                    hintMaxLines: 1,
                    hintText: 'Password...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(.9),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Forgotten password!',
                          style: GoogleFonts.adamina(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              HapticFeedback.lightImpact();
                              Fluttertoast.showToast(
                                msg: 'Forgotten password! button pressed',
                              );
                            },
                        ),
                      ),
                      SizedBox(
                        height: size.height / 100,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Create a new Account',
                          style: GoogleFonts.adamina(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              HapticFeedback.lightImpact();
                              Fluttertoast.showToast(
                                msg: 'Create a new Account button pressed',
                              );
                            },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (number.text.isNotEmpty && password.text.isNotEmpty) {
                    try {
                      Auth().addUser(
                          number.text, DropdownState().dropdownValue, password.text);
                      if ("${number.text[0]}" == "0") {
                        number.text = number.text.substring(1);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => OTP(
                                    number: CountryPickerState().dialCodeDigits +
                                        number.text,
                                  )),
                        );
                      }else
                        {
                          HapticFeedback.lightImpact();
                          Fluttertoast.showToast(
                            msg: 'Invalid Phone Number',
                          );
                        }
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    HapticFeedback.lightImpact();
                    Fluttertoast.showToast(
                      msg: 'Please Fill All Gaps',
                    );
                  }
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .33,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: size.width * .05,
                      ),
                      height: size.height / 12,
                      width: size.width / 3,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.adamina(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                  child: Text(
                "Book your Journeys Online",
                style: GoogleFonts.lobster(
                    textStyle: TextStyle(fontSize: 25, color: Colors.white)),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
