//
//  ViewController.swift
//  PhotoDetector
//
//  Created by Madwor1d3 on 06/03/2019.
//  Copyright © 2019 Madwor1d3. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Social
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var resultSound = SoundModel()
    
    private var classificationResults : [VNClassificationObservation] = []
    
    private let imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    func detect(image: CIImage) {
        
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("can't load ML model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first
                else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            if topResult.identifier.contains("cat") {
                DispatchQueue.main.async {
                    self.navigationItem.title = "It's a cat!!"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.resultSound.playSound(soundFileName: self.resultSound.soundArray[0])
                }
            }
            else {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Not cat :(!"
                    self.navigationController?.navigationBar.barTintColor = UIColor.red
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.resultSound.playSound(soundFileName: self.resultSound.soundArray[1])
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do { try handler.perform([request]) }
        catch { print(error) }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            
            imageView.image = image
            imagePicker.dismiss(animated: true, completion: nil)
            guard let ciImage = CIImage(image: image) else {
                fatalError("couldn't convert uiimage to CIImage")
            }
            detect(image: ciImage)
        }
    }
    

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
}


fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
