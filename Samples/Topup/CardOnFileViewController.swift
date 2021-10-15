import ModernRIBs
import UIKit

protocol CardOnFilePresentableListener: AnyObject {
  func didTapClose()
  func didSelectItem(at: Int)
}

final class CardOnFileViewController: UIViewController, CardOnFilePresentable, CardOnFileViewControllable, UITableViewDataSource, UITableViewDelegate {
  
  weak var listener: CardOnFilePresentableListener?
  
  func update(with viewModels: [PaymentMethodViewModel]) {
    self.viewModels = viewModels
    tableView.reloadData()
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupViews()
  }
  
  private var viewModels: [PaymentMethodViewModel] = []
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(cellType: CardOnFileCell.self)
    tableView.tableFooterView = UIView()
    tableView.rowHeight = 60
    tableView.separatorInset = .zero
    return tableView
  }()
  
  private func setupViews() {
    title = "카드 선택"
    view.backgroundColor = .white
    view.addSubview(tableView)
    
    setupNavigationItem(with: .back, target: self, action: #selector(didTapClose))
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
  
  // MARK: - UITableView
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModels.count + 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: CardOnFileCell = tableView.dequeueReusableCell(for: indexPath)

    if let viewModel = viewModels[safe: indexPath.row] {
      cell.setImage(UIImage(color: viewModel.color))
      cell.setTitle("\(viewModel.name) \(viewModel.digits)")
    } else {
      cell.setImage(UIImage(systemName: "plus.rectangle"))
      cell.setTitle("카드 추가")
    }

    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    listener?.didSelectItem(at: indexPath.row)
  }
  
  @objc
  private func didTapClose() {
    listener?.didTapClose()
  }
  
}
