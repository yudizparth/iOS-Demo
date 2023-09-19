//
//  AnimationVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 19/09/23.
//

import UIKit

class AnimationVC: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension AnimationVC : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animationCell") as! AnimatedCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //UIScreen.main.bounds.height
        return tableView.frame.height
    }
}

//MARK: - Actions
extension AnimationVC {
    @IBAction func tapToBack(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - TableViewCell
class AnimatedCell : UITableViewCell {
    
    @IBOutlet weak var animnatedTxt: UITextField!
    @IBOutlet weak var animatedButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonAnimation()
        animatedTextField()
    }
    
}

//MARK: - Add - Animation
extension AnimatedCell {
    func buttonAnimation() {
        let buttonWidth: CGFloat = 60
        UIView.animate(withDuration: 2.0 ) {
            self.animatedButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonWidth)
            self.animatedButton.center = self.contentView.center
        }
    }
    
    func animatedTextField(){
        animnatedTxt.alpha = 0
        let transform  = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        animnatedTxt.layer.transform = transform
        UIView.animate(withDuration: 1.0) {
            self.animnatedTxt.alpha = 1.0
            self.animnatedTxt.layer.transform = CATransform3DIdentity
        }
    }
}

//MARK: - Actions
extension AnimatedCell {
    
    @IBAction func tapToAnimateButton(_ sender: UIButton) {
        let newButtonWidth: CGFloat = 60
        UIView.animate(withDuration: 3.0,
                       delay: 0.0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 1,
                       options: UIView.AnimationOptions.curveEaseInOut,
                       animations: {
            self.animatedButton.frame = CGRect(x: 0, y: 0, width: newButtonWidth, height: newButtonWidth)
            self.animatedButton.center =  self.contentView.center
        },completion: nil)
    }
    
}
