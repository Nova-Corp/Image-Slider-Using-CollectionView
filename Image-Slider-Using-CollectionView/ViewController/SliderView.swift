//
//  SliderView.swift
//  Image-Slider-Using-CollectionView
//
//  Created by ADMIN on 09/05/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

struct Item {
    let id: String
    let itemUrl: String
    let itemColor: String?
    let itemTitle: String?
    let itemDescription: String?
    
}

class SliderView: UIView {
    
    let items: [Item] = [
        Item(id: "0", itemUrl: "", itemColor: nil, itemTitle: nil, itemDescription: nil),
        Item(id: "1", itemUrl: "", itemColor: nil, itemTitle: nil, itemDescription: nil),
        Item(id: "2", itemUrl: "", itemColor: nil, itemTitle: nil, itemDescription: nil),
    ]
    
    // MARK:- Configure CollectionView
    let collectionView: UICollectionView = {
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
    let leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    
    let rightButton: UIButton = {
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
    func configureView() {
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
        
        let pageControl: UIPageControl = {
            let pageControl = UIPageControl()
            pageControl.numberOfPages = items.count
            pageControl.isUserInteractionEnabled = false
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            return pageControl
        }()
        
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
        
    }
    
    @objc func didTapLeftButton() {
        
    }
    
    @objc func didTapRightButton() {
        
    }
    
}

extension SliderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderImageCollectionViewCell.identifier,
                                                      for: indexPath) as! SliderImageCollectionViewCell
        
        switch indexPath.item {
        case 0:
            cell.backgroundColor = .lightGray
        case 1:
            cell.backgroundColor = .green
        default:
            cell.backgroundColor = .blue
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        frame.size
    }
}

class SliderImageCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "SliderImageCollectionViewCell"
    
    lazy var itemView: UIImageView = {
        let itemView = UIImageView()
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
    
    func configureView() {
        addSubview(itemView)
        
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: topAnchor),
            itemView.bottomAnchor.constraint(equalTo: bottomAnchor),
            itemView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
