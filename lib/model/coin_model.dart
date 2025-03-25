class CoinModel {
  
  final String? id;
  final String? name;
  final String? first;
  final String? addon;
  final String? inr;
  final String? usdt;
 

  CoinModel({
    required this.id,
    required this.name,
    required this.first,
    required this.addon,
    required this.inr,
    required this.usdt,
    
  });
  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
     id: json['id'],
     name: json['name'],
     first: json['first'],
     addon: json['addon'],
     inr: json['INR'],
     usdt: json['USDT'],
      
  );
  }
}