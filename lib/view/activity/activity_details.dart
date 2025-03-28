import 'package:flutter/material.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/slider_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';

class ActivityDetails extends StatefulWidget {
  final SliderModel bannerdata;
  const ActivityDetails({super.key, required this.bannerdata});

  @override
  State<ActivityDetails> createState() => _ActivityDetailsState();
}

class _ActivityDetailsState extends State<ActivityDetails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.darkColor,
      appBar: const GradientAppBar(
          title: Text(
            "Activity Details",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: AppBackBtn(),
          gradient: AppColors.primaryGradient),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox( height: height * 0.02,),
          Container(
            height: 150,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    widget.bannerdata.image.toString()),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox( height: height * 0.01,),
          Center(
            child: Text(widget.bannerdata.name.toString(),style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),),
          ),
          widget.bannerdata.activityImage == null?const SizedBox()
          :Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height*0.50,
              width: width,
              decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      widget.bannerdata.activityImage.toString()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
