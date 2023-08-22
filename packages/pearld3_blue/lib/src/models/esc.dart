class Esc {
  String? generatorType;
  String? text;

  Style? posStyles;


  Esc({this.generatorType, this.text, this.posStyles});

  Esc.fromJson(Map<String, dynamic> json) {
    generatorType = json['generatorType'];
    text = json['text'];

    posStyles = json['posStyles'] != null
        ? new Style.fromJson(json['posStyles'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['generatorType'] = this.generatorType;
    data['text'] = this.text;

    if (this.posStyles != null) {
      data['posStyles'] = this.posStyles!.toJson();
    }
    return data;
  }
}

class Style {
  bool? bold;
  bool? reverse;
  bool? underline;
  bool? turn90;
  String? align;
  String? height;
  String? width;
  String? fontType;
  String? codeTable;

  Style(
      {this.bold,
        this.reverse,
        this.underline,
        this.turn90,
        this.align,
        this.height,
        this.width,
        this.fontType,
        this.codeTable});

  Style.fromJson(Map<String, dynamic> json) {
    bold = json['bold'];
    reverse = json['reverse'];
    underline = json['underline'];
    turn90 = json['turn90'];
    align = json['align'];
    height = json['height'];
    width = json['width'];
    fontType = json['fontType'];
    codeTable = json['codeTable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bold'] = this.bold;
    data['reverse'] = this.reverse;
    data['underline'] = this.underline;
    data['turn90'] = this.turn90;
    data['align'] = this.align;
    data['height'] = this.height;
    data['width'] = this.width;
    data['fontType'] = this.fontType;
    data['codeTable'] = this.codeTable;
    return data;
  }
}
