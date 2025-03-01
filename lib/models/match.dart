import 'package:kaze_app/common/enums/match_status.dart';

class Match {
  final String? id;
  final String creatorId;
  final String? opponentId;
  final String? winnerId;
  final String matchTitle;
  final String matchDescription;
  final DateTime? schedule;
  final double creatorBetAmount;
  final double totalCreatorBetAmount;
  final double opponentBetAmount;
  final double totalOpponentBetAmount;
  final MatchStatus status;
  final String? inviteCode;
  final DateTime? creatorUpdatedAt;
  final DateTime? opponentUpdatedAt;
  final DateTime? adminUpdatedAt;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final bool creatorCancelRequested;
  final bool opponentCancelRequested;

  Match({
    this.id,
    required this.creatorId,
    this.opponentId,
    this.winnerId,
    required this.matchTitle,
    required this.matchDescription,
    this.schedule,
    required this.creatorBetAmount,
    required this.totalCreatorBetAmount,
    required this.opponentBetAmount,
    required this.totalOpponentBetAmount,
    this.status = MatchStatus.pending,
    this.inviteCode,
    this.creatorUpdatedAt,
    this.opponentUpdatedAt,
    this.adminUpdatedAt,
    DateTime? createdAt,
    this.deletedAt,
    this.creatorCancelRequested = false,
    this.opponentCancelRequested = false,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'] as String?,
      creatorId: json['creator_id'] as String,
      opponentId: json['opponent_id'] as String?,
      winnerId: json['winner_id'] as String?,
      matchTitle: json['match_title'] as String,
      matchDescription: json['match_description'] as String,
      schedule:
          json['schedule'] != null ? DateTime.parse(json['schedule']) : null,
      creatorBetAmount: (json['creator_bet_amount'] as num).toDouble(),
      totalCreatorBetAmount:
          (json['total_creator_bet_amount'] as num).toDouble(),
      opponentBetAmount: (json['opponent_bet_amount'] as num).toDouble(),
      totalOpponentBetAmount:
          (json['total_opponent_bet_amount'] as num).toDouble(),
      status: MatchStatus.fromString(json['status'] as String? ?? 'pending'),
      inviteCode: json['invite_code'] as String?,
      creatorUpdatedAt:
          json['creator_updated_at'] != null
              ? DateTime.parse(json['creator_updated_at'])
              : null,
      opponentUpdatedAt:
          json['opponent_updated_at'] != null
              ? DateTime.parse(json['opponent_updated_at'])
              : null,
      adminUpdatedAt:
          json['admin_updated_at'] != null
              ? DateTime.parse(json['admin_updated_at'])
              : null,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : DateTime.now(),
      deletedAt:
          json['deleted_at'] != null
              ? DateTime.parse(json['deleted_at'])
              : null,
      creatorCancelRequested:
          json['creator_cancel_requested'] as bool? ?? false,
      opponentCancelRequested:
          json['opponent_cancel_requested'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson({bool forInsert = false}) {
    final data = {
      if (!forInsert && id != null) 'id': id,
      'creator_id': creatorId,
      'opponent_id': opponentId,
      'winner_id': winnerId,
      'match_title': matchTitle,
      'match_description': matchDescription,
      'schedule': schedule?.toIso8601String(),
      'creator_bet_amount': creatorBetAmount,
      'total_creator_bet_amount': totalCreatorBetAmount,
      'opponent_bet_amount': opponentBetAmount,
      'total_opponent_bet_amount': totalOpponentBetAmount,
      'status': status.toValue(),
      'invite_code': inviteCode,
      'creator_updated_at': creatorUpdatedAt?.toIso8601String(),
      'opponent_updated_at': opponentUpdatedAt?.toIso8601String(),
      'admin_updated_at': adminUpdatedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'creator_cancel_requested': creatorCancelRequested,
      'opponent_cancel_requested': opponentCancelRequested,
    };

    return data;
  }
}
