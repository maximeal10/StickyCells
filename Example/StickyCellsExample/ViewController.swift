//
//  ViewController.swift
//  StickyCellsExample
//
//  Created by Maxime Tenth on 9/10/20.
//  Copyright © 2020 Mothxim. All rights reserved.
//

import UIKit
import StickyCells

class ViewController: UIViewController {

    var tableView: UITableView!

    var models: [CellModel] = []

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        tableView = StickyCellsTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        self.view = view
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        models = [
            ItemModel("some content"),
            HeaderModel("PEW\nPEW", level: 0),
            ItemModel("some content"),
            ItemModel("some content"),
            HeaderModel("Food", level: 0),
            ItemModel("some content"),
            ItemModel("some content"),
            HeaderModel("Fruits", level: 1),
            ItemModel("some content"),
            ItemModel("some content"),
            HeaderModel("Apples", level: 2),
            ItemModel("Green apples"),
            ItemModel("Red apples"),
            ItemModel("and other apples"),
            HeaderModel("Oranges", level: nil),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            HeaderModel("Peaches", level: 2),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            HeaderModel("Vegetables", level: 1),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            HeaderModel("Potato", level: 2),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            HeaderModel("Carrot \n(rabbits like that))", level: 2),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            HeaderModel("Some special carrot", level: 3),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            HeaderModel("Other", level: 1),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            HeaderModel("FINISH", level: 0),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
            ItemModel("some content"),
        ]

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ItemModel.reuseIdentifier)
        tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderModel.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.reuseIdentifier, for: indexPath)
        model.setup(cell: cell)
        return cell
    }
}
