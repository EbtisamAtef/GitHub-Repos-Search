//
//  RepositoriesListViewController.swift
//  GitHub Repos Search
//
//  Created by ebtisam atef on 5/17/21.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftPullToRefresh

class RepositoriesListViewController: UIViewController {
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var cellIdentifire = "RepoDetailsCell"
    var query = ""
    var page = 1
    var searchRepoViewModel : SearchRepoViewModel?
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        repoTableView.register(UINib(nibName: "RepoDetailsCell", bundle: nil), forCellReuseIdentifier: cellIdentifire)
        searchRepoViewModel = SearchRepoViewModel()
        self.searchRepoViewModel?.filterText.accept(query)
        self.searchRepoViewModel?.getData()
        subscribLoadingSearchResult()
        loadMoreData()
        subscribLoading()
        subscribError()
        
    }
    
    
    func setupNavigation(){
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.view.tintColor = .systemBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    
    func subscribLoadingSearchResult(){
           searchRepoViewModel?.searchResultListObservable.bind(to: repoTableView.rx.items(cellIdentifier: cellIdentifire, cellType: RepoDetailsCell.self)){(row, data, cell) in
                cell.assignData(repoData: data)
                if row % 2 == 0 {
                    cell.languageIcon.image = UIImage(named: "greenCircle")
                }else {
                    cell.languageIcon.image = UIImage(named: "goldCircle")
                }
        }.disposed(by: disposeBag)
    }
    
    func loadMoreData(){
        //repoTableView.rx.willDisplayCell.subscribe(onNext: {cell, indexPath in
        //}).disposed(by: disposeBag)
        self.repoTableView.spr_setIndicatorAutoFooter {
            let compelete = self.searchRepoViewModel?.incompletResult.value
            if (compelete == false){
                self.page += 1
                self.searchRepoViewModel?.getData(page: self.page)
            }
        }
        
        self.repoTableView.spr_setIndicatorHeader {
            if self.page > 1 {
                self.page -= 1
                self.searchRepoViewModel?.getData(page: self.page)
            }else{
                self.repoTableView.spr_endRefreshing()
            }
        }
    }
    
    func subscribLoading(){
        searchRepoViewModel?.loadingBehavior.subscribe(onNext: { (loading) in
            if(loading){
                self.loader.isHidden = false
            }else{
                self.repoTableView.spr_endRefreshing()
                self.loader.isHidden = true
            }
        }).disposed(by: disposeBag)
    }
    
    func subscribError(){
        searchRepoViewModel?.errorObservable.bind { (value) in
            self.loader.isHidden = true
            let alert = UIAlertController(title: "Error", message: value, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    
}

