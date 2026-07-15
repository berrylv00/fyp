/// The three account roles in AZHly.
enum AzhlyRole { teacher, crGr, student }

extension AzhlyRoleX on AzhlyRole {
  String get label {
    switch (this) {
      case AzhlyRole.teacher:
        return 'Teacher';
      case AzhlyRole.crGr:
        return 'CR / GR';
      case AzhlyRole.student:
        return 'Student';
    }
  }

  String get description {
    switch (this) {
      case AzhlyRole.teacher:
        return 'View your schedule and find rooms for makeup classes';
      case AzhlyRole.crGr:
        return 'Find rooms and manage room requests from your class';
      case AzhlyRole.student:
        return 'View your timetable and suggest rooms via your CR/GR';
    }
  }
}
