

import Foundation


class TranslatorManager {
    
    let text: String
    let outputLanguage: String
    
    func callYaTranslate(completion: @escaping(String) -> ()) {
        
        let url = URL(string: "https://translate.api.cloud.yandex.net/translate/v2/translate")
        
        
        var request = URLRequest(url: url!, timeoutInterval: Double.infinity)
        
        request.httpMethod = "POST"
        
        // let jsonData = "{\n\r\"folderId\": \"b1grbe66qrddgq60nja1\",\n\r\"texts\": \(text.components(separatedBy: " ")),\n\r\"targetLanguageCode\": \(getLanguageCode(language: outputLanguage))\n}"
        
        // print(jsonData)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer t1.9euelZrIkYnKkomWjp2Oy4-MicfNme3rnpWaxpWKzpHJk8nInsuanpmbzMjl9PcAWUVp-e9lcUWf3fT3QAdDafnvZXFFnw.cUiumMgcych-Rq6GlPeNEYz-RXRSWW2K8f3USYlTZd4RBxdXPiVR9mnAZULK-1JfeNqwLPHzlYiYt_Lm42y_Ag", forHTTPHeaderField: "Authorization")
        
        
        let parameters = ["folderId" : "b1grbe66qrddgq60nja1",  "texts" : text.components(separatedBy: " "), "targetLanguageCode": getLanguageCode(language: self.outputLanguage)] as [String : Any]
        
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        var output = ""
        
        let session = URLSession.shared
        
        var task: URLSessionDataTask? = nil
        
        task = session.dataTask(with: request, completionHandler: { data, response, error in
            do {
                if let data = data {
                    let translate = try? JSONDecoder().decode(Translate.self, from: data)
                    for word in translate!.translations {
                        output += word.text + " "
                    }
                    completion(output)
                }
            } catch let myError {
                print(myError)
            }
        })
        task?.resume()
    }
    
    init(text: String, outputLanguage: String) {
        self.text = text
        self.outputLanguage = outputLanguage
    }
    
    
    func getLanguageCode(language: String) -> String {
        switch language {
        case "Arabic🇦🇪": return "ar"
        case languages[1]: return  "zh"
        case languages[2]: return  "bg"
        case languages[3]: return  "hr"
        case languages[4]: return  "cs"
        case languages[5]: return  "da"
        case languages[6]: return  "nl"
        case languages[7]: return  "en"
        case languages[8]: return  "fi"
        case languages[9]: return  "fr"
        case languages[10]: return  "de"
        case languages[11]: return  "el"
        case languages[12]: return "hu"
        case languages[13]: return  "it"
        case languages[14]: return  "ja"
        case languages[15]: return  "ko"
        case languages[16]: return  "pl"
        case languages[17]: return  "pt"
        case languages[18]: return  "ru"
        case languages[19]: return  "es"
        case languages[20]: return  "sl"
        case languages[21]: return  "sv"
        case languages[22]: return "tr"
        default: return "en"
        }
    }
}


// token Authorization: Bearer t1.9euelZrGi5bNx8eVl5jHxpfLmYqWyu3rnpWaxpWKzpHJk8nInsuanpmbzMjl8_cBUEZp-e90Tn0g_d3z90F-Q2n573ROfSD9.rcBaWk7DXY6ojXfwNegTDge55xqq-kfHgwI8snfMVFd0WscB4bVphttaHZ9KnUDwjxnKzS0inFDWLkSJYHxOAw
