//udk oct2009-feb2010 / fredrikolofsson.com
//091126

s.boot

//phase modulation and transform, scale, rotate

(
SynthDef(\pm, {|amp= 0.5, freq= 500, pmamp= 2|
	var env= EnvGen.ar(Env.perc(0.01, 0.4), doneAction:2);
	var src= SinOsc.ar(0, SinOsc.ar(freq, 0, 2pi*pmamp), amp);
	Out.ar(0, Pan2.ar(src*env));
}).memStore;
)

Synth(\pm)
Synth(\pm, [\freq, 200, \pmamp, 109])
Synth(\pm, [\freq, 2000, \pmamp, 4.5])
Synth(\pm, [\freq, 1000, \pmamp, 0.5])
Synth(\pm, [\freq, 1550, \pmamp, 0.15, \amp, 1])

(
SynthDef(\pm2, {|amp= 0.5, freq= 500, pmamp= 2, mod= 50, atk= 0.01, rel= 0.2|
	var env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	var src= SinOsc.ar(0, BPF.ar(LFSaw.ar(freq, 0, pmamp), mod), amp);
	Out.ar(0, Pan2.ar(src*env));
}).memStore;
)
Synth(\pm2)
Synth(\pm2, [\pmamp, 10, \mod, 500])
Synth(\pm2, [\pmamp, 40, \mod, 140])
Synth(\pm2, [\pmamp, 400, \mod, 40, \rel, 0.5])
Synth(\pm2, [\pmamp, 80, \mod, 6pi*3, \rel, 0.5, \freq, 180])

//bd
Synth(\pm2, [\freq, 50, \atk, 0.001, \rel, 0.06, \amp, 1, \mod, 100])
//hh
Synth(\pm2, [\freq, 5000, \atk, 0.001, \rel, 0.04, \mod, 7000, \pmamp, 40])
//bass
Synth(\pm2, [\freq, 100, \atk, 0.05, \rel, 0.5, \pmamp, 1, \mod, 100, \amp, 0.8])
//sn
Synth(\pm2, [\freq, 5000, \atk, 0.05, \rel, 0.5, \pmamp, 9000, \mod, 2.8])
(
Routine({
	10.do{|i|
		Synth(\pm2, [\freq, 50.rrand(500), \atk, 0.001, \rel, 0.06, \amp, 1, \mod, 100]);
		0.21.wait;
		if(i%2==0, {
			Synth(\pm2, [\freq, 5000, \atk, 0.001, \rel, 0.04, \mod, 7000, \pmamp, 40]);
		});
		0.29.wait;
	};
}).play;
)

(
Routine({
	60.do{|i|
		Synth(\pm2, [\freq, 40, \atk, 0.001, \rel, 0.06, \amp, i/60, \mod, 10*i]);
		0.125.wait;
	};
	60.do{|i|
		Synth(\pm2, [\freq, 40, \atk, 0.001, \rel, 0.06, \amp, 1-(i/60), \mod, 10*(60-i)]);
		0.125.wait;
	};
}).play;
)


//--translate, rotate, scale

(
var width= 500, height= 500;
var win= Window("scale", Rect(300, 300, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.strokeRect(Rect(0, 0, 100, 100));
	Pen.translate(width*0.5, height*0.5);//moves the pen to the middle of screen
	Pen.rotate(0.123);	//rotate pen in radians (0-2pi)  pi= 180, 2pi= 360degrees
	Pen.scale(0.2, 2);	//scale width and height in percent
	Pen.strokeRect(Rect(0, 0, 100, 100));
};
win.front;
)

(
var width= 500, height= 500;
var win= Window("scale", Rect(300, 300, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);//moves the pen to the middle of screen
	120.do{|i|
		Pen.rotate(-0.123.rrand(0.1));
		Pen.scale(0.97, 0.96);
		Pen.strokeOval(Rect(0, 0, 400, 400));
	};
};
win.front;
)


(
var width= 500, height= 500;
var win= Window("scale", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);//moves the pen to the middle of screen
	120.do{|i|
		Pen.strokeColor= Color.grey(1-(i/120));//go from white to black
		Pen.rotate(-0.123.rrand(0.1));
		Pen.scale(0.97, 0.96);
		Pen.strokeOval(Rect(0, 0, 400, 400));
	};
};
win.front;
)

(
var width= 500, height= 500;
var win= Window("scale", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.translate(width*0.3, height*0.3);
	Pen.width= 5;	//pen width size (line thickness)
	120.do{|i|
		Pen.strokeColor= Color.white;
		Pen.fillColor= Color.red(1-(i/120), 0.2);//red with 20% alpha
		Pen.rotate(-0.123.rrand(0.1));
		Pen.scale(0.97, 0.96);
		Pen.addOval(Rect(0, 0, 400, 400));
		Pen.draw(1);	//try modes 0-4
	};
};
win.front;
)


(
var width= 500, height= 500;
var win= Window("scale", Rect(300, 300, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.width= 5;	//pen width size (line thickness)
	4.do{|j|
		Pen.translate(width*0.5.rand, height*0.5.rand);
		Pen.push;		//remember pen state on in stack
		120.do{|i|
			Pen.strokeColor= Color.white;
			Pen.fillColor= Color.red(1-(i/120), 0.2);//red with 20% alpha
			Pen.rotate(-0.123.rrand(0.1));
			Pen.scale(0.97, 0.96);
			Pen.addOval(Rect(0, 0, 400, 400));
			Pen.draw(1);	//try modes 0-4
		};
		Pen.pop;	//recall pen state from stack
	};
};
win.front;
)
