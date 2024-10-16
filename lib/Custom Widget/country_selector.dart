// import 'package:flutter/material.dart';
// import 'package:spato_mobile_app/app/data/country_list.dart';
// import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
//
//
// class CountrySelector extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//
//   CountrySelector({
//     required this.controller,
//     required this.hintText,
//   });
//
//   @override
//   _CountrySelectorState createState() => _CountrySelectorState();
// }
//
// class _CountrySelectorState extends State<CountrySelector> {
//   bool _isDropdownOpen = false;
//   String? _selectedCountry;
//
//   @override
//   void initState() {
//     super.initState();
//     // Set default country as Germany
//     _selectedCountry = 'Germany';
//     widget.controller.text = _selectedCountry!;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         TextInputField(
//           height: 50,
//           controller: widget.controller,
//           borderColor: Colors.grey,
//           backgroundColor: Colors.white,
//           hintText: widget.hintText,
//           suffixIconWidget: IconButton(
//             icon: Icon(_isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
//             onPressed: () {
//               setState(() {
//                 _isDropdownOpen = !_isDropdownOpen;
//               });
//             },
//           ),
//           enabledBorder: InputBorder.none,
//           focusedBorder: InputBorder.none,
//           onTap: () {
//             setState(() {
//               _isDropdownOpen = true;
//             });
//           },
//         ),
//         if (_isDropdownOpen)
//           Positioned(
//             top: 60,
//             left: 0,
//             right: 0,
//             child: Material(
//               elevation: 4.0, // Add elevation for better visibility
//               child: Container(
//                 height: 200,
//                 color: Colors.white,
//                 child: Scrollbar(
//                   child: ListView(
//                     padding: EdgeInsets.zero,
//                     children: CountryList.countries.map((country) {
//                       return ListTile(
//                         title: Text(country),
//                         selected: country == _selectedCountry,
//                         onTap: () {
//                           setState(() {
//                             _selectedCountry = country;
//                             widget.controller.text = _selectedCountry!;
//                             _isDropdownOpen = false;
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
