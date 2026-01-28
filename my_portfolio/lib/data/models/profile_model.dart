class ProfileModel {
  final int? id;
  final String name;
  final String headline;
  final String location;
  final String about;
  final String? profileImagePath; // ✅ Store image path
  final String email; // ✅ Added
  final String phone; // ✅ Added
  final String linkedIn; // ✅ Added
  final int isOpenToWork; // ✅ Added (0 for false, 1 for true)
  final int showLanguages, showVolunteer, showAwards;

  ProfileModel({
    this.id,
    required this.name,
    required this.headline,
    required this.location,
    required this.about,
    this.profileImagePath,
    this.email = "example@gmail.com",
    this.phone = "+91 0000000000",
    this.linkedIn = "linkedin.com/in/user",
    this.isOpenToWork = 1,
    this.showLanguages = 0,
    this.showVolunteer = 0,
    this.showAwards = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'headline': headline,
      'location': location,
      'about': about,
      'profileImagePath': profileImagePath,
      'email': email,
      'phone': phone,
      'linkedIn': linkedIn,
      'isOpenToWork': isOpenToWork,
      'showLanguages': showLanguages,
      'showVolunteer': showVolunteer,
      'showAwards': showAwards,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'],
      name: map['name'] ?? '',
      headline: map['headline'] ?? '',
      location: map['location'] ?? '',
      about: map['about'] ?? '',
      profileImagePath: map['profileImagePath'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      linkedIn: map['linkedIn'] ?? '',
      isOpenToWork: map['isOpenToWork'] ?? 1,
      showLanguages: map['showLanguages'] ?? 0,
      showVolunteer: map['showVolunteer'] ?? 0,
      showAwards: map['showAwards'] ?? 0,
    );
  }
}
