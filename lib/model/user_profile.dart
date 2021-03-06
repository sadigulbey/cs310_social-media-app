

class UserProfile
{
  late String username;
  late String fullName;
  late String profilepicture;
  late String userId;
  late String biography;
  late bool isPrivate;
  late List<dynamic> followers;
  late List<dynamic> following;
  late List<dynamic> requests;
  late List<dynamic> notifications;
  late List<dynamic> bookmarks;
  late bool isThereNewNotif;
  late bool isDisabled;
  late int postCount;


  List<dynamic> posts;

  UserProfile({
    required this.username,
    required this.fullName,
    required this.profilepicture,
    required this.userId,
    required this.biography,
    required this.followers,
    required this.following,
    required this.posts,
    required this.isPrivate,
    required this.requests,
    required this.notifications,
    required this.isThereNewNotif,
    required this.isDisabled,
    required this.postCount,
    required this.bookmarks
  });

  factory UserProfile.fromMap(Map data){
    return UserProfile(
        username: data['username'],
        fullName: data['fullName'],
        profilepicture: data['profilepicture'],
        userId: data['userId'],
        biography: data['biography'],
        isPrivate: data['isPrivate'],
        followers: data['followers'],
        following: data['following'],
        posts:  data["posts"],
        requests: data["requests"],
        notifications:  data["notifications"] ?? <dynamic>[],
        isThereNewNotif: data["isThereNewNotif"] ?? false,
        isDisabled: data["isDisabled"],
        postCount: data["postCount"] ?? 0,
        bookmarks: data["bookmarks"] ?? <dynamic>[]
    );
  }
}