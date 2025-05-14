class UserProfile {
  final String name;
  final int age;
  final String bio;
  final String profileImage;
  final int minutesUsed;
  final List<String> galleryImages;

  UserProfile({
    required this.name,
    required this.age,
    required this.bio,
    required this.profileImage,
    required this.minutesUsed,
    required this.galleryImages,
  });
}
