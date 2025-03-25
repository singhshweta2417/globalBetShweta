import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/components/app_btn.dart';
import 'package:globalbet/res/components/text_field.dart';
import 'package:globalbet/res/helper/api_helper.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:http/http.dart'as http;

class NickNamePopUp extends StatefulWidget {
  const NickNamePopUp({super.key});

  @override
  State<NickNamePopUp> createState() => _NickNamePopUpState();
}



class _NickNamePopUpState extends State<NickNamePopUp> {

  TextEditingController nameCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
final profileView = Provider.of<ProfileViewModel>(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: ListView(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height*0.2,),
            Container(
              height: height*0.5,
              decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(15)
              ),
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(height: 1,width: width*0.07,color: Colors.white,),
                        const Text('Change NickName',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
                        Container(height: 1,width: width*0.07,color: Colors.white,)
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    width: width*0.7,
                    decoration: BoxDecoration(
                        color: AppColors.darkColor,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: height*0.06,),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: width*0.13,
                              decoration:  const BoxDecoration(
                                  image: DecorationImage(image: AssetImage(Assets.iconsDialogNickname))
                              ),
                            ),
                            const Text("Nickname",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        SizedBox(height: height*0.02,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: CustomTextField(
                            fillColor: Colors.grey.withOpacity(0.2),
                            controller: nameCon,
                            filled: true,
                            focusColor: Colors.white,
                            maxLines: 1,
                            hintText:profileView.userName.toString()
                          ),
                        ),

                const Spacer(),
                        AppBtn(
                          height: 50,
                          title: 'Submit',
                          fontSize: 20,
                          titleColor: AppColors.whiteColor,
                          hideBorder: true,
                          onTap: () {
                            avtarChangeApi(context,nameCon.text);
                          },
                          gradient: AppColors.loginSecondaryGrad,
                        ),
                        SizedBox(height: height*0.02,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: const Icon(Icons.cancel_outlined,size: 35,color: Colors.white,),),
            )
          ],
        ),
      ),
    );
  }
  BaseApiHelper baseApiHelper = BaseApiHelper();

  UserViewModel userProvider = UserViewModel();
  avtarChangeApi(context,String nickname) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.updateAviatorApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": token,
        "username": nickname,
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