
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/helper/api_helper.dart';
import 'package:globalbet/res/provider/terms_condition_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {

  @override
  void initState() {
    fetchtc(context);
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final dataTc = Provider.of<TermsConditionProvider>(context).TcData;


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
            text: 'Terms & Condition',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.whiteColor,
          ),
          gradient: AppColors.unSelectedColor),
      body: dataTc!= null?SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(dataTc.description.toString(),textStyle: const TextStyle(color: AppColors.whiteColor)),
                ),
              ],
            )),
      ):Container(),
    ));
  }
  Future<void> fetchtc(context) async {
    try {
      final dataTerms = await  baseApiHelper.fetchdataTC();
      if (dataTerms != null) {
        Provider.of<TermsConditionProvider>(context, listen: false).setterms(dataTerms);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
