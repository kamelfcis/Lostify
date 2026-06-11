import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/add_post_details/view_models/cubit/add_post_cubit.dart';

class PickItemImage extends StatelessWidget {
  const PickItemImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AddPostCubit>();
    return GestureDetector(
      onTap: () {
        cubit.pickImageWithGallery();
      },
      child: Container(
        height: SizeConfig.height * 0.25,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        child: BlocBuilder<AddPostCubit, AddPostState>(
          buildWhen: (previous, current) =>
              previous is PickImageSuccess || current is PickImageSuccess,
          builder: (context, state) {
            return state is PickImageSuccess && cubit.selectedImage != null
                ? Image.file(File(cubit.selectedImage!.path))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        size: SizeConfig.width * 0.1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: SizeConfig.height * 0.005),
                      Text("Select Image With Gallery",
                          style: AppTextStyles.title18GreyW500),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
