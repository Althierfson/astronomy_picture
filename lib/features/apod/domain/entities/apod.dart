import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Apod extends Equatable {
  final String copyright;
  final DateTime date;
  final String explanation;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;
  final String? thumbnailUrl;
  final String? hdurl;

  const Apod({
    required this.copyright,
    required this.date,
    required this.explanation,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
    this.hdurl,
    this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [
        copyright,
        date,
        explanation,
        mediaType,
        hdurl,
        serviceVersion,
        thumbnailUrl,
        title,
        url,
      ];
}
