part of dto;

@JsonEnum()
enum Language {
  @JsonValue('EN')
  en,
  @JsonValue('ID')
  id;

  factory Language.fromLocaleName(String localeName) {
    if (localeName == 'id_ID') {
      return Language.id;
    }

    return Language.en;
  }

  factory Language.fromString(String name) {
    return Language.values.firstWhere((element) => element.name == name);
  }

  Locale toLocale() {
    return Locale.fromSubtags(languageCode: name);
  }
}
