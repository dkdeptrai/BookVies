import 'package:bookvies/blocs/admin_newest_books_bloc/admin_newest_books_bloc.dart';
import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/common_widgets/custom_text_form_field.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminEditBookScreen extends StatefulWidget {
  final Book book;
  const AdminEditBookScreen({super.key, required this.book});

  static const String id = "/admin-edit-ebook-screen";

  @override
  State<AdminEditBookScreen> createState() => _AdminEditBookScreenState();
}

class _AdminEditBookScreenState extends State<AdminEditBookScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pagesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.book.name;
    authorController.text = widget.book.author;
    descriptionController.text = widget.book.description;
    pagesController.text = widget.book.pages.toString();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    pagesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppDimensions.defaultAppBarPreferredSize,
          child: CustomAppBar(
            title: "Edit book",
            leading: IconButton(
              icon: SvgPicture.asset(AppAssets.icArrowLeft),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Name"),
            CustomTextFormField(controller: nameController, hintText: "Name"),
            const SizedBox(height: 5),
            const Text("Author"),
            CustomTextFormField(
                controller: authorController, hintText: "Author"),
            const SizedBox(height: 5),
            const Text("Description"),
            CustomTextFormField(
                maxLines: 5,
                controller: descriptionController,
                hintText: "Description"),
            const SizedBox(height: 15),
            CustomButtonWithGradientBackground(
                height: 52,
                text: "Update",
                onPressed: () {
                  context.read<AdminNewestBooksBloc>().add(UpdateBook(
                      context: context,
                      book: widget.book.copyWith(
                        name: nameController.text,
                        description: descriptionController.text,
                        author: authorController.text,
                        // pages: pagesController.text.isEmpty
                        //     ? 0
                        //     : int.parse(pagesController.text)
                      )));
                })
          ],
        ),
      )),
    );
  }
}
