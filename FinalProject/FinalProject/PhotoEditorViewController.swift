//
//  PhotoEditorViewController.swift
//  FinalProject
//
//  Created by Aleks on 4/28/18.
//  Copyright © 2018 Aleks. All rights reserved.
//

import UIKit

class PhotoEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

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
        //FOR NOW JUST REMOVE THE TOP IMAGEVIEW, IMPLEMENT ACTION UNDO (Command Pattern?)
        viewsArray.popLast()?.removeFromSuperview()
    }
    @IBAction func SaveTapped(_ sender: UIBarButtonItem) {
    }
    @IBAction func DeleteTapped(_ sender: UIBarButtonItem) {
        deleteAlert()
    }
    
    func deleteAlert(){
        let alert = UIAlertController(title: "Delete entire canvas?", message: "This will delete the entire canvas", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "confirm", style: .destructive, handler: handleConfirmDelete)
        let declineAction = UIAlertAction(title: "decline", style: .cancel, handler: handleDeclineDelete)
        alert.addAction(confirmAction)
        alert.addAction(declineAction)
        present(alert, animated: true, completion: nil)
    }
    
    func handleConfirmDelete(_ action: UIAlertAction){
        for imageView in viewsArray{
            imageView.removeFromSuperview()
        }
        viewsArray.removeAll()
    }
    func handleDeclineDelete(_ action: UIAlertAction){}
    
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
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func addImageToCanvas(_ image: UIImage, _ background: Bool){
        if(background){
            let imageView = UIImageView(image: image)
            imageView.isUserInteractionEnabled = true
            addGesturesToImageView(imageView)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: 0, y: 0, width: self.MainCanvas.frame.width, height: self.MainCanvas.frame.height)
            //            imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            viewsArray.append(imageView)
            self.MainCanvas.addSubview(imageView)//view.addSubview(imageView)
            self.MainCanvas.bringSubview(toFront: imageView)//view.bringSubview(toFront: imageView)
        }
        
        
    }
    
    func addGesturesToImageView(_ image: UIImageView){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGesture.delegate = self;
        image.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        pinchGesture.delegate = self;
        image.addGestureRecognizer(pinchGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.delegate = self;
        image.addGestureRecognizer(tapGesture)
    }
    
    @objc func handlePinchGesture(_ sender: UIPinchGestureRecognizer){
        if let imageView = sender.view as? UIImageView{
            if(sender.state == .changed){
                imageView.transform = imageView.transform.scaledBy(x: sender.scale, y: sender.scale)
            }
        }
    }
    
    @objc func handleTapGesture(_ sender: UITapGestureRecognizer){
        
    }
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer){
        if let imageView = sender.view as? UIImageView{
            if(sender.state == .began){
                self.MainCanvas.bringSubview(toFront: imageView)
            }
            if(sender.state == .changed){
                let panPoint = sender.translation(in: self.MainCanvas)
                let zero = CGPoint(x:0,y:0)
                imageView.transform = imageView.transform.translatedBy(x: panPoint.x, y: panPoint.y)
                sender.setTranslation(zero, in: self.MainCanvas)
            }
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
