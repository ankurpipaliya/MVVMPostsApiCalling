//
//  ViewController.swift
//  MVVMPostsApiCalling
//
//  Created by AnkurPipaliya on 11/07/23.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var tblPost: UITableView!
   // var posts: [PostModel] = []
    var postsViewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  tblPost.register(UITableViewCell.self, forCellReuseIdentifier: "cell" )
        tblPost.delegate = self
        tblPost.dataSource = self
        fetchPosts()
        //showLoader()
    }
    func updateUI()
    {
        self.tblPost.reloadData()
    }
    func fetchPosts() {
        showLoader()
        postsViewModel.fetchPostsfromApi { [weak self] res1 in
            print(res1)            
            self?.hideLoader()
            DispatchQueue.main.async
            {
                self?.updateUI()
            }
        }
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsViewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                as? cell else {return UITableViewCell()}
        let ind = self.postsViewModel.posts[indexPath.row]
            cell.lblid.text = "\(ind.id)"
            cell.lblUserid.text = "\(ind.userId)"
            cell.lblTitle.text = ind.title
            cell.lblBody.text = ind.body
            return cell
    }
    
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DetailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        DetailVC.getId = postsViewModel.posts[indexPath.row].id
        navigationController?.pushViewController(DetailVC, animated: true)
    }
}

