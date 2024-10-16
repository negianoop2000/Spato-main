
import 'package:flutter/material.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';


import 'countries.dart';
import 'helpers.dart';

class PickerDialogStyle {
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;

  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
}

class CountryPickerDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;

  CountryPickerDialog({
    Key? key,
    required this.searchText,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
  }) : super(key: key);

  @override
  _CountryPickerDialogState createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey.withOpacity(0.1)
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color createAnAcount = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.colorsecondaryDark;
    Color bottomAcountText = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.colorprimaryLight;

    final mediaWidth = MediaQuery.of(context).size.width;
    final width = widget.style?.width ?? mediaWidth;
    final defaultHorizontalPadding = 40.0;
    final defaultVerticalPadding = 24.0;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: defaultVerticalPadding,
          horizontal: mediaWidth > (width + defaultHorizontalPadding * 2)
              ? (mediaWidth - width) / 2
              : defaultHorizontalPadding),
      backgroundColor: Colors.grey.shade700,
      child: Container(
        padding: widget.style?.padding ?? EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: widget.style?.searchFieldPadding ?? EdgeInsets.all(0),
              child: TextField(
                cursorColor: widget.style?.searchFieldCursorColor,
                decoration: widget.style?.searchFieldInputDecoration ??
                    InputDecoration(
                      suffixIcon: const Icon(Icons.search, color: Colors.white),
                      labelText: widget.searchText,
                      labelStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Montserrat'),
                      hintStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Montserrat'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                onChanged: (value) {
                  _filteredCountries = isNumeric(value)
                      ? widget.countryList
                          .where((country) => country.dialCode.contains(value))
                          .toList()
                      : widget.countryList
                          .where((country) => country.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                  if (this.mounted) setState(() {});
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredCountries.length,
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      // leading:ClipOval(
                      //   child: Image.asset(
                      //     'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
                      //     width: 35,
                      //     height: 35,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      contentPadding: widget.style?.listTilePadding,
                      title: Text(
                        _filteredCountries[index].name,
                        style: widget.style?.countryNameStyle ??
                            TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontFamily: 'Montserrat'),
                      ),
                      trailing: Text(
                        '+${_filteredCountries[index].dialCode}',
                        style: widget.style?.countryCodeStyle ??
                            TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontFamily: 'Montserrat'),
                      ),
                      onTap: () {
                        _selectedCountry = _filteredCountries[index];
                        widget.onCountryChanged(_selectedCountry);
                        Navigator.of(context).pop();
                      },
                    ),
                    widget.style?.listTileDivider ?? const Divider(thickness: 1,color: Colors.white,),
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
