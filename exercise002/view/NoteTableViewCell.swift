//
//  NoteTableViewCell.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit
import SnapKit

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
        noteImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(noteImageView.snp.width)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(settingImageView)
        settingImageView.image = UIImage(systemName: "slider.horizontal.3")
        settingImageView.contentMode = .scaleAspectFill
        settingImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(settingImageView.snp.width)
        }

        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalTo(settingImageView).offset(-30)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
}

