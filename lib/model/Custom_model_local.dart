import 'dart:convert';
/// name : "Swiftlash"
/// logo_url : "http://static.wikia.nocookie.net/dota2_gamepedia/images/9/96/Swiftslash_icon.png"

CustomModelLocal customModelLocalFromJson(String str) => CustomModelLocal.fromJson(json.decode(str));
String customModelLocalToJson(CustomModelLocal data) => json.encode(data.toJson());
class CustomModelLocal {
  CustomModelLocal({
      String? name, 
      String? logoUrl,}){
    _name = name;
    _logoUrl = logoUrl;
}

  CustomModelLocal.fromJson(dynamic json) {
    _name = json['name'];
    _logoUrl = json['logo_url'];
  }
  String? _name;
  String? _logoUrl;
CustomModelLocal copyWith({  String? name,
  String? logoUrl,
}) => CustomModelLocal(  name: name ?? _name,
  logoUrl: logoUrl ?? _logoUrl,
);
  String? get name => _name;
  String? get logoUrl => _logoUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['logo_url'] = _logoUrl;
    return map;
  }

}