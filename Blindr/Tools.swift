//
//  Tools.swift
//  Blindr
//
//  Created by Carson Carbery on 11/28/16.
//  Copyright © 2016 Carson Carbery. All rights reserved.
//

import Foundation
import UIKit

class FaceImages {
    
    static func setUpFaceImages() -> [UIImage] {
        
        var faceImages: [UIImage] = []
        
        for n in 1...8 {
            
            if let faceImageName = UIImage(named: "Face \(n)") {

                faceImages.append(faceImageName)
            }
            
        }
        
        
        return faceImages
        
    }

    
}

