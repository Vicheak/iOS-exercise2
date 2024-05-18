//
//  HomeScreenViewController.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var dataSourceFolder = DataSourceFolder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Home Screen"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white
        ], for: .normal)
        
        setUpViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(createNewNote), name: NSNotification.Name.folderSaveData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editNote), name: NSNotification.Name.folderEditData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteNote), name: NSNotification.Name.folderDeleteData, object: nil)
    }
    
    @objc func rightBarButtonTapped(sender: UIBarButtonItem){
        let createNoteViewController = CreateFolderViewController()
        navigationController?.pushViewController(createNoteViewController, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func createNewNote(notification: Notification){
        guard notification.object is Folder else { return }
        collectionView.insertItems(at: [IndexPath(row: dataSourceFolder.folders.count - 1, section: 0)])
    }
    
    @objc func editNote(notification: Notification){
        guard let folder = notification.object as? Folder else { return }
        if let index = dataSourceFolder.folders.firstIndex(where: { n in
            n.id == folder.id
        }){
            collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    
    @objc func deleteNote(notification: Notification){
        guard let indexPath = notification.object as? IndexPath else { return }
        collectionView.deleteItems(at: [indexPath])
    }
    
    private func setUpViews(){
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: 0)
        ])
    }
    
}

extension HomeScreenViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceFolder.folders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NoteCollectionViewCell
        collectionViewCell.contentView.backgroundColor = .systemYellow
        let folder = dataSourceFolder.folders[indexPath.row]
        collectionViewCell.titleLabel.text = folder.folderName
        collectionViewCell.detailLabel.text = folder.folderDetail
        return collectionViewCell
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewCellEstimatedSize = (collectionView.frame.width - 10) / 4 - 5
        return CGSize(width: collectionViewCellEstimatedSize, height: collectionViewCellEstimatedSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.contentView.backgroundColor = .systemBackground
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                cell?.contentView.backgroundColor = .systemYellow
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let refreshAction = UIAction(title: "View Notes", image: UIImage(systemName: "arrow.clockwise.circle")) { [weak self] (action) in
                guard let self = self else { return }
                let tableNotesViewController = TableNotesViewController()
                tableNotesViewController.folder = dataSourceFolder.folders[indexPath.row]
                navigationController?.pushViewController(tableNotesViewController, animated: true)
            }
            let editAction = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil")) { [weak self] (action) in
                guard let self = self else { return }
                let editViewController = EditFolderViewController()
                editViewController.folder = dataSourceFolder.folders[indexPath.row]
                navigationController?.pushViewController(editViewController, animated: true)
            }
            let yes = UIAction(title: "Yes", image: UIImage(systemName: "checkmark.seal.fill")) { (action) in
                NotificationCenter.default.post(name: NSNotification.Name.folderDeleteData, object: indexPath)
            }
            let no = UIAction(title: "No", image: UIImage(systemName: "xmark.app")) { _ in
                
            }
            let deleteAction = UIMenu(title: "Delete", image: UIImage(systemName: "trash.square"), options: .destructive, children: [yes, no])
            return UIMenu(title: "note", children: [refreshAction, editAction, deleteAction])
        }
    }
    
}

