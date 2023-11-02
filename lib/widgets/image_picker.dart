
import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'image_picker_dialog.dart';

class CustomUploadWidget extends StatefulWidget {
  const CustomUploadWidget(
      {super.key,
        required this.labelText,
        required this.onTap,
        this.optional = ""
      });

  final String labelText, optional;
  final Function onTap;

  @override
  State<CustomUploadWidget> createState() => _CustomUploadWidgetState();
}

class _CustomUploadWidgetState extends State<CustomUploadWidget> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleHeading4Widget(
              text: widget.labelText.tr,
              fontWeight: FontWeight.w600,
            ),
            Visibility(
              visible: widget.optional.isNotEmpty,
              child: TitleHeading4Widget(
                text: widget.optional.tr,
                opacity: .4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox * 1),
        InkWell(
          onTap: () {
            ImagePickerDialog.pickImage(context, onPicked: (File value) {
              file = value;
              setState(() {
                widget.onTap(value);
              });
            });
          },
          child: Container(
            width: double.infinity,
            height: Dimensions.buttonHeight * 1.5,
            alignment: Alignment.center,
            decoration: DottedDecoration(
              shape: Shape.box,
              dash: const [3, 3],
              color: Theme.of(context).primaryColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(Dimensions.radius * .5),
            ),
            child: file == null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Animate(
                  effects: const [FadeEffect(), ScaleEffect()],
                  child: Icon(
                    Icons.backup_outlined,
                    size: 30,
                    color:
                    CustomColor.primaryLightTextColor.withOpacity(.2),
                  ),
                ),
                verticalSpace(3),
                TitleHeading3Widget(
                  text: Strings.upload,
                  color:
                  CustomColor.primaryLightTextColor.withOpacity(.2),
                ),
              ],
            )
                : Image.file(
              file!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        )
      ],
    );
  }
}
