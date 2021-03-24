//
//  NewsViewController.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//

import UIKit

class NewsViewController: UIViewController {
  
  @IBOutlet weak private var tableView: UITableView!
  
  var refreshControl = UIRefreshControl()
  
  let viewModel = NewsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
    self.tableView.addSubview(refreshControl)
    
    self.setupBindings()
    self.refresh()
  }
  
  @objc private func refresh() {
    viewModel.getNews()
  }
  
  private func setupBindings() {
    self.viewModel.loading = { loading in
      DispatchQueue.main.async {
        if loading {
          self.refreshControl.beginRefreshing()
        } else {
          self.refreshControl.endRefreshing()
        }
      }
    }
    
    self.viewModel.didUpdate = {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
    
    self.viewModel.errorMessage = { msg in
      print(msg)
    }
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension NewsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.news.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "newCell") as? NewTableViewCell else {
      return UITableViewCell()
    }
    cell.new = self.viewModel.news[indexPath.row]
    return cell
  }
  
  
}

extension NewsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(self.viewModel.news[indexPath.row].objectID)
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, handler) in
      self.viewModel.deleteNew(index: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .automatic)
      handler(true)
    }
    let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
    configuration.performsFirstActionWithFullSwipe = true
    return configuration
  }
}
