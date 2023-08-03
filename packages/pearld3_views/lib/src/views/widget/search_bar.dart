import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_util/utilites/context_extensions.dart';
import 'package:pearld3_views/pearld3_views.dart';

class CustomSearchBar extends StatelessWidget {
  FocusNode? focusNode;
  Function(String)? onSearch;
  double height;
  double width;
  VoidCallback onClear;

  CustomSearchBar(
      {super.key,
      required this.onClear,
      this.onSearch,
      this.focusNode,
      this.height = 45,
      this.width = 280});
  TextEditingController _controller = TextEditingController();
  ValueNotifier<String> serarchNotifier = ValueNotifier<String>('');

  void _clear() {
    onClear.call();
    serarchNotifier.value = '';
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: serarchNotifier,
      builder: (context, value, child) {
        return SizedBox(
          height: height,
          width: width,
          child: TextField(
            focusNode: focusNode,
            onChanged: (value) {
              onSearch!(value);
              serarchNotifier.value = value;
            },
            controller: _controller,
            textAlign: TextAlign.start,
            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 18),
            decoration: InputDecoration(
              hintText: '${'search_here'.tr()}...',

              contentPadding: context.locale.languageCode == 'en'
                  ? const EdgeInsets.only(left: 60, top: 10, bottom: 10)
                  : const EdgeInsets.only(left: 30, top: 15),
              fillColor: Colors.white,
              filled: true,
              // Add a clear button to the search bar
              suffixIcon: value.isNotEmpty
                  ? IconButtonWidget(
                      icon: Icons.clear,
                      onTap: () => _clear(),
                      color: context.colorGrey,
                      size: 26,
                    )
                  : null,
              // Add a search icon or button to the search bar
              prefixIcon: value.isEmpty
                  ? IconButtonWidget(
                      size: 26,
                      color: Colors.black54,
                      onTap: () => onSearch!(_controller.text),
                      icon: Icons.search)
                  : null,

              border: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
      },
    );
  }
}
