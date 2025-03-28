import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/helper/api_helper.dart';
import 'package:game_on/res/provider/contact_us_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  @override
  void initState() {
    fetchcontact(context);
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final contactusData = Provider.of<ContactUsProvider>(context).contactUsData;

    return SafeArea(child: Scaffold(
      
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Contact Us',
              fontSize: 25,
              color: AppColors.whiteColor),
          gradient: AppColors.primaryAppbarGrey),
      body: contactusData!= null?SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(contactusData.description.toString(),textStyle: const TextStyle(color: Colors.white),),
                ),
              ],
            )),


      ):Column(
        children: [
          Center(
            child: Image(
              image: const AssetImage(Assets.imagesNoDataAvailable),
              height: height / 3,
              width: width / 2,
            ),
          ),
          SizedBox(height: height*0.04),
          const Text("Data not found",style: TextStyle(color: Colors.white),)
        ],
      ),
    ));
  }
  Future<void> fetchcontact(context) async {
    try {
      final dataContact = await  baseApiHelper.fetchdataCU();
      if (kDebugMode) {
        print(dataContact);
        print("dataContact");
      }
      if (dataContact != null) {
        Provider.of<ContactUsProvider>(context, listen: false).setCu(dataContact);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
