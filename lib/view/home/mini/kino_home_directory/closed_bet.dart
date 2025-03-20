import 'package:flutter/material.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';


class ClosedBet extends StatefulWidget {
  const ClosedBet({super.key});


  @override
  State<ClosedBet> createState() => _ClosedBetState();
}

class _ClosedBetState extends State<ClosedBet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black26),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                child: Container(
                  height: height*0.055,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Colors.black),
                    color:  AppColors.greyColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 8,
                        offset: Offset(2, 2), // Shadow position
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.play_arrow_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      Text(
                        'BET CLOSED',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height*0.01,),
              Container(
                height: height*0.08,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5, right: 12, left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'BET INR',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Container(
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade500,
                              border: Border.all(
                                  width: 1, color: Colors.black),
                            ),
                            child: const Center(
                                child: Text(
                                  '10',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(

                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 0.5, color: Colors.black),
                              color:  AppColors.greyColor,),
                            child: const Icon(
                              Icons.remove,
                              size: 20,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(

                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 0.5, color: Colors.black),
                              color:  AppColors.greyColor,),
                            child: const Icon(
                              Icons.dynamic_feed_rounded,
                              size: 20,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(

                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 0.5, color: Colors.black),
                              color:  AppColors.greyColor,),
                            child: const Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}