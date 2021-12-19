//
//  CitiesViewController.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//
//

import UIKit
import PinLayout

final class CitiesViewController: UIViewController {
    
    private let output: CitiesViewOutput
    private let tableView = UITableView()
    
    init(output: CitiesViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupTableView()
        output.didLoadView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.title = "Weather"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.8941176471, blue: 1, alpha: 1)
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = navigationItem.standardAppearance
        setupRefresh()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "CityTableViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.8941176471, blue: 1, alpha: 1)
        
    }
    
    private func setupRefresh() {
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControll
    }
    
    @objc
    private func didTapAddButton() {
        output.didTapAddButton()
    }
    
    @objc
    private func didRefresh() {
        output.didRefresh()
    }
}

extension CitiesViewController: CitiesViewInput {
    func reloadData() {
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let message: String = "Click on the ➕ to add a city.\nIf you want to delete a city, just swipe left."
        tableView.setEmptyMessage(message, output.itemsCount == 0)
        return output.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell
        cell?.configure(with: output.item(at: indexPath.row))
        cell?.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.8941176471, blue: 1, alpha: 1)
        return cell ?? .init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            output.deleteData(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectItem(at: indexPath.row)
    }
}

extension UITableView {
    
    private func configureLabelLayout(_ messageLabel: UILabel) {
      //  messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.pin
            .center()
            .width(UIScreen.main.bounds.width - 60)
    }
    
    private func configureLabel(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 25, weight: .medium)
        messageLabel.text = message
        messageLabel.adjustsFontSizeToFitWidth = true
        self.backgroundView = UIView()
        self.backgroundView?.addSubview(messageLabel)
        configureLabelLayout(messageLabel)
        self.separatorStyle = .none
    }
    
    func setEmptyMessage(_ message: String, _ isEmpty: Bool) {
        if isEmpty {
            configureLabel(message)
        }
        else {
            restore()
        }
        
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}
