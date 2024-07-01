import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/cart/data/model/cart_model.dart';
import 'package:shoppizel/Features/home/view/widgets/store/list_of_sizes.dart';
import '../../../../../core/function/favourite.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/screen_dimentions.dart';
import '../../../../Favourite/controller/favourite_cubit.dart';
import '../../../../cart/view/widgets/add_to_cart_btn.dart';
import '../../../data/model/product_model.dart';

class ChoseSizeAndColor extends StatefulWidget {
  ChoseSizeAndColor({super.key, required this.color, required this.model});
  final String color;
  bool isFav = false;
  final ProductModel model;

  @override
  State<ChoseSizeAndColor> createState() => _ChoseSizeAndColorState();
}

class _ChoseSizeAndColorState extends State<ChoseSizeAndColor> {
  String? selectedSize ;
  String? selectedColor;
  @override
  Widget build(BuildContext context) {
    List<String> sizes = widget.model.sizes
            ?.where((item) => item is String)
            .map((item) => item as String)
            .toList() ??
        [];
    List<String> colors = widget.model.colors
            ?.where((item) => item is String)
            .map((item) => item as String)
            .toList() ??
        [];


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Divider(
            color: Colors.grey.shade300,
          ),
        ),
        sizeChart(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListOfSizes(
            sizes: sizes,
            color: widget.color,
            onSizeSelected: (selected) {
              setState(() {
                selectedSize = selected;
              });
            },
          ),
        ),
        const Text(
          "Select Color",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListOfColors(
            colors: colors,
            onSizeSelected: (String value) {
              setState(() {
                selectedColor = value;

              });

            },
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            height: 60,
            width: screenWidth(context) * 0.15,
            decoration: BoxDecoration(
                color: Color(int.parse(widget.color)),
                borderRadius: BorderRadius.circular(12)),
            child: InkWell(
                onTap: () async{

                  await BlocProvider.of<FavouriteCubit>(context).addOrRemoveFromFavourite(widget.isFav, widget.model);
                  setState(() {

                    widget.isFav = !widget.isFav;
                  });
                },
                child: Icon(
                  Icons.favorite,
                  size: 24,
                  color: widget.isFav == false ? Colors.white : Colors.red,
                )),
          ),
          AddToCartBtn(
            color: widget.color,
            model: CartModel(
                productId: widget.model.id,
                size: selectedSize??widget.model.sizes.first,
                color: selectedColor??widget.model.colors.first,
                quantity: 1,
                madeBy: widget.model.madeBy,
                price: widget.model.price!,
                sale: widget.model.sale ?? "0",
                imageUrl: widget.model.imageCover,
                name: widget.model.name),

          )
        ]),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  Widget sizeChart() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Select Size",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          "Size Chart",
          style: TextStyle(
              color: AppConstants.appColor,
              decoration: TextDecoration.underline,
              decorationColor: AppConstants.appColor),
        ),
      ],
    );
  }
}
