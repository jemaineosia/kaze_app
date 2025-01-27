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
      creatorId: json['creator_id'], // Updated to snake_case
      opponentId: json['opponent_id'], // Updated to snake_case
      winnerId: json['winner_id'], // Updated to snake_case
      matchTitle: json['match_title'], // Updated to snake_case
      matchDescription: json['match_description'], // Updated to snake_case
      schedule:
          json['schedule'] != null ? DateTime.parse(json['schedule']) : null,
      creatorBetAmount:
          (json['creator_bet_amount'] as num).toDouble(), // Updated
      totalCreatorBetAmount:
          (json['total_creator_bet_amount'] as num).toDouble(), // Updated
      opponentBetAmount:
          (json['opponent_bet_amount'] as num).toDouble(), // Updated
      totalOpponentBetAmount:
          (json['total_opponent_bet_amount'] as num).toDouble(), // Updated
      status: MatchStatus.fromString(json['status'] ?? 'pending'),
      creatorUpdatedAt: json['creator_updated_at'] != null // Updated
          ? DateTime.parse(json['creator_updated_at'])
          : null,
      opponentUpdatedAt: json['opponent_updated_at'] != null // Updated
          ? DateTime.parse(json['opponent_updated_at'])
          : null,
      adminUpdatedAt: json['admin_updated_at'] != null // Updated
          ? DateTime.parse(json['admin_updated_at'])
          : null,
      createdAt: json['created_at'] != null // Updated
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      deletedAt: json['deleted_at'] != null // Updated
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator_id': creatorId, // Updated to snake_case
      'opponent_id': opponentId, // Updated to snake_case
      'winner_id': winnerId, // Updated to snake_case
      'match_title': matchTitle, // Updated to snake_case
      'match_description': matchDescription, // Updated to snake_case
      'schedule': schedule?.toIso8601String(),
      'creator_bet_amount': creatorBetAmount, // Updated to snake_case
      'total_creator_bet_amount':
          totalCreatorBetAmount, // Updated to snake_case
      'opponent_bet_amount': opponentBetAmount, // Updated to snake_case
      'total_opponent_bet_amount':
          totalOpponentBetAmount, // Updated to snake_case
      'status': status.toValue(),
      'creator_updated_at': creatorUpdatedAt?.toIso8601String(), // Updated
      'opponent_updated_at': opponentUpdatedAt?.toIso8601String(), // Updated
      'admin_updated_at': adminUpdatedAt?.toIso8601String(), // Updated
      'created_at': createdAt.toIso8601String(), // Updated to snake_case
      'deleted_at': deletedAt?.toIso8601String(), // Updated to snake_case
    };
  }
}
