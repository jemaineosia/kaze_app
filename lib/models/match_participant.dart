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
      matchId: json['matchId'],
      userId: json['userId'],
      team: json['team'],
      contributionAmount: (json['contributionAmount'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matchId': matchId,
      'userId': userId,
      'team': team,
      'contributionAmount': contributionAmount,
      'createdAt': createdAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}
