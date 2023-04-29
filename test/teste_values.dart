import 'package:astronomy_picture/features/apod/data/models/apod_model.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';

Apod Function() tApod = () => Apod(
    copyright: "Stefan Seip",
    date: DateTime.parse("2004-09-27"),
    explanation: "The Great Nebula in Orion is a colorful place.",
    mediaType: "image",
    serviceVersion: "v1",
    title: "The Great Nebula in Orion",
    url: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
    hdurl: "https://apod.nasa.gov/apod/image/0409/orion_seip_big.jpg");

DateTime Function() tDateTime = () => DateTime(2023, 3, 22);

ApodModel Function() tApodModel = () => ApodModel(
    copyright: "Stefan Seip",
    date: DateTime.parse("2004-09-27"),
    explanation: "The Great Nebula in Orion is a colorful place.",
    mediaType: "image",
    serviceVersion: "v1",
    title: "The Great Nebula in Orion",
    url: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
    hdurl: "https://apod.nasa.gov/apod/image/0409/orion_seip_big.jpg");
