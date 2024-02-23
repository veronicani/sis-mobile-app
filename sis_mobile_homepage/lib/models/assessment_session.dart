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

  factory AssessmentSession.fromJson(Map<String, dynamic> json){
    String startAt = json["start_at"];
    print('startAt=$startAt');
    DateTime startAtDateTime = DateTime.parse(startAt).toLocal();
    print('startAtDateTime=$startAtDateTime');
    DateTime startAtDateLocal = DateFormat.yyyy-MM-ddTHH:mm:ss.format(startAtDateTime);
    // print('dateLocal=$dateLocal');R
    return AssessmentSession(
      id: json["id"],
      title: json["title"],
      status: json["status"],
      apiUrl: json["api_url"],
      description: json["description"],
      startAt: json["start_at"],
      endAt: json["end_at"]
    );
  }
}

