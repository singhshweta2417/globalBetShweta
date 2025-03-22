import 'package:flutter/material.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/app_constant.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/clipboard.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/helper/api_helper.dart';
import 'package:globalbet/view/account/change_password.dart';
import 'package:globalbet/view/account/service_center/bind_mail_box.dart';
import 'package:globalbet/view/account/service_center/change_aviator.dart';
import 'package:globalbet/view/account/service_center/change_user_name.dart';

class SettingPageNew extends StatefulWidget {
  const SettingPageNew({super.key});

  @override
  State<SettingPageNew> createState() => _SettingPageNewState();
}

class _SettingPageNewState extends State<SettingPageNew> {
  @override
  void initState() {
   // fetchData();
   //
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    List<ListItem> settingList = [
      ListItem(
          image: Assets.iconsEditPswIcon,
          name: 'Login Password',
          subTitle: 'Edit',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChangePassword()));
          }
      ),
      ListItem(
          image: Assets.iconsEmailIcon,
          name: 'Bind mailbox',
          subTitle: 'to bind',
          onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const BindMailBoxScreen()));
    }
      ),
      ListItem(
          image: Assets.iconsVersionUpdate,
          name: 'Updated Version',
          subTitle: AppConstants.appVersion,
          onTap: () {}

      ),
    ];
   final profileView= Provider.of<ProfileViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.scaffoldDark,
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
              text: 'Setting center',
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: AppColors.primaryTextColor,
            ),
            gradient: AppColors.primaryGradient),
        body:
        // context.read<ProfileProvider>() == null
        //     ? const Center(child: CircularProgressIndicator())
        //     :
        ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Stack(
                      children: [
                    Container(
                      height: height * 0.25,
                      width: width,
                      decoration: const BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40))),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.04),
                            child: Container(
                              height: height * 0.35,
                              width: width * 0.95,
                              decoration: BoxDecoration(
                                  gradient: AppColors.primaryUnselectedGradient,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(15)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ChangeAvtar()));
                                      },
                                      child: Row(
                                        children: [
                                          Center(
                                            child: CircleAvatar(
                                              radius: 50,
                                              child: CircleAvatar(
                                                radius: 48,
                                                backgroundImage: NetworkImage(
                                                    profileView.userImage.toString()
                                              ),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          textWidget(
                                              text: 'Change Avatar ',
                                              color:
                                                  AppColors.gradientFirstColor,
                                              fontSize: 16),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 17,
                                            color: AppColors.primaryTextColor,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.03,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => const NickNamePopUp());
                                      },
                                      child: Row(
                                        children: [
                                          textWidget(
                                              text: '    NickName',
                                              color: AppColors.primaryTextColor,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15),
                                          const Spacer(),
                                          textWidget(
                                              text: profileView.userName.toString(),
                                              color: AppColors.primaryTextColor,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 17,
                                            color: AppColors.primaryTextColor,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: AppColors.secondaryTextColor,
                                    ),
                                    Row(
                                      children: [
                                        textWidget(
                                            text: '    UID',
                                            color: AppColors.primaryTextColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                        const Spacer(),
                                        textWidget(
                                            text: profileView.userId.toString(),
                                            color: AppColors.primaryTextColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                        IconButton(
                                          onPressed: () {
                                            copyToClipboard(
                                                profileView.userId.toString(),
                                                context);
                                          },
                                          icon: Image.asset(
                                            Assets.iconsCopyIcon,
                                            scale: 1.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Container(
                                height: 20,
                                width: 3,
                                color: AppColors.gradientFirstColor,
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              textWidget(
                                  text: 'Security Information',
                                  color: AppColors.primaryTextColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: settingList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (settingList[index].onTap != null) {
                                      settingList[index].onTap!(); // Call the onTap function if it's not null
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(5),
                                    width: width * 0.5,
                                    decoration: BoxDecoration(
                                        gradient:
                                            AppColors.primaryUnselectedGradient,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        Container(
                                          height: height * 0.08,
                                          width: width * 0.15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              //gradient: AppColors.lightGradient,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      settingList[index]
                                                          .image
                                                          .toString()),
                                                  fit: BoxFit.fill)),
                                        ),
                                        SizedBox(
                                          width: width * 0.02,
                                        ),
                                        textWidget(
                                            text: settingList[index]
                                                .name
                                                .toString(),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.primaryTextColor),
                                        const Spacer(),
                                        textWidget(
                                            text: settingList[index]
                                                .subTitle
                                                .toString(),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.primaryTextColor),
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 17,
                                            color: AppColors.primaryTextColor),
                                        SizedBox(
                                          width: width * 0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ]),
                ),
              ));
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();


}

class ListItem {
  String? image;
  String? name;
  String? subTitle;
   VoidCallback? onTap;

  ListItem({
    this.image,
    this.name,
    this.subTitle,
    this.onTap,
  });
}
