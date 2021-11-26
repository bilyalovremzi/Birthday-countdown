//
//  ThirdViewController.swift
//  Homework3
//
//  Created by Ремзи Билялов on 28.10.2021.
//

import UIKit
import PhotosUI
import Photos

class ThirdViewController: UIViewController, PHPickerViewControllerDelegate {
    
    weak var delegate: SecondViewController?
    
    @IBOutlet weak var buttonCancel: UIBarButtonItem!
    @IBOutlet weak var buttonAdd: UIBarButtonItem!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageFoto: UIImageView!

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var textfieldName: UITextField!
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var textfieldDate: UITextField!
    
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var textfieldAge: UITextField!
    
    @IBOutlet weak var labelSex: UILabel!
    @IBOutlet weak var textfieldSex: UITextField!
    
    @IBOutlet weak var labelInstagram: UILabel!
    @IBOutlet weak var textfieldInstagram: UITextField!
    
    var datePicker = UIDatePicker()
    let agePicker = UIPickerView()
    let sexPicker = UIPickerView()
    
    let sex = ["Мужской", "Женский"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageFoto.image = UIImage(systemName: "person.circle")
        imageFoto.tintColor = UIColor.lightGray
        imageFoto.layer.cornerRadius = imageFoto.frame.size.width / 2
        
        createDatePicker()
        datePicker.locale = .init(identifier: "Russian")
        datePicker.preferredDatePickerStyle = .wheels
    
        createPicker()
        
        agePicker.dataSource = self
        agePicker.delegate = self
        agePicker.tag = 1
        textfieldAge.inputView = agePicker
        
        sexPicker.dataSource = self
        sexPicker.delegate = self
        sexPicker.tag = 2
        textfieldSex.inputView = sexPicker
        
        textfieldInstagram.addTarget(self, action: #selector(alertInstagram), for: .allEditingEvents)
    
    }
    
    //MARK: Func button Add (delegate)
    @IBAction func buttonAdd(_ sender: Any) {
        delegate?.update(name: textfieldName.text!, age: textfieldAge.text!, instagram: textfieldInstagram.text!, image: imageFoto.image!, dayTo: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Func cancel button
    @IBAction func buttonCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    //MARK: Func Button add Foto
    @IBAction func buttonAddFoto(_ sender: Any) {
        
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true)
        
    }
    
    //MARK: Func Picker Foto
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        results.forEach { results in
            results.itemProvider.loadObject(ofClass:  UIImage.self) { [weak self] reading, error in
                DispatchQueue.main.async {
                    guard let image = reading as? UIImage, error == nil else {
                        return
                    }
                    self?.imageFoto.image = image
                }
            } 
        }
        
    }
    
    //MARK: Data Picker
    func createDatePicker () {
        
        let toolbarPicker = UIToolbar()
        toolbarPicker.sizeToFit()
        
        let doneButtonToolbar = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(pressedDoneBtn))
        toolbarPicker.setItems([doneButtonToolbar], animated: true)
        
        textfieldDate.inputAccessoryView = toolbarPicker
        textfieldDate.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    @objc func pressedDoneBtn () {
        
        let formted = DateFormatter()
        formted.dateStyle = .long
        formted.timeZone = .none
        
        // Date in russin lenguage
        formted.locale = .init(identifier: "Russian")
        
        
        textfieldDate.text = formted.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    //MARK: Create Done button for picker
    func createPicker() {
        
        let toolbarPicker = UIToolbar()
        toolbarPicker.sizeToFit()
        
        let doneButtonToolbar = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtomAge))
        toolbarPicker.setItems([doneButtonToolbar], animated: true)

        textfieldAge.inputAccessoryView = toolbarPicker
        textfieldSex.inputAccessoryView = toolbarPicker
        
    }
    
    @objc func doneButtomAge() {
        view.endEditing(true)
    }
    
    //MARK: Alert for Instagram
    
    @objc func alertInstagram() {
        
        let alertInstagram = UIAlertController(title: "Введите username Instagram", message: "", preferredStyle: .alert)
        
        alertInstagram.addTextField { (field) in
            field.placeholder = "@"
        }
        
        alertInstagram.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (cancelAct) in
        }))
        
        alertInstagram.addAction(UIAlertAction(title: "OK", style: .default, handler: { (ok) in
            let inst = alertInstagram.textFields?.first
            
            self.textfieldInstagram.text! += (inst?.text!)!
        }))
        
        present(alertInstagram, animated: true, completion: nil)
    }
    
}

//MARK: Picker Age/Sex

extension ThirdViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    //количксвто компонентов
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    //содержимое компоненотов
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag  {
        case 1:
            return 100
        case 2:
            return sex.count
        default:
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag  {
        case 1:
            return "\(row)"
        case 2:
            return sex[row]
        default:
            return "Data not found "
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag  {
        case 1:
            textfieldAge.text = "\(row)"
        case 2:
            textfieldSex.text = sex[row ]
        default:
            return
        }
    }
}





