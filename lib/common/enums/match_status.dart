enum MatchStatus {
  pending,
  accepted,
  ongoing,
  creatorDeclaredWinner,
  opponentDeclaredWinner,
  dispute,
  completed,
  canceled,
  adminDeclaredWinner;

  /// Convert a string to a MatchStatus enum
  /// pending → Waiting for opponent
  /// accepted → Opponent accepted, both bet amounts are on hold
  /// ongoing → Match is ongoing
  /// creatorDeclaredWinner → Creator declared winner
  /// opponentDeclaredWinner → Opponent declared winner
  /// dispute → Dispute raised
  /// completed → Winner confirmed, funds transferred
  /// canceled → Match canceled by both sides
  /// adminDeclaredWinner → Admin resolved the dispute
  static MatchStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return MatchStatus.pending;
      case 'accepted':
        return MatchStatus.accepted;
      case 'ongoing':
        return MatchStatus.ongoing;
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
      case MatchStatus.ongoing:
        return 'ongoing';
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

  String toDisplay() {
    switch (this) {
      case MatchStatus.pending:
        return 'Waiting for opponent';
      case MatchStatus.accepted:
        return 'Opponent accepted, both bet amounts on hold';
      case MatchStatus.ongoing:
        return 'Match is ongoing';
      case MatchStatus.creatorDeclaredWinner:
        return 'Creator declared winner';
      case MatchStatus.opponentDeclaredWinner:
        return 'Opponent declared winner';
      case MatchStatus.dispute:
        return 'Dispute raised';
      case MatchStatus.completed:
        return 'Winner confirmed, funds transferred';
      case MatchStatus.canceled:
        return 'Canceled';
      case MatchStatus.adminDeclaredWinner:
        return 'Admin resolved the dispute';
    }
  }
}
