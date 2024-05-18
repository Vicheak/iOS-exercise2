//
//  NoteCollectionViewCell.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class FolderCollectionViewCell: UICollectionViewCell {

    let folderImageView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUpViews(){
        contentView.addSubview(folderImageView)
        folderImageView.image = UIImage(systemName: "folder.fill")
        folderImageView.contentMode = .scaleAspectFit
        folderImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            folderImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            folderImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            folderImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            folderImageView.heightAnchor.constraint(equalTo: folderImageView.widthAnchor)
        ])
        
        contentView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: contentView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 5),
        ])
//        titleLabel.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        
//        contentView.addSubview(detailLabel)
//        detailLabel.textAlignment = .center
//        detailLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            NSLayoutConstraint(item: detailLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 5),
//            NSLayoutConstraint(item: detailLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 5),
//            NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: detailLabel, attribute: .bottom, multiplier: 1, constant: 5),
//            NSLayoutConstraint(item: contentView, attribute: .right, relatedBy: .equal, toItem: detailLabel, attribute: .right, multiplier: 1, constant: 5)
//        ])
//        detailLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
}
