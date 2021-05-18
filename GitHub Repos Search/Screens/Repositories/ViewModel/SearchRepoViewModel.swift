//
//  SearchRepoViewModel.swift
//  GitHub Repos Search
//
//  Created by ebtisam atef on 5/17/21.
//

import Foundation
import RxCocoa
import RxSwift


class SearchRepoViewModel{
    
    let disposeBag = DisposeBag()
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var tableIsHidden = BehaviorRelay<Bool>(value: false)
    var filterText = BehaviorRelay<String>(value:"")
    var incompletResult = BehaviorRelay<Bool>(value: false)
    
    var searchResultList = PublishSubject<[RepoDetailsModel]>()
    private var error = PublishSubject<String>()
    var serachResult = PublishSubject<SearchRepoModel>()
    
    var searchResultListObservable : Observable<[RepoDetailsModel]> {
        return searchResultList
    }
    var errorObservable : Observable<String> {
        return error
    }
    var serachResultObservable : Observable<SearchRepoModel> {
        return serachResult
    }
    
    var resultList:[RepoDetailsModel] = []
    

    
    func getData(page:Int = 1) {
        loadingBehavior.accept(true)
        let query = filterText.value
        Service.instance.loadRepos(keyword: query, page: page) {[weak self] (searchRepo:SearchRepoModel?, error: Error?) in
            
            guard let self = self else {return}
            self.loadingBehavior.accept(false)
            if let error = error {
                self.error.onNext(error.errorMsg)
                return
            }
            guard let result = searchRepo else{return}
            self.serachResult.onNext(result)
            self.incompletResult.accept(result.incomplete_results)
            self.searchResultList.onNext(result.items)
            self.resultList = result.items
      }
   }
    
    
}
