import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';

class ApodModel extends Apod {
  const ApodModel(
      {required super.copyright,
      required super.date,
      required super.explanation,
      required super.mediaType,
      required super.serviceVersion,
      required super.title,
      required super.url,
      super.hdurl,
      super.thumbnailUrl});

  factory ApodModel.fromJson(Map<String, dynamic> json) => ApodModel(
        copyright: json["copyright"] ?? "Nasa APOD",
        date: DateTime.parse(json["date"]),
        explanation: json["explanation"],
        mediaType: json["media_type"],
        serviceVersion: json["service_version"],
        title: json["title"],
        url: json["url"],
        hdurl: json["hdurl"],
        thumbnailUrl: json["thumbnail_url"],
      );

  factory ApodModel.fromEntity(Apod apod) => ApodModel(
        copyright: apod.copyright,
        date: apod.date,
        explanation: apod.explanation,
        mediaType: apod.mediaType,
        serviceVersion: apod.serviceVersion,
        title: apod.title,
        url: apod.url,
        hdurl: apod.hdurl,
        thumbnailUrl: apod.thumbnailUrl,
      );

  Map<String, dynamic> toJson() => {
        'copyright': copyright,
        'date': date.toString(),
        'explanation': explanation,
        'media_type': mediaType,
        'service_version': serviceVersion,
        'title': title,
        'url': url,
        'hdurl': hdurl,
        'thumbnail_url': thumbnailUrl,
      };

  Apod toEntity() => Apod(
      copyright: copyright,
      date: date,
      explanation: explanation,
      mediaType: mediaType,
      serviceVersion: serviceVersion,
      title: title,
      url: url,
      hdurl: hdurl,
      thumbnailUrl: thumbnailUrl);
}
