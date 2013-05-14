//udk oct2009-feb2010 / fredrikolofsson.com
//100107

//this time go through techniques we did so far


//02: ikeda, routine, barcode
//03: env, modulo
//04: fm, lines, grid
//05: animation
//06: pm, translate, rotate, scale
//07: push, pop
//08: pdef, pbind


s.boot

(
SynthDef(\sine, {|freq= 500|
	var src= SinOsc.ar(freq, 0, 0.5);
	Out.ar(0, Pan2.ar(src));
}).memStore;
)

a= Synth(\sine)
a.free

a= Synth(\sine, [\freq, 800])
a.set(\freq, 400)
a.set(\freq, 700)
a.free

(
Routine({
	30.do{|index|
		a= Synth(\sine, [\freq, index*50+500]);
		0.1.wait;
		a.free;
		0.05.wait;
	};
}).play;
)

100.rand	//integer random values between 0 and 99
100.rrand(200)	//rangerand.  integer random between 100 and 200
100.0.rand	//float random values between 0.0 and 99.99999
100.0.rrand(200.0)	//float random values between 100.0 and 199.999
//also try linrand, exprand, rand2...


(
SynthDef(\noise, {|pan= 0|
	var src= WhiteNoise.ar(0.5);
	Out.ar(0, Pan2.ar(src, pan));
}).memStore;
)

a= Synth(\noise)
a.set(\pan, -1)		//left speaker
a.set(\pan, 1)		//right speaker
a.set(\pan, 0)		//middle
a.free

(
Routine({
	30.do{|index|
		a= Synth(\sine, [\freq, 6000+200.rand2]);
		(0.2/1.rrand(3)).wait;
		a.free;
		a= Synth(\noise, [\pan, -1]);
		0.01.wait;
		a.set(\pan, 1);
		0.02.wait;
		a.free;
		(index/30/4).wait;
	};
}).play;
)


//--

(
var width= 500, height= 500;
var win= Window("something", Rect(300, 300, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.width= 1;
	90.do{|index|
		Pen.strokeColor= Color.new(0.4, 0.1, 0.6, 1.0.rand);
		Pen.strokeOval(Rect(30+(index%12*16), 40+(index%7*16), 50, 60));
	};
};
win.front;
)



//--

(
SynthDef(\fm, {|amp= 0.5, atk= 0.01, rel= 0.2, freq= 500|
	var env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	var src= SinOsc.ar(freq*(1-env), 0, env);
	Out.ar(0, Pan2.ar(src*amp));
}).memStore;
)

a= Synth(\fm)
a= Synth(\fm, [\freq, 1800, \atk, 0.1, \rel, 0.5])

Env.perc(0.01, 0.2).plot
Env.perc(0.2, 0.01).plot
Env.perc(0.01, 0.2).test
Env.perc(0.2, 0.01).test


(
SynthDef(\fm2, {|amp= 0.5, atk= 0.01, rel= 2, freq= 500, gate= 1|
	var env= EnvGen.ar(Env.adsr(atk, 0.5, 0.5, rel), gate, doneAction:2);
	var src= SinOsc.ar(freq, 0, env);
	Out.ar(0, Pan2.ar(src*amp));
}).memStore;
)
a= Synth(\fm2)	//start the synth
a.set(\gate, 0)	//release gate and the synth will stop



(
SynthDef(\fm3, {|amp= 0.5, atk= 0.01, rel= 0.2, freq= 500|
	var env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	var src= SinOsc.ar(freq*Saw.ar(400*env), 0, env);
	Out.ar(0, Pan2.ar(src*amp));
}).memStore;
)

a= Synth(\fm3)
a= Synth(\fm3, [\freq, 1800, \atk, 0.1, \rel, 0.5])


//--
(
var width= 500, height= 500;
var win= Window("lines", Rect(300, 300, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.width= 1;
	90.do{|index|
		Pen.strokeColor= Color.black;
		Pen.moveTo(Point(width*0.5, height*0.5));
		Pen.lineTo(Point((width*0.5).rand, (height*0.5).rand));
		Pen.stroke;
	};
};
win.front;
)


(
var width= 500, height= 500;
var win= Window("lines", Rect(300, 300, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.width= 1;
	90.do{|index|
		Pen.strokeColor= Color.black;
		Pen.moveTo(Point(index*4, 30));
		Pen.lineTo(Point(index*5, height-30));
		Pen.stroke;
		Pen.moveTo(Point(0, index*4));
		Pen.lineTo(Point(width-30, index*5));
		Pen.stroke;
	};
};
win.front;
)


//--
(
var width= 500, height= 500, cnt= 0;
var win= Window("animated lines", Rect(300, 300, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.width= 1;
	90.do{|index|
		Pen.strokeColor= Color.black;
		Pen.moveTo(Point(index*4+(cnt%40), 30));
		Pen.lineTo(Point(index*5, height-30));
		Pen.stroke;
		Pen.moveTo(Point(cnt, index*4));
		Pen.lineTo(Point(width-30-cnt, index*5));
		Pen.stroke;
	};
	cnt= cnt+1;
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh; (1/25).wait;
	});
}).play(AppClock);
)


//--

(
SynthDef(\pm, {|amp= 0.5, atk= 0.01, rel= 0.2, freq= 500|
	var env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	var src= SinOsc.ar(freq, SinOsc.ar(freq*env)*pi, env);
	Out.ar(0, Pan2.ar(src*amp));
}).memStore;
)

a= Synth(\pm)
a= Synth(\pm, [\freq, 1800, \atk, 0.1, \rel, 0.5])



//--
(
var width= 500, height= 500;
var win= Window("pushpoptranslatescalerotate", Rect(300, 300, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.width= 1;
	90.do{|index|
		Pen.translate(10.rand2, 10.rand2);
		Pen.rotate(0.1+0.05.rand2, width*0.5, height*0.5);
		Pen.scale(0.96+0.05.rand2, 0.98+0.05.rand2);
		Pen.strokeColor= Color.black;
		Pen.moveTo(Point(index*4, 30));
		Pen.lineTo(Point(index*5, height-30));
		Pen.stroke;
		Pen.moveTo(Point(0, index*4));
		Pen.lineTo(Point(width-30, index*5));
		Pen.stroke;
	};
};
win.front;

)

//--

(
SynthDef(\pm, {|amp= 0.5, atk= 0.01, rel= 0.2, freq= 500|
	var env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	var src= SinOsc.ar(freq, SinOsc.ar(freq*env)*pi, env);
	Out.ar(0, Pan2.ar(src*amp));
}).memStore;
)

Pdef(\seq1).play(quant:4)
(
Pdef(\seq1, Pbind(
	\instrument, \pm,
	\dur, 0.125,
	\amp, Pseq([0.5, 0, 0.25, 0.5], inf)
))
)
Pdef(\seq2).play(quant:4)
(
Pdef(\seq2, Pbind(
	\instrument, \pm,
	\dur, 0.125,
	\freq, Pseq([900, 1000, 1500], inf),
	\atk, Pseq([0, 0.1], inf),
	\rel, Pseq([0.1, 0.01, 0.02], inf),
	\amp, Pseq([0.5, 0.1, 0, 0.6, 0.6], inf)
))
)

TempoClock.tempo= 2
Pdef(\seq2).stop
Pdef(\seq1).stop
