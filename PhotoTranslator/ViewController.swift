//
//  ViewController.swift
//  PhotoTranslator
//
//  Created by Никита Падалко on 12.07.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var imagePicked: UIImageView = {
        var picture = UIImageView()
        
        return picture
    }()
    
    let originalTextLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Text from Photo:"
        label.textAlignment = .center
        
        return label
    }()
    
    
    let takePhotoButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 100, y: 100, width: 60, height: 60))
        let config = UIImage.SymbolConfiguration(pointSize: 60)
        
        var image = UIImage(systemName: "camera.circle.fill", withConfiguration: config)
        
        
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    let swapLanguagesButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 200, y: 200, width: 30, height: 30))
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        
        button.setImage(UIImage(systemName: "arrow.left.arrow.right", withConfiguration: config), for: .normal)
        
        
        return button
    }()
    
    let inputPicker : UIPickerView = {
        var picker = UIPickerView()
        picker.frame = CGRect(x: 200, y: 200, width: 100, height: 20)
        picker.contentMode = .bottom
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        
        return picker
    }()
    
    let outputPicker : UIPickerView = {
        var picker = UIPickerView()
        picker.frame = CGRect(x: 40, y: 200, width: 180, height: 20)
        picker.contentMode = .bottom
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    let originalTextView: UITextView = {
        var textView = UITextView()
        textView.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 235/255, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 20)
        
        return textView
    }()
    
    let translatedTextView: UITextView = {
        var textView = UITextView()
        textView.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 235/255, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 20)
        
        return textView
    }()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.originalTextView.resignFirstResponder()
        self.translatedTextView.resignFirstResponder()
    }
    
    fileprivate func pickersSetup() {
        inputPicker.delegate = self
        inputPicker.dataSource = self
        outputPicker.delegate = self
        outputPicker.dataSource = self
    }
    
    fileprivate func initialize() {
        view.backgroundColor = .white
        
        view.addSubview(originalTextLabel)
        view.addSubview(swapLanguagesButton)
        view.addSubview(inputPicker)
        view.addSubview(outputPicker)
        view.addSubview(originalTextView)
        view.addSubview(translatedTextView)
        view.addSubview(takePhotoButton)
        
        takePhotoButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        swapLanguagesButton.addTarget(self, action: #selector(swapLanguage), for: .touchUpInside)
        
        originalTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        
        originalTextView.snp.makeConstraints { make in
            make.top.equalTo(originalTextLabel.snp.bottom).inset(-10)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(470)
        }
        
        takePhotoButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(50)
        }
        
        swapLanguagesButton.snp.makeConstraints { make in
            make.top.equalTo(originalTextView.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        inputPicker.snp.makeConstraints { make in
            make.right.equalTo(swapLanguagesButton.snp.left).inset(-5)
            make.centerY.equalTo(swapLanguagesButton.snp.centerY)
            make.left.equalToSuperview().inset(5)
        }
        
        outputPicker.snp.makeConstraints { make in
            make.centerY.equalTo(swapLanguagesButton.snp.centerY)
            make.left.equalTo(swapLanguagesButton.snp.right).inset(-10)
            make.right.equalToSuperview().inset(5)
        }
        
        translatedTextView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(swapLanguagesButton.snp.bottom).inset(-20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickersSetup()
        initialize()
        
        TranslatorManager(text: "Hello, World!", outputLanguage: "Russian🇷🇺").callYaTranslate { hello in
            print(hello)
        }
        
    }
    
    @objc func swapLanguage() {
        let inputCurrentPick = inputPicker.selectedRow(inComponent: 0)
        let outputCurrentPick = outputPicker.selectedRow(inComponent: 0)
        
        self.outputPicker.selectRow(inputCurrentPick, inComponent: 0, animated: true)
        self.inputPicker.selectRow(outputCurrentPick, inComponent: 0, animated: true)
    }

    @objc func takePhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        picker.allowsEditing = false
    }
    
    
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return languages[row]
    }
    
    
    
}

extension ViewController: UITextViewDelegate {
    
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagedata = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePicked.image = imagedata
        }
        dismiss(animated: true)
        let group = DispatchGroup()
        group.enter()

        
        self.originalTextView.text = ""
        
        var inputText = ""
        var outputText = ""
        
        DispatchQueue.main.async {
            if let image = self.imagePicked.image {
                let ocr = OCR(image: image, language: languages[self.inputPicker.selectedRow(inComponent: 0)])
                ocr.callOCRSpace(completion: { text in
                    inputText = text
                    translate()
                })
            }
            
            
            group.notify(queue: .main) {
                self.originalTextView.text += inputText
                self.translatedTextView.text += outputText
            }
            
        }
        
        func translate() {
        DispatchQueue.main.async {
            let translate = TranslatorManager(text: inputText, outputLanguage: languages[self.outputPicker.selectedRow(inComponent: 0)])
            translate.callYaTranslate { answer in
                outputText = answer
                group.leave()
            }
        }
        
        

    }
    }

    
    
    
}

// OCR API Key: K89601051888957
