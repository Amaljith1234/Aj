import 'package:flutter/material.dart';

class UserWholesaler {
  // final String? wholesalerUserId;
  // final String? wholesalerId;
  // final String? userId;
  // final String? wholesalerUserType;
  // final String? createdAt;
  // final String? updatedAt;
  // final String? id;
  final String? name;
  final String? email;
  final String? contactNo;
  // final String? emailVerifiedAt;
  final String? password;
  // final String? image;
  // final String? userType;
  // final String? status;
  // final String? rememberToken;
  // final String? start_time;
  // final String? end_time;
  // final String? salary;

  bool isChecked=  false;

  UserWholesaler({
    // this.wholesalerUserId,
    // this.wholesalerId,
    // this.userId,
    // this.wholesalerUserType,
    // this.createdAt,
    // this.updatedAt,
    // this.id,
    this.name,
    this.email,
    this.contactNo,
    // this.emailVerifiedAt,
    this.password,
    // this.image,
    // this.userType,
    // this.status,
    // this.rememberToken,
    // this.start_time,
    // this.end_time,
    // this.salary,
  });

  factory UserWholesaler.fromJson(Map<String, dynamic> json) {
    debugPrint(json['name'] + json['salary']!.toString());
    return UserWholesaler(
      // wholesalerUserId: json['wholesaler_user_id']?.toString(),
      // wholesalerId: json['wholesaler_id']?.toString(),
      // userId: json['user_id']?.toString(),
      // wholesalerUserType: json['wholesaler_user_type']?.toString(),
      // createdAt: json['created_at']?.toString(),
      // updatedAt: json['updated_at']?.toString(),
      // id: json['id']?.toString(),
      name: json['name']??"",
      email: json['email']??"",
      contactNo: json['contact_no']??"",
      // emailVerifiedAt: json['email_verified_at']?.toString(),
      password: json['password']?.toString(),
      // image: json['image']?.toString(),
      // userType: json['user_type']?.toString(),
      // status: json['status']?.toString(),
      // rememberToken: json['remember_token']?.toString(),
      // start_time: json['start_time']?.toString(),
      // end_time: json['end_time']?.toString(),
      // salary: json['salary']?.toString(),
    );
  }

  Map<String, String?> toJson() {
    return {
      // 'wholesaler_user_id': wholesalerUserId,
      // 'wholesaler_id': wholesalerId,
      // 'user_id': userId,
      // 'wholesaler_user_type': wholesalerUserType,
      // 'created_at': createdAt,
      // 'updated_at': updatedAt,
      // 'id': id,
      'name': name,
      'email': email,
      'contact_no': contactNo,
      // 'email_verified_at': emailVerifiedAt,
      'password': password,
      // 'image': image,
      // 'user_type': userType,
      // 'status': status,
      // 'remember_token': rememberToken,
      // 'start_time': start_time,
      // 'end_time': end_time,
      // 'salary': salary,
    };
  }
}
