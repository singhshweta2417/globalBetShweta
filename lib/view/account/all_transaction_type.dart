
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:game_on/model/transaction_type_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/utils/routes/routes_name.dart';

class TransactionType extends StatefulWidget {
  String selectedId;

  TransactionType({Key? key, required this.selectedId}) : super(key: key);

  @override
  TransactionTypeState createState() => TransactionTypeState();
}

class TransactionTypeState extends State<TransactionType> {
  List<TransctionTypeModel> transactionTypes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTransactionTypes(context);
  }

  Future<void> fetchTransactionTypes(context) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(ApiUrl.allTransactionType));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        setState(() {
          transactionTypes = responseData
              .map((item) => TransctionTypeModel.fromJson(item))
              .toList();
        });
      } else if (response.statusCode == 401) {
        Navigator.pushNamed(context, RoutesName.loginScreen);
      } else {
        throw Exception('Failed to load transaction types');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching transaction types: $e');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: AppColors.darkColor,
      ),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: textWidget(
                    text: 'Cancel',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: widget.selectedId == '0'
                        ? Colors.blue
                        : AppColors.dividerColor,
                  ),
                ),
                textWidget(
                  text: 'Confirm',
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: transactionTypes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final transactionType = transactionTypes[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            widget.selectedId = index.toString();
                          });
                        },
                        child: Column(
                          children: [
                            Center(
                              child: textWidget(
                                text: transactionType.name,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: widget.selectedId == index.toString()
                                    ? Colors.blue
                                    : AppColors.whiteColor,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
