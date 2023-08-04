//
//  NewsfeedPresenter.swift
//  VKNews
//
//  Created by Альберт Хайдаров on 28.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
    var viewController: NewsfeedDisplayLogic?
    
    //MARK: - замена в FeedCellLayoutCalculator на дефолтный инициализатор
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
       let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
        
    }()
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
  
      switch response {

      case .presentNewsfeed(let feed, let revealdedPostIds):
  
          
          let cells = feed.items.map { feedItem in
              cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealdedPostIds: revealdedPostIds)
          }
          let footerTitle = String.localizedStringWithFormat(NSLocalizedString("newsFeed cells count", comment: ""), cells.count)
          let feedViewModel = FeedViewModel.init(cells: cells, footerTitle: footerTitle)
          viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayNewsfeed(feedViewModel: feedViewModel))
     
      case .presentUserInfo(user: let user):
          let userViewModel = UserViewModel(photoUrlString: user?.photo100)
          viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayUser(userViewModel: userViewModel))
      case .presentFooterLoader:
          viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayFooterLoader)
      }
      
  }
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealdedPostIds: [Int]) -> FeedViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        
        let data = Date(timeIntervalSince1970: feedItem.date)
        let dataTitle = dateFormatter.string(from: data)
        
        let isFullSized = revealdedPostIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
       
        }
        //let isFullSized = revealdedPostIds.contains(feedItem.postId) // краткий вариант записи
     
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
 
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dataTitle,
                                       text: postText,
                                       likes: formattedCounter(feedItem.likes?.count),
                                       comments: formattedCounter(feedItem.comments?.count),
                                       shares: formattedCounter(feedItem.reposts?.count),
                                       views: formattedCounter(feedItem.views?.count),
                                       photoAttachments: photoAttachments,
                                       sizes: sizes)
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else {return nil}
        var counterString = String(counter)
        if 4...6 ~= counterString.count{
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "K"
        }
        return counterString
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentrable{
        let profileOrGroups: [ProfileRepresentrable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profileOrGroups.first { myProfileRepresentable in
            myProfileRepresentable.id == normalSourceId
        }
        return profileRepresentable!
    }
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ attachment in
            attachment.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBIG,
                                                          width: firstPhoto.width,
                                                          height: firstPhoto.height)
    }
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment]{
        guard let attachments = feedItem.attachments else {return []}
        return attachments.compactMap( { attachment -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else {return nil}
            return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: photo.srcBIG,
                                                              width: photo.width,
                                                              height: photo.height)
        })
    }
}
