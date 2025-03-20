import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_button.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/custom_textfield.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view_model/deposit_view_model.dart';
import 'package:provider/provider.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({super.key});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final nameCon = TextEditingController();
  final bankNameCon = TextEditingController();
  final accountNumberCon = TextEditingController();
  final branchCon = TextEditingController();
  final ifscCon = TextEditingController();
  final upiIdCon = TextEditingController();

  bool isLoading = false;

  bool isAllFilled = false;

  @override
  void initState() {
    super.initState();
    nameCon.addListener(checkAllFieldsFilled);
    bankNameCon.addListener(checkAllFieldsFilled);
    accountNumberCon.addListener(checkAllFieldsFilled);
    ifscCon.addListener(checkAllFieldsFilled);
    upiIdCon.addListener(checkAllFieldsFilled);
  }

  void checkAllFieldsFilled() {
    setState(() {
      isAllFilled = nameCon.text.isNotEmpty &&
          bankNameCon.text.isNotEmpty &&
          accountNumberCon.text.isNotEmpty &&
          upiIdCon.text.isNotEmpty &&
          ifscCon.text.isNotEmpty;
    });
  }

  void clearAllFieldsFilled() {
    setState(() {
      nameCon.clear();
      bankNameCon.clear();
      accountNumberCon.clear();
      upiIdCon.clear();
      ifscCon.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final addAccount = Provider.of<DepositViewModel>(context);
    return SingleChildScrollView(
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: height * 0.75,
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.1,
            ),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.imagesBlackHisBox),
                  fit: BoxFit.fill),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Add Account",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: AppColors.white,
                  height: height * 0.01,
                ),
                allTextfield("NAME", nameCon),
                allTextfield("BANK NAME", bankNameCon),
                allTextfield("ACCOUNT NUMBER", accountNumberCon,
                    keyboardType: TextInputType.number),
                allTextfield("IFSC CODE", ifscCon),
                allTextfield("Upi Id", upiIdCon),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppBtn(
                        height: height * 0.08,
                        width: width * 0.15,
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        label: "Cancel",
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }),
                    AppBtn(
                      loading: addAccount.addAccountLoading,
                      height: height * 0.08,
                      width: width * 0.15,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      onTap: () async {
                        if (nameCon.text.isEmpty) {
                          Utils.flushBarErrorMessage(
                              "Please enter Recipient Name",
                              context,
                              Colors.black);
                        } else if (accountNumberCon.text.isEmpty) {
                          Utils.flushBarErrorMessage(
                              "Please enter Account Number",
                              context,
                              Colors.black);
                        } else if (bankNameCon.text.isEmpty) {
                          Utils.flushBarErrorMessage(
                              "Please enter Bank Name", context, Colors.black);
                        } else if (ifscCon.text.isEmpty) {
                          Utils.flushBarErrorMessage(
                              "Please enter IFSC Code", context, Colors.black);
                        } else if (upiIdCon.text.isEmpty) {
                          Utils.flushBarErrorMessage("Please enter your Upi Id",
                              context, Colors.black);
                        } else if (isAllFilled) {
                          setState(() {
                            isLoading = true;
                          });

                          await addAccount.addAccountApi(
                              nameCon.text,
                              accountNumberCon.text,
                              bankNameCon.text,
                              ifscCon.text,
                              upiIdCon.text,
                              context);

                          setState(() {
                            isLoading = false;
                          });
                          clearAllFieldsFilled();
                        }
                      },
                      color: isAllFilled ? AppColors.green : AppColors.red,
                      label: 'Submit',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget allTextfield(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return SizedBox(
      width: width * 0.40,
      // color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label : ",
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: width * 0.18,
            child: CustomTextField(
              controller: controller,
              title: '',
              icon: null,
            ),
          ),
        ],
      ),
    );
  }
}
