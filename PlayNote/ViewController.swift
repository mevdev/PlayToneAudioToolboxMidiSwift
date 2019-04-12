//
//  ViewController.swift
//  PlayNote
//
//  Created by Robert Linnemann on 4/12/19.
//  Copyright © 2019 Robert Linnemann. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    //
    let notePlayer = NotePlayer()

    // MARK: Lifecycles of the rich and famous
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        playButton.addTarget(self, action: #selector(ViewController.touchDownEvent), for: .touchDown)
        playButton.addTarget(self, action: #selector(ViewController.touchUpEvent), for: [.touchUpInside, .touchUpOutside])
    }

    // MARK: Actions
    @objc func touchDownEvent(_ sender: AnyObject) {
        // print("TouchDown")
        notePlayer.noteOn(note: 99)
    }

    @objc func touchUpEvent(_ sender: AnyObject) {
        // print("TouchUp")
        notePlayer.noteOff(note: 99)
    }

}
