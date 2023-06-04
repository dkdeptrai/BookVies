import 'dart:io';
import 'dart:ui' as ui;

import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/common_widgets/custom_text_form_field.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class PersonalInformationScreen extends StatefulWidget {
  static const id = '/personal-information-screen';
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  File? _pickedImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double topMargin = size.height * 0.05;
    final double bottomMargin = size.height * 0.03;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          title: "Personal information",
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.primaryTextColor,
            ),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventLogOut());
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            padding: EdgeInsets.only(
                left: 20, right: 20, top: topMargin, bottom: bottomMargin),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 33, top: 6),
                  child: const Text(
                    "We need some personal information to create your own profile.",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 33, bottom: 10),
                  width: double.infinity,
                  child: const Text(
                    "Choose your profile image",
                    style: AppStyles.subHeaderTextStyle,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: _pickedImage == null
                          ? Image.asset(
                              AppAssets.imgGenericUser,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _pickedImage!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14, bottom: 3),
                  width: double.infinity,
                  child: const Text(
                    "Your name",
                    style: AppStyles.subHeaderTextStyle,
                  ),
                ),
                CustomTextFormField(
                  controller: _nameController,
                  hintText: "Name",
                  prefixIconConstraints:
                      BoxConstraints.tight(const Size(24, 24)),
                  prefixIcon: const SizedBox(),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14, bottom: 3),
                  width: double.infinity,
                  child: const Text(
                    "Your description",
                    style: AppStyles.subHeaderTextStyle,
                  ),
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: _descriptionController,
                  hintText: "Your description",
                  prefixIconConstraints:
                      BoxConstraints.tight(const Size(24, 24)),
                  prefixIcon: const SizedBox(),
                  height: 166,
                  maxLines: null,
                ),
                const Spacer(),
                CustomButtonWithGradientBackground(
                  height: 52,
                  text: "Submit",
                  onPressed: () {
                    _uploadUserInfo();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    setState(() {
      _pickedImage = File(pickedFile.path);
    });
  }

// ...

  Future<File> _loadDefaultImage() async {
    // Load the default image bytes from assets
    ByteData byteData = await rootBundle.load(AppAssets.imgGenericUser);

    // Create a Uint8List from the byteData
    Uint8List uint8List = byteData.buffer.asUint8List();

    // Decode the image
    ui.Codec codec = await ui.instantiateImageCodec(uint8List);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    ui.Image image = frameInfo.image;

    // Create a new image with a white background
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    canvas.drawRect(
        ui.Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Paint()..color = ui.Color(0xFFFFFFFF));
    canvas.drawImage(image, ui.Offset.zero, Paint());

    // Convert the image with a white background to PNG
    ui.Image whiteBgImage =
        await recorder.endRecording().toImage(image.width, image.height);
    ByteData? whiteBgByteData =
        await whiteBgImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List whiteBgUint8List =
        whiteBgByteData?.buffer.asUint8List() ?? Uint8List(0);

    // Get the temporary directory
    Directory tempDir = await getTemporaryDirectory();

    // Create a File object with the default image bytes
    File file = File('/${tempDir.path}/default_image.png');
    await file.writeAsBytes(whiteBgUint8List);

    return file;
  }

  Future<void> _uploadUserInfo() async {
    if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) {
      return;
    }

    File? imageToUpload;

    if (_pickedImage != null) {
      imageToUpload = _pickedImage;
    } else {
      imageToUpload = await _loadDefaultImage();
    }

    Uint8List compressedBytes = await FlutterImageCompress.compressWithFile(
            imageToUpload!.path,
            quality: 75) ??
        Uint8List(0);

    File compressedImageFile =
        File('${(await getTemporaryDirectory()).path}/compressed_image.jpg');
    await compressedImageFile.writeAsBytes(compressedBytes);

    context.read<AuthBloc>().add(AuthEventAddUserInformation(
          name: _nameController.text,
          description: _descriptionController.text,
          image: compressedImageFile,
        ));
  }
}
