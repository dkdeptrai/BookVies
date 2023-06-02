import 'package:bookvies/common_widgets/admin_text_field.dart';
import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/common_widgets/loading_manager.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/services/book_service.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class AdminAddBookScreen extends StatefulWidget {
  const AdminAddBookScreen({super.key});

  static const String id = "/admin-add-book-screen";

  @override
  State<AdminAddBookScreen> createState() => _AdminAddBookScreenState();
}

class _AdminAddBookScreenState extends State<AdminAddBookScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController publisherController = TextEditingController();
  final TextEditingController publishDateController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController pagesController = TextEditingController();
  bool isLoading = false;
  DateTime publishDate = DateTime.now();
  List<String> genres = [];

  @override
  void initState() {
    super.initState();
    publishDateController.text =
        DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    publisherController.dispose();
    publishDateController.dispose();
    isbnController.dispose();
    pagesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: AppDimensions.defaultAppBarPreferredSize,
            child: CustomAppBar(
                title: "Add book",
                leading: IconButton(
                  icon: SvgPicture.asset(AppAssets.icArrowLeft),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ))),
        body: SafeArea(
          child: LoadingManager(
            isLoading: isLoading,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      const Text("Name", style: AppStyles.adminHeader),
                      AdminTextField(
                          controller: nameController, hintText: "Name"),
                      const SizedBox(height: 5),
                      const Text("Author", style: AppStyles.adminHeader),
                      AdminTextField(
                          controller: authorController, hintText: "Author"),
                      const SizedBox(height: 5),
                      const Text("Description", style: AppStyles.adminHeader),
                      AdminTextField(
                          controller: descriptionController,
                          hintText: "Description",
                          maxLines: 5),
                      const SizedBox(height: 5),
                      const Text("Image", style: AppStyles.adminHeader),
                      AdminTextField(
                          controller: nameController, hintText: "Image"),
                      const SizedBox(height: 5),
                      const Text("Publisher", style: AppStyles.adminHeader),
                      AdminTextField(
                          controller: publisherController,
                          hintText: "Publisher"),
                      const SizedBox(height: 5),
                      const Text("ISBN", style: AppStyles.adminHeader),
                      AdminTextField(
                          controller: isbnController, hintText: "ISBN"),
                      const SizedBox(height: 5),
                      const Text("First publish date",
                          style: AppStyles.adminHeader),
                      AdminTextField(
                          keyboardType: TextInputType.datetime,
                          suffixIcon: IconButton(
                            icon: SvgPicture.asset(
                              AppAssets.icCalendar,
                              colorFilter: ColorFilter.mode(
                                  AppColors.darkBlueBackground,
                                  BlendMode.srcIn),
                              height: 25,
                              width: 25,
                            ),
                            onPressed: () => _showDatePicker(),
                          ),
                          controller: publishDateController,
                          hintText: "First publish date"),
                      const SizedBox(height: 5),
                      const Text("Genres", style: AppStyles.adminHeader),
                      Wrap(
                        children: [
                          ...List.generate(AppConstants.bookGenres.length,
                              (index) {
                            final String genre = AppConstants.bookGenres[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: ChoiceChip(
                                labelStyle: const TextStyle(
                                    color: AppColors.primaryTextColor),
                                label: Text(genre),
                                selectedColor: AppColors.lightBlueBackground,
                                selected: genres.contains(genre),
                                onSelected: (isSelected) {
                                  if (isSelected) {
                                    setState(() {
                                      genres.add(genre);
                                    });
                                  } else {
                                    setState(() {
                                      genres.remove(genre);
                                    });
                                  }
                                },
                              ),
                            );
                          })
                        ],
                      ),
                      const Text("Pages", style: AppStyles.adminHeader),
                      AdminTextField(
                          keyboardType: TextInputType.number,
                          controller: pagesController,
                          hintText: "Pages"),
                      const SizedBox(height: 15),
                      CustomButtonWithGradientBackground(
                          height: 52, text: "Add", onPressed: addBook),
                      const SizedBox(height: 15),
                    ]),
              ),
            ),
          ),
        ));
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 400),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      publishDate = date;
      publishDateController.text =
          DateFormat("dd/MM/yyyy").format(date).toString();
    });
  }

  Future<void> addBook() async {
    _setLoading();
    try {
      await BookService().addBook(
          book: Book(
              id: "",
              name: nameController.text,
              description: descriptionController.text,
              image: '',
              reviews: [],
              numberReviews: 0,
              averageRating: 0,
              author: authorController.text,
              publisher: publisherController.text,
              isbn: isbnController.text,
              firstPublishDate: publishDate,
              pages: int.parse(pagesController.text),
              genres: genres));

      if (!mounted) {
        return;
      }
      await showSuccessDialog(
          context: context, message: "Add book successfully");

      if (!mounted) {
        return;
      }
      Navigator.pop(context);
    } catch (error) {
      showErrorDialog(context: context, message: "Add book failed");
      print(error);
    } finally {
      Future.delayed(Duration(milliseconds: 100), () {
        _setLoading();
      });
    }
  }

  void _setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
