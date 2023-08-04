//
//  GallaryViewCollectionView.swift
//  VKNews-1
//
//  Created by Admin on 02.08.2023.
//

import UIKit

class GallaryViewCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var photos = [FeedCellPhotoAttachmentViewModel]()
    
    init() {
        let rowLayout = RowCollectionViewLayout()
        super.init(frame: .zero, collectionViewLayout: rowLayout)
        delegate = self
        dataSource = self
        
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        register(GallaryViewCollectionViewCell.self, forCellWithReuseIdentifier: GallaryViewCollectionViewCell.reusedId)
        
        if let rowLayout = collectionViewLayout as? RowCollectionViewLayout {
            rowLayout.delegate = self
        }
    }
    
    func set(photos: [FeedCellPhotoAttachmentViewModel]){
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = dequeueReusableCell(withReuseIdentifier: GallaryViewCollectionViewCell.reusedId, for: indexPath) as! GallaryViewCollectionViewCell
        cell.set(imageUrl: photos[indexPath.row].photoUrlString)
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension GallaryViewCollectionView: RowLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let heigth = photos[indexPath.row].height
        return CGSize(width: width, height: heigth)
    }
    
    
}
