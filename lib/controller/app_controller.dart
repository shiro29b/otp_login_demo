import 'package:country_calling_code_picker/country.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMainController extends GetxController {
  final TextEditingController phoneNo = TextEditingController();
  Country? selectedCountry;

  final TextEditingController otp = TextEditingController();
}
