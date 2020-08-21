import UIKit
import PlaygroundSupport

var cfURL = Bundle.main.url(forResource: "PTSans-Bold", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)


public var jogadorEscolhido: String!

public var goleiroEscolhido: Jogador?
public var zagueiroEscolhido: Jogador?
public var lateralDireitoEscolhido: Jogador?
public var lateralEsquerdoEscolhido: Jogador?
public var meioCampoEscolhido: Jogador?
public var atacanteEscolhido: Jogador?




class mainScreenViewController: UIViewController {
    
    override func loadView() {
        
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemYellow
        
        let attrString = NSAttributedString(
            string: "PelADA Team Maker",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.strokeWidth: -4.0,
                NSAttributedString.Key.font: UIFont(name: "PTSans-Bold", size: 60) ?? " "
            ]
        )
        
        let appName: UILabel!
        appName = UILabel()
        appName.frame = CGRect(x: -10, y: 130, width: 400, height: 200)
        appName.attributedText = attrString
//        appName.font = UIFont(name: "PTSans-Bold", size: 40)
        appName.textColor = .white
        appName.textAlignment = .center
        appName.lineBreakMode = NSLineBreakMode.byWordWrapping
        appName.numberOfLines = 2
        appName?.layer.cornerRadius = 15
        
        
        let startButton: UIButton!
        startButton = UIButton()
        startButton.frame = CGRect(x: 65, y: 500, width: 250, height: 100)
        startButton.backgroundColor = .systemBlue
        startButton?.layer.cornerRadius = 15
        startButton.setTitle("Montar equipe", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 30)
        startButton.addTarget(nil, action: #selector(startGame), for: .touchUpInside)
        
        
        view.addSubview(appName)
        view.addSubview(startButton)
        
        self.view = view
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func startGame() {
    
        navigationController?.pushViewController(gsvc, animated: false)
    
    }
    
}


public struct Jogador {
    public var nome: String
    public var imagem: String
    
    public init(nome: String, imagem: String) {
        self.nome = nome
        self.imagem = imagem
        
    }
}

class goleiroSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 800))
        view.backgroundColor = .systemBlue
        
        
        
        let label: UILabel = UILabel()
        label.font = UIFont(name: "PTSans-Bold", size: 20)
        label.text = "Escolha um goleiro"
        label.textColor = .white
        label.frame = CGRect(x: 90, y: -20, width: 200, height: 100)
        label.textAlignment = .center
        
        
        let backButton: UIButton!
        backButton = UIButton()
        backButton.frame = CGRect(x: -90, y: -20, width: 250, height: 100)
        backButton?.layer.cornerRadius = 15
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 30)
        backButton.addTarget(nil, action: #selector(backToMainScreen), for: .touchUpInside)
        
        let myLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        myLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        myLayout.itemSize = CGSize(width: 335, height: 175)
        myLayout.minimumLineSpacing = 20
        myLayout.scrollDirection = .vertical
        
        var myCollectionView: UICollectionView!
        myCollectionView = UICollectionView(frame: CGRect(x: 0, y: 61, width: 375, height: 607), collectionViewLayout: myLayout)
        myCollectionView.register(playerCell.self, forCellWithReuseIdentifier: "identifier")
        myCollectionView.backgroundColor = UIColor.systemYellow
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        view.addSubview(myCollectionView)
        view.addSubview(label)
        view.addSubview(backButton)
        
        self.view = view
        
        navigationController?.navigationBar.isHidden = true
    }
    
    public var goleiros = [Jogador(nome: "Alisson", imagem: "alisson.jpg"), Jogador(nome: "De Gea", imagem: "degea.jpg"), Jogador(nome: "Navas", imagem: "navas.jpg")]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return goleiros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as! playerCell
        myCell.backgroundView = UIImageView(image: UIImage(named: self.goleiros[indexPath.row].imagem))
        myCell.title.text = self.goleiros[indexPath.row].nome
        myCell.translatesAutoresizingMaskIntoConstraints = false
        myCell.contentMode = .scaleToFill
        myCell.clipsToBounds = true
        myCell.layer.cornerRadius = 12
        myCell.layer.shadowColor = UIColor.darkGray.cgColor
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Goleiro: \(self.goleiros[indexPath.row].nome)")
        goleiroEscolhido = self.goleiros[indexPath.row]
        
        nextPage()
    }
    
    @objc func backToMainScreen() {
        
        navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func nextPage() {
    
        navigationController?.pushViewController(zsvc, animated: false)
    
    }

}

class zagueiroSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 800))
        view.backgroundColor = .systemBlue
        
        
        
        let label: UILabel = UILabel()
        label.font = UIFont(name: "PTSans-Bold", size: 20)
        label.text = "Escolha um zagueiro"
        label.textColor = .white
        label.frame = CGRect(x: 90, y: -20, width: 200, height: 100)
        label.textAlignment = .center
        
        
        let backButton: UIButton!
        backButton = UIButton()
        backButton.frame = CGRect(x: -90, y: -20, width: 250, height: 100)
        backButton?.layer.cornerRadius = 15
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 30)
        backButton.addTarget(nil, action: #selector(backToGoalkeeperSelection), for: .touchUpInside)
        
        let myLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        myLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        myLayout.itemSize = CGSize(width: 335, height: 175)
        myLayout.minimumLineSpacing = 20
        myLayout.scrollDirection = .vertical
        
        var myCollectionView: UICollectionView!
        myCollectionView = UICollectionView(frame: CGRect(x: 0, y: 61, width: 375, height: 607), collectionViewLayout: myLayout)
        myCollectionView.register(playerCell.self, forCellWithReuseIdentifier: "identifier")
        myCollectionView.backgroundColor = UIColor.systemYellow
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        view.addSubview(myCollectionView)
        view.addSubview(label)
        view.addSubview(backButton)
        
        self.view = view
        
        navigationController?.navigationBar.isHidden = true
    }
    
    public var zagueiros = [Jogador(nome: "Sergio Ramos", imagem: "ramos.jpg"), Jogador(nome: "Marquinhos", imagem: "marquinhos.jpg"), Jogador(nome: "Van Dijk", imagem: "vandijk.JPG")]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return zagueiros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as! playerCell
        myCell.backgroundView = UIImageView(image: UIImage(named: self.zagueiros[indexPath.row].imagem))
        myCell.title.text = self.zagueiros[indexPath.row].nome
        myCell.translatesAutoresizingMaskIntoConstraints = false
        myCell.contentMode = .scaleAspectFill
        myCell.clipsToBounds = true
        myCell.layer.cornerRadius = 12
        myCell.layer.shadowColor = UIColor.darkGray.cgColor
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Zagueiro: \(self.zagueiros[indexPath.row].nome)")
        zagueiroEscolhido = self.zagueiros[indexPath.row]

        nextPage()
    }
    
    @objc func backToGoalkeeperSelection() {

        navigationController?.popViewController(animated: false)
    }
    
    @objc func nextPage() {
    
        navigationController?.pushViewController(ldsvc, animated: false)
    
    }
}

class lateralDireitoSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 800))
        view.backgroundColor = .systemBlue
        
        
        
        let label: UILabel = UILabel()
        label.font = UIFont(name: "PTSans-Bold", size: 20)
        label.text = "Escolha um lateral direito"
        label.textColor = .white
        label.frame = CGRect(x: 80, y: -20, width: 220, height: 100)
        label.textAlignment = .center
        
        
        let backButton: UIButton!
        backButton = UIButton()
        backButton.frame = CGRect(x: -90, y: -20, width: 250, height: 100)
        backButton?.layer.cornerRadius = 15
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 30)
        backButton.addTarget(nil, action: #selector(backToZagueiroSelection), for: .touchUpInside)
        
        let myLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        myLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        myLayout.itemSize = CGSize(width: 335, height: 175)
        myLayout.minimumLineSpacing = 20
        myLayout.scrollDirection = .vertical
        
        var myCollectionView: UICollectionView!
        myCollectionView = UICollectionView(frame: CGRect(x: 0, y: 61, width: 375, height: 607), collectionViewLayout: myLayout)
        myCollectionView.register(playerCell.self, forCellWithReuseIdentifier: "identifier")
        myCollectionView.backgroundColor = UIColor.systemYellow
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        view.addSubview(myCollectionView)
        view.addSubview(label)
        view.addSubview(backButton)
        
        self.view = view
        
        navigationController?.navigationBar.isHidden = true
    }
    
    public var latDireitos = [Jogador(nome: "Alphonso Davies", imagem: "davies.jpg"), Jogador(nome: "Alex Telles", imagem: "telles.jpg"), Jogador(nome: "David Alaba", imagem: "alaba.jpg")]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return latDireitos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as! playerCell
        myCell.backgroundView = UIImageView(image: UIImage(named: self.latDireitos[indexPath.row].imagem))
        myCell.title.text = self.latDireitos[indexPath.row].nome
        myCell.translatesAutoresizingMaskIntoConstraints = false
        myCell.contentMode = .scaleAspectFill
        myCell.clipsToBounds = true
        myCell.layer.cornerRadius = 12
        myCell.layer.shadowColor = UIColor.darkGray.cgColor
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Lateral direito: \(self.latDireitos[indexPath.row].nome)")
        lateralDireitoEscolhido = self.latDireitos[indexPath.row]
        
        nextPage()
    }
    
    @objc func backToZagueiroSelection() {

        navigationController?.popViewController(animated: false)
    }
    
    @objc func nextPage() {
    
        navigationController?.pushViewController(lesvc, animated: false)
    
    }
}

class lateralEsquerdoSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 800))
        view.backgroundColor = .systemBlue
        
    
        
        let label: UILabel = UILabel()
        label.font = UIFont(name: "PTSans-Bold", size: 20)
        label.text = "Escolha um lateral esquerdo"
        label.textColor = .white
        label.frame = CGRect(x: 60, y: -20, width: 260, height: 100)
        label.textAlignment = .center
        
        
        let backButton: UIButton!
        backButton = UIButton()
        backButton.frame = CGRect(x: -90, y: -20, width: 250, height: 100)
        backButton?.layer.cornerRadius = 15
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 30)
        backButton.addTarget(nil, action: #selector(backToLatDireitoSelection), for: .touchUpInside)
        
        let myLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        myLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        myLayout.itemSize = CGSize(width: 335, height: 175)
        myLayout.minimumLineSpacing = 20
        myLayout.scrollDirection = .vertical
        
        var myCollectionView: UICollectionView!
        myCollectionView = UICollectionView(frame: CGRect(x: 0, y: 61, width: 375, height: 607), collectionViewLayout: myLayout)
        myCollectionView.register(playerCell.self, forCellWithReuseIdentifier: "identifier")
        myCollectionView.backgroundColor = UIColor.systemYellow
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        view.addSubview(myCollectionView)
        view.addSubview(label)
        view.addSubview(backButton)
        
        self.view = view
        
        navigationController?.navigationBar.isHidden = true
    }
    
    public var latEsquerdos = [Jogador(nome: "Kimmich", imagem: "kimmich.jpg"), Jogador(nome: "Carvajal", imagem: "carvajal.jpg"), Jogador(nome: "Walker", imagem: "walker.jpg")]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return latEsquerdos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as! playerCell
        myCell.backgroundView = UIImageView(image: UIImage(named: self.latEsquerdos[indexPath.row].imagem))
        myCell.title.text = self.latEsquerdos[indexPath.row].nome
        myCell.translatesAutoresizingMaskIntoConstraints = false
        myCell.contentMode = .scaleAspectFill
        myCell.clipsToBounds = true
        myCell.layer.cornerRadius = 12
        myCell.layer.shadowColor = UIColor.darkGray.cgColor
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Lateral esquerdo: \(self.latEsquerdos[indexPath.row].nome)")
        lateralEsquerdoEscolhido = self.latEsquerdos[indexPath.row]
        
        nextPage()
    }
    
    @objc func backToLatDireitoSelection() {

        navigationController?.popViewController(animated: false)
    }
    
    @objc func nextPage() {
    
        navigationController?.pushViewController(mcsvc, animated: false)
    
    }
}

class meioCampoSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 800))
        view.backgroundColor = .systemBlue
        
        
        
        let label: UILabel = UILabel()
        label.font = UIFont(name: "PTSans-Bold", size: 20)
        label.text = "Escolha um meio-campo"
        label.textColor = .white
        label.frame = CGRect(x: 80, y: -20, width: 220, height: 100)
        label.textAlignment = .center
        
        
        let backButton: UIButton!
        backButton = UIButton()
        backButton.frame = CGRect(x: -90, y: -20, width: 250, height: 100)
        backButton?.layer.cornerRadius = 15
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 30)
        backButton.addTarget(nil, action: #selector(backToLatEsquerdoSelection), for: .touchUpInside)
        
        let myLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        myLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        myLayout.itemSize = CGSize(width: 335, height: 175)
        myLayout.minimumLineSpacing = 20
        myLayout.scrollDirection = .vertical
        
        var myCollectionView: UICollectionView!
        myCollectionView = UICollectionView(frame: CGRect(x: 0, y: 61, width: 375, height: 607), collectionViewLayout: myLayout)
        myCollectionView.register(playerCell.self, forCellWithReuseIdentifier: "identifier")
        myCollectionView.backgroundColor = UIColor.systemYellow
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        view.addSubview(myCollectionView)
        view.addSubview(label)
        view.addSubview(backButton)
        
        self.view = view
        
        navigationController?.navigationBar.isHidden = true
    }
    
    public var meioCampos = [Jogador(nome: "Modrić", imagem: "modric.jpg"), Jogador(nome: "Pogba", imagem: "pogba.jpg"), Jogador(nome: "De Bruyne", imagem: "debruyne.jpg")]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return meioCampos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as! playerCell
        myCell.backgroundView = UIImageView(image: UIImage(named: self.meioCampos[indexPath.row].imagem))
        myCell.title.text = self.meioCampos[indexPath.row].nome
        myCell.translatesAutoresizingMaskIntoConstraints = false
        myCell.contentMode = .scaleAspectFill
        myCell.clipsToBounds = true
        myCell.layer.cornerRadius = 12
        myCell.layer.shadowColor = UIColor.darkGray.cgColor
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Meio-campo: \(self.meioCampos[indexPath.row].nome)")
        meioCampoEscolhido = self.meioCampos[indexPath.row]
        
        nextPage()
    }
    
    @objc func backToLatEsquerdoSelection() {

        navigationController?.popViewController(animated: false)
    }
    
    @objc func nextPage() {
    
        navigationController?.pushViewController(asvc, animated: false)
    
    }
}

class atacanteSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 800))
        view.backgroundColor = .systemBlue
        
        
        
        let label: UILabel = UILabel()
        label.font = UIFont(name: "PTSans-Bold", size: 20)
        label.text = "Escolha um atacante"
        label.textColor = .white
        label.frame = CGRect(x: 90, y: -20, width: 200, height: 100)
        label.textAlignment = .center
        
        
        let backButton: UIButton!
        backButton = UIButton()
        backButton.frame = CGRect(x: -90, y: -20, width: 250, height: 100)
        backButton?.layer.cornerRadius = 15
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 30)
        backButton.addTarget(nil, action: #selector(backToMeioCampoSelection), for: .touchUpInside)
        
        let myLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        myLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        myLayout.itemSize = CGSize(width: 335, height: 175)
        myLayout.minimumLineSpacing = 20
        myLayout.scrollDirection = .vertical
        
        var myCollectionView: UICollectionView!
        myCollectionView = UICollectionView(frame: CGRect(x: 0, y: 61, width: 375, height: 607), collectionViewLayout: myLayout)
        myCollectionView.register(playerCell.self, forCellWithReuseIdentifier: "identifier")
        myCollectionView.backgroundColor = UIColor.systemYellow
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        view.addSubview(myCollectionView)
        view.addSubview(label)
        view.addSubview(backButton)
        
        self.view = view
        
        navigationController?.navigationBar.isHidden = true
    }
    
    public var atacantes = [Jogador(nome: "Neymar", imagem: "neymar.jpg"), Jogador(nome: "Lewandowski", imagem: "lewandovski.jpg"), Jogador(nome: "Gabriel Jesus", imagem: "jesus.jpg")]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return atacantes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as! playerCell
        myCell.backgroundView = UIImageView(image: UIImage(named: self.atacantes[indexPath.row].imagem))
        myCell.title.text = self.atacantes[indexPath.row].nome
        myCell.translatesAutoresizingMaskIntoConstraints = false
        myCell.contentMode = .scaleAspectFill
        myCell.clipsToBounds = true
        myCell.layer.cornerRadius = 12
        myCell.layer.shadowColor = UIColor.darkGray.cgColor
        
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Atacante: \(self.atacantes[indexPath.row].nome)")
        atacanteEscolhido = self.atacantes[indexPath.row]
        
        let ctvc = completeTeamViewController()
        
        navigationController?.pushViewController(ctvc, animated: false)
    }
    
    @objc func backToMeioCampoSelection() {

        navigationController?.popViewController(animated: false)
    }
    
}

class completeTeamViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    override func loadView() {
        
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 800))
        view.backgroundColor = .systemBlue



        let label: UILabel = UILabel()
        label.font = UIFont(name: "PTSans-Bold", size: 20)
        label.text = "Esta é sua equipe"
        label.textColor = .white
        label.frame = CGRect(x: 90, y: -20, width: 200, height: 100)
        label.textAlignment = .center


        let backButton: UIButton!
        backButton = UIButton()
        backButton.frame = CGRect(x: 300, y: 15, width: 60, height: 30)
        backButton?.layer.cornerRadius = 15
        backButton.setTitle("Início", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 15)
        backButton.backgroundColor = .systemYellow
        backButton.addTarget(nil, action: #selector(backToMainScreen), for: .touchUpInside)

        let myLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        myLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        myLayout.itemSize = CGSize(width: 335, height: 175)
        myLayout.minimumLineSpacing = 20
        myLayout.scrollDirection = .vertical

        var myCollectionView: UICollectionView!
        myCollectionView = UICollectionView(frame: CGRect(x: 0, y: 61, width: 375, height: 607), collectionViewLayout: myLayout)
        myCollectionView.register(playerCell.self, forCellWithReuseIdentifier: "identifier")
        myCollectionView.backgroundColor = UIColor.systemYellow
        myCollectionView.dataSource = self
        myCollectionView.delegate = self

        view.addSubview(myCollectionView)
        view.addSubview(label)
        view.addSubview(backButton)

        self.view = view

        navigationController?.navigationBar.isHidden = true
    }


    var equipeCompleta = [goleiroEscolhido!, zagueiroEscolhido!, lateralDireitoEscolhido!, lateralEsquerdoEscolhido!, meioCampoEscolhido!, atacanteEscolhido!]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return equipeCompleta.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as! playerCell
        myCell.backgroundView = UIImageView(image: UIImage(named: self.equipeCompleta[indexPath.row].imagem))
        myCell.title.text = self.equipeCompleta[indexPath.row].nome
        myCell.translatesAutoresizingMaskIntoConstraints = false
        myCell.contentMode = .scaleAspectFill
        myCell.clipsToBounds = true
        myCell.layer.cornerRadius = 12
        myCell.layer.shadowColor = UIColor.darkGray.cgColor


        return myCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Esta é sua equipe")

    }

    @objc func backToMainScreen() {

        navigationController?.popToRootViewController(animated: false)
    }

}

class playerCell: UICollectionViewCell {
    
    
    fileprivate let title: UILabel = UILabel(frame: CGRect(x: -10, y: 110, width: 350, height: 80))
    let attrString = NSAttributedString(
        string: "\(String(describing: jogadorEscolhido))",
        attributes: [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeWidth: -4.0,
            NSAttributedString.Key.font: UIFont(name: "PTSans-Bold", size: 40) ?? " "
        ]
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        

        
        title.textColor = .white
        title.font = UIFont(name: "PTSans-Bold", size: 35)
        title.textAlignment = .center
        title.lineBreakMode = NSLineBreakMode.byWordWrapping
        title.numberOfLines = 2
        title.attributedText = attrString
        
        contentView.addSubview(title)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
}

let msvc = mainScreenViewController()
let gsvc = goleiroSelectionViewController()
let zsvc = zagueiroSelectionViewController()
let ldsvc = lateralDireitoSelectionViewController()
let lesvc = lateralEsquerdoSelectionViewController()
let mcsvc = meioCampoSelectionViewController()
let asvc = atacanteSelectionViewController()


let navigation = UINavigationController(rootViewController: msvc)
PlaygroundPage.current.liveView = navigation

