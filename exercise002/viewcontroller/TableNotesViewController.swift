//
//  TableNotesViewController.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class TableNotesViewController: UIViewController {
    
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let tableView = UITableView();
    
    var folderIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .white;
        navigationItem.title = "Note List - Folder, \(DataSource.folders[folderIndex].name)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.rectangle.on.rectangle"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        setUpViews();
        
        titleLabel.text = "Folder Name : \(DataSource.folders[folderIndex].name)"
        detailLabel.text = "Folder Detail : \(DataSource.folders[folderIndex].detail)"
        
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(createNote), name: NSNotification.Name.saveNote, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editNote), name: NSNotification.Name.editNote, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteNote), name: NSNotification.Name.deleteNote, object: nil)
    }
    
    @objc func rightBarButtonTapped(sender: UIBarButtonItem){
        let createNoteViewController = CreateNoteViewController()
        navigationController?.pushViewController(createNoteViewController, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.layoutIfNeeded()
    }
    
    @objc func createNote(notification: Notification){
        guard let note = notification.object as? Note else { return }
        DataSource.folders[folderIndex].notes.append(note)
        tableView.insertRows(at: [IndexPath(row: DataSource.folders[folderIndex].notes.count - 1, section: 0)], with: .automatic)
    }
    
    @objc func editNote(notification: Notification){
        guard let note = notification.object as? Note else { return }
        if let index = DataSource.folders[folderIndex].notes.firstIndex(where: { n in
            n.id == note.id
        }){
            DataSource.folders[folderIndex].notes[index].title = note.title
            DataSource.folders[folderIndex].notes[index].detail = note.detail
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
    
    @objc func deleteNote(notification: Notification){
        guard let indexPath = notification.object as? IndexPath else { return }
        DataSource.folders[folderIndex].notes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    private func setUpViews(){
        view.addSubview(titleLabel)
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-5)
        }
        
        view.addSubview(detailLabel)
        detailLabel.font = UIFont(name: "HelveticaNeue", size: 16)
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-5)

        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(30)
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension TableNotesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.folders[folderIndex].notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteTableViewCell
        let note = DataSource.folders[folderIndex].notes[indexPath.row]
        cell.titleLabel.text = note.title
        cell.detailLabel.text = note.detail
        return cell
    }
    
}

extension TableNotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, complete in
            guard let self = self else { return}
            let alertController = UIAlertController(title: "Confirmation", message: "Are you sure to remove?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "OK", style: .destructive) { _ in
                NotificationCenter.default.post(name: NSNotification.Name.deleteNote, object: indexPath)
            }
            let noAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                complete(true)
            }
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            present(alertController, animated: true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, complete in
            guard let self = self else { return }
            let editNoteViewController = EditNoteViewController()
            editNoteViewController.note = DataSource.folders[folderIndex].notes[indexPath.row]
            navigationController?.pushViewController(editNoteViewController, animated: true)
        }
        editAction.backgroundColor = .systemGreen
    
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
}

