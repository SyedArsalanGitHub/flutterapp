class NotesModel {
  final int? id;
  final String distance;
  final String time;

  NotesModel({
    this.id,
    required this.distance,
    required this.time,

  });

  NotesModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        distance = res["distance"],
        time = res["time"]



  Map<String, Object?> toMap() {
    return {'id':id,'distance': distance, 'time': time,};
  }
}

