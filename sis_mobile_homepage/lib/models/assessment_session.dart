import 'package:date_time_format/date_time_format.dart';

/// AssessmentSession: {id, title, status, apiUrl}
class AssessmentSession {
  final int id;
  final String title;
  final String status;
  final String apiUrl;
  final String description;
  final String startAt;
  final String endAt;

  const AssessmentSession(
    {
      required this.id,
      required this.title,
      required this.status,
      required this.apiUrl,
      required this.description,
      required this.startAt,
      required this.endAt
    });

  /// Creates an instant of assessment session from JSON data.
  factory AssessmentSession.fromJson(Map<String, dynamic> json){
    /// convertUtcToLocal: Converts a string in UTC time to USA local time.
    ///   E.g. 2024-02-06T17:00:04.287983-08:00 -> Tues, Feb 6, 8:00
    String convertUtcToLocal(String utcString){
      DateTime convertToDateTime = DateTime.parse(utcString);
      return convertToDateTime.format('D, M j, H:i');
    }

    return AssessmentSession(
      id: json["id"],
      title: json["title"],
      status: json["status"],
      apiUrl: json["api_url"],
      description: json["description"],
      startAt: convertUtcToLocal(json["start_at"]),
      endAt: convertUtcToLocal(json["end_at"])
    );
  }
}

