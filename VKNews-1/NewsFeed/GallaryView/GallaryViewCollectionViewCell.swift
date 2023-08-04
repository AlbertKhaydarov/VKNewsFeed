//
//  GallaryViewCollectionViewCell.swift
//  VKNews-1
//
//  Created by Admin on 02.08.2023.
//

import UIKit

class GallaryViewCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "GallaryViewCollectionViewCell"
    
    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myImageView)
        backgroundColor = .systemBlue
        
//        myImageView constraints
        myImageView.fillSuperview()
    }
    
    
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    func set(imageUrl: String?){
        myImageView.set(imageURL: imageUrl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 2.5, height: 4)
            
    }

    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
