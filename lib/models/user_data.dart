
class UserData {
  final String uid;
  final String phone;

  UserData({required this.uid, required this.phone});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'uid': uid});
    result.addAll({'phone': phone});
  
    return result;
  }

  factory UserData.fromMap(Map<String, dynamic> map, String documentId) {
    return UserData(
      uid: documentId,
      phone: map['phone'] ?? '',
    );
  }
}
