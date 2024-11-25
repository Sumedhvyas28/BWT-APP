class MaintenanceVisit {
  final String maintenanceVisit;
  final String type;
  final String reason;
  final String date;
  final String hours;

  MaintenanceVisit({
    required this.maintenanceVisit,
    required this.type,
    required this.reason,
    required this.date,
    required this.hours,
  });

  Map<String, dynamic> toJson() {
    return {
      "maintenance_visit": maintenanceVisit,
      "type": type,
      "reason": reason,
      "date": date,
      "hours": hours,
    };
  }
}
