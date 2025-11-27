class AppVersionResponseModel {
  bool? success;
  Versions? versions;

  AppVersionResponseModel({this.success, this.versions});

  factory AppVersionResponseModel.fromJson(Map<String, dynamic> json) =>
      AppVersionResponseModel(
        success: json["success"],
        versions: json["versions"] == null
            ? null
            : Versions.fromJson(json["versions"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "versions": versions?.toJson(),
  };
}

class Versions {
  String? version;
  bool? mandatoryUpdate;
  DateTime? releaseDate;
  List<String>? changelog;
  String? downloadUrl;
  String? supportEmail;
  bool? isPayAvailable;

  Versions({
    this.version,
    this.mandatoryUpdate,
    this.releaseDate,
    this.changelog,
    this.downloadUrl,
    this.supportEmail,
    this.isPayAvailable,
  });

  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
    version: json["version"],
    mandatoryUpdate: json["mandatory_update"],
    releaseDate: json["release_date"] == null
        ? null
        : DateTime.parse(json["release_date"]),
    changelog: json["changelog"] == null
        ? []
        : List<String>.from(json["changelog"]!.map((x) => x)),
    downloadUrl: json["download_url"],
    supportEmail: json["support_email"],
    isPayAvailable: json["isPayAvailable"],
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "mandatory_update": mandatoryUpdate,
    "release_date":
        "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "changelog": changelog == null
        ? []
        : List<dynamic>.from(changelog!.map((x) => x)),
    "download_url": downloadUrl,
    "support_email": supportEmail,
    "isPayAvailable": isPayAvailable,
  };
}
