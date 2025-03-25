class SliderModel{
  final String? name;
  final String? image;
  final String? activityImage;


  SliderModel({
    this.name,
    this.image,
    this.activityImage,
  });
  factory SliderModel.fromJson(Map<dynamic, dynamic>json){

    return SliderModel(
      name: json["name"],
      image: json["image"],
      activityImage: json["activity_image"],
    );
  }


}
