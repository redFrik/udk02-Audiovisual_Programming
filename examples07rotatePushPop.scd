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


		// put first circle at 12 o'clock
(
var width= 500, height= 500, num;
var win= Window("pushpop0", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
num= 5;		//try to change number of segments
usr.drawFunc= {
	var radius = 140; 
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);
	num.do{|i|
		Pen.rotate(1/num*2pi);	//calculate percent of radians (2pi)
		Pen.strokeOval(Rect(radius * -0.5, radius * -1, radius, radius));
	};
};
win.front;
)

		// random circles
(
var width= 500, height= 500, num;
var win= Window("pushpop0", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
num= 50;		//try to change number of segments
usr.drawFunc= {
	var radius = 140, x, y; 
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);
	num.do{|i|
		x = (width * 0.4).rand2; 
		y = (height * 0.4).rand2;
		Pen.strokeOval(Rect(radius * -0.5 + x, radius * -1 + y, radius, radius));
	};
};
win.front;
)

200.rand
200.rand
200.rand

200.rand2
200.rand2
200.rand2

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

//make it expand ? 
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
		Pen.strokeOval(Rect(i * 7, i * 7, 140, 140));
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


// try expanding to several centers
(
var width= 500, height= 500, num;
var win= Window("pushpop3", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
num= 700;
usr.drawFunc= {
	Pen.strokeColor= Color.black; 
	
	3.do { |i|
		Pen.push;
		Pen.rotate(i / 3, width * 0.5, height * 0.5);
		Pen.translate(width*0.8, height*0.2);
		num.do{|i|
			Pen.rotate(1/num*2pi*3);//3 laps
			Pen.scale(0.995, 0.995);//decrease size
			Pen.translate(0, 7);
			Pen.strokeOval(Rect(0, 0, 140, 140));
		};
		Pen.pop;
	};
};
win.front;
)


// rotate one spiral in time
(
var width= 500, height= 500, num;
var win= Window("pushpop3", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
var rotAngle = 0;
usr.background= Color.white;
num= 600;
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.rotate(rotAngle, width * 0.5, height * 0.5);
	Pen.translate(width*0.8, height*0.2);
	num.do{|i|
		Pen.rotate(1/num*2pi*3);//3 laps
		Pen.scale(0.995, 0.995);//decrease size
		Pen.translate(0, (i * 0.1).sin + 1 * 20 );
		Pen.strokeOval(Rect(0, 0, 140, 140));
	};
}; 
Tdef(\spiral, { 
	300.do { 
		rotAngle = rotAngle + (2pi / 300);
		0.03.wait;
		win.refresh;
	}
}).play(AppClock);
win.front;
)


// rotate one spiral in time
(
var width= 500, height= 500, num = 600;
var win= Window("pushpop3", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
var rotAngle = 0;
var toplefts = { [0, 0] }.dup(num);
usr.background= Color.white;

usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.rotate(rotAngle, width * 0.5, height * 0.5);
	Pen.translate(width*0.8, height*0.2);
	num.do{|i| 
		var myXY = toplefts[i];
		toplefts[i] = myXY + [10.0.bilinrand, 10.0.bilinrand]; 
		Pen.rotate(1/num*2pi*3);//3 laps
		Pen.scale(0.995, 0.995);//decrease size
		Pen.translate(0, 7 );
		Pen.strokeOval(Rect(myXY[0], myXY[1], 140, 140));
	};
	toplefts.keep(5).round(0.01).postln;
}; 
Tdef(\spiral, { 
	600.do { 
		// rotAngle = rotAngle + (2pi / 300);
		0.03.wait;
		win.refresh;
	}
}).play(AppClock);
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

win.front;

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
			Pen.lineTo(Point(0, 0));
			Pen.stroke;
		};
		Pen.pop;
	}
};
win.front;
)




q = ();
q[\adc] = 123;
q[\adc] = 12;
q[\adc] * 100;

a = 123

//more andvanced shape with rotate and translate
(
var width= 500, height= 500, num = 100;
var win= Window("pushpop8", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));

var arms = { 
	var numSegs = 25.rand+5; 
	var dict = ();
	dict.put(\numSegs, numSegs);
	dict.put(\rotations, { 0.5.rand2 }.dup(numSegs)); 
	dict;
}.dup(num);

usr.background= Color.white;

usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);
	num.do{|i|
		var seg = arms[i][\numSegs]; //number of segments per arm
		
		var rotations = arms[i][\rotations];
		
		arms[i][\rotations] = rotations.collect { |rot| rot + 0.03.rand2 };
		Pen.push;
		Pen.rotate(i/num*2pi);
		Pen.translate(50, 0);
		seg.do{|j|
			Pen.moveTo(Point(0, 0));
			Pen.rotate(rotations[j]);
			Pen.translate(10, 0);
			Pen.scale(0.975, 0.975);
			Pen.lineTo(Point(0, 0));
			Pen.stroke;
		};
		Pen.pop;
	}
};
win.front;
Tdef(\arms, { 200.do { 0.035.wait; win.refresh } }).play(AppClock)
)
