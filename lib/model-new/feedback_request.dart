class FeedbackRequest {
  String? feedbackText;
  String? personalNumber;

  FeedbackRequest({
    this.feedbackText,
    this.personalNumber,
  });

  FeedbackRequest.fromJson(Map<String, dynamic> json) {
    feedbackText = json['feedback'];
    personalNumber = json['personalNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feedback'] = this.feedbackText;
    data['personalNumber'] = this.personalNumber;
    return data;
  }
}
