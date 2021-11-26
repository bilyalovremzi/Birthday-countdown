//
//  SecondViewController.swift
//  Homework3
//
//  Created by Ремзи Билялов on 25.10.2021.
//

import UIKit

protocol SecondVievControllerDelegate: AnyObject {
    func update(name: String, age: String, instagram: String, image: UIImage, dayTo: Date)
}

class SecondViewController: UIViewController, SecondVievControllerDelegate {
   
    @IBOutlet weak var dayToBirthday: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var instagramLabel: UILabel!
    
    @IBOutlet weak var navBarBirthday: UINavigationItem!
    @IBOutlet weak var buttonPlus: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayToBirthday.text = ""
        dayToBirthday.tintColor = .systemGray
        nameLabel.text = ""
        ageLabel.text = ""
        ageLabel.tintColor = .systemGray
        instagramLabel.text = ""
        
        imageView.image = UIImage()
        imageView.tintColor = .lightGray
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinaion = segue.destination as? ThirdViewController else { return }
        destinaion.delegate = self

    }
    
    func update(name: String, age: String, instagram: String, image: UIImage, dayTo: Date) {
        
        nameLabel.text = name.capitalized
        ageLabel.text = "Исполняется" + " " + age
        instagramLabel.text = instagram
        imageView.image = image
        
        let fromDay = dayTo
        let diffInDays = Calendar.current.dateComponents([.day], from: .now, to: fromDay).day
        dayToBirthday.text! = diffInDays!.description + " " + "дней"


  
    }
    
        
    
    }
      
    

