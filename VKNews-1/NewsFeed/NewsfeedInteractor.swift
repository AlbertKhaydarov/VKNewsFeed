//
//  NewsfeedInteractor.swift
//  VKNews
//
//  Created by Альберт Хайдаров on 28.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
    
    var presenter: NewsfeedPresentationLogic?
    var service: NewsfeedService?
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        switch request {
            
        case .getNewsFeed:
            service?.getFeed(completion: { [weak self] revealedPostIds, feed in
                self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsfeed(feed: feed, revealdedPostIds: revealedPostIds))
            })
        case .revealPostIds(postId: let postId):
            service?.revealedPostIds(forPostId: postId, completion: { [weak self] revealedPostIds, feed in
                self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsfeed(feed: feed, revealdedPostIds: revealedPostIds))
            })
      
        case .getUser:
            service?.getUser(completion: { [weak self] user in
                self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentUserInfo(user: user))
            })
        case .getNextBatch:
            self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentFooterLoader)
            service?.getNextBatch(completion: { revealedPostIds, feed in
                self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsfeed(feed: feed, revealdedPostIds: revealedPostIds))
            })
        }
        
    }
}
