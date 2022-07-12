//
//  ViewController.swift
//  PhotoTranslator
//
//  Created by Никита Падалко on 12.07.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let originalTextLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Text from Photo:"
        label.textAlignment = .center
        
        return label
    }()
    
    let translatedTextLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Translated text:"
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
//        view.addSubview(translatedTextLabel)
        view.addSubview(swapLanguagesButton)
        view.addSubview(inputPicker)
        view.addSubview(outputPicker)
        view.addSubview(originalTextView)
        view.addSubview(translatedTextView)
        view.addSubview(takePhotoButton)
        
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
        
        var answer = ""

        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            let ocr = OCR(image: UIImage(named: "sample")!, language: "English🇬🇧")
            ocr.callOCRSpace(completion: { text in
                answer = text
                group.leave()

            })
        }
        
        group.notify(queue: .main) {
            self.originalTextView.text += answer
        }
        
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

// OCR API Key: K89601051888957
