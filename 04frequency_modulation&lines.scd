//udk oct2009-feb2010 / fredrikolofsson.com
//091112

s.boot

//frequency modulation and lines

(
SynthDef(\fm, {|freq= 500, amp= 0.5, atk= 0.01, rel= 0.4|
	var env= EnvGen.kr(Env.perc(atk, rel), doneAction:2);
	var src= SinOsc.ar(freq+SinOsc.ar(10, 0, 100), 0, amp);
	Out.ar(0, Pan2.ar(src*env));
}).add;
)

Synth(\fm, [\freq, 1000])
//freq will vary between 900 and 1100 with a rate of 10 times/sec
//10 is vibrato speed
//100 is vibrato depth
//freq is mid frequency

Synth(\fm, [\freq, 500, \rel, 4])
Synth(\fm, [\freq, 6000, \rel, 4])



//--again with different modulator (Saw oscillator)
(
SynthDef(\fm2, {|freq= 500, amp= 0.5, modAmp= 10, modFreq= 50, atk= 0.1, rel= 0.2|
	var env= EnvGen.kr(Env.perc(atk, rel), doneAction:2);
	var src= SinOsc.ar(freq+Saw.ar(modFreq, modAmp), 0, amp);
	Out.ar(0, Pan2.ar(src*env));
}).add;
)

Synth(\fm2, [\modAmp, 100, \modFreq, 50])
Synth(\fm2, [\modAmp, 10000, \modFreq, 50])
Synth(\fm2, [\modAmp, 10000, \modFreq, 500])
Synth(\fm2, [\freq, 400, \modAmp, 6000, \modFreq, 500])


//--using env to scale the modulation
(
SynthDef(\fm3, {|freq= 500, amp= 0.5, modAmp= 10, modFreq= 50, atk= 0.1, rel= 0.2|
	var env= EnvGen.kr(Env.perc(atk, rel), doneAction:2);
	var src= SinOsc.ar(freq+Saw.ar(modFreq, modAmp*env), 0, amp);
	Out.ar(0, Pan2.ar(src*env));
}).add;
)

Synth(\fm3, [\modFreq, 15, \modAmp, 100, \atk, 1, \rel, 2])
Synth(\fm3, [\modFreq, 5, \modAmp, 1000, \atk, 1, \rel, 2])
Synth(\fm3, [\freq, 400, \modFreq, 50, \modAmp, 400, \atk, 1, \rel, 2])

//so in the beginning and the end of the sound there will be no modulation


//--simple lines - from window centre to random point
(
var width= 500, height= 500;
var win= Window("lines", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	600.do{|i|		//draw 600 lines
		Pen.moveTo(Point(width*0.5, height*0.5));//move pen to centre
		Pen.lineTo(Point(width.rand, height.rand));//draw to random
	};
	Pen.stroke;
};
win.front;
)

//--lines with end position rounded off
(
var width= 500, height= 500;
var win= Window("lines", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.width= 1;
	600.do{|i|		//draw 600 lines
		Pen.moveTo(Point(width*0.5, height*0.5));//move pen to centre
		Pen.lineTo(Point(width.rand.round(200), height.rand.round(5)));//draw to random
	};
	Pen.stroke;
};
win.front;
)


//--lines makes a grid
(
var width= 500, height= 500;
var win= Window("lines", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	60.do{|i|
		Pen.moveTo(Point(i/60*width, 0));
		Pen.lineTo(Point(i/60*width, height));
		Pen.moveTo(Point(0, i/60*height));
		Pen.lineTo(Point(width, i/60*height));
	};
	Pen.stroke;
};
win.front;
)


//--lines makes a strange grid
(
var width= 500, height= 500;
var win= Window("lines", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.width= 2;
	Pen.strokeColor= Color.grey(0.8);
	60.do{|i|
		Pen.moveTo(Point(i/600*width, 0));
		Pen.lineTo(Point(i/60*width, height));
		Pen.moveTo(Point(0, i/20*height));
		Pen.lineTo(Point(width, i/60*height));
	};
	Pen.stroke;
};
win.front;
)


//--to set different colours you need to stroke individual lines
(
var width= 500, height= 500;
var win= Window("lines", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.width= 2;
	60.do{|i|
		Pen.strokeColor= Color.blue(1, 0.5);
		Pen.moveTo(Point(i/600*width, 0));
		Pen.lineTo(Point(i/60*width, height+i.rand));
		Pen.stroke;
		Pen.strokeColor= Color.red;
		Pen.moveTo(Point(i*3, i/60*height));
		Pen.lineTo(Point(width, i/60*height));
		Pen.stroke;
	};
};
win.front;
)





/*
//3rd party code/packages/classes available from...
Quarks.gui
http://swiki.hfbk-hamburg.de:8888/MusicTechnology/6
sc-users mailinglist http://www.listarc.bham.ac.uk/lists/sc-users/search/
*/
