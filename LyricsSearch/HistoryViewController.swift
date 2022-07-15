//
//  HistoryViewController.swift
//  LyricsSearch
//
//  Created by William Sjahrial on 2022/7/15.
//

import UIKit

class HistoryViewController: UIViewController {

    var historyList: [SearchHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "History"
        
        loadHistory()
    }
    
    // MARK: - Persistent Storage
    
    private func loadHistory() {
        print(#function)
        
//        historyList.removeAll()
//        let h1 = SearchHistory(artist: "A1", title: "T1", lyrics: "L1")
//        let h2 = SearchHistory(artist: "A2", title: "T2", lyrics: "L2")
//        historyList.append(h1)
//        historyList.append(h2)
        
        historyList = SearchHistoryManager.shared.historyList // TODO: Persistent Storage
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LyricsSegue" {
            let indexPath = sender as! IndexPath
            let history = historyList[indexPath.row]
            let vc = segue.destination as! LyricsViewController
            vc.artistName = history.artist
            vc.songTitle = history.title
            vc.lyrics = history.lyrics
        }
    }

}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        let history = historyList[indexPath.row]
        cell.textLabel?.text = history.artist
        cell.detailTextLabel?.text = history.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "LyricsSegue", sender: indexPath)
    }
    
}
