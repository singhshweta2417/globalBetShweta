import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// Model classes
class ResultHistoryModel {
  final List<ResultHistoryData> data;
  final int status;
  final String message;

  ResultHistoryModel({required this.data, required this.status, required this.message});

  factory ResultHistoryModel.fromJson(Map<String, dynamic> json) {
    return ResultHistoryModel(
      data: (json['data'] as List<dynamic>)
          .map((data) => ResultHistoryData.fromJson(data))
          .toList(),
      status: json['status'],
      message: json['message'],
    );
  }
}

class ResultHistoryData {
  final String id;
  final String sNumber;
  final String result;
  final String status;

  ResultHistoryData({
    required this.id,
    required this.sNumber,
    required this.result,
    required this.status,
  });

  factory ResultHistoryData.fromJson(Map<String, dynamic> json) {
    return ResultHistoryData(
      id: json['id'],
      sNumber: json['s_number'],
      result: json['result'],
      status: json['status'],
    );
  }
}

