//
//  MemeEditorViewController.swift
//  FinalProject
//
//  Created by Aleks on 4/28/18.
//  Copyright © 2018 Aleks. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var canvasImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasImageView.contentMode = .scaleAspectFit
        canvasImageView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addGesturesToImageView(_ image: UIImageView){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.delegate = self;
        image.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func handleTapGesture(_ sender: UITapGestureRecognizer){
        if let imageView = sender.view as? UIImageView{
            let point = sender.location(in: imageView)
            let textField = UITextField(frame: CGRect(x: point.x, y: point.y, width: 200, height: 50))
            textField.placeholder = "Type here"
            textField.textColor = UIColor.black
            textField.autocorrectionType = UITextAutocorrectionType.no
            textField.keyboardType = UIKeyboardType.default
            textField.returnKeyType = UIReturnKeyType.done
            textField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
            textField.delegate = self
            imageView.addSubview(textField)
        }
    }
//////////////////////
    
    func addPanGestureToTextField(_ textField: UITextField){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGesture.delegate = self;
        textField.addGestureRecognizer(panGesture)
    }

    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer){
        if let textField = sender.view as? UITextField{
            if(sender.state == .changed){
                let panPoint = sender.translation(in: self.canvasImageView)
                let zero = CGPoint(x:0,y:0)
                textField.transform = textField.transform.translatedBy(x: panPoint.x, y: panPoint.y)
                sender.setTranslation(zero, in: self.canvasImageView)
            }
        }
    }
    
/////////////////////
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func unwindToMemePage(_ sender: UIStoryboardSegue){
        let sourceVC = sender.source as! MemeSelectorViewController
//        print("Returned: \(sourceVC.selectedImage)")
        canvasImageView.image = UIImage(named: sourceVC.selectedImage)
        addGesturesToImageView(canvasImageView)
    }
    
//    {
//        let sourceVC = sender.source as! MemeSelectorViewController
//    }


}
