extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
  String removebl(){
    return "${this.replaceAll('\\n', '')}";
  }
}
