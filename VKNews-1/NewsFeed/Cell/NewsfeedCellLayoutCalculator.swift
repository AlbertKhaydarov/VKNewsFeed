//
//  NewsfeedCellLayoutCalculator.swift
//  VKNews
//
//  Created by Альберт Хайдаров on 30.07.2023.
//

import Foundation
import UIKit

struct Sizes: FeedCellSizes {
    var bottomViewFrame: CGRect
    var moreTextButtonFrame: CGRect
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    var totalHeight: CGFloat
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    //MARK: - замена на дефолтный инициализатор
    //    init(screenWidth: CGFloat) {
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //MARK: work with "postlabelFrame"
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top),
                                    size: .zero)
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.heigth(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            
            if !isFullSizedPost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: - work with moreTextButtonFrame
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        // MARK: - work with attachmentFrame
        
        let attachmentTop = postLabelFrame.size == .zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
                                     size: CGSize.zero)
        
        //        if let attachment = photoAttachment {
        //            let photoHeigth: Float = Float(attachment.heigth)
        //            let photoWidth: Float = Float(attachment.width)
        //
        //            let ratio: CGFloat = CGFloat(photoHeigth / photoWidth)
        //            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        //        }
        if let attachment = photoAttachments.first{
            let photoHeight: Float = Float(attachment.height)
            let photoWidth: Float = Float(attachment.width)
            let ratio: CGFloat = CGFloat(photoHeight / photoWidth)
            if  photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio )
//                attachmentFrame.size = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height) )
             
            } else if photoAttachments.count > 1 {
//
                var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                    photos.append(photoSize)
                }
                let rowHeight = RowCollectionViewLayout.rowHeightCounter(superViewWidth: cardViewWidth, photosArray: photos)
                attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeight!)
                
            }
        }
        
        
        // MARK: - work with bottomViewFrame
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeigth))
        
        // MARK: - work with totalHeight
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(bottomViewFrame: bottomViewFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame,
                     totalHeight: totalHeight)
    }
    
}
