//
//  SettingsVC.swift
//  kabreet
//
//  Created by Essam Orabi on 06/03/2023.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    var settings = [DriverSettingsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        settings.append(DriverSettingsModel(settingName: "Account information".localized(), SettingImage: "accountInfo"))
        settings.append(DriverSettingsModel(settingName: "Change Language".localized(), SettingImage: "language"))
        settings.append(DriverSettingsModel(settingName: "Log out".localized(), SettingImage: "logout"))
        settingsTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    func setupTableview() {
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(UINib(nibName: DriverSettingsCell.identifier, bundle: nil), forCellReuseIdentifier: DriverSettingsCell.identifier)
        settingsTableView.tableFooterView = UIView()
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DriverSettingsCell.identifier, for: indexPath) as? DriverSettingsCell else { return UITableViewCell() }
        let lastItem = indexPath.row == settings.count - 1
        cell.ConfigureCell(data: settings[indexPath.row], isLastItem: lastItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
        case 0:
            let accountInfoVc = DriverInfoVC.instantiate(fromAppStoryboard: .Home)
            accountInfoVc.modalPresentationStyle = .fullScreen
            self.present(accountInfoVc, animated: true)
        case 1:
            let changeLanguageVc = ChangeLanguageVC.instantiate(fromAppStoryboard: .Home)
            changeLanguageVc.modalPresentationStyle = .fullScreen
            self.present(changeLanguageVc, animated: true)
        case 2:
            self.showLocalizedAlertWithOkButton(style: .alert, alertTitle: "Warning".localized(), message: "Do you want to logout?".localized(), buttonTitle: "Ok".localized()) {
                UserInfoManager.shared.logout()
                guard let homeVC = UIStoryboard.init(name:"Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
                UIApplication.shared.windows.first?.rootViewController = homeVC
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
}
