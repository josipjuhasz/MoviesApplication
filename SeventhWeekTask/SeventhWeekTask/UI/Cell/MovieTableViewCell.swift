//
//  MovieTableViewCell.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 04.07.2021..
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

class MovieTableViewCell: UITableViewCell{
    
    let cellView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1).cgColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand-Bold", size: 20)
        label.textColor = .white
        return label
    }()
    
    let groupsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand-Regular", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand-Bold", size: 20)
        label.textColor = .white
        return label
    }()
    
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let buttonChecked: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red: 0.475, green: 0.729, blue: 0.757, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        return button
    }()
    
    let buttonFavorite: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red: 0.475, green: 0.729, blue: 0.757, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.addBlackGradientLayerInBackground(colors: [.clear ,UIColor.init(white: 0, alpha: 0.9)])
    }
    
    func configureCell(movieName: String, groupNames: String, imageUrl: String, date: String, check: Bool, favorite: Bool) {
        movieTitleLabel.text = movieName
        groupsLabel.text = groupNames
        movieImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w185\(imageUrl)"))
        dateLabel.text = String(date.prefix(4))
        setupButtons(check: check, favorite: favorite)
    }
}

private extension MovieTableViewCell {
    
    func setupUI() {
        contentView.addSubview(cellView)
        contentView.backgroundColor = UIColor(red: 0.221, green: 0.221, blue: 0.221, alpha: 1)
        cellView.addSubview(movieTitleLabel)
        cellView.addSubview(groupsLabel)
        cellView.addSubview(movieImageView)
        cellView.addSubview(dateLabel)
        cellView.addSubview(buttonChecked)
        cellView.addSubview(buttonFavorite)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        cellView.snp.makeConstraints{ (make) -> Void in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(155)
            make.bottom.equalToSuperview().priority(.low)
            
        }
        
        movieImageView.snp.makeConstraints{ (make) -> Void in
            make.top.leading.equalToSuperview()
            make.width.height.equalTo(155)
        }
        
        movieTitleLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(14)
            make.leading.equalTo(movieImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
        }
        
        groupsLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(movieTitleLabel.snp.bottom)
            make.leading.equalTo(movieImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalTo(movieImageView.snp.centerX)
            make.bottom.equalTo(movieImageView).offset(-5)
        }
        
        buttonChecked.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalToSuperview().offset(-15)
            make.trailing.equalToSuperview().offset(-90)
        }
        
        buttonFavorite.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalToSuperview().offset(-15)
            make.trailing.equalToSuperview().offset(-30)
        }
        
    }
    
    func setupButtons(check: Bool, favorite: Bool){
        
        if check {
            buttonChecked.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        }else {
            buttonChecked.setImage(UIImage(systemName: "checkmark.seal"), for: .normal)
        }
        
        if favorite {
            buttonFavorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else {
            buttonFavorite.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}


