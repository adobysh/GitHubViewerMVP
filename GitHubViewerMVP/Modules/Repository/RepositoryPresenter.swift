//
//  RepositoryPresenter.swift
//  GitHubViewerMVP
//
//  Created by Andrei Dobysh on 1.12.20.
//

import Foundation

protocol RepositoryPresenter {
    init(view: RepositoryView)
    var count: Int { get }
    func show(user: String)
    func item(for index: Int) -> RepositoryModel
}

class RepositoryPresenterImpl: RepositoryPresenter {
    
    public var count: Int {
        return repositories.count
    }
    private var repositories: [RepositoryModel] = []
    private let view: RepositoryView
    
    required init(view: RepositoryView) {
        self.view = view
    }
    
    func show(user: String) {
        RepositoryModel.load(user: user) { completion in
            switch completion {
            case .complete(let value):
                self.repositories = value
                self.view.update()
            case .error(let error):
                self.repositories = []
                self.view.showError(error)
            }
        }
    }
    
    func item(for index: Int) -> RepositoryModel {
        return repositories[index]
    }
    
}
