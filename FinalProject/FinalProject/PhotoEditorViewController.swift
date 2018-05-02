//
//  PhotoEditorViewController.swift
//  FinalProject
//
//  Created by Aleks on 4/28/18.
//  Copyright © 2018 Aleks. All rights reserved.
//

import UIKit

class PhotoEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var MainCanvas: UIImageView!
    var viewsArray: [UIImageView] = []
    let imagePicker = UIImagePickerController()
    @IBAction func LibraryTapped(_ sender: UIBarButtonItem) {
        getImageFromLibrary()
    }
    @IBAction func CameraTapped(_ sender: UIBarButtonItem) {
        getImageFromLibrary()
    }
    @IBAction func UndoTapped(_ sender: UIBarButtonItem) {
    }
    @IBAction func SaveTapped(_ sender: UIBarButtonItem) {
    }
    @IBAction func DeleteTapped(_ sender: UIBarButtonItem) {
        //THROW PROMPT TO CONFIRM
        for imageView in viewsArray{
            imageView.removeFromSuperview()
        }
    }
    
    func getImageFromLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }else
        {
            print("UIImagePicker SourceType PhotoLibrary Unavailable")
        }
    }
    
    func getImageFromCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("got here 2")
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }else
        {
            print("UIImagePicker SourceType Camera Unavailable")
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let edittedSelection = info[UIImagePickerControllerEditedImage] as? UIImage{
            addImageToCanvas(edittedSelection, true)
        } else if let selection = info[UIImagePickerControllerOriginalImage] as? UIImage{
            addImageToCanvas(selection, true)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let edittedSelection = info[UIImagePickerControllerEditedImage] as? UIImage{
//            addImageToCanvas(edittedSelection, true)
//        } else if let selection = info[UIImagePickerControllerOriginalImage] as? UIImage{
//            addImageToCanvas(selection, true)
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func addImageToCanvas(_ image: UIImage, _ background: Bool){
        if(background){
            let imageView = UIImageView(image: image)
            imageView.isUserInteractionEnabled = true
            //AddGesturesHere
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: 0, y: 0, width: self.MainCanvas.frame.width, height: self.MainCanvas.frame.height)
            //            imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            viewsArray.append(imageView)
            self.MainCanvas.addSubview(imageView)//view.addSubview(imageView)
            self.MainCanvas.bringSubview(toFront: imageView)//view.bringSubview(toFront: imageView)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
