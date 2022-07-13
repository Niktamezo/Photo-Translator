

import Foundation

// MARK: - TranslatorData
struct TranslatorData: Codable {
    let sourceLanguageCode, targetLanguageCode, format: String
    let texts: [String]
    let folderID, model: String
    let glossaryConfig: GlossaryConfig

    enum CodingKeys: String, CodingKey {
        case sourceLanguageCode, targetLanguageCode, format, texts
        case folderID = "folderId"
        case model, glossaryConfig
    }
}

// MARK: - GlossaryConfig
struct GlossaryConfig: Codable {
    let glossaryData: GlossaryData
}

// MARK: - GlossaryData
struct GlossaryData: Codable {
    let glossaryPairs: [GlossaryPair]
}

// MARK: - GlossaryPair
struct GlossaryPair: Codable {
    let sourceText, translatedText: String
}
