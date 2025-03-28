import 'package:flutter/material.dart';
import 'package:game_on/main.dart';
import 'package:game_on/view/home/mini/kino_home_directory/hello_how_to_play.dart';
import 'package:game_on/view/home/mini/kino_home_directory/keno_game_history.dart';


class KinoMenuBar extends StatefulWidget {
  const KinoMenuBar({super.key});

  @override
  State<KinoMenuBar> createState() => _KinoMenuBarState();
}

class _KinoMenuBarState extends State<KinoMenuBar> {

  bool light0 = true;


  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.topRight,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding:  EdgeInsets.only(top: height*0.045,right: width*0.02,),
          child: Container(
            width: width*0.5,
            height: height*0.26,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade900,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height*0.028),
                MenuItem(
                  label: 'Sound',
                  onTap: () {
                    Navigator.pop(context);
                  },
                  actionIcon:  Switch(
                    value: light0,
                    focusColor: Colors.white,
                    hoverColor:Colors.white,
                    onChanged: (bool value) {
                      setState(() {
                        light0 = value;
                      });
                    },
                  ),
                ),

                MenuItem(
                  icon: Icons.history,
                  label: 'Game History',
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true, // Dismiss when tapping outside
                      builder: (BuildContext context) {
                        return const KinoGameHistory();
                      },
                    );
                  },
                ),
                const Divider(indent: 10,endIndent: 10,thickness: 0.3,),
                MenuItem(
                  icon: Icons.help_outline_rounded,
                  label: 'how to Play',
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true, // Dismiss when tapping outside
                      builder: (BuildContext context) {
                        return const HiloHowToPlay();
                      },
                    );
                    // Handle Contact Us tap
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData? icon; // Leading icon
  final Widget? actionIcon; // Trailing action widget (like an icon or text)
  final String label; // Menu label
  final VoidCallback onTap; // Tap callback

  const MenuItem({
    super.key,
    this.icon,
    this.actionIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 10),
                  ],
                  Text(
                    label,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(width: 20,),
                  if (actionIcon != null) actionIcon!, // Display trailing widget if provided

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





