//
//  AddNewMovieViewController.swift
//  Instabug_Task
//
//  Created by Islam Soliman on 2/25/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import UIKit

class AddNewMovieViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var posterButton: UIButton!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var overviewTextField: UITextField!
    @IBOutlet weak var releaseDatePicker: UIDatePicker!
    
    
    // MARK: - Variables
    var presenter: AddNewMoviePresenter?
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureSubviews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Configurations
    func configureSubviews() {
        
        posterButton.layer.cornerRadius = 10
        posterButton.layer.borderWidth = 0.5
        posterButton.layer.borderColor = UIColor(red: 243/255, green: 103/255, blue: 103/255, alpha: 1).cgColor
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    // MARK: - Actions
    @IBAction func addPoster(_ sender: UIButton) {
        
        let sourceType: UIImagePickerControllerSourceType = .savedPhotosAlbum
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveMovie(_ sender: UIButton) {
        
        presenter?.saveMovie(with: titleTextField.text, overview: overviewTextField.text, releaseDate: releaseDatePicker.date, poster: posterImage.image)
        
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - AddNewMovieSceneProtocol
protocol AddNewMovieSceneProtocol: AnyObject {
    
    
}

extension AddNewMovieViewController: AddNewMovieSceneProtocol {
    
}

// MARK: - UIImagePickerControllerDelegate
extension AddNewMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            posterImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITextFieldDelegate
extension AddNewMovieViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == titleTextField {
            
            overviewTextField.becomeFirstResponder()
        } else {
            
            textField.resignFirstResponder()
        }
        
        return true
    }
}
