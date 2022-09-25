import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CountryPicker extends StatefulWidget {
  const CountryPicker({Key? key}) : super(key: key);
  @override
  State<CountryPicker> createState() => CountryPickerState();
}

class CountryPickerState extends State<CountryPicker> {
  String dialCodeDigits = '+963';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 17,
      width: size.width / 3.20,
      child: CountryCodePicker(
        onChanged: (country) {
          setState(() {
            dialCodeDigits = country.dialCode!;
          });
        },
        initialSelection: 'SY',
        showCountryOnly: true,
        showOnlyCountryWhenClosed: false,
        favorite: ['+963','SY'],
        enabled: true,
        hideMainText: false,
        showFlagMain: true,
        showFlag: true,
        textStyle: GoogleFonts.lobster(textStyle: TextStyle(color: Colors.white)),
      ),
    );
  }
}