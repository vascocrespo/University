function enter(c, dx, dy, sx, sy) {
    c.save();
    c.translate(dx,dy);
    c.scale(sx,sy);
}

function leave(c, fs, ss) {
    c.restore();
    c.fillStyle = fs;
    c.strokeStyle = ss;
    c.fill();
    c.stroke();
}

function leave_width(c, fs, ss, w) {
	c.restore();
	c.fillStyle = fs;
	c.strokeStyle = ss;
	c.lineWidth = w;
	c.fill();
	c.stroke();
	c.lineWidth = 0;
	}

function rectangulo(c,largura,comprimento,x,y,color){
	c.fillStyle = color;
	c.fillRect(x,y,largura,comprimento);

}

function losango(c, x1 , y1 , x2, y2){
    c.beginPath();
    
    c.moveTo( 0.12 + x1 + x2, 0.32 - y1 + y2);
    c.lineTo( 0.11+ x1 + x2,  0.65 - y1 + y2);
    c.lineTo( 0.27 + x1 + x2,  0.69 + y1 - y2);
    c.lineTo( 0.28 + x1 + x2, 0.38 - 0.02 + y1 -y2);
    c.closePath();

}

function circulo(c){
    c.beginPath();
        c.ellipse(30.6,12,2,2,0,0,2*Math.PI);
    c.closePath();
}



function triangulo(c){
    c.beginPath();
    c.moveTo(0.58, 0.335);
    c.lineTo(0.56, 0.31);
    c.lineTo(0.60,0.31);
    c.closePath();
}

function trianguloRetangulo(c){
	c.beginPath();
	c.moveTo(1,0);
	c.lineTo(0,1);
	c.lineTo(-1,0);
	c.closePath();

}

function linhaLocalizador(c){
    c.beginPath();
    c.moveTo(0.29, 0.565);
    c.lineTo(0.29, 0.595);
    c.closePath();
}

function linhasEscuras(c){
    c.beginPath();

    //linha de cima -esquerda (cima para baixo)
    c.moveTo(0.12,0.32);
    c.lineTo(0.16, 0.38);
    c.moveTo(0.16,0.38);
    c.lineTo(0.20,0.34);
    c.moveTo(0.20,0.34);
    c.lineTo(0.281,0.44);
    c.moveTo(0.281,0.44);
    c.lineTo(0.285,0.45);
    c.moveTo(0.285,0.45);
    c.lineTo(0.32,0.46);
    c.moveTo(0.32,0.46);
    c.lineTo(0.35,0.52);
    
   //linha de baixo -esquerda (baixo para cima)
    c.moveTo(0.11,0.62);
    c.lineTo(0.16,0.64);
    c.moveTo(0.16,0.64);
    c.lineTo(0.225,0.61);
    c.moveTo(0.225,0.61);
    c.lineTo(0.20,0.56);
    c.moveTo(0.20,0.56);
    c.lineTo(0.233,0.54);
    c.moveTo(0.233,0.54);
    c.lineTo(0.23,0.48);
    c.moveTo(0.23,0.48);
    c.lineTo(0.28,0.50);

    //linha do meio da direta -meio(baixo para cima)
    c.moveTo(0.41,0.67);
    c.lineTo(0.39,0.63);
    c.moveTo(0.39,0.63);
    c.lineTo(0.41,0.60);
    c.moveTo(0.41,0.60);
    c.lineTo(0.38,0.59);
    c.moveTo(0.38,0.59); //esta!
    c.lineTo(0.41,0.56);
    c.moveTo(0.41,0.56);
    c.lineTo(0.39,0.51);
    c.moveTo(0.39,0.51);
    c.lineTo(0.425,0.47);
    c.moveTo(0.425,0.47);
    c.lineTo(0.42,0.405);
    c.moveTo(0.42,0.405);
    c.lineTo(0.38,0.43);
    c.moveTo(0.38,0.43);
    c.lineTo(0.35,0.40);
    c.moveTo(0.35,0.40);
    c.lineTo(0.40,0.37);
    
    //linha da esquerda em baixo -meio (cima para baixo)
    c.moveTo(0.38,0.59);
    c.lineTo(0.355,0.615);
    c.moveTo(0.355,0.615);
    c.lineTo(0.356,0.66);
    
    //linha do meio que vem da direita para a esquerda -meio
    c.moveTo(0.452,0.49);
    c.lineTo(0.415,0.55);
    c.moveTo(0.415,0.55);
    c.lineTo(0.39,0.54);
    c.moveTo(0.39,0.54);
    c.lineTo(0.37,0.56);

    //linha da direita em baixo - direita   
    c.moveTo(0.56,0.65);
    c.lineTo(0.59,0.61);
    c.moveTo(0.59,0.61);
    c.lineTo(0.51,0.615);
    c.moveTo(0.51,0.615);
    c.lineTo(0.555,0.58);

    c.moveTo(0.572,0.557);
    c.lineTo(0.555,0.554);

    //liha do meio - direita (de baixo ate ao topo)
    c.moveTo(0.545,0.55);
    c.lineTo(0.53,0.547);
    c.moveTo(0.53,0.547);
    c.lineTo(0.58,0.43);
    c.moveTo(0.58,0.43);
    c.lineTo(0.50,0.431);
    c.moveTo(0.50,0.431);
    c.lineTo(0.53,0.35);

    //linha solta em baixo da esquerda para a direita - direita
    c.moveTo(0.543,0.56);
    c.lineTo(0.475,0.60);
    c.moveTo(0.475,0.60);
    c.lineTo(0.485,0.62);
    c.moveTo(0.485,0.62);
    c.lineTo(0.47,0.645);

    c.closePath();
 
}

function linhasClaras(c){
    c.beginPath();
    
    //linhas de cima - esquerda
    c.moveTo(0.26,0.355);
    c.lineTo(0.238,0.37);
    c.moveTo(0.238,0.37);
    c.lineTo(0.24,0.41);
    c.moveTo(0.24,0.41);
    c.lineTo(0.21,0.42);
    c.moveTo(0.21,0.42);
    c.lineTo(0.19,0.45);
    c.moveTo(0.19,0.45);
    c.lineTo(0.23,0.465);
    c.moveTo(0.23,0.465);
    c.lineTo(0.21,0.485);
    c.moveTo(0.21,0.42);
    c.lineTo(0.19,0.39);
    c.moveTo(0.19,0.39);
    c.lineTo(0.15,0.41);
    c.moveTo(0.15,0.41);
    c.lineTo(0.135,0.37);

    //linha do meio à esquerda - esquerda
    c.moveTo(0.115,0.44);
    c.lineTo(0.175,0.48);
    c.moveTo(0.175,0.48);
    c.lineTo(0.175,0.488);

    //linha por baixo do localizador - esquerda
    c.moveTo(0.16,0.53);
    c.lineTo(0.157,0.54);
    c.moveTo(0.157,0.54);
    c.lineTo(0.185,0.57);
    c.moveTo(0.185,0.57);
    c.lineTo(0.165,0.58);
    c.moveTo(0.166,0.58);
    c.lineTo(0.11,0.58);

    //linha em baixo ao lado do localizador grande - esquerda
    c.moveTo(0.212,0.58);
    c.lineTo(0.24,0.593);

    //linha colada ao localizador por baixo - esquerda
    c.moveTo(0.257,0.625);
    c.lineTo(0.249,0.630);
    c.moveTo(0.249,0.630);
    c.lineTo(0.273,0.66);

    //linhas na parte de baixo - esquerda
    c.moveTo(0.225,0.61);
    c.lineTo(0.248,0.64);
    c.moveTo(0.248,0.64);
    c.lineTo(0.21,0.66);
    c.moveTo(0.21,0.66);
    c.lineTo(0.245,0.67);
    c.moveTo(0.245,0.67);
    c.lineTo(0.26,0.685);

    c.moveTo(0.225,0.61);
    c.lineTo(0.20,0.65);
    c.moveTo(0.20,0.65);
    c.lineTo(0.16,0.65);

    c.moveTo(0.27,0.53);
    c.lineTo(0.27,0.556);

    //linhas de cima - meio
    c.moveTo(0.295,0.36);
    c.lineTo(0.305,0.375);
    c.moveTo(0.305,0.375);
    c.lineTo(0.33,0.385);
    c.moveTo(0.33,0.385);
    c.lineTo(0.325,0.43);
    c.moveTo(0.325,0.43);
    c.lineTo(0.36,0.455);
    c.moveTo(0.36,0.455);
    c.lineTo(0.39,0.43);

    //linhas do meio -meio
    c.moveTo(0.305,0.458);
    c.lineTo(0.315,0.53);
    c.moveTo(0.315,0.53);
    c.lineTo(0.355,0.53);
    c.moveTo(0.355,0.53);
    c.lineTo(0.36,0.56);
    c.moveTo(0.36,0.56);
    c.lineTo(0.37,0.56);
    c.moveTo(0.37,0.56);
    c.lineTo(0.37,0.597);

    c.moveTo(0.28,0.66);
    c.lineTo(0.30,0.658);
    c.moveTo(0.30,0.658);
    c.lineTo(0.315,0.67);

    //linhas da esquerda - direita
    c.moveTo(0.458,0.38);
    c.lineTo(0.47,0.45);
    c.moveTo(0.47,0.45);
    c.lineTo(0.456, 0.49);
    c.moveTo(0.456,0.49);
    c.lineTo(0.48, 0.52);
    c.moveTo(0.48,0.52);
    c.lineTo(0.478,0.52);
    c.moveTo(0.478,0.52);
    c.lineTo(0.481,0.55);
    c.moveTo(0.481,0.55);
    c.lineTo(0.50,0.565);
    c.moveTo(0.50,0.565);
    c.lineTo(0.483,0.595);
    c.moveTo(0.483,0.595);
    c.lineTo(0.51,0.60);
    c.moveTo(0.51,0.60);
    c.lineTo(0.490,0.635);
    c.moveTo(0.490,0.635);
    c.lineTo(0.502,0.638);
    c.moveTo(0.502,0.638);
    c.lineTo(0.505,0.655);
    c.moveTo(0.505,0.655);
    c.lineTo(0.513,0.663);
    c.moveTo(0.513,0.663);
    c.lineTo(0.54,0.66)

    //linha na parte de baixo a direira - direita
    c.moveTo(0.56,0.65);
    c.lineTo(0.545,0.665);
    c.moveTo(0.545,0.665);
    c.lineTo(0.59,0.662);
    c.moveTo(0.59,0.662);
    c.lineTo(0.586,0.678);
    c.moveTo(0.586,0.678);
    c.lineTo(0.595,0.682);

    //linha no meio mesmo - direita
    c.moveTo(0.525,0.43);
    c.lineTo(0.52,0.448);
    c.moveTo(0.52,0.448);
    c.lineTo(0.57,0.465);
    c.moveTo(0.57,0.465);
    c.lineTo(0.53,0.527);
    c.moveTo(0.53,0.527);
    c.lineTo(0.567,0.567);

    //linda de cima da direita - direita
    c.moveTo(0.555,0.345);
    c.lineTo(0.565,0.375);
    c.moveTo(0.565,0.375);
    c.lineTo(0.605,0.356);
    c.moveTo(0.605,0.356);
    c.lineTo(0.622,0.38);

    //mini linha da direita -direita
    c.moveTo(0.622,0.42);
    c.lineTo(0.613,0.425);

    //linha pequeninca do meio da direita - direita
    c.moveTo(0.622,0.53);
    c.lineTo(0.605,0.53);
    c.moveTo(0.605,0.53);
    c.lineTo(0.605,0.57);
  
    c.closePath();
}


function linhasWidth(c){
	c.beginPath();
	
	c.moveTo(0.53,0.35);
    c.lineTo(0.485,0.37);
    
    c.moveTo(0.62,0.63);
    c.lineTo(0.56,0.65);

	c.moveTo(0.35,0.52);
    c.lineTo(0.385,0.515);

    c.moveTo(0.40,0.37);
    c.lineTo(0.375,0.34);	

    c.moveTo(0.356,0.66);
    c.lineTo(0.315, 0.67);
    c.moveTo(0.315,0.67);
    c.lineTo(0.315,0.70);

    c.closePath();
}

function letrasCima(c){
	c.beginPath();
	
	c.font="bold italic 30px Bodoni MT";
	c.fillText("Paper Towns",0,0);

	c.closePath();
}


function letrasBaixo(c){
	c.beginPath();
	c.font = "bold 30px Calibri";
	c.fillText("JOHN  GREEN", 0, 0);
	c.closePath();

}

function mapa(c, opacity){

    enter(c,6,15,400,500);
    losango(c , 0, 0, 0, 0);
    leave(c,"white", "white");

    enter(c,6,15,400,500);
    losango(c , 0.17, -0.04, 0, 0);
    leave(c,"white", "white");
    
    enter(c,6,15,400,500);
    losango(c , 0.18, -0.05, 0.16, -0.05);
    leave(c,"white", "white");

//preto de cima da direita
    
    enter(c, 92, 208,3.5,3.5);
    circulo(c);
    leave(c,"black", "black");

    enter(c,25.5,98,300,500);
    triangulo(c);
    leave(c,"black", "black");

    enter(c, 153.5, 232, 1.5, 1.5);
    circulo(c);
    leave(c,"white", "white");

    //preto de baixo da direita
    
    enter(c, 108, 245,4,4);
    circulo(c);
    leave(c,"black", "black");

    enter(c,56.5,142,300,500);
    triangulo(c);
    leave(c,"black", "black");

    enter(c, 184.8, 275, 1.5, 1.5);
    circulo(c);
    leave(c,"white", "white");

    //preto do meio
    
    enter(c, 77, 206.5, 2.4, 2.4);
    circulo(c);
    leave(c,"black", "black");

    enter(c,28.5,129,210,350);
    triangulo(c);
    leave(c,"black", "black");

    enter(c, 120, 223, 1, 1);
    circulo(c);
    leave(c,"white", "white");

    //preto da esquerda
    enter(c, -65, 213,4.5,4.5);
    circulo(c);
    leave(c,"black", "black");

    enter(c,-147.5, 91,380,580);
    triangulo(c);
    leave(c,"black", "black");

    enter(c, 5, 240, 2.2, 2.2);
    circulo(c);
    leave(c,"white", "white");

    //preto maior
    enter(c, -128, 212, 8, 8);
    circulo(c);
    leave(c,"black", "black");

    enter(c,-260,7,650,1000);
    triangulo(c);
    leave(c,"black", "black");

    enter(c, -6 , 258, 4, 4);
    circulo(c);
    leave(c,"white", "black");

    
    enter(c, 1.9 , 16.4 , 400, 500);
    linhaLocalizador(c);
    leave_width(c, "#ED1554", "#ED1554", 2.6);

    
    enter(c, 5.5, 14, 400, 500);
    linhasEscuras(c);
    leave_width(c, "#ED1554", "#ED1554", 1.7);

    
    
    enter(c, 5.5, 14, 400, 500);
    linhasClaras(c);
    leave_width(c, "#DEBAAC", "#DEBAAC", 0.7);

    
    enter(c, 5.5, 14, 400, 500);
    linhasWidth(c);
    leave_width(c, "#ED1554", "#ED1554", 0.5);
}

function livro(c){

    enter(c,0,0,300*2,500*2);
    rectangulo(c, 0.7,1.0, 0.0,0.0,"#ED1554");
    c.restore();
    
    //branco de cima
    enter(c, 90, 100,5,5);
    circulo(c);
    leave(c,"white", "white");

    enter(c,11,11,400,500);
    triangulo(c);
    leave(c,"white", "white");

    enter(c, 175, 133, 2.2, 2.2);
    circulo(c);
    leave(c,"#ED1554", "#ED1554");

    //enter(c,50,50,300,500);
    c.save();
    mapa(c);
    c.restore();

    c.save();
	var gradient = c.createLinearGradient(0,300,0,370);
	gradient.addColorStop(0,'rgba(255,255,255,1)');
	gradient.addColorStop(1,'rgba(255,255,255,0)');
	c.fillStyle = gradient;
	c.fillRect(50,340,200,100);
	c.restore();
	
	c.save();
  	c.translate(300	,705);
	c.rotate(Math.PI);
	c.globalAlpha = 0.1;
	mapa(c);
	c.restore();

	c.save();
	c.fillStyle = "#ED1554";
	c.fillRect(40,400,300,100);
	c.restore();
	
    //branco de baixo
    enter(c, -105, 315, 4.5, 4.5);
    circulo(c);
    leave(c,"white", "white");

    enter(c,-187.8, 192,380,580);
    triangulo(c);
    leave(c,"white", "white");

    enter(c, -34.5 , 342, 2.2, 2.2);
    circulo(c);
    leave(c,"#ED1554", "#ED1554");

    //triangulo da esquerda de cima
    enter(c, 25, 162, 5, 6);
    c.rotate(-Math.PI/2.9);
    trianguloRetangulo(c);
    leave(c,"white", "white");

    //triangulo do meio da esquerda
    enter(c, 25, 250, 5, 6);
    c.rotate(-Math.PI/1.5);
    trianguloRetangulo(c);
    leave(c,"white", "white");

    //triangulo da direita
    enter(c, 268, 225, 2, 6.5);
    c.rotate(-Math.PI/0.99);
    trianguloRetangulo(c);
    leave(c,"white", "white");

    //triangulo da direita de baixo
    enter(c, 270, 375, 4, 2);
    c.rotate(-Math.PI/3);
    trianguloRetangulo(c);
    leave(c,"white", "white");

    //primeiro triangulo de baixo
    enter(c, 70, 385, 5, 1.5);
    c.rotate(Math.PI/2);
    trianguloRetangulo(c);
    leave(c,"white", "white");

    //segundo triangulo de baixo 
    enter(c, 85, 367, 3, 5);
    c.rotate(2*Math.PI/0.93);
    trianguloRetangulo(c);
    leave(c,"white", "white");


    //terceiro triangulo de baixo
    enter(c, 180, 380, 6, 3);
    c.rotate(Math.PI/-3);
    trianguloRetangulo(c);
    leave(c,"white", "white");

    //quarto triangulo de baixo
    enter(c, 215, 375, 1.5, 5);
    c.rotate(-Math.PI/0.99);
    trianguloRetangulo(c);
    leave(c,"white", "white");

    //quinto triangilo de baixo
    enter(c, 237, 385, 6, 6);
    c.rotate(-Math.PI/1.5);
    trianguloRetangulo(c);
    leave(c,"white", "white");

	enter(c,67,100, 1, 1);
	letrasCima(c);
	c.restore();

	enter(c, 50, 455, 1.15, 1.15);
	letrasBaixo(c);
	c.restore();
}

function main(){
	var c = document.getElementById("acanvas").getContext("2d");
	c.save();	
   	livro(c);
    c.restore();
}