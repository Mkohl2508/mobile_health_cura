// ignore_for_file: file_names

class BasicTile {
  final String title;
  final List<BasicTile> tiles;
  final void Function()? function;
  final String? parent;

  const BasicTile(
      {required this.parent,
      required this.title,
      this.tiles = const [],
      this.function});
}
