import 'package:kaze_app/common/enums/match_status.dart';

class Match {
  final String id;
  final String creatorId;
  final String opponentId;
  final String? winnerId;
  final String matchTitle;
  final String matchDescription;
  final DateTime? schedule;
  final double creatorBetAmount;
  final double totalCreatorBetAmount;
  final double opponentBetAmount;
  final double totalOpponentBetAmount;
  final MatchStatus status; // Using the MatchStatus enum
  final DateTime? creatorUpdatedAt;
  final DateTime? opponentUpdatedAt;
  final DateTime? adminUpdatedAt;
  final DateTime createdAt;
  final DateTime? deletedAt;

  Match({
    required this.id,
    required this.creatorId,
    required this.opponentId,
    this.winnerId,
    required this.matchTitle,
    required this.matchDescription,
    this.schedule,
    required this.creatorBetAmount,
    required this.totalCreatorBetAmount,
    required this.opponentBetAmount,
    required this.totalOpponentBetAmount,
    this.status = MatchStatus.pending,
    this.creatorUpdatedAt,
    this.opponentUpdatedAt,
    this.adminUpdatedAt,
    DateTime? createdAt,
    this.deletedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      creatorId: json['creatorId'],
      opponentId: json['opponentId'],
      winnerId: json['winnerId'],
      matchTitle: json['matchTitle'],
      matchDescription: json['matchDescription'],
      schedule:
          json['schedule'] != null ? DateTime.parse(json['schedule']) : null,
      creatorBetAmount: (json['creatorBetAmount'] as num).toDouble(),
      totalCreatorBetAmount: (json['totalCreatorBetAmount'] as num).toDouble(),
      opponentBetAmount: (json['opponentBetAmount'] as num).toDouble(),
      totalOpponentBetAmount:
          (json['totalOpponentBetAmount'] as num).toDouble(),
      status: MatchStatus.fromString(json['status'] ?? 'pending'),
      creatorUpdatedAt: json['creatorUpdatedAt'] != null
          ? DateTime.parse(json['creatorUpdatedAt'])
          : null,
      opponentUpdatedAt: json['opponentUpdatedAt'] != null
          ? DateTime.parse(json['opponentUpdatedAt'])
          : null,
      adminUpdatedAt: json['adminUpdatedAt'] != null
          ? DateTime.parse(json['adminUpdatedAt'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creatorId': creatorId,
      'opponentId': opponentId,
      'winnerId': winnerId,
      'matchTitle': matchTitle,
      'matchDescription': matchDescription,
      'schedule': schedule?.toIso8601String(),
      'creatorBetAmount': creatorBetAmount,
      'totalCreatorBetAmount': totalCreatorBetAmount,
      'opponentBetAmount': opponentBetAmount,
      'totalOpponentBetAmount': totalOpponentBetAmount,
      'status': status.toValue(),
      'creatorUpdatedAt': creatorUpdatedAt?.toIso8601String(),
      'opponentUpdatedAt': opponentUpdatedAt?.toIso8601String(),
      'adminUpdatedAt': adminUpdatedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}
