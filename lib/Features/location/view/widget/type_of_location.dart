import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TypeOfLocation extends StatefulWidget {
  final void Function(String?) onSelected;
  const TypeOfLocation({super.key , required this.onSelected});

  @override
  State<TypeOfLocation> createState() => _TypeOfLocationState();
}

class _TypeOfLocationState extends State<TypeOfLocation> {
  List<DropdownMenuItem<String>> items = [
    DropdownMenuItem(
      value: 'building',
      child: Row(
        children: <Widget>[
          SvgPicture.asset("assets/images/building-2-svgrepo-com.svg", width: 40),
          SizedBox(width: 10),
          Text('Building'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'villa',
      child: Row(
        children: <Widget>[
          SvgPicture.asset("assets/images/villa-svgrepo-com.svg", width: 40),
          SizedBox(width: 10),
          Text('Villa'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'office',
      child: Row(
        children: <Widget>[
          SvgPicture.asset("assets/images/office-building-svgrepo-com.svg", width: 40),
          SizedBox(width: 10),
          Text('Office'),
        ],
      ),
    ),
  ] ;
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Full width
      padding: const EdgeInsets.symmetric(horizontal: 12.0 , vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),

      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedValue,
          hint: items.first ,
          isExpanded: true, // Ensures the dropdown takes the full width
          items: items ,
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            widget.onSelected(newValue);

          },
        ),
      ),
    );
  }
}
