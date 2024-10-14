class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? contactNo;
  String? emailVerifiedAt;
  String? image;
  String? userType;
  String? status;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
        this.name,
        this.email,
        this.contactNo,
        this.emailVerifiedAt,
        this.image,
        this.userType,
        this.status,
        this.createdAt,
        this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name']??"";
    email = json['email']??"";
    contactNo = json['contact_no']??"";
    emailVerifiedAt = json['email_verified_at'].toString()??"";
    image = json['image'];
    userType = json['user_type'].toString()??"";
    status = json['status']??"";
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
    password = json['password']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['image'] = this.image;
    data['user_type'] = this.userType;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['password'] = this.password;
    return data;
  }
}