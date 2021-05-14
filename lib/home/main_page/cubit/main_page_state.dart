part of 'main_page_cubit.dart';


class MainPageState extends Equatable {
  final int selectedItem;

  const MainPageState({this.selectedItem = 0}); /// default state of item is zero which is tab zero

  MainPageState copyWith({
    int selectedItem,
}) {
    return MainPageState(
      selectedItem: selectedItem ?? this.selectedItem, /// if null return our default selectedItem
    );
}
  @override
  // TODO: implement props
  List<Object> get props => [selectedItem]; /// implement this later :-)

}