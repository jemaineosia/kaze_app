enum MatchStatus {
  pending,
  accepted,
  creatorDeclaredWinner,
  opponentDeclaredWinner,
  dispute,
  completed,
  canceled,
  adminDeclaredWinner;

  /// Convert a string to a MatchStatus enum
  static MatchStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return MatchStatus.pending;
      case 'accepted':
        return MatchStatus.accepted;
      case 'creator_declared_winner':
        return MatchStatus.creatorDeclaredWinner;
      case 'opponent_declared_winner':
        return MatchStatus.opponentDeclaredWinner;
      case 'dispute':
        return MatchStatus.dispute;
      case 'completed':
        return MatchStatus.completed;
      case 'canceled':
        return MatchStatus.canceled;
      case 'admin_declared_winner':
        return MatchStatus.adminDeclaredWinner;
      default:
        throw ArgumentError('Invalid match status: $status');
    }
  }

  /// Convert a MatchStatus enum to a string
  String toValue() {
    switch (this) {
      case MatchStatus.pending:
        return 'pending';
      case MatchStatus.accepted:
        return 'accepted';
      case MatchStatus.creatorDeclaredWinner:
        return 'creator_declared_winner';
      case MatchStatus.opponentDeclaredWinner:
        return 'opponent_declared_winner';
      case MatchStatus.dispute:
        return 'dispute';
      case MatchStatus.completed:
        return 'completed';
      case MatchStatus.canceled:
        return 'canceled';
      case MatchStatus.adminDeclaredWinner:
        return 'admin_declared_winner';
    }
  }
}
