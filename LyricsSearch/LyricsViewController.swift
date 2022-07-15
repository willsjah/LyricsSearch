//
//  LyricsViewController.swift
//  LyricsSearch
//
//  Created by William Sjahrial on 2022/7/15.
//

import UIKit

class LyricsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var lyricsModel: LyricsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Details"
        
        if let lyricsModel = lyricsModel {
            textView.text = lyricsModel.lyrics
        } else {
            textView.text = "(Lyrics not found)"
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
