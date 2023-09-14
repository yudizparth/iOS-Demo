//
//  AddMovieInfoCell.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 21/08/23.
//

import UIKit

class AddMovieInfoCell: UITableViewCell, UIPickerViewDelegate , DataPass, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    class var addInfoCell: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: addInfoCell, bundle: nil) }
    
    var viewController: AddMovieInfoVC?
    var isUpdate : Bool = false
    var i : Int!
    var imageByte: Data!


    @IBOutlet weak var btnMovieList: UIButton!
    @IBOutlet weak var txtLanguage: UITextField!
    @IBOutlet weak var txtGener: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var imgMovie : UIImageView!
    @IBOutlet weak var btnUpdate: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txtLanguage.delegate = self
        txtLanguage.isUserInteractionEnabled = true
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtLanguage.inputView = pickerView
        if ((viewController?.movieList.isEmpty) != nil){
            btnMovieList.isHidden = true
        }
        txtLanguage.inputView = viewController?.languagePickerView
    }
}


extension AddMovieInfoCell {
    
    @IBAction func uploadImage(_ sender: UIButton) {
        viewController?.imagePicker =  UIImagePickerController()
        viewController?.imagePicker.delegate = self
        viewController!.present(viewController!.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func tapToSave(_ sender: UIButton) {
        if (isUpdate){
            let movieDic  = ["movieName" : txtName.text ,"movieGener" : txtGener.text ,"language" : txtLanguage.text]
            DataBaseHelper.sharedInstace.update(object:  (movieDic as? [String : String])!, i: i)
            guard let vc = viewController else {return}

            UIAlertController.showAlert(title: "Update", message: "Data updated Sucessfully.", viewController: vc)
        }else {
            if (!txtName.text!.isEmpty && !txtGener.text!.isEmpty  && !txtLanguage.text!.isEmpty){
                let movieDic  = ["movieName" : txtName.text ?? "","movieGener" : txtGener.text ?? "","language" : txtLanguage.text ?? "", "moviePoster" : imageByte ?? ""] as [String : Any]
                DataBaseHelper.sharedInstace.save(object: (movieDic as? [String : Any])!)
                guard let vc = viewController else {return}
                UIAlertController.showAlert(title: "Save", message: "Data Save Sucessfully.", viewController: vc)
            }else {
                guard let vc = viewController else {return}
                UIAlertController.showAlert(title: "Validation", message: "Please Fill All Detail", viewController: vc)
            }
        }
    }
    
    @IBAction func tapToFlushData(_ sender: UIButton) {
        DataBaseHelper.sharedInstace.clearData()
        guard let vc = viewController else {return}
        UIAlertController.showAlert(title: "Delete ", message: "Data Flush Sucessfully.", viewController: vc)
    }
    
    @IBAction func tapToMovieList(_ sender: UIButton) {
        let vc  : MovieDataVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "movieList") as! MovieDataVC
        vc.delegate = self
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}


extension AddMovieInfoCell : UITextFieldDelegate {
  
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewController?.languagePickerView.isHidden = false
    }
    
    func dataPass(object: [String : Any], index: Int, isEdit: Bool) {
        
        txtLanguage.text = object["language"] as? String
        txtGener.text = object["movieGener"] as? String
        txtName.text = object["movieName"] as? String
//        guard object["movieName"] != nil else {return}
//        if let imageData = object["moviePoster"], let image = UIImage(data: imageData as! Data) {
//            imgMovie?.image = image
//        }
        i = index
        isUpdate = isEdit
        if isEdit {
            btnUpdate.setTitle("Update", for: .normal)
        }else {
            btnUpdate.setTitle("Save", for: .normal)
        }
    }
}

//MARK: - ImagePickerViewDelegete
extension AddMovieInfoCell {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgMovie.image = selectedImage
            if let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                imageByte  = imageData
            }
        }
    }
}
