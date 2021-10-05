//
//  PlayerCollectionCell.swift
//  CombineDemo
//
//  Created by Michal Cichecki on 30/06/2019.
//

import UIKit
import Combine

final class PlayerCollectionCell: UICollectionViewCell {
    static let identifier = "PlayerTableViewCell"
    lazy var playerNameLabel = UILabel()
    lazy var teamLabel = UILabel()
    var player: Player! {
        didSet { setUpView() }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubiews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubiews() {
        let subviews = [playerNameLabel, teamLabel]
        
        subviews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            playerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            playerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            playerNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            
            teamLabel.centerYAnchor.constraint(equalTo: playerNameLabel.centerYAnchor),
            teamLabel.leadingAnchor.constraint(equalTo: playerNameLabel.trailingAnchor, constant: 10.0),
            teamLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            teamLabel.heightAnchor.constraint(equalTo: playerNameLabel.heightAnchor)
        ])
    }
    
    private func setUpView() {
        playerNameLabel.text = "\(player.firstName) \(player.lastName)"
        teamLabel.text = player.team
    }
}
