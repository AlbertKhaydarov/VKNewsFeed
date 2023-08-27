//
//  NewsfeedCodeCell.swift
//  VKNews
//
//  Created by Альберт Хайдаров on 31.07.2023.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String {get}
    var name: String {get}
    var date: String {get}
    var text: String? {get}
    var likes: String? {get}
    var comments: String? {get}
    var shares: String? {get}
    var views: String? {get}
    var photoAttachments: [FeedCellPhotoAttachmentViewModel] {get}
    var sizes: FeedCellSizes {get}
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect {get}
    var attachmentFrame: CGRect {get}
    var bottomViewFrame: CGRect {get}
    var totalHeight: CGFloat {get}
    var moreTextButtonFrame: CGRect {get}
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? {get}
    var width: Int {get}
    var height: Int {get}
}

protocol NewsfeedCodeCellDelegate: AnyObject {
    func revealPost(for cell: NewsfeedCodeCell)
}

final class NewsfeedCodeCell: UITableViewCell {
    
   weak var delegate: NewsfeedCodeCellDelegate?
    
    static let reuseId = "NewsfeedCodeCell"
    
    //first layer
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    //second layer
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var postLabel: UITextView = {
        let textView = UITextView()
        textView.font = Constants.postLabelFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        
        return textView
    }()
    
    private lazy var moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.4012392163, green: 0.6231879592, blue: 0.8316264749, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    
    let gallaryViewCollectionView = GallaryViewCollectionView()
    
    private lazy var postImageView: WebImageView = {
        let imageViwe = WebImageView()
        imageViwe.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3098039216, blue: 0.3294117647, alpha: 1)
        return imageViwe
    }()
    
    private lazy var bottomView: UIView = {
        let bottomView = UIView()
        return bottomView
    }()
    // third layer on topView
    
    private lazy var likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.5960784314, alpha: 1)
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.5960784314, alpha: 1)
        return label
    }()
    
    // fours layer on bottomView
    private lazy var likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .init(named: "like")
        return imageView
    }()
    
    private lazy var commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .init(named: "comment")
        return imageView
    }()
    
    private lazy var sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .init(named: "share")
        return imageView
    }()
    
    private lazy var viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .init(named: "eye")
        return imageView
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.5960784314, alpha: 1)
        return label
    }()
    
    private lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.5960784314, alpha: 1)
        return label
    }()
    
    private lazy var sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.5960784314, alpha: 1)
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.5960784314, alpha: 1)
        return label
    }()
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayerOnTopView()
        overlayThirdLayerOnBottomView()
        overlayFourthLayerOnBottomViewViews()
        
        iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
        //
        
    }
    
    @objc func moreTextButtonTouch() {
        delegate?.revealPost(for: self)
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1{
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            gallaryViewCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachments.count > 1 {
            gallaryViewCollectionView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            gallaryViewCollectionView.isHidden = false
            gallaryViewCollectionView.set(photos: viewModel.photoAttachments)
        } else {
            postImageView.isHidden = true
            gallaryViewCollectionView.isHidden = true
        }
    }
    
    private func overlayFourthLayerOnBottomViewViews(){
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        helpInFourLayer(view: likesView, imageView: likesImage, label: likesLabel)
        helpInFourLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        helpInFourLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        helpInFourLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
    }
    
    private func helpInFourLayer(view: UIView, imageView: UIImageView, label: UILabel){
        //imageView Constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewWiewIconSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewWiewIconSize).isActive = true
        
        //label Constraints
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    private func overlayThirdLayerOnBottomView() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        //likesView Constraints
        likesView.anchor(top: bottomView.topAnchor,
                         leading: bottomView.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeigth)
        )
        //commentsView Constraints
        commentsView.anchor(top: bottomView.topAnchor,
                            leading: likesView.trailingAnchor,
                            bottom: nil,
                            trailing: nil,
                            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeigth)
        )
        //sharesView Constraints
        sharesView.anchor(top: bottomView.topAnchor,
                          leading: commentsView.trailingAnchor,
                          bottom: nil,
                          trailing: nil,
                          size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeigth)
        )
        //viewsView Constraints
        viewsView.anchor(top: bottomView.topAnchor,
                         leading: nil,
                         bottom: nil,
                         trailing: bottomView.trailingAnchor,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeigth)
        )
    }
    
    private func overlayThirdLayerOnTopView() {
        //cardView Constraints
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        // iconImageView Constraints
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // namelabel Constraints
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true
        
        // datelabel Constraints
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(gallaryViewCollectionView)
        cardView.addSubview(bottomView)
        
        // topView Constraints
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // postLabel Constraints
        // не нужно, так как размеры задаются динамически
        
        // moreTextButton Constraints
        // не нужно, так как размеры задаются динамически
        
        // postImageView Constraints
        // не нужно, так как размеры задаются динамически
        
        // bottomView Constraints
        // не нужно, так как размеры задаются динамически
        
    }
    
    private func overlayFirstLayer() {
        
        self.contentView.addSubview(cardView)
        
        //cardView Constraints
        cardView.fillSuperview(padding: Constants.cardInsets)
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
