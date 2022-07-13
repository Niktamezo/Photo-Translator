

// MARK: - Translate
struct Translate: Codable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let text, detectedLanguageCode: String
}
