class CycleDetail {
  String? price;
  String? type;
  String? description;
  String? name;
  List<String>? image;
  String? color;
  num? speed;
  num? rating;
  bool? bookedStatus;
  String? id;
  String? bookedDate;
  String? returnDate;

  CycleDetail({
    this.price,
    this.type,
    this.description,
    this.name,
    this.image,
    this.color,
    this.speed,
    this.rating,
    this.bookedStatus,
    this.id,
    this.bookedDate,
    this.returnDate,
  });

  factory CycleDetail.fromJson(Map<String, dynamic> json) {
    return CycleDetail(
      price: json['price'],
      type: json['type'],
      description: json['description'],
      name: json['name'],
      image: List.from(json['image'].map((e) => e.toString())),
      color: json['color'],
      speed: json['speed'],
      rating: json['rating'],
      bookedStatus: json['bookedStatus'],
      id: json['id'],
      bookedDate: json['bookedDate'],
      returnDate: json['returnDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'type': type,
      'description': description,
      'name': name,
      'image': image!.toList(),
      'color': color,
      'speed': speed,
      'rating': rating,
      'bookedStatus': bookedStatus,
      'id': id,
      'bookedDate': bookedDate,
      'returnDate': returnDate
    };
  }
}

class CycleModel {
  String? price;
  String? type;
  String? name;
  List<String>? image;
  bool? bookedStatus;
  String? id;

  CycleModel({
    this.price,
    this.type,
    this.name,
    this.image,
    this.bookedStatus,
    this.id,
  });

  factory CycleModel.fromJson(Map<String, dynamic> json) {
    return CycleModel(
      price: json['price'],
      type: json['type'],
      name: json['name'],
      image: List.from(json['image'].map((e) => e.toString())),
      bookedStatus: json['bookedStatus'],
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'image': image!.toList(),
      'type': type,
      'name': name,
      'bookedStatus': bookedStatus,
      'id': id,
    };
  }
}

class AllCycles {
  List<CycleModel>? data;

  AllCycles({this.data});

  factory AllCycles.fromJson(Map<String, dynamic> json) {
    return AllCycles(
        data:
            List.from(json['data'].map((cycle) => CycleModel.fromJson(cycle))));
  }
}
