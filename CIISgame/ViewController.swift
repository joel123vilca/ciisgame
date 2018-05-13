//
//  ViewController.swift
//  CIISgame
//
//  Created by Apple on 12/05/18.
//  Copyright © 2018 esis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var board: UIView!
    var cuadrowidth : CGFloat = 0.0
    var cuadrocenterX : CGFloat = 0.0
    var cuadrocenterY : CGFloat = 0.0
    
    var cuadroarray : NSMutableArray = []
    var cuadrocenterarray : NSMutableArray = []
    
    var cuadroEmptyCenter : CGPoint = CGPoint(x: 0, y: 0)
    
    @IBAction func btnRandom(_ sender: Any) {
        randomcuadros()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makecuadro()
        randomcuadros()
    }
    
    func makecuadro(){
        self.cuadroarray = []
        self.cuadrocenterarray = []
        // Do any additional setup after loading the view, typically from a nib.
        let boardwidth = self.board.frame.width
        self.cuadrowidth = boardwidth / 4
        self.cuadrocenterX = self.cuadrowidth / 2
        self.cuadrocenterY = self.cuadrowidth / 2
        var cuadroNumber : Int = 1
        
        for _ in 0..<4{
            for _ in 0..<4{
            let cuadroFrame : CGRect = CGRect(x: 0, y: 0, width: self.cuadrowidth - 2, height: self.cuadrowidth - 2)
            let cuadro : CustomCuadro  = CustomCuadro(frame: cuadroFrame)
            
            let  currentCenter : CGPoint = CGPoint(x: self.cuadrocenterX, y: self.cuadrocenterY)
            cuadro.center = currentCenter
            cuadro.origincenter = currentCenter
            cuadro.text = "\(cuadroNumber)"
            cuadro.textAlignment = NSTextAlignment.center
            cuadro.isUserInteractionEnabled = true//interaccion con el touch
            
            //guardando la posicion central del label
            self.cuadrocenterarray.add(currentCenter)
            cuadro.backgroundColor = UIColor.red
            self.board.addSubview(cuadro)
            cuadroNumber = cuadroNumber + 1
                
                
            self.cuadroarray.add(cuadro)//guardando los datos de los cuadros en el array
            
            self.cuadrocenterX = self.cuadrocenterX + cuadrowidth
            }
            self.cuadrocenterX = self.cuadrowidth / 2
            self.cuadrocenterY = self.cuadrocenterY + cuadrowidth
        }
        let ultimocuadro : CustomCuadro = self.cuadroarray.lastObject as! CustomCuadro
        ultimocuadro.removeFromSuperview()
        self.cuadroarray.removeObject(at : 15)
    }
    
    func randomcuadros(){
        let tempcuadrocenterarray : NSMutableArray = self.cuadrocenterarray.mutableCopy() as! NSMutableArray
        
        for anycuadro in self.cuadroarray{
            let randomindex : Int = Int(arc4random()) % tempcuadrocenterarray.count//indice 5
            let randomcenter : CGPoint = tempcuadrocenterarray[randomindex] as! CGPoint// x=80 , y=90
            (anycuadro as! CustomCuadro).center = randomcenter
            //elimine si ya uso ese numero del cuadro
            tempcuadrocenterarray.removeObject(at: randomindex)
            
        }
        self.cuadroEmptyCenter = tempcuadrocenterarray[0] as! CGPoint
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentTouch : UITouch = touches.first!//calcular el evento que esta tocando el usuario
        if (self.cuadroarray.contains(currentTouch.view as Any))//identificando si la vista que toca esta dentro de los cuadros
        {
            //currentTouch.view?.alpha = 0
            let touchlabel : CustomCuadro = currentTouch.view as! CustomCuadro
            let xDif : CGFloat = touchlabel.center.x - self.cuadroEmptyCenter.x
            let yDif : CGFloat = touchlabel.center.y - self.cuadroEmptyCenter.y
            //calculamos la distancia entre los dos puntos
            let distance : CGFloat = sqrt(pow(xDif,2) + pow(yDif,2))
            //comprobamos para poder mover
            if(distance == self.cuadrowidth){
                let tempcenter: CGPoint = touchlabel.center
                touchlabel.center = self.cuadroEmptyCenter
                self.cuadroEmptyCenter = tempcenter
            }
        }
    }
}

class CustomCuadro : UILabel{
    var origincenter : CGPoint = CGPoint(x: 0, y: 0)
}

