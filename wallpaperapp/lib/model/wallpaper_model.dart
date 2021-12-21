class WallpaperModel{
  String photographer;
  String photographer_url;
  int photographer_id;
  SrcModel src;

  WallpaperModel({
    required this.photographer,
    required this.photographer_id,
    required this.photographer_url,
    required this.src
  });

  factory WallpaperModel.fromMap(Map<String,dynamic> jsonData){
    return WallpaperModel(
        photographer: jsonData['photographer'],
        photographer_id: jsonData['photographer_id'],
        photographer_url: jsonData['photographer_url'],
        src: SrcModel.fromMap(jsonData['src'])
    );
  }
}
class SrcModel{
  String small;
  String portrait;
  String original;

  SrcModel({
    required this.original,
    required this.portrait,
    required this.small,
  });

  factory SrcModel.fromMap(Map<String, dynamic> jsonData){
    return SrcModel(
      original: jsonData['original'],
      portrait: jsonData['portrait'],
      small: jsonData['small'],
    );
  }
}