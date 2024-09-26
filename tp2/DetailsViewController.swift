//
//  DetailsViewController.swift
//  tp2
//
//  Created by Tekup-mac-10 on 26/9/2024.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var labText: String? // To receive the title
        var imgName: String? // To receive the image name
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lab.text = labText
                if let imageName = imgName {
                    img.image = UIImage(named: imageName)
                }
    }
    



}
