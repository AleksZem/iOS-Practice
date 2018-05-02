//
//  MemeSelectorViewController.swift
//  FinalProject
//
//  Created by Aleks on 5/1/18.
//  Copyright © 2018 Aleks. All rights reserved.
//

import UIKit

class MemeSelectorViewController: UIViewController, UIGestureRecognizerDelegate {

    var selectedImage: String = ""
    var imageViews: [UIImageView] = []
    let images: [String] = ["2b4.png","3c5.png","6dc.png","12d.png","020.png","29e.png","85b.png","252.png","590.png","af6.png","b57.png","b71.png","d4d.png"]
    
    func addGesturesToImageViews(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.delegate = self;
        let subViews = self.view.subviews
        for image in subViews{
            image.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func handleTapGesture(_ sender: UITapGestureRecognizer){
        if let imageView = sender.view as? UIImageView{
            selectedImage = images[imageViews.index(of: imageView)!]
        }
        print(selectedImage)
        performSegue(withIdentifier: "unwindToMemePage", sender: self)
    }
    
    func addTapGestureTo(_ image: UIImageView){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.delegate = self;
        image.addGestureRecognizer(tapGesture)
        print("adding tap gesture")
    }
    
    func addImagesToViews(){
        var index: Int = 0
        for view in self.view.subviews{
            let imageView = view as? UIImageView
            imageView!.isUserInteractionEnabled = true
            addTapGestureTo(imageView!)
            imageView?.image = UIImage(named: images[index])
            imageViews.append(imageView!)
            index += 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addImagesToViews()
//        addGesturesToImageViews()
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
