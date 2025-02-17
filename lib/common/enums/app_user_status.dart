enum AppUserStatus {
  active,
  suspended;

  /// Convert a string to an AppUserStatus enum
  static AppUserStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppUserStatus.active;
      case 'suspended':
        return AppUserStatus.suspended;
      default:
        throw ArgumentError('Invalid status value: $status');
    }
  }

  /// Convert an AppUserStatus enum to a string
  String toValue() {
    switch (this) {
      case AppUserStatus.active:
        return 'active';
      case AppUserStatus.suspended:
        return 'suspended';
    }
  }
}
