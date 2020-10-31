class User {
  final String uid;
  final String name;
  final String surname;
  final String phonenumber;
  final String password;
  final Address address;

  const User({
    this.uid,
    this.name,
    this.surname,
    this.phonenumber,
    this.password,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json["uid"] as String,
      name: json["name"] as String,
      surname: json["surname"] as String,
      phonenumber: json["phonenumber"] as String,
      password: json["password"] as String,
      address: Address.fromJson(json["address"]),
    );
  }
}

class Address {
  final String parish;
  final String district;
  final String province;
  final String latt; // or Number
  final String long;

  Address({
    this.parish,
    this.district,
    this.province,
    this.latt,
    this.long,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      parish: json["parish"] as String,
      district: json["district"] as String,
      province: json["province"] as String,
      latt: json["latt"] as String,
      long: json["long"] as String,
    );
  } // or Number
}

/*const User users = User(
  phonenumber: '0987654321',
  password: '123456',
);*/
