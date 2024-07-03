import 'package:flutter/material.dart';

class ListOfColors extends StatefulWidget {

  final List<String> colors;
  final ValueChanged<String> onSizeSelected;
  const ListOfColors({super.key , required this.onSizeSelected , required this.colors ,});

  @override
  State<ListOfColors> createState() => _ListOfColorsState();
}

class _ListOfColorsState extends State<ListOfColors> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return    SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.colors.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
            radius: 19,
            backgroundColor: _selectedIndex == index ? Colors.white : Colors.transparent ,
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onSizeSelected(widget.colors[index]); // Call the callback with selected value

              },
              child: CircleAvatar(
                  backgroundColor: _selectedIndex == index ? Colors.white
                      : const Color(0xffF3F3F3),
                  radius: 18,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(int.parse(widget.colors[index])),
                  )
              ),
            ),
          ),
        ),
      ),
    );

  }
}
