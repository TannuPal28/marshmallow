class BannerModel {
  final String id;
  final String title;
  final String file;
  final int sequence;

  BannerModel({
    required this.id,
    required this.title,
    required this.file,
    required this.sequence,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      file: json['file'] ?? '',
      sequence: json['sequence'] ?? 0,
    );
  }
}