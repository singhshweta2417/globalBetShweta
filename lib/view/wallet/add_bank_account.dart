import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/add_account_view_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_field.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/provider/add_acount_controller.dart';
import 'package:flutter/material.dart';
import 'package:game_on/utils/utils.dart';
import 'package:provider/provider.dart';

class AddBankAccount extends StatefulWidget {
  final List<AddacountViewModel>? data;
  AddBankAccount({
    super.key,
    this.data,
  });

  @override
  State<AddBankAccount> createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  TextEditingController accNumberCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  TextEditingController ifscCon = TextEditingController();
  TextEditingController upiCon = TextEditingController();
  TextEditingController banknameCon = TextEditingController();
  TextEditingController branchnameCon = TextEditingController();

  bool isLoading = false;

  bool isAllFilled = false;
  @override
  void initState() {
    super.initState();

    if (widget.data != null) {
      nameCon.text = widget.data!.first.name ?? "";
      banknameCon.text = widget.data!.first.bankName ?? "";
      accNumberCon.text = widget.data!.first.accountNumber ?? "";
      branchnameCon.text = widget.data!.first.branch ?? "";
      ifscCon.text = widget.data!.first.ifscCode ?? "";
    }

    // ✅ Add Listeners to Detect Changes in Input Fields
    nameCon.addListener(checkAllFieldsFilled);
    banknameCon.addListener(checkAllFieldsFilled);
    accNumberCon.addListener(checkAllFieldsFilled);
    branchnameCon.addListener(checkAllFieldsFilled);
    ifscCon.addListener(checkAllFieldsFilled);
    upiCon.addListener(checkAllFieldsFilled);
  }

  void checkAllFieldsFilled() {
    setState(() {
      isAllFilled = nameCon.text.isNotEmpty &&
          banknameCon.text.isNotEmpty &&
          accNumberCon.text.isNotEmpty &&
          branchnameCon.text.isNotEmpty &&
          ifscCon.text.isNotEmpty &&
          upiCon.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AddacountProvider>(context);

    return Scaffold(
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Add a bank account number',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.whiteColor),
          gradient: AppColors.unSelectedColor),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                  height: height * 0.08,
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      gradient: AppColors.unSelectedColor,
                      borderRadius: BorderRadiusDirectional.circular(30)),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.iconsAttention,
                        color: AppColors.whiteColor,
                      ),
                      textWidget(
                          text:
                              'Need to add beneficiary information to be able to \nwithdraw money',
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w900),
                    ],
                  )),
              const SizedBox(height: 15),
              titleWidget(Assets.iconsPeople, "Full recipient's name"),
              const SizedBox(height: 15),
              CustomTextField(
                  controller: nameCon,
                  cursorColor: AppColors.whiteColor,
                  hintText: "Please enter the recipient's name",
                  style: const TextStyle(color: AppColors.whiteColor),
                  hintColor: AppColors.whiteColor),
              const SizedBox(height: 15),
              titleWidget(Assets.iconsBank, 'Bank name'),
              const SizedBox(height: 15),
              CustomTextField(
                  controller: banknameCon,
                  cursorColor: AppColors.whiteColor,
                  hintText: 'Please enter your bank name ',
                  style: const TextStyle(color: AppColors.whiteColor),
                  hintColor: AppColors.whiteColor),

              const SizedBox(height: 15),
              titleWidget(Assets.iconsAccNumber, 'Bank account number'),
              const SizedBox(height: 15),
              CustomTextField(
                controller: accNumberCon,
                cursorColor: AppColors.whiteColor,
                hintText: 'Please enter your bank account no.',
                style: const TextStyle(color: AppColors.whiteColor),
                hintColor: AppColors.whiteColor,
              ),
              const SizedBox(height: 15),
              titleWidget(Assets.iconsAccNumber, 'Bank branch'),
              const SizedBox(height: 15),
              CustomTextField(
                  controller: branchnameCon,
                  cursorColor: AppColors.whiteColor,
                  hintText: 'Please enter your branch name ',
                  style: const TextStyle(color: AppColors.whiteColor),
                  hintColor: AppColors.whiteColor),

              const SizedBox(height: 15),
              titleWidget(Assets.iconsIfscCode, 'IFSC code'),
              const SizedBox(height: 15),
              CustomTextField(
                  controller: ifscCon,
                  cursorColor: AppColors.whiteColor,
                  hintText: 'Please enter IFSC code',
                  style: const TextStyle(color: AppColors.whiteColor),
                  hintColor: AppColors.whiteColor),
              const SizedBox(height: 15),
              titleWidget(Assets.iconsIfscCode, 'UPI ID'),
              const SizedBox(height: 15),
              CustomTextField(
                  controller: upiCon,
                  cursorColor: AppColors.whiteColor,
                  hintText: 'Please enter UPI ID ',
                  style: const TextStyle(color: AppColors.whiteColor),
                  hintColor: AppColors.whiteColor),
              const SizedBox(height: 15), // Add this state variable

              AppBtn(
                onTap: () async {
                  if (nameCon.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please enter Recipient Name", context, Colors.black);
                  } else if (banknameCon.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please enter Bank Name", context, Colors.black);
                  } else if (accNumberCon.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please enter Bank Account Number",
                        context,
                        Colors.black);
                  } else if (branchnameCon.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please enter Branch Name", context, Colors.black);
                  } else if (ifscCon.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please enter IFSC Code", context, Colors.black);
                  } else if (upiCon.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please enter UPI ID", context, Colors.black);
                  } else if (isAllFilled) {
                    setState(() {
                      isLoading = true; // Show loader
                    });

                    await authProvider.addAccount(
                      context,
                      nameCon.text,
                      banknameCon.text,
                      accNumberCon.text,
                      branchnameCon.text,
                      ifscCon.text,
                      upiCon.text,
                    );

                    setState(() {
                      isLoading = false; // Hide loader after API call
                    });
                  }
                },
                hideBorder: true,
                gradient: isAllFilled
                    ? AppColors.greenButtonGrad
                    : AppColors.primaryAppbarGrey,
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'S a v e',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleWidget(String image, String title) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 30,
        ),
        const SizedBox(width: 10),
        textWidget(
            text: title,
            fontSize: 18,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w600),
      ],
    );
  }
}
