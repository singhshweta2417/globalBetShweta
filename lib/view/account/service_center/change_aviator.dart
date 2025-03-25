import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/model/change_avatar_list_model.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/helper/api_helper.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../res/api_urls.dart';
import 'package:http/http.dart'as http;
class ChangeAvtar extends StatefulWidget {
  const ChangeAvtar({super.key});

  @override
  State<ChangeAvtar> createState() => _ChangeAvtarState();
}

class _ChangeAvtarState extends State<ChangeAvtar> {
  int selectedIndex = -1;
  @override
  void initState() {
    changeAvtarApi();
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
            text: 'Change avatar',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.whiteColor,
          ),
          gradient: AppColors.unSelectedColor),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:changeAvtar.isEmpty?const Center(child: CircularProgressIndicator()):
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: changeAvtar.length,
          itemBuilder: (context, index) {
            final bool isSelected = index == selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                avtarChangeApi(context,image:changeAvtar[index].image.toString());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                                image: NetworkImage(changeAvtar[index].image.toString(),
                        ))),
                      ),
                      isSelected ?
                      const Align(
                        alignment: Alignment.bottomRight,
                          child: Icon(Icons.check_circle,color: AppColors.whiteColor,)):Container()

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  BaseApiHelper baseApiHelper = BaseApiHelper();



  UserViewModel userProvider = UserViewModel();

  List<ChangeAvtarModel> changeAvtar = [];
  Future<void> changeAvtarApi() async {
    final response = await http.get(Uri.parse(ApiUrl.changeAviatorList),);
    if (kDebugMode) {
      print(ApiUrl.changeAviatorList);
      print('changeAvtarList');

    }


    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        changeAvtar = responseData.map((item) => ChangeAvtarModel.fromJson(item)).toList();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        changeAvtar = [];
      });
      throw Exception('Failed to load data');
    }
  }


  avtarChangeApi(context,{required String image}) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.updateAviatorApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": token,
        "userimage": image,
      }),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == 200) {
      Provider.of<ProfileViewModel>(context, listen: false).profileApi(context);
      Navigator.pop(context);
      return Utils.flushBarSuccessMessage(data['message'], context, Colors.black);
    } else if (data["status"] == 401) {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    } else {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }
}

