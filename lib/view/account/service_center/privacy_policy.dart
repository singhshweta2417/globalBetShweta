import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/helper/api_helper.dart';
import 'package:globalbet/res/provider/privacy_policy_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  @override
  void initState() {
    fetchDataPrivacyPolicy(context);
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final dataprivacy = Provider.of<PrivacyPolicyProvider>(context).PpData;


    return SafeArea(child: Scaffold(
      
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
            text: 'Privacy policy',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.whiteColor,
          ),
          gradient: AppColors.unSelectedColor),
      body: dataprivacy!= null?SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(dataprivacy.description.toString(),textStyle: const TextStyle(color: AppColors.whiteColor),),
                ),

              ],
            )),


      ):Container(),
    ));
  }
  Future<void> fetchDataPrivacyPolicy(context) async {
    try {
      final privacyDataa = await  baseApiHelper.fetchdataPP();
      if (kDebugMode) {
        print(privacyDataa);
        print("privacyDataa");
      }
      if (privacyDataa != null) {
        Provider.of<PrivacyPolicyProvider>(context, listen: false).setPrivacy(privacyDataa);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
