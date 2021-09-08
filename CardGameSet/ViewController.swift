//
//  ViewController.swift
//  CardGameSet
//
//  Created by Alexis on 10/10/20.
//  Copyright © 2020 Cooper Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let dataArray = ["AAA", "BBB", "CCC", "DDD","AAA", "BBB", "CCC", "DDD", "BBB", "CCC", "DDD","AAA", "BBB", "CCC", "DDD"]
    var test = NSAttributedString()
    var nsStringArray:[NSAttributedString] = []
    var estimateWidth = 160.0
    var global: String = "NotSet"
    
    @IBOutlet weak var notificationLabel: UILabel!
    
    @IBOutlet weak var buttonDeal: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet var secondDozen: [UIButton]!
    
    //@IBOutlet weak var cardsContainerView: CardContainerView!
    //@IBOutlet weak var cardContainerView: CardContainerView!
    
    lazy var cardsOnScreen = nsStringArray.count//cardButtons.count
    

    
    //responsible for creating a new game
    @IBAction func newGameButton(_ sender: UIButton) {
        
        game = CardGameSet(numberOfCards: numOfCards)
        game?.gameReset()
        cardsOnScreen = 11
        resetCardsInGame()
        updateViewFromModel()
        
    }
    
    //this is the button that will deal 3 cards if pressed
    @IBAction func dealButton(_ sender: UIButton) {
       /* if(cardsOnScreen != 23){
        for _ in 1...3{
            cardsOnScreen = cardsOnScreen + 1
            cardButtons[cardsOnScreen].isHidden = false
        }
        }else{
            ///buttonDeal.isHidden = true
            print("no more cards on screen")
        }
        
        if(cardsOnScreen == 23){
            buttonDeal.isHidden = true
        }
        //cardButtons[9].isHidden = false
        
        */
        cardsOnScreen = cardsOnScreen + 3
        updateLayout()
        
    }
    //this is kind of like a helper class for newGameButton
    func resetCardsInGame(){
        print("Hello world")
        buttonDeal.isHidden = false
        
        for _ in 1...12{
            cardsOnScreen = cardsOnScreen + 1
            cardButtons[cardsOnScreen].isHidden = true
        }
        cardsOnScreen = 11
        
        
        
    }
    
    private var game : CardGameSet?
    
    //numOfCards gives the nums of cardsbuttons
    private var numOfCards:Int{
        return cardButtons.count
    }
    
    
   /* override func loadView() {
        super.loadView()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cv)
        NSLayoutConstraint.activate([
            cv.topAnchor.constraint(equalTo: view.topAnchor),
            cv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        self.collectionView = cv
        
        
    }*/
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        game = CardGameSet(numberOfCards: numOfCards )
        updateViewFromModel()
        //cardsContainerView.addCardButtons(byAmount: 11)
        //cardContainerView.addCardButtons(byAmount: 2)
        
        //set delegates
        
        updateLayout()
        
        //collectionView.backgroundColor = .white
        //collectionView.dataSource = self
        //collectionView.delegate = self
        
        //collectionView.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
        
        
    }
    
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
 */
    
    
    func updateLayout(){
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: (view.frame.size.width/3) - 50, height: ( view.frame.size.width/3) - 50 )
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isScrollEnabled = false
        //self.collectionView.clipsToBounds = true
        //register cells
        self.collectionView.register(ItemCell.nib() , forCellWithReuseIdentifier: ItemCell.identifier)
    }
    //*********************************************************
    //button responsible for when user touches a card on screen
    //*********************************************************
    @IBAction func cardIsTouched(_ sender: UIButton) {
        notificationLabel.text = "Notification"
        if let cardNumber = cardButtons.index(of: sender){
            print(cardNumber)
            if var setGame = game{
                setGame.deSelectCard(at: cardNumber)
                setGame.cardSelected(at: cardNumber)
                game = setGame
                let selectedCards = setGame.selectedCards
                if selectedCards.count == 3 {
                    if(setGame.itsASet() == false){
                        print("Not a Set")
                        notificationLabel.text = "Not a Set"
                        setGame.unSelectSet()
                        
                        game = setGame
                        //game = setGame
                    }else{
                        print("Its A Set")
                        notificationLabel.text = "Its a Set"
                        setGame.makeASet()
                        //gameBuilder()
                        game = setGame
                        //gameBuilder()
                    }
                    
                }
                updateViewFromModel()
                
            }
        }
    }
    
    //updates whats on the screen
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            if let setGame = game{
                let cards = setGame.cards
                scoreLabel.text = "Score: \(setGame.scoreTracker)"
                let card = cards[index]
                
                let button = cardButtons[index]
                let colorNShade = getColorNShade(card: card)
                let shape = getShape(card: card)
                let attributedString = NSAttributedString(
                    string: shape, attributes: colorNShade)
                if (card.isFaceUp){
                    //button.setTitle("Touched", for: UIControl.State.normal)
                    
                    button.backgroundColor = #colorLiteral(red: 0.9838003062, green: 1, blue: 0.122650244, alpha: 1)
                    button.setAttributedTitle(attributedString, for: UIControl.State.normal)
                    //ItemCell.configure(Ite)
                    global = "updated"
                    //nsStringArray.append(attributedString)
                    
                }else{
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    button.setAttributedTitle(attributedString, for: UIControl.State.normal)
                    nsStringArray.append(attributedString)
                    global = "updated"
                    
                }

            }
        }
        
        
    }
    
    //gets color and shade from NSAttributedString
    private func getColorNShade(card: PlayingCard) ->
           [NSAttributedString.Key: Any] {
           var defaulColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
           var attributes: [NSAttributedString.Key: Any] = [
               .foregroundColor: defaulColor,
           ]
           if let cardColor = card.color {
               switch cardColor {
               case .red:
                   defaulColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                   attributes[.foregroundColor] = defaulColor
               case .purple:
                   defaulColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                   attributes[.foregroundColor] = defaulColor
               case .green:
                   defaulColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                   attributes[.foregroundColor] = defaulColor
               }
           }
           if let cardShade = card.shade {
               switch cardShade {
               case .Fill:
                   attributes[.strokeWidth] = 0
               case .notFill:
                   attributes[.strokeWidth] = 8.0
                   attributes[.strokeColor] = defaulColor
               case .striped:
                   attributes[.strokeWidth] = 8.0
                   attributes[.strokeColor] = defaulColor
                   attributes[.strikethroughStyle] = 2.0
               }
           }
           return attributes
       }
    
    //gets shape atrributes
    private func getShape(card: PlayingCard) -> String {
        var textContent = ""
        if let cardNumber = card.number {
            switch cardNumber {
            case .one:
                if let cardSymbol = card.shape {
                    textContent = String(repeating: cardSymbol.description,
                                         count: 1)
                    
                }
            case .two:
                if let cardSymbol = card.shape {
                    textContent = String(repeating: cardSymbol.description,
                                         count: 2)
                }
            case .three:
                if let cardSymbol = card.shape {
                    textContent = String(repeating: cardSymbol.description,
                                         count: 3)
                }
            }
        }
        return textContent
    }
}

extension ViewController: UICollectionViewDataSource{
    
    /*func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsOnScreen
    }
    //responsible for passind data to the nib
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as! ItemCell
        cell.configure(text: nsStringArray[indexPath.row])
        return cell
        
    }
    //function responsible for having each card withing the container and based on how many cards are in the table
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        let hightSize = Int((collectionView.bounds.height - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: hightSize)
        //return  CGSize(width: collectionView.bounds.size.width/3 - yourCellInterItemSpacing, height: collectionView.bounds.size.height/3 - yourCellInterItemSpacing)
    }


   

    
    //cell.textLabel.text = String(indexPath.row + 1)
    
    
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAtIndex section: Int) -> UIEdgeInsets {

        let cellWidthPadding = collectionView.frame.size.width / 30
        let cellHeightPadding = collectionView.frame.size.height / 4
        return UIEdgeInsets(top: cellHeightPadding,left: cellWidthPadding, bottom: cellHeightPadding,right: cellWidthPadding)
    }
    /*
    func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
                let kWhateverHeightYouWant = 80
                return CGSize(width: collectionView.bounds.size.width, height: CGFloat(kWhateverHeightYouWant))
    }
 ////
    func collectionView( collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPaath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 120)
    }
    
}
     */

/*extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
    }
    
    func calculateWith() -> CGFloat{
        let estimateWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width) / estimateWidth)
    }
 
}
 */
}


class MyCell: UICollectionViewCell{
    weak var textLabel: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        textLabel = label
        contentView.backgroundColor = .lightGray
        textLabel.textAlignment = .center
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
