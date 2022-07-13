

import Foundation
import UIKit

class OCR {
    let image: UIImage
    let language: String
    
    
    
    func callOCRSpace(completion: @escaping(String)->()) {
        let url = URL(string: "https://api.ocr.space/Parse/Image")
        
        var request: URLRequest? = nil
        
        if let url = url {
            request = URLRequest(url: url)
        }
        
        request?.httpMethod = "POST"
        
        let boundary = "randomString"
        request?.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let imageData = image.jpegData(compressionQuality: 0.3)
        let parametersDictionary = ["apikey": "Your Ocr.space API key", "isOverlayRequired" : "True", "language": language]
        print(language)
        
        let data = createBody(withBoundary: boundary, parameters: parametersDictionary, imageData: imageData, filename: "image.jpg")
        
        request?.httpBody = data
        
        var task: URLSessionDataTask? = nil
        if let request = request {
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                var result: [AnyHashable : Any]? = nil
                do {
                    if let data = data {
                        result = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable : Any]
                    }
                } catch let myError {
                    print(myError)
                }
                if let parsedResults = result?["ParsedResults"] as? [[String: Any]] {
                    if let parsedResult = parsedResults.first {
                        if let text = parsedResult["ParsedText"] as? String? {
                            completion(text!)
                        }
                    }
                }
            })
        }
        task?.resume()
        
    }
    
    func createBody(withBoundary boundary: String?, parameters: [AnyHashable : Any]?, imageData data: Data?, filename: String?) -> Data? {
            var body = Data()
            if data != nil {
                if let data1 = "--\(boundary ?? "")\r\n".data(using: .utf8) {
                    body.append(data1)
                }
                if let data1 = "Content-Disposition: form-data; name=\"\("file")\"; filename=\"\(filename ?? "")\"\r\n".data(using: .utf8) {
                    body.append(data1)
                }
                if let data1 = "Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) {
                    body.append(data1)
                }
                if let data = data {
                    body.append(data)
                }
                if let data1 = "\r\n".data(using: .utf8) {
                    body.append(data1)
                }
            }

            for key in parameters!.keys {
                if let data1 = "--\(boundary ?? "")\r\n".data(using: .utf8) {
                    body.append(data1)
                }
                if let data1 = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8) {
                    body.append(data1)
                }
                if let parameter = parameters?[key], let data1 = "\(parameter)\r\n".data(using: .utf8) {
                    body.append(data1)
                }
            }

            if let data1 = "--\(boundary ?? "")--\r\n".data(using: .utf8) {
                body.append(data1)
            }

            return body
        }
    
    
    init(image: UIImage, language: String) {
        self.image = image
        switch language {
        case "Arabic🇦🇪": self.language = "ara"
        case languages[1]: self.language = "chs"
        case languages[2]: self.language = "bul"
        case languages[3]: self.language = "hrv"
        case languages[4]: self.language = "cze"
        case languages[5]: self.language = "dan"
        case languages[6]: self.language = "dut"
        case languages[7]: self.language = "eng"
        case languages[8]: self.language = "fin"
        case languages[9]: self.language = "fre"
        case languages[10]: self.language = "ger"
        case languages[11]: self.language = "gre"
        case languages[12]: self.language = "hun"
        case languages[13]: self.language = "ita"
        case languages[14]: self.language = "jpn"
        case languages[15]: self.language = "kor"
        case languages[16]: self.language = "pol"
        case languages[17]: self.language = "por"
        case languages[18]: self.language = "rus"
        case languages[19]: self.language = "spa"
        case languages[20]: self.language = "slv"
        case languages[21]: self.language = "swe"
        case languages[22]: self.language = "tur"
        default: self.language = "en"
        }
    }
}
