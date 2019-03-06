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

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var classificationResults : [VNClassificationObservation] = []
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

