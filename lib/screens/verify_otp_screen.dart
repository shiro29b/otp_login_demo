import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_login_demo/controller/app_controller.dart';
import 'package:otp_login_demo/screens/welcome_screen.dart';

import '../components/custom_elevated_button.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});

  final AppMainController appcontroller = Get.put(AppMainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.blue[200]!, Colors.blue[700]!])),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Please Enter otp..",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 28)),
              const Image(
                image: AssetImage("assets/loginPageBg.png"),
                height: 300,
              ),
              Text("Otp sent to ",
                  style: GoogleFonts.montserrat(
                      color: Colors.white, fontSize: 18)),
              const SizedBox(height: 5),
              Text(
                  "${appcontroller.selectedCountry!.callingCode} ${appcontroller.phoneNo.text}",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 15),
              OtpTextField(
                showCursor: true,
                margin: const EdgeInsets.all(10),
                textStyle: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.w500),

                numberOfFields: 4,
                cursorColor: Colors.black,

                borderColor: Colors.white,
                enabledBorderColor: Colors.white,
                focusedBorderColor: Colors.blue[700]!,

                //set to true to show as box or false to show as dash
                showFieldAsBox: false,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  appcontroller.otp.text = verificationCode;
                }, // end onSubmit
              ),
              const SizedBox(height: 35),
              SizedBox(
                  width: 250,
                  child: CustomElevatedButton(
                      title: "Verify Otp",
                      onTapped: () {
                        if (appcontroller.otp.text.length != 4) {
                          Fluttertoast.showToast(msg: "Enter a valid otp.");
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                // set up the buttons
                                Widget cancelButton = TextButton(
                                  child: Text(
                                    "Cancel",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                );
                                Widget continueButton = SizedBox(
                                  height: 35,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blue[300]!,
                                            Colors.blue[600]!,
                                            Colors.blue[900]!
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          stops: const [0.1, 0.6, 1.8],
                                          tileMode: TileMode.mirror,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                              color: Color.fromRGBO(0, 0, 0,
                                                  0.57), //shadow for button
                                              blurRadius:
                                                  5) //blur radius of shadow
                                        ]),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            disabledForegroundColor: Colors
                                                .transparent
                                                .withOpacity(0.38),
                                            disabledBackgroundColor: Colors
                                                .transparent
                                                .withOpacity(0.12),
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      100), // <-- Radius
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 0)),
                                        onPressed: () {
                                          appcontroller.phoneNo.text = "";
                                          Get.to(const WelcomeScreen());
                                        },
                                        child: Text(
                                          "Continue",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 15),
                                        )),
                                  ),
                                );
                                return AlertDialog(
                                  backgroundColor: Colors.blue[200],
                                  title: Text(
                                    "Your details has been submitted.",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.w600),
                                  ),
                                  content: Text(
                                    "Press continue to repeat",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.w500),
                                  ),
                                  actions: [
                                    cancelButton,
                                    continueButton,
                                  ],
                                );
                              });
                        }
                      })),
              const SizedBox(
                height: 50,
              ),
              Text("By Signing up you agree with our terms\n and conditions!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      color: Colors.white, fontSize: 15)),
            ],
          ),
        ),
      )),
    ));
  }
}
