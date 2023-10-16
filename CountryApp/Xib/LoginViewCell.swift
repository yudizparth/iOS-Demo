//
//  LoginViewCell.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 05/09/23.
//

import UIKit

class LoginViewCell: UITableViewCell{
    
    var buttonTapCallback: (() -> Void)?
    
    lazy var countryPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor =   UIColor(named: "BackgroundColor")
        return pickerView
    }()
    
    typealias Handler = (Bool) -> Void
    
    var counrtyData : [CountryData] = []
    class var loginCell: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: loginCell, bundle: nil) }
    
    @IBOutlet weak var lblLogintxt: UILabel!
    @IBOutlet weak var contryCodeTxt : UITextField!
    @IBOutlet weak var mobileNumberTxt : UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadPickerDataFromJSON()
        configureTextField()
        lblLogintxt.text =  AppHelper.shared.getLocalizeString(str: "We will send you OTP by SMS to verify your Number.")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


//MARK: - Delegate PickerView
extension LoginViewCell : UIPickerViewDataSource , UIPickerViewDelegate{
    func loadPickerDataFromJSON() {
        if let path = Bundle.main.path(forResource: "CountryCodes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]]
                
                if let jsonArray = jsonArray {
                    for dict in jsonArray {
                        counrtyData.append(CountryData(dict: dict as NSDictionary))
                    }
                    debugPrint(counrtyData.count)
                }
            } catch {
                print("Error loading data from JSON: \(error)")
            }
        }
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return counrtyData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return counrtyData[row].countryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        contryCodeTxt.text = counrtyData[row].code
    }
    
}

//MARK: - TextField
extension LoginViewCell : UITextFieldDelegate{
    func configureTextField() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
        toolbar.barStyle = .default

        contryCodeTxt.inputAccessoryView = toolbar
        contryCodeTxt.inputView = countryPicker
    }
    
    @objc func doneButtonTapped() {
        contryCodeTxt.resignFirstResponder()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mobileNumberTxt{
            buttonTapCallback?()
            textField.resignFirstResponder()
            return true
        }
        
        return true
    }
}

//MARK: - Actions
extension LoginViewCell {
    @IBAction func tapToHomeScreen ( _ sender : UIButton){
        buttonTapCallback?()
    }
}
