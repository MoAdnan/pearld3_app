/// Represents a print model configuration for generating reports.
class PrintModel {
  /// Creates a [PrintModel] instance.
  ///
  /// The [name] is the name of the print model.
  /// The [file] is the file associated with the print model.
  /// The [needsData] indicates whether the print model requires data.
  const PrintModel(this.name, this.file, [this.needsData = false]);

  /// The name of the print model.
  final String name;

  /// The file associated with the print model.
  final String file;

  /// Indicates whether the print model requires data.
  final bool needsData;
}
