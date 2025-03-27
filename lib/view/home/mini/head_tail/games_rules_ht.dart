import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/view/home/mini/head_tail/head_tail_assets.dart';
import 'package:http/http.dart' as http;

import '../../../../res/api_urls.dart';


class GameRulesPage extends StatefulWidget {
  final String gameId;
  const GameRulesPage({Key? key,  required this.gameId}) : super(key: key);

  @override
  State<GameRulesPage> createState() => _GameRulesPageState();
}

class _GameRulesPageState extends State<GameRulesPage> {
  dynamic data;
  Future<void> gameRuleApi() async {
    var gameIds= widget.gameId;
    final response = await http.get(Uri.parse(ApiUrl.gameRules+gameIds));
    final datas = jsonDecode(response.body);

    if (kDebugMode) {
      print(datas);
    }
    if (datas['success'] == "200") {
      setState(() {
        data = datas['data'];
      });
    } else {}
  }

  @override
  void initState() {
    gameRuleApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Material(
        color: Colors.transparent,
        child:  Align(
          alignment: Alignment.center,
          child: Container(
            height: height*0.6,
            width: width*0.6,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(HeadTailAssets.headTailTaleBg),
                    fit: BoxFit.fill)),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 20,
                        width: 40,
                      ),
                      const Text(
                        'Game Rules',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const SizedBox(
                          height: 30,
                          width: 60,
                          //  color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                ),
                SizedBox(
                  height: height*0.45,
                  width: width*0.53,
                  child: data==null?const Center(child: CircularProgressIndicator()):
                  SingleChildScrollView(
                    child: HtmlWidget(
                        data.toString()
                    ),
                  ),
                )


              ],
            ),
          ),
        )

    );
  }
}