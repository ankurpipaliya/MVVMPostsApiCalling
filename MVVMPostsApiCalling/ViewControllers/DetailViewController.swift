//
//  DetailViewController.swift
//  MVVMPostsApiCalling
//
//  Created by AnkurPipaliya on 11/07/23.
//

import UIKit

class DetailViewController: BaseViewController {
    var getId:Int?
    var commentsViewModel = CommentViewModel()
    
    @IBOutlet weak var tblComment: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(getId)
        tblComment.dataSource = self
        fetchComments()
       // showLoader()
    }
    func updateUI(){
        self.tblComment.reloadData()
    }
    func fetchComments(){
        self.showLoader()
        commentsViewModel.fetchCommentsFromApi(getId ?? 0) { [weak self] ree in
            print(ree)
            self?.hideLoader()
            DispatchQueue.main.async
            {
                self?.updateUI()
            }
        }
    }
}
extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsViewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
                as? commentCell else {return UITableViewCell()}
        let ind = self.commentsViewModel.comments[indexPath.row]
        cell.lblid.text = "\(ind.id)"
        cell.lblName.text = "\(ind.name)"
        cell.lblEmail.text = ind.email
        cell.lblbody.text = ind.body
        return cell
    }
}
