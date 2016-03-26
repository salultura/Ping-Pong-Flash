import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.media.Sound;

//Som

//var som:URLRequest = new URLRequest("ping.mp3");
var rebateu:Sound = new Som();


//Controle CPU
var velocidadeCpu:Number = 6;

//pontos
var pontosCpu:int = 0;
var pontosJogador:int = 0;

//Variaveis de controle da bola
var bolaX:Number;
var bolaY:Number;
var velocidadeBola:Number = 0;

//Verifica se o jogo foi inicializado
var inicio:Boolean = false;

//Coloca a bola em modo botão
bola_mc.buttonMode = true;


//Controles do Jogador
jogador_mc.addEventListener(Event.ENTER_FRAME, controleJogador);

function controleJogador(e:Event):void{
	e.target.y = mouseY;
	
	if(e.target.y <= 50){
		e.target.y = 50;
	}else if(e.target.y >= 350){
		e.target.y = 350;
	}
}

//Controle da bola

//Inicio do jogo
bola_mc.addEventListener(MouseEvent.MOUSE_DOWN, cliqueNaBola);

function cliqueNaBola(e:MouseEvent):void{
	if(inicio == false){
		inicio = true;
		e.target.buttonMode = false;
		
		//
		if(Math.random() * 10 < 5){
			bolaX = 1;
		}else{
			bolaX = -1;
		}
		
		bolaY = 0;
		velocidadeBola = 8;
		
	}
}

bola_mc.addEventListener(Event.ENTER_FRAME, controlaBola);

function controlaBola(e:Event):void{
	if(inicio == true){
		
		//Inicia com bola na horizontal
		e.target.x += velocidadeBola * bolaX;
		e.target.y += velocidadeBola * bolaY;
		
		//Controla a colisao da bola nas raquetes
		if(e.target.hitTestObject(jogador_mc)){
			bolaY = (e.target.y - jogador_mc.y)/16;
			
			bolaX *= -1;
			
			rebateu.play();
		}
		
		if(e.target.hitTestObject(cpu_mc)){
			bolaY = (e.target.y - cpu_mc.y)/16;
			
			bolaX *= -1;
			
			rebateu.play();
		}
		
		//evita que a bola saia no eixo Y
		if(e.target.y <= 8 || e.target.y > 392){
			bolaY *= -1;
		}
		
		//Marcacao de pontos
		
		//Ponto do jogador
		if(e.target.x <=0){
			//Para a bola
			velocidadeBola = 0;
			//Posiciona a bola no centro 
			e.target.x = stage.stageWidth / 2;
			e.target.y = stage.stageHeight / 2;
			cpu_mc.y = stage.stageHeight / 2;
			inicio = false;
			e.target.buttonMode = true;
			pontosJogador++;
			placarJogador_txt.text = String(pontosJogador);
			//ponto da CPU
		}else if(e.target.x >= stage.stageWidth){
			//Para a bola
			velocidadeBola = 0;
			//Posiciona a bola no centro 
			e.target.x = stage.stageWidth / 2;
			e.target.y = stage.stageHeight / 2;
			cpu_mc.y = stage.stageHeight / 2;
			inicio = false;
			e.target.buttonMode = true;
			pontosCpu++;
			placarCpu_txt.text = String(pontosCpu);
		}
	}
}

cpu_mc.addEventListener(Event.ENTER_FRAME, controlaCpu);

function controlaCpu(e:Event):void{
	if(inicio == true){
		if(bola_mc.x < 400 && bolaX < 1){
			if(bola_mc.y > e.target.y + velocidadeCpu){
				e.target.y += velocidadeCpu;
			}else if(bola_mc.y < e.target.y - velocidadeCpu){
				e.target.y -= velocidadeCpu;
			}else{
				if(e.target.y < 200){
					e.target.y += velocidadeCpu;
				}else if(e.target.y > 200){
					e.target.y -= velocidadeCpu;
				}
			}
		}
	}
}



















