//
//  ChatMessageCell.swift
//  ChatPlayground
//
//  Created by David Salzer on 18/10/2020.
//

import UIKit

class ChatMessageCell: UITableViewCell {
    
    let timeLabel = UILabel()
    let nameLabel = UILabel()
    let profileImageView = RoundImageView()
    let bubbleView = CustomRoundedCornerRectangle()
    let stackView = UIStackView()
    let contentImageView = UIImageView()
    let messageLabel = UILabel()
    
    var contentImageHeightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() -> Void {
        
        [timeLabel, nameLabel, profileImageView, bubbleView, stackView, contentImageView, messageLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // MARK: add cell elements
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(bubbleView)

        bubbleView.addSubview(stackView)
        
        stackView.addArrangedSubview(contentImageView)
        stackView.addArrangedSubview(messageLabel)

        // MARK: cell element constraints
        
        // make constraints relative to the default cell margins
        let g = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            
            // timeLabel Top: 0 / Leading: 20
            timeLabel.topAnchor.constraint(equalTo: g.topAnchor, constant: 0.0),
            timeLabel.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
            
            // nameLabel Top: 0 / Trailing: 30
            nameLabel.topAnchor.constraint(equalTo: g.topAnchor, constant: 0.0),
            nameLabel.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -30.0),
            
            // profile image
            //  Top: bubbleView.top + 6
            profileImageView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 6.0),
            //  Trailing: 0 (to contentView margin)
            profileImageView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: 0.0),
            //  Width: 50 / Height: 1:1 (to keep it square / round)
            profileImageView.widthAnchor.constraint(equalToConstant: 50.0),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            
            // bubbleView
            //  Top: timeLabel.bottom + 4
            bubbleView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4.0),
            //  Leading: timeLabel.leading + 16
            bubbleView.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: 16.0),
            //  Trailing: profile image.leading - 4
            bubbleView.trailingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: -4.0),
            //  Bottom: contentView.bottom
            bubbleView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 0.0),
            
            // stackView (to bubbleView)
            //  Top / Bottom: 12
            stackView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 12.0),
            stackView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -12.0),
            //  Leading / Trailing: 16
            stackView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 16.0),
            stackView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -16.0),

        ])
        
        // contentImageView height ratio - will be changed based on the loaded image
        // we need to set its Priority to less-than Required or we get auto-layout warnings when the cell is reused
        contentImageHeightConstraint = contentImageView.heightAnchor.constraint(equalTo: contentImageView.widthAnchor, multiplier: 2.0 / 3.0)
        contentImageHeightConstraint.priority = .defaultHigh
        contentImageHeightConstraint.isActive = true

        // messageLabel minimum Height: 40
        // we need to set its Priority to less-than Required or we get auto-layout warnings when the cell is reused
        let c = messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40.0)
        c.priority = .defaultHigh
        c.isActive = true
        
        // MARK: element properties
        
        stackView.axis = .vertical
        stackView.spacing = 6
        
        // set label fonts and alignment here
        timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        timeLabel.textColor = .gray
        nameLabel.textColor = UIColor(red: 0.175, green: 0.36, blue: 0.72, alpha: 1.0)
        
        // for now, I'm just setting the message label to right-aligned
        //  likely using RTL
        messageLabel.textAlignment = .right
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        
        contentImageView.backgroundColor = .blue
        contentImageView.contentMode = .scaleAspectFit
        contentImageView.layer.cornerRadius = 8
        contentImageView.layer.masksToBounds = true
        
        profileImageView.contentMode = .scaleToFill
        
        // MARK: cell background
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    func fillData(_ msg: MyMessageStruct, isSameAuthor: Bool) -> Void {
        timeLabel.text = msg.time
        nameLabel.text = msg.name
        
        nameLabel.isHidden = isSameAuthor
        profileImageView.isHidden = isSameAuthor
        
        if !isSameAuthor {
            if !msg.profileImageName.isEmpty {
                if let img = UIImage(named: msg.profileImageName) {
                    profileImageView.image = img
                }
            }
        }
        if !msg.contentImageName.isEmpty {
            contentImageView.isHidden = false
            if let img = UIImage(named: msg.contentImageName) {
                contentImageView.image = img
                let ratio = img.size.height / img.size.width
                contentImageHeightConstraint.isActive = false
                contentImageHeightConstraint = contentImageView.heightAnchor.constraint(equalTo: contentImageView.widthAnchor, multiplier: ratio)
                contentImageHeightConstraint.priority = .defaultHigh
                contentImageHeightConstraint.isActive = true
            }
        } else {
            contentImageView.isHidden = true
        }
        messageLabel.text = msg.message
    }
}
