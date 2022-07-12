

import Foundation

import Foundation

// MARK: - Welcome
struct parsedOCR {
    let parsedResults: [ParsedResult]
    let ocrExitCode: Int
    let isErroredOnProcessing: Bool
    let processingTimeInMilliseconds, searchablePDFURL: String
}

// MARK: - ParsedResult
struct ParsedResult {
    let textOverlay: TextOverlay
    let textOrientation: String
    let fileParseExitCode: Int
    let parsedText, errorMessage, errorDetails: String
}

// MARK: - TextOverlay
struct TextOverlay {
    let lines: [Any?]
    let hasOverlay: Bool
    let message: String
}
