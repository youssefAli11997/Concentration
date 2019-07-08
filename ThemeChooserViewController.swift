//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by Owner on 7/8/19.
//  Copyright © 2019 Owner. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?

    let themes = ["Sports" : "⚾️🎾🏈🏀⚽️🎱🏓🏒🥊🥋⛳️🏹",
                  "Faces" : "👶👨‍🦰😃🤣😎😛😍😹😪👽👺🤡💀",
                  "Animals" : "🦕🐠🐢🦄🐴🦉🐧🐸🐵🐶🐼🐰"]
    
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        }
        else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let concentrationViewController = segue.destination as? ConcentrationViewController {
                    concentrationViewController.theme = theme
                    lastSeguedToConcentrationViewController = concentrationViewController
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }

}
