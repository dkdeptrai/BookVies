import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Report {
  final String id;
  final String reportTitle;
  final String reportContent;
  final String reportUserId;
  final String reportUserName;
  final String reportUserImageUrl;
  final String mediaName;
  final String mediaImageUrl;
  final String reviewId;
  final String reviewTitle;
  final String reviewContent;
  final String reviewUserId;
  final String reviewUserName;
  final String reviewUserImageUrl;
  final int reviewRating;
  Report({
    required this.id,
    required this.reportTitle,
    required this.reportContent,
    required this.reportUserId,
    required this.reportUserName,
    required this.reportUserImageUrl,
    required this.mediaName,
    required this.mediaImageUrl,
    required this.reviewId,
    required this.reviewTitle,
    required this.reviewContent,
    required this.reviewUserId,
    required this.reviewUserName,
    required this.reviewUserImageUrl,
    required this.reviewRating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reportTitle': reportTitle,
      'reportContent': reportContent,
      'reportUserId': reportUserId,
      'reportUserName': reportUserName,
      'reportUserImageUrl': reportUserImageUrl,
      'mediaName': mediaName,
      'mediaImageUrl': mediaImageUrl,
      'reviewId': reviewId,
      'reviewTitle': reviewTitle,
      'reviewContent': reviewContent,
      'reviewUserId': reviewUserId,
      'reviewUserName': reviewUserName,
      'reviewUserImageUrl': reviewUserImageUrl,
      'reviewRating': reviewRating,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] as String,
      reportTitle: map['reportTitle'] as String,
      reportContent: map['reportContent'] as String,
      reportUserId: map['reportUserId'] as String,
      reportUserName: map['reportUserName'] as String,
      reportUserImageUrl: map['reportUserImageUrl'] as String,
      mediaName: map['mediaName'] ?? "",
      mediaImageUrl: map['mediaImageUrl'] ?? "",
      reviewId: map['reviewId'] as String,
      reviewTitle: map['reviewTitle'] as String,
      reviewContent: map['reviewContent'] as String,
      reviewUserId: map['reviewUserId'] as String,
      reviewUserName: map['reviewUserName'] as String,
      reviewUserImageUrl: map['reviewUserImageUrl'] as String,
      reviewRating: map['reviewRating'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) =>
      Report.fromMap(json.decode(source) as Map<String, dynamic>);

  Report copyWith({
    String? id,
    String? reportTitle,
    String? reportContent,
    String? reportUserId,
    String? reportUserName,
    String? reportUserImageUrl,
    String? mediaName,
    String? mediaImageUrl,
    String? reviewId,
    String? reviewTitle,
    String? reviewContent,
    String? reviewUserId,
    String? reviewUserName,
    String? reviewUserImageUrl,
    int? reviewRating,
  }) {
    return Report(
      id: id ?? this.id,
      reportTitle: reportTitle ?? this.reportTitle,
      reportContent: reportContent ?? this.reportContent,
      reportUserId: reportUserId ?? this.reportUserId,
      reportUserName: reportUserName ?? this.reportUserName,
      reportUserImageUrl: reportUserImageUrl ?? this.reportUserImageUrl,
      mediaName: mediaName ?? this.mediaName,
      mediaImageUrl: mediaImageUrl ?? this.mediaImageUrl,
      reviewId: reviewId ?? this.reviewId,
      reviewTitle: reviewTitle ?? this.reviewTitle,
      reviewContent: reviewContent ?? this.reviewContent,
      reviewUserId: reviewUserId ?? this.reviewUserId,
      reviewUserName: reviewUserName ?? this.reviewUserName,
      reviewUserImageUrl: reviewUserImageUrl ?? this.reviewUserImageUrl,
      reviewRating: reviewRating ?? this.reviewRating,
    );
  }
}
