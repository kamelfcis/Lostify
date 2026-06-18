import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitSearch() {
    FocusScope.of(context).unfocus();
    context.read<SearchCubit>().submitTextSearch(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _submitSearch(),
            style: AppTextStyles.title16White500.copyWith(color: Colors.black87),
            decoration: InputDecoration(
              hintText: 'Search by title, description, or card number',
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: AppColors.kPrimaryColor,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.04,
                vertical: SizeConfig.height * 0.016,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.kPrimaryColor.withValues(alpha: 0.15),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.kPrimaryColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: SizeConfig.width * 0.02),
        Material(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(14),
          elevation: 2,
          child: InkWell(
            onTap: _submitSearch,
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: SizeConfig.width * 0.13,
              height: SizeConfig.height * 0.055,
              child: const Icon(Icons.search, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
