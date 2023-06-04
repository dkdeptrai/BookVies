import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:bookvies/screens/favorite_genres_screen/favorite_genres_screen.dart';
import 'package:bookvies/screens/profile_screen/widgets/review_overview_widget.dart';
import 'package:bookvies/screens/profile_screen/widgets/user_description_widget.dart';
import 'package:bookvies/screens/search_user_screen/search_user_screen.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  static const id = '/profile-screen';
  final String userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _reviewNum = 0;
  late Future<UserModel> _userData;
  late Future<List<Review>> _userReviews;

  Future<UserModel> _fetchUserData(String id) async {
    var user = await usersRef.doc(id).get();
    return UserModel.fromMap(user.data()! as Map<String, dynamic>);
  }

  Future<void> _refreshData() async {
    if (mounted) {
      setState(() {
        _userData = _fetchUserData(widget.userId);
        _userReviews = _fetchUserReviews();
      });
    }
  }

  Future<List<Review>> _fetchUserReviews() async {
    var reviews =
        await reviewsRef.where('userId', isEqualTo: widget.userId).get();
    List<Review> userReviews = [];
    for (var review in reviews.docs) {
      userReviews.add(Review.fromMap(review.data()! as Map<String, dynamic>));
    }
    if (mounted) {
      setState(() {
        _reviewNum = userReviews.length;
      });
    }
    return userReviews;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    Uint8List compressedBytes = await FlutterImageCompress.compressWithFile(
            pickedFile.path,
            quality: 75) ??
        Uint8List(0);

    File compressedImageFile =
        File('${(await getTemporaryDirectory()).path}/compressed_image.jpg');
    await compressedImageFile.writeAsBytes(compressedBytes);
    context.read<AuthBloc>().add(AuthEventEditUserAvatar(compressedImageFile));
  }

  @override
  void initState() {
    super.initState();
    _userData = _fetchUserData(widget.userId);
    _userReviews = _fetchUserReviews();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var user = snapshot.data as UserModel;
              return Scaffold(
                key: _scaffoldKey,
                endDrawerEnableOpenDragGesture: false,
                endDrawer: user.id == firebaseAuth.currentUser!.uid
                    ? Stack(
                        children: [
                          Positioned(
                            top: 60,
                            right: 0,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Drawer(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        leading:
                                            SvgPicture.asset(AppAssets.icKey),
                                        title: const Text("Change Password"),
                                        onTap: () {
                                          context.read<AuthBloc>().add(
                                              AuthEventForgotPasswordSent(
                                                  firebaseAuth.currentUser!
                                                      .email as String,
                                                  context));
                                        },
                                      ),
                                      ListTile(
                                        leading:
                                            SvgPicture.asset(AppAssets.icImage),
                                        title: const Text(
                                            "Change Profile Picture"),
                                        onTap: () => _pickImage(),
                                      ),
                                      ListTile(
                                        leading: SvgPicture.asset(
                                            AppAssets.icGradientUser),
                                        title: const Text("Edit Profile"),
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              EditProfileScreen.id,
                                              arguments: user);
                                        },
                                      ),
                                      ListTile(
                                        leading: SvgPicture.asset(
                                            AppAssets.icLogout),
                                        title: const Text("Log Out"),
                                        onTap: () {
                                          context
                                              .read<AuthBloc>()
                                              .add(const AuthEventLogOut());
                                        },
                                      ),
                                      ListTile(
                                        leading: SvgPicture.asset(
                                            AppAssets.icLogout),
                                        title:
                                            const Text("Edit Favorite Genres"),
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              FavoriteGenresScreen.id,
                                              arguments: false);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : null,
                body: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset(
                        AppAssets.imgProfileBackground,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: _refreshData,
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (user.id != firebaseAuth.currentUser!.uid)
                                    IconButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: AppColors.secondaryColor,
                                      ),
                                    ),
                                  if (user.id == firebaseAuth.currentUser!.uid)
                                    const Spacer(),
                                  IconButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(SearchUserScreen.id),
                                    icon: const Icon(Icons.search_rounded,
                                        color: AppColors.secondaryColor),
                                  ),
                                  if (user.id == firebaseAuth.currentUser!.uid)
                                    IconButton(
                                      onPressed: () => _scaffoldKey.currentState
                                          ?.openEndDrawer(),
                                      icon: SvgPicture.asset(
                                        AppAssets.icHamburgerMenu,
                                      ),
                                    ),
                                ],
                              ),
                              Center(
                                child: UserDescriptionWidget(
                                  user: user,
                                ),
                              ),
                              const SizedBox(height: 27),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        _reviewNum.toString(),
                                        style: AppStyles.sectionHeaderText,
                                      ),
                                      const Text('Reviews'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        user.following.length.toString(),
                                        style: AppStyles.sectionHeaderText,
                                      ),
                                      const Text('Following'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        user.followers.length.toString(),
                                        style: AppStyles.sectionHeaderText,
                                      ),
                                      const Text('Followers'),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 20,
                                  bottom: 10,
                                ),
                                child: const Text(
                                  'Following',
                                  style: AppStyles.subHeaderTextStyle,
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: user.following.length,
                                  itemBuilder: (context, index) {
                                    return FutureBuilder(
                                      future: _fetchUserData(
                                          user.following.elementAt(index)),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasData) {
                                            var followingUser = snapshot.data;
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => Navigator.of(
                                                            context)
                                                        .pushNamed(
                                                            ProfileScreen.id,
                                                            arguments:
                                                                followingUser
                                                                    .id),
                                                    child: CircleAvatar(
                                                      radius: 40,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              followingUser!
                                                                  .imageUrl),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  left: 20,
                                  bottom: 10,
                                ),
                                child: const Text(
                                  'Reviews',
                                  style: AppStyles.subHeaderTextStyle,
                                ),
                              ),
                              SizedBox(
                                height: 200,
                                child: FutureBuilder(
                                  future: _userReviews,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _reviewNum,
                                        itemBuilder: (context, index) {
                                          return ReviewOverviewWidget(
                                              review: snapshot.data!
                                                  .elementAt(index));
                                        },
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("User not found"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
