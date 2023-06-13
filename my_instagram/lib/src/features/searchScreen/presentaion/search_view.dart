import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_instagram/src/utils/src/extensions/color_extension.dart';

import '../../../utils/src/constants.dart';
import 'widgets/seach_grid_view.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTextController = useTextEditingController();
    final searchKey = useState('');
    useEffect(() {
      searchTextController.addListener(() {
        searchKey.value = searchTextController.text;
      });
      return () {};
    }, [searchTextController]);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              textInputAction: TextInputAction.search,
              controller: searchTextController,
              decoration: InputDecoration(
                labelText: Strings.enterYourSearchTermHere,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchTextController.clear();
                    dismissKeyboard();
                  },
                ),
              ),
            ),
          ),
        ),
        SearchGridView(
          searchTerm: searchKey.value,
        ),
      ],
    );
  }
}
