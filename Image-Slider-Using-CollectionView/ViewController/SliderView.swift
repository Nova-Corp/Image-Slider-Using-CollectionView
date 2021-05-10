//
//  SliderView.swift
//  Image-Slider-Using-CollectionView
//
//  Created by ADMIN on 09/05/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

struct SliderItem {
    let id: String
    let itemUrl: String
    let image: UIImage?
    let itemColor: String?
    let itemTitle: String?
    let itemDescription: String?
    
}

class SliderView: UIView {
    
    var timeInterval: Double! = 2.0
    
    var sliderItems: [SliderItem]! = [SliderItem]() {
        didSet{
            pageControl.numberOfPages = sliderItems.count
        }
    }
    
    private var currentSlide: Int! = 0 {
        didSet{
            let indexPath: IndexPath = IndexPath(item: currentSlide, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentSlide
        }
    }
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    
    // MARK:- Configure CollectionView
    private let collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
        
    }()
    
    //MARK:- Control Buttons
    private let leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        
    }
    // MARK:- Configuration
    private func configureView() {
        backgroundColor = .white
        
        // CollectionView Delegate
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.frame = frame
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        collectionView.register(SliderImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: SliderImageCollectionViewCell.identifier)
        
        addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        //MARK:- Configure Control Button
        
        addSubview(leftButton)
        NSLayoutConstraint.activate([
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            leftButton.widthAnchor.constraint(lessThanOrEqualToConstant: 60),
            leftButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        addSubview(rightButton)
        NSLayoutConstraint.activate([
            rightButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            rightButton.widthAnchor.constraint(lessThanOrEqualToConstant: 60),
            rightButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        leftButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        
        Timer.scheduledTimer(timeInterval: timeInterval,
                             target: self,
                             selector: #selector(didTapRightButton),
                             userInfo: nil,
                             repeats: true)
        
        
        
    }
    
    @objc private func didTapLeftButton() {
        if currentSlide == 0 {
            currentSlide = sliderItems.count - 1
        }else{
            currentSlide -= 1
        }
    }
    
    @objc private func didTapRightButton() {
        if sliderItems.count > currentSlide + 1 {
            currentSlide += 1
        }else{
            currentSlide = 0
        }
    }
}

extension SliderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sliderItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderImageCollectionViewCell.identifier,
                                                      for: indexPath) as! SliderImageCollectionViewCell
        
        cell.itemView.setImage(from: sliderItems[indexPath.item].itemUrl, contentMode: .scaleAspectFill)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        frame.size
    }
}

class SliderImageCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "SliderImageCollectionViewCell"
    
    let itemView: SlideImageView = {
        let itemView = SlideImageView()
        itemView.translatesAutoresizingMaskIntoConstraints = false
        return itemView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        addSubview(itemView)
        
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: topAnchor),
            itemView.bottomAnchor.constraint(equalTo: bottomAnchor),
            itemView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}



class SlideImageView: UIImageView {
    private let imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    func setImage(from url: URL,
                  contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        contentMode = mode
        if let imageCached = imageCache.object(forKey: url.absoluteString as NSString) {
            image = imageCached
            return
        }else{
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                    self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                }
            }.resume()
        }
    }
    func setImage(from link: String,
                  contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        setImage(from: url, contentMode: mode)
    }
}
