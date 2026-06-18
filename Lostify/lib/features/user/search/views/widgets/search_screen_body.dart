import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lostify/core/helper/pick_image.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:lostify/features/user/search/views/widgets/filter_button.dart';
import 'package:lostify/features/user/search/views/widgets/filter_items_grid_view.dart';
import 'package:lostify/features/user/search/views/widgets/search_field.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key, this.initialImage});

  final File? initialImage;

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  File? _previewImage;

  @override
  void initState() {
    super.initState();
    _previewImage = widget.initialImage;
  }

  Future<void> _pickAndSearch(ImageSource source) async {
    final file = await pickImage(source: source);
    if (file == null || !mounted) return;

    setState(() => _previewImage = file);
    await context.read<SearchCubit>().searchByImage(selectedImage: file);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchHeader(context),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    final cubit = context.read<SearchCubit>();
                    if (!cubit.hasSearched) return const SizedBox.shrink();
                    return Padding(
                      padding: EdgeInsets.only(top: SizeConfig.height * 0.015),
                      child: Row(
                        children: [
                          const FilterButton(),
                          if (cubit.classificationResult.isNotEmpty) ...[
                            SizedBox(width: SizeConfig.width * 0.03),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.kPrimaryColor
                                      .withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.kPrimaryColor
                                        .withValues(alpha: 0.2),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.auto_awesome,
                                      size: 16,
                                      color: AppColors.kPrimaryColor,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        'AI: ${cubit.classificationResult}',
                                        style: TextStyle(
                                          color: AppColors.kPrimaryColor,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
                const FilterItemsGridView(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        SizeConfig.width * 0.04,
        SizeConfig.height * 0.02,
        SizeConfig.width * 0.04,
        SizeConfig.height * 0.025,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.kPrimaryColor,
            AppColors.kPrimaryColor.withValues(alpha: 0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimaryColor.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchTextField(),
          SizedBox(height: SizeConfig.height * 0.02),
          Text(
            'AI Image Search',
            style: AppTextStyles.title16White500,
          ),
          SizedBox(height: SizeConfig.height * 0.012),
          Row(
            children: [
              Expanded(
                child: _ImageSourceButton(
                  label: 'Camera',
                  icon: Icons.camera_alt_rounded,
                  onTap: () => _pickAndSearch(ImageSource.camera),
                ),
              ),
              SizedBox(width: SizeConfig.width * 0.03),
              Expanded(
                child: _ImageSourceButton(
                  label: 'Gallery',
                  icon: Icons.photo_library_rounded,
                  onTap: () => _pickAndSearch(ImageSource.gallery),
                ),
              ),
            ],
          ),
          if (_previewImage != null) ...[
            SizedBox(height: SizeConfig.height * 0.015),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.file(
                _previewImage!,
                height: SizeConfig.height * 0.1,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ImageSourceButton extends StatelessWidget {
  const _ImageSourceButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.height * 0.016),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
