// ignore_for_file: file_names

class BasicTile {
  final String title;
  final List<BasicTile> tiles;
  final void Function()? function;

  const BasicTile({required this.title, this.tiles = const [], this.function});
}
