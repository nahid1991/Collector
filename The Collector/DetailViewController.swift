//
//  DetailViewController.swift
//  The Collector
//
//  Created by Nahid on 22/6/19.
//  Copyright © 2019 Nahid. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var item : Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let realItem = item {
            title = realItem.title
            
            if let cellItemImageData = realItem.imageData {
                if let cellItemImage = UIImage(data: cellItemImageData) {
                    imageView?.image = cellItemImage
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
