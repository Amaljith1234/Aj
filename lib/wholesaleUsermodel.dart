
import 'package:eassets/User/usermodel.dart';

class WholesaleUserModel {
  String? wholesalerUserId;
  String? wholesalerId;
  String? userId;
  String? wholesalerUserType;
  String? createdAt;
  String? updatedAt;
  UserModel? users;

  WholesaleUserModel(
      {this.wholesalerUserId,
        this.wholesalerId,
        this.userId,
        this.wholesalerUserType,
        this.createdAt,
        this.updatedAt , this.users});

  WholesaleUserModel.fromJson(Map<String, dynamic> json) {
    wholesalerUserId = json['wholesaler_user_id'].toString();
    wholesalerId = json['wholesaler_id'].toString();
    userId = json['user_id'].toString();
    wholesalerUserType = json['wholesaler_user_type'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    users = json['users'] != null ? UserModel.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wholesaler_user_id'] = this.wholesalerUserId;
    data['wholesaler_id'] = this.wholesalerId;
    data['user_id'] = this.userId;
    data['wholesaler_user_type'] = this.wholesalerUserType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}