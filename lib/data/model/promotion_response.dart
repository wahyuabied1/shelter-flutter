class PromotionResponse {
  String image;
  String deeplink;
  String url;

  PromotionResponse({
    required this.image,
    required this.deeplink,
    required this.url,
  });

  // Factory method to create a Promotion object from JSON
  factory PromotionResponse.fromJson(Map<String, dynamic> json) {
    return PromotionResponse(
      image: json['image'],
      deeplink: json['deeplink'],
      url: json['url'],
    );
  }

  // Convert a Promotion object to JSON
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'deeplink': deeplink,
      'url': url,
    };
  }

}
