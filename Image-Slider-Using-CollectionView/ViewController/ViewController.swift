//
//  ViewController.swift
//  Image-Slider-Using-CollectionView
//
//  Created by ADMIN on 09/05/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sliderView: SliderView!
    
    let sliderItems: [SliderItem] = [
        SliderItem(id: "1",
                   itemUrl: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                   image: nil,
                   itemColor: nil,
                   itemTitle: nil,
                   itemDescription: nil),
        SliderItem(id: "1",
                   itemUrl: "https://neilpatel.com/wp-content/uploads/2017/09/image-editing-tools.jpg",
                   image: nil,
                   itemColor: nil,
                   itemTitle: nil,
                   itemDescription: nil),
        SliderItem(id: "1",
                   itemUrl: "https://www.whatsappimages.in/wp-content/uploads/2020/11/Boys-Free-Feeling-Sad-Pics-Images-Download.jpg",
                   image: nil,
                   itemColor: nil,
                   itemTitle: nil,
                   itemDescription: nil),
        SliderItem(id: "1",
                   itemUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png",
                   image: nil,
                   itemColor: nil,
                   itemTitle: nil,
                   itemDescription: nil),
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderView.sliderItems = sliderItems
        sliderView.timeInterval = 2.0
        
    }


}

