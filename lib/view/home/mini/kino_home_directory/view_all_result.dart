import 'package:flutter/material.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/api/kino_result_api.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/kino_colors.dart';
import 'package:provider/provider.dart';


class KinoAllResult extends StatefulWidget {
  const KinoAllResult({super.key});

  @override
  State<KinoAllResult> createState() => _KinoAllResultState();
}

class _KinoAllResultState extends State<KinoAllResult> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.05, right: width * 0.023, left: width * 0.023),
          child: Container(
            height: height * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade900,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'View All Result',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: height*0.04,
                          width: width*0.075,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          child: const Icon(
                            Icons.cancel_outlined,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 0.2),

                Consumer<KinoResultApi>(
                  builder: (context, krv, child) {
                    if (krv.response.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: krv.response.map((data) {
                            List<dynamic> numbers = data.number
                                .replaceAll(RegExp(r'[\[\]]'), '') // Remove brackets
                                .split(',')
                                .map((e) => e.trim()) // Trim spaces
                                .toList();
                            return Wrap(
                              alignment: WrapAlignment.center,
                              children: numbers.map((num) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    decoration: BoxDecoration(
                                      gradient: KiNoColors.greenGradient,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black, width: 2),
                                    ),
                                    width: width * 0.07,
                                    height: height * 0.035,
                                    child: Center(
                                      child: Text(
                                        num,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }).toList(),
                        ),
                      ),
                    );
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
