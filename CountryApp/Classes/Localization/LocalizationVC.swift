//
//  LocalizationViewController.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 13/09/23.
//

import UIKit

class LocalizationVC: UIViewController {
 
    @IBOutlet weak var selectedLanguageLbl: UILabel!
    @IBOutlet weak var toolBar : UIToolbar!
    @IBOutlet weak var languagePicker: UIPickerView!
    var selectedLanguage: String = ""
    var dictLanguage = [String:String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapToSelect(_ sender : UIButton) {
        toolBar.isHidden = false
        languagePicker.isHidden =  false
    }
    
    @IBAction func tapToDone(_ sender: UIBarButtonItem) {
        toolBar.isHidden = true
        languagePicker.isHidden =  true
    }
    
}

extension LocalizationVC {
    @IBAction func  tapToBack(_ sender : UIButton){
        navigationController?.popViewController(animated: true)
    }
}


extension LocalizationVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return languageList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languageList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        languagePicker.tag = row
        AppHelper.shared.setLanguage(languageList[row].code)
        selectedLanguageLbl.text = AppHelper.shared.getLocalizeString(str: "Pick Language")
    }

}



