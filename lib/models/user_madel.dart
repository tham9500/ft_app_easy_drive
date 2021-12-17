class User_model {
  // String? userId;
  // String? email;
  // String? password;
  // String? firstName;
  // String? lastName;
  // String? role;
  // String? statusUser;
  // String? createDate;
  // String? editDate;
  // String? activateDate;
  // String? lastDate;
  // String? lastMenu;
  String userId = "";
  String email = "";
  String password = "";
  String firstName = "";
  String lastName = "";
  String role = "";
  String statusUser = "";
  String createDate = "";
  String editDate = "";
  String activateDate = "";
  String lastDate = "";
  String lastMenu = "";

  User_model(
      {required this.userId,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.role,
      required this.statusUser,
      required this.createDate,
      required this.editDate,
      required this.activateDate,
      required this.lastDate,
      required this.lastMenu});

  User_model.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    role = json['role'];
    //statusUser = json['status_user'];
    createDate = json['create_date'];
    //editDate = json['edit_date'];
    //activateDate = json['activate_date'];
    lastDate = json['last_date'];
    //lastMenu = json['last_menu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['role'] = this.role;
    data['status_user'] = this.statusUser;
    data['create_date'] = this.createDate;
    data['edit_date'] = this.editDate;
    data['activate_date'] = this.activateDate;
    data['last_date'] = this.lastDate;
    data['last_menu'] = this.lastMenu;
    return data;
  }
}
