class UploadImage {
  bool? error;
  String? message;
  String? url;

  UploadImage({this.error, this.message, this.url});

  UploadImage.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    data['url'] = url;
    return data;
  }
}
