class ReviewModel {
  final String username;
  final String profilePic;
  final String userInfo;
  final String comment;
  final String commentDate;
  final int stars;

  ReviewModel({
    required this.username,
    required this.profilePic,
    required this.userInfo,
    required this.comment,
    required this.commentDate,
    required this.stars,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      username: json['username'] ?? '',
      profilePic: json['profile_pic'] ?? '',
      userInfo: json['user_info'] ?? '',
      comment: json['comment'] ?? '',
      commentDate: json['comment_date'] ?? '',
      stars: json['stars'] ?? 5,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'profile_pic': profilePic,
      'user_info': userInfo,
      'comment': comment,
      'comment_date': commentDate,
      'stars': stars,
    };
  }
}
