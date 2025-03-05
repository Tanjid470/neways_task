class AttendanceDataModel {
  final String color;
  final String date;
  final String status;


  AttendanceDataModel({
    required this.color,
    required this.date,
    required this.status,
  });

  factory AttendanceDataModel.fromMap(Map<String, dynamic> data) {
    return AttendanceDataModel(
      color: data['color'] ?? '',
      date: data['date'] ?? '',
      status: data['status'] ?? '',
    );
  }
}
