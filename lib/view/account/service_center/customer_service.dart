import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/model/customer_service_model.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:http/http.dart'as http;

class CustomerCareService extends StatefulWidget {
  const CustomerCareService({super.key});

  @override
  State<CustomerCareService> createState() => _CustomerCareServiceState();
}

class _CustomerCareServiceState extends State<CustomerCareService> {




  @override
  void initState() {
    customerServiceApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: GradientAppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.white,
                )),
          ),
          centerTitle: true,
          title: textWidget(
            text: 'Customer service',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.whiteColor,
          ),
          gradient: AppColors.unSelectedColor),
      body: Stack(
        //clipBehavior: Clip.none,
        children: [
          Container(
            height: height*0.28,
            width: width*999,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(Assets.imagesCustomerBg),fit: BoxFit.fill),),
          ),
          Padding(
            padding:  EdgeInsets.only(top: height*0.28,),
            child: Container(
              height: height*0.7,
              width: width*0.999,
              decoration: const BoxDecoration(
                  gradient: AppColors.unSelectedColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
              ),
              child:ListView.builder(
                shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: customerService.length,
                  itemBuilder: (context,index){
                  final service = customerService[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15,5,15,5),
                      child: InkWell(
                        onTap: (){
                          _launchURL(service.link.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 15, 15, 5),
                          height: height*0.09,
                          width: width*0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.darkColor,

                          ),
                          child: Row(
                            children: [
                              SizedBox(width: width*0.02,),

                              Image(image: NetworkImage(service.image.toString()),height: height*0.05,),
                              SizedBox(width: width*0.02,),
                              textWidget(
                                text: service.name.toString(),
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: AppColors.whiteColor,
                              ),
                              const Spacer(),

                              const Icon(Icons.arrow_forward_ios,color: AppColors.whiteColor,)
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  //---------------

  UserViewModel userProvider = UserViewModel();

  List<CustomerServiceModel> customerService = [];

  Future<void> customerServiceApi() async {

    final response = await http.get(Uri.parse(ApiUrl.customerService),);
    if (kDebugMode) {
      print(ApiUrl.customerService);
      print('getwayList+token');

    }


    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        customerService = responseData.map((item) => CustomerServiceModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        customerService = [];
      });
      throw Exception('Failed to load data');
    }
  }

  _launchURL(String urlget) async {
    var url = urlget;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
