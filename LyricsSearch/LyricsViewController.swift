//
//  LyricsViewController.swift
//  LyricsSearch
//
//  Created by William Sjahrial on 2022/7/15.
//

import UIKit

class LyricsViewController: UIViewController {

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lyricsTextView: UITextView!
    
    var artistName: String?
    var songTitle: String?
    var lyrics: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Details"
        
        artistLabel.text = artistName
        titleLabel.text = songTitle
        lyricsTextView.text = lyrics        
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
