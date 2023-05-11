import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/services/library_service.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:flutter/material.dart';

class ChooseListDialog extends StatefulWidget {
  final String mediaId;
  final String image;
  final String name;
  final String author;
  const ChooseListDialog(
      {super.key,
      required this.mediaId,
      required this.image,
      required this.name,
      required this.author});

  @override
  State<ChooseListDialog> createState() => _ChooseListDialogState();
}

class _ChooseListDialogState extends State<ChooseListDialog> {
  final List<String> titles = ["Read", "Reading", "To read"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                const Text("Which list to save?",
                    style: AppStyles.sectionHeaderText),
                const SizedBox(height: 15),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedIndex == index
                                ? AppColors.mediumBlue.withOpacity(0.1)
                                : AppColors.secondaryColor,
                          ),
                          child: ListTile(
                            title: Text(titles[index]),
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          ),
                        ),
                    separatorBuilder: (_, index) => const SizedBox(height: 10),
                    itemCount: titles.length),
                const SizedBox(height: 20),
                CustomButtonWithGradientBackground(
                    height: 53,
                    text: "Add to library",
                    onPressed: _addToLibrary)
              ],
            ),
          )
        ],
      )),
    );
  }

  _addToLibrary() async {
    try {
      // check if this book is already in the library
      final bool isExistedInLibrary =
          await LibraryService.isThisBookInLibrary(widget.mediaId);

      if (isExistedInLibrary) {
        if (!mounted) {
          return;
        }
        showWarningDialog(
            context: context, message: "This book is already in your library.");
        return;
      }

      // else, add it to the library
      await LibraryService.addToLibrary(
          mediaId: widget.mediaId,
          image: widget.image,
          name: widget.name,
          author: widget.author,
          status: convertToCamelCase(titles[selectedIndex]));

      if (!mounted) {
        return;
      }
      Navigator.pop(context);
      showSuccessDialog(
          context: context, message: "Added to library successfully");
    } catch (error) {
      showErrorDialog(context: context, message: "Something went wrong.");
    }
  }
}
