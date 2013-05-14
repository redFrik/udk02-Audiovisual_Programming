//udk oct2009-feb2010 / fredrikolofsson.com
//100115

s.boot

//rotation and polar coordinates 2


//simple cross
(
var width= 500, height= 500, n= 40;//n is number of arms
var win= Window("rotate20", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);
	Pen.strokeColor= Color.red;
	n.do{|index|
		Pen.moveTo(Point(0, 0)+Polar(50.rrand(60), index/n*2pi+0.1.rand2));
		5.do{|j|
			Pen.lineTo(Point(0, 0)+Polar(200.rrand(220), index/n*2pi+0.1.rand2));
		};
	};
	Pen.stroke;
};
win.front;
)


//simple star
(
var width= 500, height= 500, n= 10;//n is number of arms
var win= Window("rotate21", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.red;//pen colour
	n.do{|index|
		Pen.moveTo(Point(0, 0)+Polar(30, index/n*2pi-(pi/n)));
		Pen.lineTo(Point(0, 0)+Polar(100, index/n*2pi));
		Pen.lineTo(Point(0, 0)+Polar(30, index/n*2pi+(pi/n)));
		Pen.stroke;//do the drawing
	};
};
win.front;
)



//star animation
(
var width= 500, height= 500, n= 1, inner= 40, outer= 100, x= 0, y= 0;
var win= Window("rotate22", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.red;//pen colour
	n.do{|index|
		Pen.moveTo(Point(x, y)+Polar(inner, index/n*2pi-(pi/n)));
		Pen.lineTo(Point(x, y)+Polar(outer, index/n*2pi));
		Pen.lineTo(Point(x, y)+Polar(inner, index/n*2pi+(pi/n)));
	};
	Pen.stroke;//do the drawing
	n= n+1%100;	//max 99 arms
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/25).wait;
	});
}).play(AppClock);
)



//star animation with sound
(
SynthDef(\blip, {|num= 1, freq= 200, pan= 0|
	var src= Blip.ar(freq, num, 0.2);
	Out.ar(0, Pan2.ar(src, pan));
}).add;
)

(
var syn= Synth(\blip);
var width= 500, height= 500, n= 1, maxN= 100, inner= 0, outer= 100, x= 0, y= 0;
var win= Window("rotate22", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	syn.set(\num, n, \freq, y.linexp(-1, 1, 60, 600), \pan, x);
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.red;//pen colour
	n.do{|index|
		var posX= x*(width*0.5);
		var posY= y*(height*0.5);
		Pen.moveTo(Point(posX, posY)+Polar(inner, index/n*2pi-(pi/n)));
		Pen.lineTo(Point(posX, posY)+Polar(outer, index/n*2pi));
		Pen.lineTo(Point(posX, posY)+Polar(inner, index/n*2pi+(pi/n)));
	};
	Pen.stroke;//do the drawing
	n= n+1%maxN;
	inner= inner+0.2;	//slowly increase inner circle
	outer= outer+0.1;	//slowly increase outer circle
	if(n==0, {
		x= 1.0.rand2;
		y= 1.0.rand2;
		maxN= 10.rrand(110);
	});
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/25).wait;
	});
}).play(AppClock);
win.onClose= {syn.free};
)


//drawing our own cirlce with a bit of randomness
(
var width= 500, height= 500, n= 100;//n is number of segments
var win= Window("rotate23", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.red;//pen colour
	Pen.moveTo(Point(0, 0));
	n.do{|index|					//once for each arm
		Pen.lineTo(Point(5.rand2, 5.rand2)+Polar(100, index/n*2pi));//100 is distance from centre to line end
	};
	Pen.stroke;//do the drawing
};
win.front;
)





//amplitude tracking

(	//first prepare an amplitude tracker
SynthDef(\amptrack, {
	var src= SoundIn.ar(0);//mic input
	var trk= Amplitude.kr(src);
	SendTrig.kr(Impulse.kr(40), 0, trk);
}).add;
)

(	//then set up a responder
var amp= 0;
o= OSCresponder(s.addr, '/tr', {|t, r, m|
	amp= m.postln;	//only post values in this example.  3rd thing in array is the amplitude value
}).add;
)

//last start the amp tracking synth (make sure you have microphone enabled)
Synth(\amptrack)

//cmd+. to stop
see SendTrig helpfile and also SendReply helpfile



//amplitude tracking with graphics - sensitive to the mic input
(
var width= 500, height= 500, n= 16;
var win= Window("rotate24", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
var syn= Synth(\amptrack);	//start the amp tracking synth here
var aamp= 0;		//variable to hold amplitude
var osc= OSCresponder(s.addr, '/tr', {|t, r, m|
	aamp= m[3];	//set aamp to third value
}).add;
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//offset drawing to middle
	Pen.strokeColor= Color.red;//pen colour
	Pen.moveTo(Point(0, 0));
	n.do{|index|
		Pen.lineTo(Point(0, 0)+Polar(aamp*width+15, index/n*2pi));
	};
	Pen.stroke;//do the drawing
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;
	});
}).play(AppClock);
)
