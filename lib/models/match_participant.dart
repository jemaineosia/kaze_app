class MatchParticipant {
  final String id;
  final String matchId;
  final String userId;
  final String team;
  final double contributionAmount;
  final DateTime createdAt;
  final DateTime? deletedAt;

  MatchParticipant({
    required this.id,
    required this.matchId,
    required this.userId,
    required this.team,
    required this.contributionAmount,
    required this.createdAt,
    this.deletedAt,
  });

  factory MatchParticipant.fromJson(Map<String, dynamic> json) {
    return MatchParticipant(
      id: json['id'],
      matchId: json['match_id'], // Updated to snake_case
      userId: json['user_id'], // Updated to snake_case
      team: json['team'],
      contributionAmount:
          (json['contribution_amount'] as num)
              .toDouble(), // Updated to snake_case
      createdAt: DateTime.parse(json['created_at']), // Updated to snake_case
      deletedAt:
          json['deleted_at'] !=
                  null // Updated to snake_case
              ? DateTime.parse(json['deleted_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'match_id': matchId, // Updated to snake_case
      'user_id': userId, // Updated to snake_case
      'team': team,
      'contribution_amount': contributionAmount, // Updated to snake_case
      'created_at': createdAt.toIso8601String(), // Updated to snake_case
      'deleted_at': deletedAt?.toIso8601String(), // Updated to snake_case
    };
  }
}
