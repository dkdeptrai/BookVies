import 'dart:async';

import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/screens/profile_screen/widgets/user_description_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  Future<UserModel> _fetchUserData(String id) async {
    var user = await usersRef.doc(id).get();
    return UserModel.fromMap(user.data()! as Map<String, dynamic>);
  }

  Future<List<Review>> _fetchUserReviews() async {
    var reviews =
        await reviewsRef.where('userId', isEqualTo: widget.userId).get();
    List<Review> userReviews = [];
    for (var review in reviews.docs) {
      userReviews.add(Review.fromMap(review.data()! as Map<String, dynamic>));
    }
    setState(() {
      _reviewNum = userReviews.length;
    });
    return userReviews;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: _fetchUserData(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var user = snapshot.data as UserModel;
              return Scaffold(
                key: _scaffoldKey,
                endDrawerEnableOpenDragGesture: false,
                endDrawer: Stack(
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
                                  leading: SvgPicture.asset(AppAssets.icKey),
                                  title: const Text("Change Password"),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: SvgPicture.asset(AppAssets.icImage),
                                  title: const Text("Change Profile Picture"),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: SvgPicture.asset(
                                      AppAssets.icGradientUser),
                                  title: const Text("Edit Profile"),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: SvgPicture.asset(AppAssets.icLogout),
                                  title: const Text("Log Out"),
                                  onTap: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(const AuthEventLogOut());
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                    Positioned(
                      top: 20,
                      right: 20,
                      child: IconButton(
                        icon: SvgPicture.asset(
                          AppAssets.icHamburgerMenu,
                        ),
                        onPressed: () =>
                            _scaffoldKey.currentState?.openEndDrawer(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 91),
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                                  CircleAvatar(
                                                    radius: 40,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            followingUser!
                                                                .imageUrl),
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

  // Future<void> _updateStatusForDocuments() async {
  //   // Reference to the Firestore collection
  //   CollectionReference collectionRef =
  //       FirebaseFirestore.instance.collection('books');

  //   // Set the maximum number of documents to process at once
  //   int batchSize =
  //       500; // Reduced to 500, since Firestore has a limit of 500 operations per batch

  //   // Get the first batch of documents
  //   QuerySnapshot querySnapshot = await collectionRef.limit(batchSize).get();

  //   // Continue processing documents until all are updated
  //   while (querySnapshot.docs.isNotEmpty) {
  //     // Create a write batch
  //     WriteBatch batch = FirebaseFirestore.instance.batch();

  //     // Iterate through each document and update the status field
  //     for (QueryDocumentSnapshot doc in querySnapshot.docs) {
  //       var currentString = (doc.data() as Map<String, dynamic>)['genres'];
  //       var array =
  //           (currentString).replaceAll(RegExp(r"[\[\]']"), "").split(", ");
  //       // Update the document in the batch
  //       batch.update(collectionRef.doc(doc.id), {
  //         'genres': array,
  //         'averageRating': 0.0,
  //         'numberOfReviews': 0,
  //       });
  //     }

  //     // Commit the batch
  //     await batch.commit();

  //     // Get the next batch of documents, starting after the last document in the current batch
  //     querySnapshot = await collectionRef
  //         .startAfterDocument(querySnapshot.docs.last)
  //         .limit(batchSize)
  //         .get();
  //   }
  // }
}
