//5 circles in a circle
(
var width= 500, height= 500, num;
var win= Window("pushpop0", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
num= 5;		//try to change number of segments
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);
	num.do{|i|
		Pen.rotate(1/num*2pi);	//calculate percent of radians (2pi)
		Pen.strokeOval(Rect(0, 0, 140, 140));
	};
};
win.front;
)


//many circles - multiple laps
(
var width= 500, height= 500, num;
var win= Window("pushpop1", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
num= 50;
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);
	num.do{|i|
		Pen.rotate(1/num*2pi*1.5);//spread out 50 over 1.5 laps
		Pen.strokeOval(Rect(0, 0, 140, 140));
	};
};
win.front;
)


//shrinking size to look like a spiral
(
var width= 500, height= 500, num;
var win= Window("pushpop2", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
num= 150;
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);
	num.do{|i|
		Pen.rotate(1/num*2pi*2);//2 laps
		Pen.scale(0.98, 0.98);	//decrease size
		Pen.strokeOval(Rect(0, 0, 140, 140));
	};
};
win.front;
)


//spiral with many more laps and many more circles.  also translate
(
var width= 500, height= 500, num;
var win= Window("pushpop3", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
num= 700;
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.8, height*0.2);
	num.do{|i|
		Pen.rotate(1/num*2pi*3);//3 laps
		Pen.scale(0.995, 0.995);//decrease size
		Pen.translate(0, 7);
		Pen.strokeOval(Rect(0, 0, 140, 140));
	};
};
win.front;
)


//adding some randomness to pushpop3 - run many times
(
var width= 500, height= 500, num;
var win= Window("pushpop4", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
num= 700;
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.8, height*0.2);
	num.do{|i|
		Pen.rotate(1/num*2pi*3+0.15.rand2);
		Pen.scale(0.995+0.001.rand2, 0.995+0.001.rand2);
		Pen.translate(0+1.0.rand2, 7+1.0.rand2);
		Pen.strokeOval(Rect(0, 0, 140+10.rand2, 140+10.rand2));
	};
};
win.front;
)


//5 circles in a circle with push and pop
(
var width= 500, height= 500, num;
var win= Window("pushpop5", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
num= 5;
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);
	num.do{|i|
		Pen.push;
		Pen.rotate(i/num*2pi);	//rotate is 'forgotten' so use i/num
		Pen.strokeOval(Rect(0, 0, 140, 140));
		Pen.pop;
	};
};
win.front;
)

//150 triangles.  compare without push&pop
(
var width= 500, height= 500, num;
var win= Window("pushpop6", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
num= 150;
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);
	num.do{|i|
		Pen.push;		//try commenting out
		Pen.rotate(2pi.rand);//rotate random direction
		Pen.translate(100, 0);
		Pen.moveTo(Point(0, 0));
		Pen.lineTo(Point(40, 40));
		Pen.lineTo(Point(-40, 40));
		Pen.lineTo(Point(0, 0));
		Pen.stroke;
		Pen.pop;		//try commenting out
	};
};
win.front;
)


//rotate, translate and scale
(
var width= 500, height= 500, num;
var win= Window("pushpop7", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
num= 150;
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);
	num.do{|i|
		Pen.push;
		Pen.rotate(2pi.rand);//rotate random direction
		Pen.translate((width*0.5).rand, 0);//translate random length
		Pen.scale(1.0.rand2, 1.0.rand2);//scale random
		Pen.strokeRect(Rect(0, 0, 40, 40));
		Pen.pop;
	};
};
win.front;
)


//more andvanced shape with rotate and translate
(
var width= 500, height= 500, num;
var win= Window("pushpop8", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
num= 150;		//number of arms
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);
	num.do{|i|
		var seg= 25.rand+5;		//number of segments per arm
		Pen.push;
		Pen.rotate(i/num*2pi);
		Pen.translate(50, 0);
		seg.do{|j|
			Pen.moveTo(Point(0, 0));
			Pen.rotate(0.5.rand2);
			Pen.translate(10, 0);
			Pen.scale(0.975, 0.975);
			Pen.lineTo(Point(10, 0));
			Pen.stroke;
		};
		Pen.pop;
	}
};
win.front;
)
