//
//  RepositoryPresenter.swift
//  GitHubViewerMVP
//
//  Created by Andrei Dobysh on 1.12.20.
//

import Foundation

protocol RepositoryPresenterProtocol {
    init(view: RepositoryViewProtocol)
    var count: Int { get }
    func show(user: String)
    func item(for index: Int) -> RepositoryCellModel?
}

class RepositoryPresenter: RepositoryPresenterProtocol {
    
    public var count: Int {
        return repositories.count
    }
    private var repositories: [RepositoryModel] = []
    private weak var view: RepositoryViewProtocol?
    
    required init(view: RepositoryViewProtocol) {
        self.view = view
    }
    
    func show(user: String) {
        RepositoryModel.load(user: user) { completion in
            switch completion {
            case .complete(let value):
                self.repositories = value
                self.view?.update()
            case .error(let error):
                self.repositories = []
                self.view?.showError(error)
            }
        }
    }
    
    func item(for index: Int) -> RepositoryCellModel? {
        if let repositoryModel = repositories[safe: index] {
            return RepositoryCellModel(titleMessage: repositoryModel.name ?? "",
                                       descriptionMessage: repositoryModel.createdAt ?? "")
        } else {
            return nil
        }
    }
    
}
