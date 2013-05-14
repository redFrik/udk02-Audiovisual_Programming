//udk oct2009-feb2010 / fredrikolofsson.com
//100114

s.boot

//rotation and polar coordinates

// http://wheelof.com/whitney



length and rotation= magnitude and angle= rho and theta
different names for the same thing.

Point	//x and y coordinates
Polar	//length and rotation


//simple line using x and y coordinates
(
var width= 500, height= 500;
var win= Window("rotate0", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.red;//pen colour
	Pen.moveTo(Point(0, 0));//set pen starting position
	Pen.lineTo(Point(-100, -80));//add a line to point -100, -80
	Pen.stroke;//do the drawing
};
win.front;
)

//rotate with Polar
(
var width= 500, height= 500;
var win= Window("rotate1", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.red;//pen colour
	Pen.moveTo(Point(0, 0));//set pen starting position
	Pen.lineTo(Point(0, 0)+Polar(150, pi*0.25));//add a line
	Pen.stroke;//do the drawing
};
win.front;
)

//Polar uses radians 0 - 2*pi.  (2pi is approximately 6.283)
//use radians for specifying angles (often called theta)


//drawing a star
(
var width= 500, height= 500;
var win= Window("rotate2", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.red;//pen colour
	20.do{|index|	//make 20 lines
		Pen.moveTo(Point(0, 0));//set pen starting position
		Pen.lineTo(Point(0, 0)+Polar(150, index/20*2pi));//add a line
		Pen.stroke;//do the drawing
	};
};
win.front;
)


//animate
//detecting when we're back at the beginning is done by checking the distance of previous theta from current theta and if this is a big negative leap (-2pi), then that means that the modulo operation have wrapped around
(
var width= 500, height= 500, theta= 0, lastTheta= 0;
var win= Window("rotate3", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.black;
	Pen.moveTo(Point(0, 0));
	Pen.lineTo(Point(0, 0)+Polar(150, 0));
	Pen.stroke;
	Pen.strokeColor= Color.red;//pen colour
	Pen.moveTo(Point(0, 0));//set pen starting position
	Pen.lineTo(Point(0, 0)+Polar(150, theta));
	Pen.stroke;//do the drawing
	theta= (theta+0.05)%2pi;	//0.05 is speed
	if(theta-lastTheta<0, {
		'now'.postln;
	});
	lastTheta= theta;	//save previous to detect beginning of circle
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;	//60fps
	});
}).play(AppClock);
)

//--make a simple sound to test the 
(
SynthDef(\snare, {|amp= 0.5, atk= 0.001, rel= 0.1|
	var env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	var src= BPF.ar(WhiteNoise.ar(env));
	Out.ar(0, Pan2.ar(src));
}).memStore;
)

//test the sound
Synth(\snare)


//animate with sound
(
var width= 500, height= 500, theta= 0, lastTheta= 0;
var win= Window("rotate4", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.black;//draw a black reference line
	Pen.moveTo(Point(0, 0));
	Pen.lineTo(Point(0, 0)+Polar(150, 0));
	Pen.stroke;
	Pen.strokeColor= Color.red;//pen colour
	Pen.moveTo(Point(0, 0));//set pen starting position
	Pen.lineTo(Point(0, 0)+Polar(150, theta));
	Pen.stroke;//do the drawing
	theta= (theta+0.1)%2pi;	//0.05 is speed
	if(theta-lastTheta<0, {
		Synth(\snare);
	});
	lastTheta= theta;
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;	//60fps
	});
}).play(AppClock);
)


//drawing a circle instead and adding some interactive control over some (3) parameters
(
var width= 500, height= 500, theta= 0, lastTheta= 0;
var win= Window("rotate5", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
~speed= 0.1;	//variables that you can change in realtime below
~radius= 30;
~length= 150;
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.black;//draw a black reference line
	Pen.moveTo(Point(0, 0));
	Pen.lineTo(Point(0, 0)+Polar(150, 0));
	Pen.stroke;
	Pen.strokeColor= Color.red;//pen colour
	Pen.strokeOval(Rect.aboutPoint(Point(0, 0)+Polar(~length, theta), ~radius, ~radius));
	theta= (theta+~speed)%2pi;
	if(theta-lastTheta<0, {
		Synth(\snare);
	});
	lastTheta= theta;
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;	//60fps
	});
}).play(AppClock);
)

//play with these while the example above is running
~speed= 0.3
~speed= 0.01
~radius= 50
~length= 20
~length= 100
~length= 200



//making a simple pitched sound
(
SynthDef(\saw, {|freq= 400, amp= 0.5|
	var env= EnvGen.ar(Env.perc(0.005, 0.1), doneAction:2);
	var src= Saw.ar(freq, amp);
	Out.ar(0, Pan2.ar(src*env));
}).memStore;
)
Synth(\saw)
Synth(\saw, [\freq, 900])
Synth(\saw, [\freq, 1900])


//mapping length to frequency of the pitched synth
(
var width= 500, height= 500, theta= 0, lastTheta= 0;
var win= Window("rotate6", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
~speed= 0.1;
~radius= 30;
~length= 150;
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.black;//draw a black reference line
	Pen.moveTo(Point(0, 0));
	Pen.lineTo(Point(0, 0)+Polar(150, 0));
	Pen.stroke;
	Pen.strokeColor= Color.red;//pen colour
	Pen.strokeOval(Rect.aboutPoint(Point(0, 0)+Polar(~length, theta), ~radius, ~radius));
	if(theta-lastTheta<0, {
		Synth(\saw, [\freq, ~length.linexp(1, 250, 1000, 300)]);
	});
	lastTheta= theta;
	theta= (theta+~speed)%2pi;
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;	//60fps
	});
}).play(AppClock);
)

//play with these while the example above is running
~length= 200;
~speed= 0.07;
~length= 100;
~length= 20;
~speed= 0.7;
~length= 80;


//draw many (n) ovals.  a bit tricky to keep track of and detecting borders.
(
var width= 500, height= 500, theta= 0, n= 20, lastThetas= 0.dup(n);
var win= Window("rotate7", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
~speed= 0.05;
~radius= 5;
~length= 10;
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.black;//draw a black reference line
	Pen.moveTo(Point(0, 0));
	Pen.lineTo(Point(0, 0)+Polar(width*0.5, 0));
	Pen.stroke;
	Pen.strokeColor= Color.red;
	theta= (theta+~speed)%2pi;
	n.do{|index|
		var tempLength= ~length+(index*10);//figure out this oval's length.  10 is the spread out between oval lenghts
		var tempTheta= (theta+(index*0.5))%2pi;//and this oval's angle.  0.5 is the spread out between oval angles
		var tempRadius= ~radius+(index*2);//bigger and bigger
		Pen.strokeColor= Color.red(index/n);//pen colour
		Pen.strokeOval(Rect.aboutPoint(Point(0, 0)+Polar(tempLength, tempTheta), tempRadius, tempRadius));
		if(tempTheta-lastThetas[index]<0, {
			Synth(\saw, [\freq, tempLength.linexp(1, 250, 1000, 300)]);
		});
		lastThetas.put(index, tempTheta);
	};
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;	//60fps
	});
}).play(AppClock);
)

~speed= 0.1
~speed= 0.2
~speed= 1
~length= 50
~length= 100
~length= 10
~speed= 0.2


//same example but with clearOnRefresh flag set to false and some more interactive control variables
(
var width= 500, height= 500, theta= 0, n= 20, lastThetas= 0.dup(n);
var win= Window("rotate7", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
~speed= 0.05;
~radius= 5;
~length= 10;
~spreadLength= 5;
~spreadTheta= 0.25;
~clear= false;
usr.background= Color.white;
usr.clearOnRefresh= false;
usr.drawFunc= {
	usr.clearOnRefresh= ~clear;
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.black;//draw a black reference line
	Pen.moveTo(Point(0, 0));
	Pen.lineTo(Point(0, 0)+Polar(width*0.5, 0));
	Pen.stroke;
	Pen.strokeColor= Color.red;
	theta= (theta+~speed)%2pi;
	n.do{|index|
		var tempLength= ~length+(index*~spreadLength);//figure out this oval's length.  10 is the spread out between oval lenghts
		var tempTheta= (theta+(index*~spreadTheta))%2pi;//and this oval's angle.  0.5 is the spread out between oval angles
		var tempRadius= ~radius+(index*2);//bigger and bigger
		Pen.strokeColor= Color.red(index/n);//pen colour
		Pen.strokeOval(Rect.aboutPoint(Point(0, 0)+Polar(tempLength, tempTheta), tempRadius, tempRadius));
		if(tempTheta-lastThetas[index]<0, {
			Synth(\saw, [\freq, tempLength.linexp(1, 250, 1000, 300)]);
		});
		lastThetas.put(index, tempTheta);
	};
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;	//60fps
	});
}).play(AppClock);
)

~speed= 0.01
~clear= true
~clear= false
~length= 100
~length= 50
~spreadLength= 40
~length= 2
~spreadTheta= 0.1
~spreadLength= 4
~clear= true
~speed= 0.5
~clear= false
~spreadTheta= 10
~spreadLength= 12



//calculate hypotenusa to find out polar length
100.hypot(80)
80.hypot(100)

//if we know starting point and only want to rotate using the same length, we can calculate the new rotated point manually from old x/y point like this...
(
var x= 100, y= 80;	//old coordinates
var theta= pi;		//how much rotation
var x2= (x*cos(theta))-(y*sin(theta));
var y2= (y*cos(theta)+(x*sin(theta)));
Point(x2, y2);
)

//or same thing simplified using Point's built in rotate method...
(
var x= 100, y= 80;	//old coordinates
var theta= pi;		//how much rotation
Point(x, y).rotate(theta);
)


