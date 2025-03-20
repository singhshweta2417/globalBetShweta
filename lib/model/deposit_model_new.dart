class GetwayModel {
  dynamic id;
  dynamic image;
  dynamic name;
  dynamic status;
  dynamic type;


  GetwayModel({
    required this.id,
    required this.image,
    required this.name,
    required this.status,
    required this.type,

  });
  factory GetwayModel.fromJson(Map<String, dynamic> json) {
    return GetwayModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      status: json['status'],
      type: json['type'],

    );
  }
}