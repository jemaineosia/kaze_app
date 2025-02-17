enum MatchStatus {
  pending,
  ongoing,
  completed,
  canceled;

  /// Convert a string to a MatchStatus enum
  static MatchStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return MatchStatus.pending;
      case 'ongoing':
        return MatchStatus.ongoing;
      case 'completed':
        return MatchStatus.completed;
      case 'canceled':
        return MatchStatus.canceled;
      default:
        throw ArgumentError('Invalid match status: $status');
    }
  }

  /// Convert a MatchStatus enum to a string
  String toValue() {
    switch (this) {
      case MatchStatus.pending:
        return 'pending';
      case MatchStatus.ongoing:
        return 'ongoing';
      case MatchStatus.completed:
        return 'completed';
      case MatchStatus.canceled:
        return 'canceled';
    }
  }
}

// void main() {
//   // Convert string to enum
//   String statusString = 'ongoing';
//   MatchStatus status = MatchStatus.fromString(statusString);
//   print(status); // Output: MatchStatus.ongoing

//   // Convert enum to string
//   String statusAsString = status.toValue();
//   print(statusAsString); // Output: ongoing

//   // Handle invalid input
//   try {
//     MatchStatus invalidStatus = MatchStatus.fromString('paused');
//   } catch (e) {
//     print(e); // Output: Invalid match status: paused
//   }
// }
