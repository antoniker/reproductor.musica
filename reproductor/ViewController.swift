//
//  ViewController.swift
//  reproductor
//
//  Created by Ing. José Antonio Franco Cortés on 10/06/16.
//  Copyright © 2016 xquared. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {

    @IBOutlet weak var portada: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var Play: UIButton!
    @IBOutlet weak var Adelante: UIButton!
    @IBOutlet weak var Atras: UIButton!
   
    
    let AtrasIcono = UIImage(named: "rewind")
    let PlayIcono = UIImage(named: "play")
    let PausaIcono = UIImage(named: "pause")
    let SiguienteIcono = UIImage(named: "fast")
    
    let ListaTitulos: [String] =   ["This Corner","Kings never died","Beast"]
    let ListaAutores: [String] =  ["Kon Artis","Eminem (Feat Gwen Stefany)","Busta Rhymes"]
    let ListaCanciones: [String] =    ["sound1","sound2","sound3"]
    let ListaImagenes: [String] =   ["image1","image2","image3"]
    
    
    var Player = AVAudioPlayer()
    var Indice: Int!


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        
        }catch let error as NSError {
            print(error)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        Atras.setImage(AtrasIcono, forState: .Normal)
        Play.setImage(PlayIcono, forState: .Normal)
        Adelante.setImage(SiguienteIcono, forState: .Normal)

        Indice = 0
        agregarCancion(NumeroCancion: Indice)
        
        
        let Volumen = UIView(frame: CGRectMake(85, 610, 230, 20))
        let VistaVolumen = MPVolumeView(frame: Volumen.bounds)
        Volumen.addSubview(VistaVolumen)
        self.view.addSubview(Volumen)
        
    }
    
    func agregarCancion(NumeroCancion NumeroCancion: Int){
        
        let CancionFuente = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(ListaCanciones[NumeroCancion], ofType: "mp3")!)
        let PortadaFuente = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(ListaImagenes[NumeroCancion], ofType: "jpg")!)
        let coverData = NSData(contentsOfURL: PortadaFuente)
        
        do{
            
            Player = try AVAudioPlayer(contentsOfURL: CancionFuente)
            Player.play()
            Play.setImage(PausaIcono, forState: .Normal)
            
            portada.image = UIImage(data: coverData!)
            titulo.text = ListaTitulos[NumeroCancion]
            autor.text = ListaAutores[NumeroCancion]
            
        }catch{
            
            print("Error")
            
            
        }
    }
 
    
    @IBAction func PlayCancion(sender: AnyObject) {
        
        if !Player.playing{
            
            Player.play()
            Play.setImage(PausaIcono, forState: .Normal)
            
        }else{
            
            Player.pause()
            Play.setImage(PlayIcono, forState: .Normal)
            
        }

    }
    
    @IBAction func SiguienteCancion(sender: AnyObject) {
        
        if Indice == ListaCanciones.count - 1{
            
            Indice! = -1
            
        }
        
        Indice! += 1
        
        agregarCancion(NumeroCancion: Indice)
        print(Indice)

    }
    
    @IBAction func AtrasCancion(sender: AnyObject) {
       
        if Indice == 0{
            
            Indice = ListaCanciones.count
        }
        
        Indice! -= 1
        
        agregarCancion(NumeroCancion: Indice)
        print(Indice)

    }
    
    @IBAction func Aleatorio(sender: AnyObject) {
    
        let shuffle = Int(arc4random_uniform(UInt32(ListaCanciones.count)))
        agregarCancion(NumeroCancion: shuffle)
        print(shuffle)
        
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if motion == .MotionShake {
            
            let aleatorio = Int(arc4random_uniform(UInt32(ListaCanciones.count)))
            agregarCancion(NumeroCancion: aleatorio)
            print(aleatorio)
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

