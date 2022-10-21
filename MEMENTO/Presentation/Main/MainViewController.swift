
import UIKit
import Combine

class MainViewController: UIViewController{
    let viewModel: MainViewModel
    var subscriber: Set<AnyCancellable> = .init()
    
    var answerExpanded = ExpandingContentCell()
    
    let contentsTableView = ContentListView()
    let sendTextView = SendTextView()
    let loadingView = LoadingView()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadingView.drawLoadingView(view: view)
        configureUI()
    }
    
    func setup() {
        setupNavHeader()
        setupKeyboardHiding()
        bind()
    }
    
    func configureUI() {
        view.backgroundColor = .white

        view.addSubview(contentsTableView)
        contentsTableView.translatesAutoresizingMaskIntoConstraints = false
        contentsTableView.tableView.delegate = self
        contentsTableView.tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            contentsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            contentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        
        view.addSubview(sendTextView)
        sendTextView.translatesAutoresizingMaskIntoConstraints = false
        sendTextView.textView.delegate = self
        sendTextView.button.addTarget(self, action: #selector(SendButtonClicked), for: .touchUpInside)
        NSLayoutConstraint.activate([
            sendTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sendTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sendTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sendTextView.heightAnchor.constraint(equalToConstant: 48 * 2)
        ])

    }
    
    func setupNavHeader() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 0.983, green: 0.983, blue: 0.983, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 0.198, green: 0.202, blue: 0.233, alpha: 1)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.shadowColor = .clear
        
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
        title = "MEMENTO"
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "slider.vertical.3"), style: .plain, target: self, action: #selector(NavButtonClicked))
        
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "text.justify"), style: .plain, target: self, action: #selector(NavButtonClicked))
        
        filterButton.tintColor = .black
        menuButton.tintColor = .black
        
        self.navigationItem.rightBarButtonItems = [menuButton, filterButton]
    }

    func bind() {
        viewModel.fetchContents()
    
        viewModel.$loading.sink { loading in
            self.loadingView.isHidden = !loading
            
            if loading == false {
                self.configureUI()
                self.contentsTableView.tableView.reloadData()
            }

            print(loading)
        }.store(in: &subscriber)
        
        viewModel.$contents.sink{ contents in
            print(contents)
        }.store(in: &subscriber)
    }
    
    
    // MARK: Button Click Event
    @objc func NavButtonClicked() {
        print("nav btn clicked")
        answerExpanded.expended = true
        contentsTableView.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
    }
    @objc func SendButtonClicked() {
        let newText = sendTextView.textView.text
//        viewModel.createMockContents(text: newText ?? "")
        viewModel.createContents(content: newText ?? "")
        self.contentsTableView.tableView.reloadData()
        self.contentsTableView.tableView.scrollToBottom()
    }
}

extension MainViewController {
    func drawMain() {
        let text = UILabel()
        
        view.addSubview(text)
        text.text = "title"
        text.translatesAutoresizingMaskIntoConstraints = false
        
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
