//
//  ListViewController.swift
//  CombineDemo
//
//  Created by Michal Cichecki on 30/06/2019.
//

import UIKit
import Combine

final class ListViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<ListViewModel.Section, Player>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ListViewModel.Section, Player>
    
    private lazy var contentView = ListView()
    private let viewModel: ListViewModel
    
    //MARK: 4. Create the cancelables
    
    
    private var dataSource: DataSource!
    
    init(viewModel: ListViewModel = ListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .darkGray
        
        setUpTableView()
        configureDataSource()
        setUpBindings()
        viewModel.fetchPlayers()
    }
    
    private func setUpTableView() {
        contentView.collectionView.register(
            PlayerCollectionCell.self,
            forCellWithReuseIdentifier: PlayerCollectionCell.identifier)
    }
    
    
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            // MARK: 3. Observe the textfield text
        }
        
        func bindViewModelToView() {
            //MARK: 1. Observe number of player
            
            //MARK: 2. Observe the loading status
            
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    private func showError(_ error: String = "") {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateSections() {
        var snapshot = Snapshot()
        snapshot.appendSections([.players])
        snapshot.appendItems(viewModel.players)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDataSource

extension ListViewController {
    private func configureDataSource() {
        dataSource = DataSource(
            collectionView: contentView.collectionView,
            cellProvider: { (collectionView, indexPath, player) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PlayerCollectionCell.identifier,
                    for: indexPath) as? PlayerCollectionCell
                cell?.player = player
                return cell
            })
    }
}
