//
//  ViewController.swift
//  GitHubViewerMVC
//
//  Created by Andrei Dobysh on 27.11.20.
//

import UIKit

protocol RepositoryViewProtocol: AnyObject {
    func update()
    func showError(_ error: Error)
}

class RepositoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    private var presenter: RepositoryPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RepositoryPresenter(view: self)
    }
    
    @IBAction func goAction(_ sender: Any) {
        presenter?.show(user: textField?.text ?? "")
    }

}

extension RepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell") as? RepositoryCell,
              let item = presenter?.item(for: indexPath.row) else {
            return UITableViewCell()
        }
        cell.titleLabel.text = item.name
        cell.descriptionLabel.text = item.createdAt
        return cell
    }
    
}

extension RepositoryViewController: RepositoryViewProtocol {
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func update() {
        tableView.reloadData()
    }
    
}
