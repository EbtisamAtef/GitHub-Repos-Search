//
//  RepoDetailsCell.swift
//  GitHub Repos Search
//
//  Created by ebtisam atef on 5/17/21.
//

import UIKit

class RepoDetailsCell: UITableViewCell {
    
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var ownerLogin: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var repoStargazersCount: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var languageIcon: UIImageView!
    
   
    private func setupLabel(label: UILabel, text: String? = "", color: UIColor = .white, alignment: NSTextAlignment = .left, numLines: Int = 0) {
        label.backgroundColor = .clear
        label.textColor = color
        label.textAlignment = alignment
        label.text = text
        label.numberOfLines = numLines
    }
    
    func assignData(repoData:RepoDetailsModel){
        if let image = repoData.owner?.avatar_url {
            ownerImage.setImage(image: image, placeHolder: UIImage(named: "defaultImage"), complition: nil)
        }
        if let login = repoData.owner?.login{
            setupLabel(label:ownerLogin,text: login,numLines: 0)
        }
        if let repoName = repoData.name{
            setupLabel(label:name,text: repoName,numLines: 0)
        }
        if let RepoDesc = repoData.description{
            setupLabel(label:repoDescription,text: RepoDesc,numLines: 5)
        }
        if let stargazers = repoData.stargazers_count{
            setupLabel(label:repoStargazersCount,text: String(stargazers),numLines: 0)
        }
        if let lang = repoData.language{
            setupLabel(label:language,text: lang,numLines: 0)
        }
 
    }
    
}
