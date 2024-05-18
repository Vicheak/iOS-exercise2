//
//  NoteTableViewCell.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    let noteImageView = UIImageView()
    let settingImageView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews(){
        contentView.addSubview(noteImageView)
        noteImageView.image = UIImage(systemName: "note.text")
        noteImageView.contentMode = .scaleAspectFill
        noteImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noteImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            noteImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            noteImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            noteImageView.heightAnchor.constraint(equalTo: noteImageView.widthAnchor)
        ])
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: noteImageView, attribute: .left, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 20)
        ])
        
        contentView.addSubview(settingImageView)
        settingImageView.image = UIImage(systemName: "slider.horizontal.3")
        settingImageView.contentMode = .scaleAspectFill
        settingImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            settingImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            settingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            settingImageView.heightAnchor.constraint(equalTo: settingImageView.widthAnchor)
        ])

        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: detailLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: detailLabel, attribute: .right, relatedBy: .equal, toItem: settingImageView, attribute: .right, multiplier: 1, constant: -30),
            NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: detailLabel, attribute: .bottom, multiplier: 1, constant: 20)
        ])

    }
    
}

