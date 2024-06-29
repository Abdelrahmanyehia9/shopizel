import 'package:flutter/material.dart';

class ListOfSizes extends StatefulWidget {
  final List<String> sizes;
  final String color;
  final ValueChanged<String> onSizeSelected; // Callback for selected value


  const ListOfSizes({super.key, required this.sizes, required this.color ,required this.onSizeSelected});

  @override
  State<ListOfSizes> createState() => _ListOfSizesState();
}

class _ListOfSizesState extends State<ListOfSizes> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.sizes.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
            radius: 18.5,
            backgroundColor: Colors.grey.withOpacity(0.6),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onSizeSelected(widget.sizes[index]); // Call the callback with selected value

              },
              child: CircleAvatar(
                backgroundColor: _selectedIndex == index
                    ? Color(int.parse(widget.color))
                    : const Color(0xffF3F3F3),
                radius: 18,
                child: Text(
                  widget.sizes[index],
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color:  _selectedIndex == index ? Colors.white :Colors.black
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
