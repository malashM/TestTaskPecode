//
//  CountryViewModelImplemetation.swift
//  NewsClient
//
//  Created by Admin on 20.09.21.
//

import Foundation

class CountryViewModelImplementation: CountryViewModel {
    
    weak var viewController: CountryViewController?
    init(_ viewController: CountryViewController) {
        self.viewController = viewController
    }

    func loadSources(_ completion: @escaping ([String]) -> Void) {
        HTTPClient.shared.fetchAvailableNewsSources { [weak self] results in
            switch results {
            case .success(let sources):
                if sources.status == "ok" {
                    var array: [String] = []
                    for value in sources.sources {
                        array.append(value.country)
                    }
                    let uniqueArray = Array(Set(array))
                    completion(uniqueArray)
                    self?.viewController?.activityIndicator.stopAnimating()
                } else {
                    self?.viewController?.showAlert("Error")
                    self?.viewController?.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                self?.viewController?.showAlert("Error")
                self?.viewController?.activityIndicator.stopAnimating()
                print(error.localizedDescription)
            }
        }
    }
}
