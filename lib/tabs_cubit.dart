import 'package:flutter_bloc/flutter_bloc.dart';

import 'example_browser_tab.dart';

class TabsCubit extends Cubit<List<ExampleBrowser>> {
  TabsCubit(List<ExampleBrowser> initialState) : super(initialState);
  changeLink({required int index, required String url}) async {
    state[index].url = url;
    print(List.generate(state.length, (index) => state[index].url));
  }
}
