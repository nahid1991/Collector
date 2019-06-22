//
//  AddImageViewController.swift
//  The Collector
//
//  Created by Nahid on 21/6/19.
//  Copyright © 2019 Nahid. All rights reserved.
//

import UIKit

class AddImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            imageView.image = chosenImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func takePhotoTapped(_ sender: Any) {
        launchPicker(sourceType: .camera)
    }
    
    @IBAction func choosePhotoTapped(_ sender: Any) {
        launchPicker(sourceType: .photoLibrary)
    }
    
    func launchPicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func addTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let itemToBeSaved = Item(entity: Item.entity(), insertInto: context)
            itemToBeSaved.title = titleTextField.text
            
            if let userImage = imageView.image {
                if let userImageData = userImage.pngData() {
                    itemToBeSaved.imageData = userImageData
                }
            }
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
            navigationController?.popViewController(animated: true)
        }
    }
}
