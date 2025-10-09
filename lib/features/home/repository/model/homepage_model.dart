class HomePageModel {
  final int status;
  final String error;
  final String info;
  final List<HomePageData> data;

  HomePageModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    // Safely extract and flatten Data only if it exists
    final dataList = json['Data'];
    final List<HomePageData> flattenedData = [];

    if (dataList is List) {
      for (var innerList in dataList) {
        if (innerList is List) {
          for (var item in innerList) {
            flattenedData.add(HomePageData.fromJson(item));
          }
        }
      }
    }

    return HomePageModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      data: flattenedData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Error': error,
      'Info': info,
      'Data': [data.map((item) => item.toJson()).toList()],
    };
  }
}

class HomePageData {
  final String name;

  HomePageData({required this.name});

  factory HomePageData.fromJson(Map<String, dynamic> json) {
    return HomePageData(
      name: json['Name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
    };
  }
}
