class RegisterModel {
  String email;
  String password;
  String fName;
  String lName;
  String phone;
  String lt;
  String lg;

  RegisterModel(
      {this.email,
      this.password,
      this.fName,
      this.lName,
      this.phone,
      this.lt,
      this.lg});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    lt = json['lt'];
    lg = json['lg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['lt'] = this.lt;
    data['lg'] = this.lg;
    return data;
  }
}
