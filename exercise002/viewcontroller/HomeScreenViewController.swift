//
//  HomeScreenViewController.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit
import SnapKit

class HomeScreenViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        setUpViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FolderCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(createFolder), name: NSNotification.Name.saveFolder, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editFolder), name: NSNotification.Name.editFolder, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteFolder), name: NSNotification.Name.deleteFolder, object: nil)
    }
    
    @objc func rightBarButtonTapped(sender: UIBarButtonItem){
        let createFolderViewController = CreateFolderViewController()
        navigationController?.pushViewController(createFolderViewController, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func createFolder(notification: Notification){
        guard let folder = notification.object as? Folder else { return }
        DataSource.folders.append(folder)
        collectionView.insertItems(at: [IndexPath(row: DataSource.folders.count - 1, section: 0)])
    }
    
    @objc func editFolder(notification: Notification){
        guard let folder = notification.object as? Folder else { return }
        if let index = DataSource.folders.firstIndex(where: { n in
            n.id == folder.id
        }){
            DataSource.folders[index].name = folder.name
            DataSource.folders[index].detail = folder.detail
            collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    
    @objc func deleteFolder(notification: Notification){
        guard let indexPath = notification.object as? IndexPath else { return }
        DataSource.folders.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }
    
    private func setUpViews(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension HomeScreenViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataSource.folders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FolderCollectionViewCell
//        collectionViewCell.contentView.backgroundColor = .systemYellow
        let folder = DataSource.folders[indexPath.row]
        collectionViewCell.titleLabel.text = folder.name
        collectionViewCell.detailLabel.text = folder.detail
        return collectionViewCell
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewCellEstimatedSize = (collectionView.frame.width - 10) / 4 - 5
        return CGSize(width: collectionViewCellEstimatedSize, height: collectionViewCellEstimatedSize + 10)
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
                cell?.contentView.backgroundColor = .systemBackground
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let viewNoteAction = UIAction(title: "View Notes", image: UIImage(systemName: "eye.circle.fill")) { [weak self] (action) in
                guard let self = self else { return }
                let tableNotesViewController = TableNotesViewController()
                tableNotesViewController.folderIndex = indexPath.row
                navigationController?.pushViewController(tableNotesViewController, animated: true)
            }
            let editAction = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil")) { [weak self] (action) in
                guard let self = self else { return }
                let editViewController = EditFolderViewController()
                editViewController.folder = DataSource.folders[indexPath.row]
                navigationController?.pushViewController(editViewController, animated: true)
            }
            let yes = UIAction(title: "Yes", image: UIImage(systemName: "checkmark.circle")) { (action) in
                NotificationCenter.default.post(name: NSNotification.Name.deleteFolder, object: indexPath)
            }
            let no = UIAction(title: "No", image: UIImage(systemName: "xmark.app")) { _ in
                
            }
            let deleteAction = UIMenu(title: "Delete", image: UIImage(systemName: "trash.square"), options: .destructive, children: [yes, no])
            return UIMenu(title: "Options", children: [viewNoteAction, editAction, deleteAction])
        }
    }
    
}

