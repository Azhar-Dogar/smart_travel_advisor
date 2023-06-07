class UserModel {
  UserModel(
      {required this.email,
      required this.uid,
      required this.profilePic,
      required this.userName,
      required this.dob});
  String userName;
  String uid;
  String email;
  String profilePic;
  int dob;
  static UserModel fromMap(Map<String,dynamic>data)=>UserModel(
      email: data["email"],
      uid: data["uid"],
      profilePic: data["profilePic"],
      dob: data["dob"],
      userName: data["userName"]);
  toMap()=>{
    "email":email,
    "uid":uid,
    "profilePic":profilePic,
    "userName":userName,
    "dob":dob
  };
}
