import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/constants.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/voice_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFieldProblemWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final void Function(String value) onChangeTextEditingController;
  String? errorMessage;
  final void Function() onVideoTap;
  final void Function() onGalleyTap;
  final int maxLengthOfVocie;
  final String title;
  final int maxLinesOfProblem;
  final int minLinesOfProblem;

  CustomTextFieldProblemWidget({
    super.key,
    required this.textEditingController,
    this.errorMessage,
    required this.maxLengthOfVocie,
    required this.maxLinesOfProblem,
    required this.onChangeTextEditingController,
    required this.onGalleyTap,
    required this.onVideoTap,
    required this.title,
    required this.minLinesOfProblem,
  });

  @override
  State<CustomTextFieldProblemWidget> createState() =>
      _CustomTextFieldProblemWidgetState();
}

class _CustomTextFieldProblemWidgetState
    extends State<CustomTextFieldProblemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorSchemes.black,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: Constants.fontWeightBold,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 172.0,
          color: ColorSchemes.white,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: widget.textEditingController,
                  onChanged: widget.onChangeTextEditingController,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  maxLength: widget.maxLinesOfProblem,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: Constants.fontWeightSemiBold,
                        color: ColorSchemes.black,
                      ),
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: ColorSchemes.border),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: ColorSchemes.border),
                        borderRadius: BorderRadius.circular(12)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: ColorSchemes.redError),
                        borderRadius: BorderRadius.circular(12)),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorSchemes.border),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    counterText: "",
                    errorText: widget.errorMessage,
                    hintText: "Describe Your Problem...",
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF989898),
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    vertical: widget.errorMessage != null ? 30 : 10,
                  ),
                  child: SizedBox(
                    // width: 100,
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: widget.onVideoTap,
                          child: SvgPicture.asset(
                            "ImagePaths.video",
                            fit: BoxFit.scaleDown,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: widget.onGalleyTap,
                          child: SvgPicture.asset(
                            "ImagePaths.newGallery",
                            fit: BoxFit.scaleDown,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        RecordVoiceWidget(
                          maxRecordingDuration: widget.maxLengthOfVocie,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.errorMessage != null)
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Text(
              "Minimum ${widget.minLinesOfProblem} , Maximum ${widget.maxLinesOfProblem} characters",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: const Color(0xFF222222),
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
      ],
    );
  }
}
