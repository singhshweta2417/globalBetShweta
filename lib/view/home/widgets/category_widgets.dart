import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final Function(int) onCategorySelected;
  const CategoryWidget({super.key, required this.onCategorySelected});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late int selectedCatIndex;
  @override
  void initState() {
    super.initState();
    selectedCatIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryList = [
      CategoryModel(
          title: 'Lottery',
          image: Assets.categoryLottery,
          subImage: Assets.categoryLotteryIcon),
      CategoryModel(
          title: 'Original',
          image: Assets.categoryFlash,
          subImage: Assets.categoryFlashIcon),
      CategoryModel(
          title: 'Casino',
          image: Assets.categoryChess,
          subImage: Assets.categoryDragonTiger),
      CategoryModel(
          title: 'Rummy',
          image: Assets.categoryPopula,
          subImage: Assets.categoryPopularIcon),
    ];

    return SizedBox(
      height: height * 0.25,
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: categoryList.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.8),
          itemBuilder: (context, index) {
            final adjustedIndex = index;
            return InkWell(
              onTap: () {
                setState(() {
                  selectedCatIndex = adjustedIndex;
                  widget.onCategorySelected(selectedCatIndex);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('${categoryList[index].image}'),
                        fit: BoxFit.fill)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height * 0.08,
                      width: width * 0.18,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                '${categoryList[index].subImage}',
                              ),
                              fit: BoxFit.fill)),
                    ),
                    textWidget(
                      text: categoryList[index].title,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: selectedCatIndex == index
                          ? Colors.black // Change text color if selected
                          : Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class CategoryModel {
  final String title;
  final String? image;
  final String? subImage;
  CategoryModel({required this.title, this.image, this.subImage});
}
