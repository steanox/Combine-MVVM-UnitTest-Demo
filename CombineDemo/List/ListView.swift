//
//  ListView.swift
//  CombineDemo
//
//  Created by Michal Cichecki on 30/06/2019.
//

import UIKit

final class ListView: UIView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var searchTextField = UITextField()
    lazy var myLabel: UILabel = UILabel()
    lazy var activityIndicationView = ActivityIndicatorView(style: .medium)
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpConstraints()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        let subviews = [searchTextField, collectionView, activityIndicationView]
        
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func startLoading() {
        collectionView.isUserInteractionEnabled = false
        searchTextField.isUserInteractionEnabled = false
        
        activityIndicationView.isHidden = false
        activityIndicationView.startAnimating()
    }
    
    func finishLoading() {
        collectionView.isUserInteractionEnabled = true
        searchTextField.isUserInteractionEnabled = true
        
        activityIndicationView.stopAnimating()
    }
    
    private func setUpConstraints() {
        let defaultMargin: CGFloat = 4.0
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: defaultMargin),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: defaultMargin),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -defaultMargin),
            searchTextField.heightAnchor.constraint(equalToConstant: 30.0),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: defaultMargin),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicationView.heightAnchor.constraint(equalToConstant: 50),
            activityIndicationView.widthAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func setUpViews() {
        collectionView.backgroundColor = .background
        
        searchTextField.autocorrectionType = .no
        searchTextField.backgroundColor = .background
        searchTextField.placeholder = "Find Player"
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(40))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.interGroupSpacing = 5
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
