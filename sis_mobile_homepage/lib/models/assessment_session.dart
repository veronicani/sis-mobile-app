/// AssessmentSession: {id, title, status, apiUrl}

class AssessmentSession {
  final int id;
  final String title;
  final String status;
  final String apiUrl;

  const AssessmentSession(
    {
      required this.id,
      required this.title,
      required this.status,
      required this.apiUrl
    });

  factory AssessmentSession.fromJson(Map<String, dynamic> json){
    return AssessmentSession(
      id: json["id"],
      title: json["title"],
      status: json["status"],
      apiUrl: json["api_url"],
    );
  }
}