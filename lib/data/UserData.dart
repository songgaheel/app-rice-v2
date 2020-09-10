class User {
  final String phonenumber;
  final String password;

  const User({
    this.phonenumber,
    this.password,
  });
}

const User users = User(
  phonenumber: '0987654321',
  password: '123456',
);
