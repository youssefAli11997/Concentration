//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by Owner on 7/8/19.
//  Copyright © 2019 Owner. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {

    let themes = ["Sports" : "⚾️🎾🏈🏀⚽️🎱🏓🏒🥊🥋⛳️🏹",
                  "Faces" : "👶👨‍🦰😃🤣😎😛😍😹😪👽👺🤡💀",
                  "Animals" : "🦕🐠🐢🦄🐴🦉🐧🐸🐵🐶🐼🐰"]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let buttonTitle = (sender as? UIButton)?.currentTitle, let theme = themes[buttonTitle] {
                if let concentrationViewController = segue.destination as? ConcentrationViewController {
                    concentrationViewController.theme = theme
                }
            }
        }
    }

}
