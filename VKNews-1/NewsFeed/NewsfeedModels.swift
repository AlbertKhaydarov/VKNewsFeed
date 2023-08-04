//
//  NewsfeedModels.swift
//  VKNews
//
//  Created by Альберт Хайдаров on 28.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Newsfeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
                case revealPostIds(postId: Int)
                case getUser
                case getNextBatch
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsfeed(feed: FeedResponse, revealdedPostIds: [Int])
                case presentUserInfo(user: UserResponse?)
                case presentFooterLoader
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayNewsfeed(feedViewModel: FeedViewModel)
                case displayUser(userViewModel: UserViewModel)
                case displayFooterLoader
                
            }
        }
    }
    
}

struct UserViewModel: TitleViewViewModel {
    var photoUrlString: String?
    
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        
        var postId: Int
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
        var sizes: FeedCellSizes
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    
    let cells: [Cell]
    let footerTitle: String?
}
