enum InviteStatus {
  open,
  pending,
  accepted,
  declined;

  /// Convert a string to an InviteStatus enum
  static InviteStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return InviteStatus.open;
      case 'pending':
        return InviteStatus.pending;
      case 'accepted':
        return InviteStatus.accepted;
      case 'declined':
        return InviteStatus.declined;
      default:
        throw ArgumentError('Invalid invite status: $status');
    }
  }

  /// Convert an InviteStatus enum to a string
  String toValue() {
    switch (this) {
      case InviteStatus.open:
        return 'open';
      case InviteStatus.pending:
        return 'pending';
      case InviteStatus.accepted:
        return 'accepted';
      case InviteStatus.declined:
        return 'declined';
    }
  }

  /// Human-readable string (optional, if you need display labels)
  String toDisplay() {
    switch (this) {
      case InviteStatus.open:
        return 'Open';
      case InviteStatus.pending:
        return 'Pending';
      case InviteStatus.accepted:
        return 'Accepted';
      case InviteStatus.declined:
        return 'Declined';
    }
  }
}
