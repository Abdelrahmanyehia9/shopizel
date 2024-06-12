import 'package:flutter/material.dart';



class CategorySelectionBar extends StatefulWidget {
  const CategorySelectionBar({super.key});

  @override
  _CategorySelectionBarState createState() => _CategorySelectionBarState();
}

class _CategorySelectionBarState extends State<CategorySelectionBar> {
  String selectedCategory = 'All';

  final List<Map<String, String>> categories = [
    {'name': 'All', 'image': 'https://img.freepik.com/free-photo/multi-colored-garments-hanging-coathangers-boutique-store-generated-by-ai_188544-19854.jpg'},
    {'name': 'Men', 'image': 'https://corporate.lcwaikiki.com/CMSFiles/PhotoGallery/BigImage/637552167794530487.jpg'},
    {'name': 'Women', 'image': 'https://static.zara.net/assets/public/9f4f/2d6c/387c49e68ecc/172f280cd6a0/05479046500-18-a1/05479046500-18-a1.jpg?ts=1709811208528&w=824'},
    {'name': 'Baby', 'image': 'https://ae01.alicdn.com/kf/Hd8f6f6e5be03415497ba28011440ae7ab/Newborn-Kids-Baby-Girls-Short-Sleeve-Floral-Dress-Top-Short-Pants-Baby-Girls-Outfit-Clothes.jpg'},
    {'name': 'jewellery', 'image': 'https://www.josalukkasonline.com/Media/CMS/jos-alukkas-wedding-20231208145835676216.webp'},

  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.map((category) {
            bool isSelected = selectedCategory == category['name'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category['name']!;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(

                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: isSelected ? Colors.orange : Colors.grey[200],
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(category['image']!),
                        radius: 30,
                        backgroundColor: isSelected ? Colors.orange : Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['name']!,
                      style: TextStyle(
                        color: isSelected ? Colors.orange : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,

                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}