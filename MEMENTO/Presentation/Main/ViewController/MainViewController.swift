
import UIKit
import Combine

class MainViewController: UIViewController{
    //TODO: Definitely need to divide Notification flow
    let userNotiCenter = UNUserNotificationCenter.current()
    
    let viewModel: MainViewModel
    var subscriber: Set<AnyCancellable> = .init()
    
    var answerExpanded = ExpandingContentCell()
    
    let contentsTableView = ContentListView()
    
    var sendTextView = SendTextView()
    var sendTagView = SendTagView()
    
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
        
        //TODO: 앱 최초 진입시에만 아래 알림 허용 요청 실행으로
        requestAutNoti()
        setup()
        loadingView.drawLoadingView(view: view)
        configureUI()
    }
    
    func setup() {
        setupNavHeader()
        setupKeyboardHiding()
        bind()
    }
    // MARK: 사용자에게 알림 권한 요처
    func requestAutNoti() {
        let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])

        userNotiCenter.requestAuthorization(options: notiAuthOptions) { (success, err) in
            if let err = err {
                print(#function, err)
            }
        }
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
            contentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])

        setupSendTextView()
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
    
    func setupSendTextView() {
        if !viewModel.tagEditStatus {
            sendTagView.removeFromSuperview()
            view.addSubview(sendTextView)
            sendTextView.translatesAutoresizingMaskIntoConstraints = false
            sendTextView.textView.delegate = self
            sendTextView.button.addTarget(self, action: #selector(SendTextButtonClicked), for: .touchUpInside)
            NSLayoutConstraint.activate([
                sendTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                sendTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                sendTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                sendTextView.heightAnchor.constraint(equalToConstant: 48 * 2)
            ])
        } else {
            sendTextView.removeFromSuperview()
            view.addSubview(sendTagView)
            sendTagView.translatesAutoresizingMaskIntoConstraints = false
            sendTagView.textView.delegate = self
            sendTagView.button.addTarget(self, action: #selector(SendTagButtonClicked), for: .touchUpInside)
            NSLayoutConstraint.activate([
                sendTagView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                sendTagView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                sendTagView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                sendTagView.heightAnchor.constraint(equalToConstant: 48 * 2)
            ])
            print("메롱")
        }
    }
    func bind() {
        viewModel.fetchContents()
    
        viewModel.$loading.sink { loading in
            self.loadingView.isHidden = !loading
            if loading == false {
                self.configureUI()
                self.contentsTableView.tableView.reloadData()
            }
        }.store(in: &subscriber)
        
        // tagEditStatus setup
        viewModel.$tagEditStatus.sink { tagEditStatus in
            print(tagEditStatus)
            self.setupSendTextView()
            //            self.sendTextView.tagListView.isHidden = tagEditStatus
        }.store(in: &subscriber)
        
        // tags setup
        viewModel.$contentTags.sink { contentTags in
            print(contentTags)
            self.sendTagView = SendTagView()
            self.sendTagView.contentTags = contentTags
        }.store(in: &subscriber)

    }
    
    
    // MARK: Button Click Event
    @objc func NavButtonClicked() {
        print("nav btn clicked")
        answerExpanded.expended = true
        contentsTableView.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
    }
    @objc func SendTextButtonClicked() {
        let newText = sendTextView.textView.text
        viewModel.createContents(content: newText ?? "")
        self.contentsTableView.tableView.reloadData()
        self.contentsTableView.tableView.scrollToBottom()
    }
    
    @objc func SendTagButtonClicked() {
        let newText = sendTagView.textView.text
        viewModel.updateContentTag(tag: newText ?? "")
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
