//
//  HomeViewController.swift
//  GitHub Repos Search
//
//  Created by ebtisam atef on 5/17/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    
    @IBOutlet weak var repoSearchBar: UISearchBar!{
        didSet{
            setupSearchBar(searchBar: repoSearchBar)
        }
    }
    
    let disposeBag = DisposeBag()
    var navigator : Navigator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repoSearchBar.rx.text
        .orEmpty
        .subscribe(onNext: { text in
            print("Text is \(text)")
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func setupSearchBar(searchBar: UISearchBar){
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.showsBookmarkButton = false
        searchBar.placeholder = "Search GitHub"
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.barTintColor = .black
        searchBar.tintColor = .systemGray
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.leftView?.tintColor = .systemGray
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.systemBlue], for: .normal)
    }
    
  
    
    
    
    func goToDetailsScreen(query: String) {
        navigator = Navigator(vc: self,mainSBName: "Main")
        guard let vc = navigator?.instantiateVC(withDestinationViewControllerType: RepositoriesListViewController.self) else { return }
        vc.query = query
        navigator?.goToNextScreen(viewController: vc, withDisplayVCType: .push)
    }


}


extension HomeViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.goToDetailsScreen(query:searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}





