enum MatchType {
  openMatch,
  inviteOpponent;

  String toValue() {
    switch (this) {
      case MatchType.openMatch:
        return 'Open Match';
      case MatchType.inviteOpponent:
        return 'Invite Opponent';
    }
  }

  static MatchType fromValue(String value) {
    switch (value) {
      case 'Open Match':
        return MatchType.openMatch;
      case 'Invite Opponent':
        return MatchType.inviteOpponent;
      default:
        throw ArgumentError('Invalid match type: $value');
    }
  }
}
