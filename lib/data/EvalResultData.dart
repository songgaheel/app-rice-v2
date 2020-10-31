class EvalResult {
  final String varieties;
  final Cost cost;
  final Product product;
  final Price price;
  final Profit profit;
  final List<TimelineResult> tl;

  EvalResult(this.varieties, this.cost, this.product, this.price, this.profit,
      [this.tl]);

  factory EvalResult.fromJson(dynamic json) {
    if (json['tl'] != null) {
      var tagObjsJson = json['tl'] as List;
      List<TimelineResult> _tl = tagObjsJson
          .map((tagJson) => TimelineResult.fromJson(tagJson))
          .toList();

      return EvalResult(
        json['varieties'] as String,
        Cost.fromJson(json['cost']),
        Product.fromJson(json['product']),
        Price.fromJson(json['price']),
        Profit.fromJson(json['profit']),
        _tl,
      );
    } else {
      return EvalResult(
        json['varieties'] as String,
        Cost.fromJson(json['cost']),
        Product.fromJson(json['product']),
        Price.fromJson(json['price']),
        Profit.fromJson(json['profit']),
      );
    }
  }
}

class TimelineResult {
  String activitiesDate;
  List<Activities> activities;

  TimelineResult(this.activitiesDate, [this.activities]);

  factory TimelineResult.fromJson(dynamic json) {
    if (json['activities'] != null) {
      var tagObjsJson = json['activities'] as List;
      List<Activities> _activities =
          tagObjsJson.map((tagJson) => Activities.fromJson(tagJson)).toList();

      return TimelineResult(
        json['activitiesDate'] as String,
        _activities,
      );
    } else {
      return TimelineResult(
        json['activitiesDate'] as String,
      );
    }
  }

  @override
  String toString() {
    return '{ ${this.activitiesDate}, ${this.activities} }';
  }
}

class Activities {
  int code;
  bool active;

  Activities(this.code, this.active);

  factory Activities.fromJson(dynamic json) {
    return Activities(json['code'] as int, json['active'] as bool);
  }

  @override
  String toString() {
    return '{ ${this.code}, ${this.active} }';
  }
}

class Bugs {
  int code;
  bool active;
  bool found;

  Bugs(this.code, this.active, this.found);

  factory Bugs.fromJson(dynamic json) {
    return Bugs(
      json['code'] as int,
      json['active'] as bool,
      json['found'] as bool,
    );
  }

  @override
  String toString() {
    return '{ ${this.code}, ${this.active}, ${this.found} }';
  }
}

class Cost {
  int value;
  String status;

  Cost(this.value, this.status);

  factory Cost.fromJson(dynamic json) {
    return Cost(json['value'] as int, json['status'] as String);
  }

  @override
  String toString() {
    return '{ ${this.value}, ${this.status} }';
  }
}

class Product {
  int value;
  String status;

  Product(this.value, this.status);

  factory Product.fromJson(dynamic json) {
    return Product(json['value'] as int, json['status'] as String);
  }

  @override
  String toString() {
    return '{ ${this.value}, ${this.status} }';
  }
}

class Price {
  int value;
  String status;

  Price(this.value, this.status);

  factory Price.fromJson(dynamic json) {
    return Price(json['value'] as int, json['status'] as String);
  }

  @override
  String toString() {
    return '{ ${this.value}, ${this.status} }';
  }
}

class Profit {
  int value;
  String status;

  Profit(this.value, this.status);

  factory Profit.fromJson(dynamic json) {
    return Profit(json['value'] as int, json['status'] as String);
  }

  @override
  String toString() {
    return '{ ${this.value}, ${this.status} }';
  }
}

/*class TimelineResult {
  final String date;
  final List<Activities> activities;

  TimelineResult(
    this.date,
    [this.activities]
  );

  factory TimelineResult.fromJson(dynamic json) {
    if (json['activities'] != null) {
      var tagObjsJson = json['activities'] as List;
      List<Activities> _activities = tagObjsJson.map((tagJson) => Activities.fromJson(tagJson)).toList();
      return TimelineResult(
        json['date'] as String,
        _activities
      );
    } else {
      return TimelineResult(
        json['date'] as String,
      );
    }
  }
}

class Activities {
  final String code;
  final bool active;

  Activities({
    this.code,
    this.active,
  });

  factory Activities.fromJson(Map<String, dynamic> json) {
    return Activities(
      code: json["code"] as String,
      active: json["active"] as bool,
    );
  }
}*/
