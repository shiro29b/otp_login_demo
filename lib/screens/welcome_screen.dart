import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_login_demo/components/custom_elevated_button.dart';
import 'package:otp_login_demo/screens/verify_otp_screen.dart';

import '../controller/app_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      appcontroller.selectedCountry = country;
    });
  }

  void _onPressedShowDialog() async {
    final country = await showCountryPickerDialog(
      context,
    );
    if (country != null) {
      setState(() {
        appcontroller.selectedCountry = country;
      });
    }
  }

  AppMainController appcontroller = Get.put(AppMainController());

  @override
  Widget build(BuildContext context) {
    final country = appcontroller.selectedCountry;
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
                  Text("Welcome Back!",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16)),
                  Text("Log-In to Continue",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 25)),
                  const Image(
                    image: AssetImage("assets/loginPageBg.png"),
                    height: 300,
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      TextFormField(
                        controller: appcontroller.phoneNo,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Phone No.",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 17),
                            filled: true,
                            fillColor: Colors.white70,
                            border: InputBorder.none,
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50))),
                      ),
                      GestureDetector(
                        onTap: _onPressedShowDialog,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor:
                              const Color.fromARGB(255, 244, 249, 253),
                          child: country != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      country.flag,
                                      package: countryCodePackageName,
                                      width: 30,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      country.callingCode,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                )
                              : const CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: 250,
                      child: CustomElevatedButton(
                          title: "Get Otp",
                          onTapped: () {
                            if (appcontroller.phoneNo.text.length != 10) {
                              Fluttertoast.showToast(
                                  msg: "Enter a valid Phone number.");
                            } else {
                              Get.to(VerifyOtpScreen());
                            }
                          })),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                      "By Signing up you agree with our terms\n and conditions!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 15)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
