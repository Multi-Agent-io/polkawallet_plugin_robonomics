class DatalogItem {
  DatalogItem(this.timestamp, this.jsonData);

  final int timestamp;
  final String jsonData;

  factory DatalogItem.fromJson(dynamic data) {
    final timestamp = int.parse(data[0]);
    final jsonData = data[1] as String;
    return DatalogItem(timestamp, jsonData);
  }
}
