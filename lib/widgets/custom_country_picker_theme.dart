import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:veggo/utilities/devices/device_utilities.dart';

class CustomCountryPicker {
  // Custom Country Picker Dialog Theme
  static CountryListThemeData countryPickerTheme(BuildContext context) {
    return CountryListThemeData(
      bottomSheetHeight: DeviceUtilities.deviceHight(context) * .6,
      inputDecoration: const InputDecoration(
        hintText: 'Search your country',
        labelText: 'Search',
        prefixIcon: Icon(Icons.search),
      ),
      flagSize: 28,
      textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 18,
          ),
    );
  }
  
  // Show Country Picker Dialog
  static void showCountryPickerDialog(
      {required BuildContext context,
      required Function(Country) onSelect}) {
    showCountryPicker(
        context: context,
        countryListTheme: countryPickerTheme(context),
        onSelect: onSelect);
  }
}
