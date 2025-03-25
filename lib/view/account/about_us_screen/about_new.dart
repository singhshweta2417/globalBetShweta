import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/text_widget.dart';
import '../../../res/api_urls.dart';
import 'package:http/http.dart' as http;

class AboutNewPage extends StatefulWidget {
  final String name;
  final String type;
  const AboutNewPage({super.key, required this.name, required this.type});

  @override
  State<AboutNewPage> createState() => _AboutNewPageState();
}

class _AboutNewPageState extends State<AboutNewPage> {

  @override
  void initState() {
    fetchaboutusData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
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
            text: widget.name.toString(),
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.whiteColor,
          ),
          gradient: AppColors.unSelectedColor),

      body: SizedBox(
      height: height,
      width: width,
      child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(description.toString(),textStyle: const TextStyle(color: AppColors.whiteColor,fontSize: 10),),
              ),

            ],
          )),


    ),
    );
  }

  dynamic description;
  fetchaboutusData() async {
    final type = widget.type.toString();
    final response = await http.get(
      Uri.parse("${ApiUrl.aboutus}type=$type"),

    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body)['data'][0];
      setState(() {
        description = responseData["description"].toString();
      });
    }
    else {
      if (kDebugMode) {
        print("Failed to load data. Status code: ${response.statusCode}");
      }
    }
  }


}
