import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';

class FabBottomNavBar extends StatefulWidget {
  const FabBottomNavBar({
    super.key,
    this.items,
    this.height = 60.0,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  });

  final List<FabBottomNavBarItem>? items;
  final double? height;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  final ValueChanged<int>? onTabSelected;

  @override
  State<StatefulWidget> createState() => FabBottomNavBarState();
}

int selectedIndex = 0;

class FabBottomNavBarState extends State<FabBottomNavBar> {
  _updateIndex(int index) {
    widget.onTabSelected!(index);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items!.length, (int index) {
      return _buildTabItem(
        item: widget.items![index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    return BottomAppBar(
      shape: widget.notchedShape,
      color: widget.backgroundColor,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.imagesBottomnavbar),
                fit: BoxFit.fill)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FabBottomNavBarItem? item,
    int? index,
    ValueChanged<int>? onPressed,
  }) {
    Color? color = selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: InkWell(
          onTap: item!.ontap,
          child: GestureDetector(
            onTap: () => onPressed!(index!),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (item.imageData != null)
                  Image.asset(item.imageData!, height: 20)
                else
                  const SizedBox(),
                Text(
                  item.text!,
                  style: TextStyle(
                      fontSize: 13,
                      color: color,
                      fontWeight: selectedIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FabBottomNavBarItem {
  FabBottomNavBarItem({this.imageData, this.text, this.ontap});

  String? imageData;
  String? text;
  final void Function()? ontap;
}
