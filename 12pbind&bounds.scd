//udk oct2009-feb2010 / fredrikolofsson.com
//100121

s.boot

(
SynthDef(\boing, {|freq= 700, amp= 0.3, pan= 0|
	var env= EnvGen.ar(Env.perc(0.01, 0.3), doneAction:2);
	var src= SinOsc.ar(freq, env*2pi, amp);
	Out.ar(0, Pan2.ar(src*env, pan));
}).add;
)

Synth(\boing)

//Pdef with Pbind is a kind of sequencer with many default values.  \freq, \amp, \dur, \legato, \sustain, \pan

Pdef(\bbb).play(quant:1)
Pdef(\bbb, Pbind(\instrument, \boing, \dur, 0.25))

Pdef(\ccc).play(quant:1)
Pdef(\ccc, Pbind(\instrument, \boing, \dur, 0.75, \freq, 800))

Pdef(\bbb, Pbind(\instrument, \boing, \dur, 0.25, \freq, 1200, \amp, 0.1))

//giving a list of frequencies
Pdef(\bbb, Pbind(\instrument, \boing, \dur, 1, \freq, Pseq([400, 900, 1200, 800, 800], inf)))

Pdef(\bbb, Pbind(\instrument, \boing, \dur, Pseq([0.25, 0.6, 0.1, 0.2], inf), \freq, Pseq([500, 700], inf)))

//amplitude uses Pseq - standard step-sequencer style
(
Pdef(\bbb, Pbind(
	\instrument, \boing,
	\freq, 80,
	\dur, 0.25,
	\amp, Pseq([0.5, 1, 0, 0, 0, 1, 0.5, 1], inf)
))
)

//using Pseq to make pattern values for all parameters
(
Pdef(\bbb, Pbind(
	\instrument, \boing,
	\freq, Pseq([80, 100, 400], inf),
	\dur, Pseq([0.5, 0.25], inf),
	\amp, Pseq([0.5, 1, 0.5, 0], inf)
))
)

//pick values at random with Prand
(
Pdef(\bbb, Pbind(
	\instrument, \boing,
	\freq, Prand([80, 100, 400], inf),
	\dur, Prand([0.5, 0.25], inf),
	\amp, Prand([0.5, 1, 0.5, 0], inf)
))
)

//simple hihat..
(
SynthDef(\hat, {|rel= 0.2, cutoff= 5000, amp= 0.1, pan= 0|
	var env= EnvGen.ar(Env.perc(0, rel), doneAction:2);
	var src= HPF.ar(PinkNoise.ar(amp), cutoff);
	Out.ar(0, Pan2.ar(src*env, pan));
}).add;
)
Synth(\hat, [\amp, 0.5])

Pdef(\ddd).play(quant:2)
(
Pdef(\ddd, Pbind(
	\instrument, \hat,
	\dur, 0.125,
	\freq, 7000,
	\rel, 0.05,
	\amp, Pseq([1, 0.5, 0, 1, 0.5, 0, 0.5, 0.5], inf)
))
)

(
Pdef(\bbb, Pbind(
	\instrument, \boing,
	\dur, Pseq([1, 0.5, 0.5, 4], inf)*0.25,
	\freq, Pseq([400, 100, 200, 80], inf)
))
)

(
Pdef(\ddd, Pbind(
	\instrument, \hat,
	\dur, 0.125,
	\freq, Prand([7000, 6000, 5000], inf),
	\rel, Pseq([0.05, 0.1, 0.05], inf),
	\amp, Pseq([1, 0.5, 0, 1, 0.5, 0, 0.5, 0.5], inf)
))
)

//changing default clock tempo
TempoClock.default.tempo= 2	//120bpm
TempoClock.default.tempo= (80/60)//80bpm



//--
//animated window with control over x position (~posx)
~posx= 100;
~posy= 50;
~radius= 40;
(
var width= 500, height= 500;
var win= Window("boing", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.fillColor= Color.blue;
	Pen.fillOval(Rect.aboutPoint(Point(~posx, ~posy), ~radius, ~radius));
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;
	});
}).play(AppClock);
)
~posx= 350
~posx= 250
~posx= 150
~posy= 100
~radius= 20
~radius= 200





Pdef(\ddd).play(quant:1)
(
Pdef(\ddd, Pbind(
	\instrument, \hat,
	\dur, 0.25,
	\freq, Prand([7000, 6000, 5000], inf),
	\rel, Pseq([0.5, 0.1, 0.05], inf),
	\amp, Pseq([0, 1, 0, 0, 0.5], inf),
	\abc, Pfunc({|ev| ~radius= (ev.amp)*100; ~posx= ev.rel*500+100})
))
)




//--
~posx2= 100;
~posy2= 100;
~radius2= 100;
(
var width= 500, height= 500;
var win= Window("boing2", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.fillColor= Color.blue;
	Pen.fillOval(Rect.aboutPoint(Point(~posx, ~posy), ~radius, ~radius));
	Pen.fillColor= Color.red;
	Pen.fillRect(Rect.aboutPoint(Point(~posx2, ~posy2), ~radius2, ~radius2));
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;
	});
}).play(AppClock);
)

Pdef(\bbb).play(quant:2)
(
Pdef(\bbb, Pbind(
	\instrument, \boing,
	\dur, 0.125*0.5,
	\amp, Pseq([0, 1, 1, 0.5], inf)*0.1,
	\freq, Pseq([500, 600, 700, 800, 900, 6000], inf),
	\dummy, Pfunc({|ev| ~radius2= ev.amp*100; ~posy2= ev.freq.explin(500, 6000, 400, 100)})
	))
)


(
Pdef(\bbb, Pbind(
	\instrument, \boing,
	\dur, 0.25,
	\amp, Pseq([0, 1, 1, 0.5], inf)*0.6,
	\freq, Pseq([50, 500, 5000], inf),
	\dummy, Pfunc({|ev| ~radius2= ev.amp*100; ~posy2= ev.freq.explin(500, 6000, 400, 100)})
	))
)





//--
(
SynthDef(\bd, {|freq= 170, amp= 0.5, rel= 0.2|
	var env= EnvGen.ar(Env.perc(0, rel), doneAction:2);
	var src= SinOsc.ar(freq, 0, amp);
	Out.ar(0, Pan2.ar(src*env));
}).add;
SynthDef(\hh, {|freq= 1700, amp= 0.5, rel= 0.2|
	var env= EnvGen.ar(Env.perc(0, rel), doneAction:2);
	var src= HPF.ar(PinkNoise.ar(amp), freq);
	Out.ar(0, Pan2.ar(src*env));
}).add;
)

~posx= 100;
(
var width= 500, height= 500;
var win= Window("bounce", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
var dx= 13, dy= 12, x= 0, y= 0;
usr.background= Color.white;
usr.drawFunc= {
	x= ~posx;
	y= y+dy;
	if(x>=width or:{x<=0}, {	//detect border
		dx= 0-dx;
	});
	if(y>=height or:{y<=0}, {	//detect border
		dy= 0-dy;
		Synth(\hh);
	});
	Pen.fillColor= Color.blue;
	Pen.fillOval(Rect.aboutPoint(Point(x, y), 5, 5));
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;
	});
}).play(AppClock);
)


//--additional pbind examples that controls x position
Pbind(\dur, Pseq([1, 0.75, 0.5, 5], inf), \degree, Pseq([0, 5, 2, 1, -2], inf), \octave, 6, \abc, Pfunc({|ev| ~posx= ev.degree*25+50})).play
Pbind(\dur, Pseq([1, 0.75], inf), \degree, Pseq([0, 5, 2, 1, -2], inf)).play
Pbind(\dur, Pseq([1, 0.75, 0.25], inf)*0.5, \degree, Pseq([0, 5, 2, 1, -2], inf)).play
//stop with cmd+.



~posx= -51;
~posy= -20;
(
var width= 500, height= 500;
var win= Window("sin", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
var x= 0, y= 0, dx= 1, dy= 1, cnt= 0;
usr.background= Color.white;
usr.clearOnRefresh= false;
usr.drawFunc= {
	if(x>=width or:{x<=0}, {
		dx= -1*dx;
		Synth(\bd, [\freq, x.linexp(0, width, 170, 700)]);
	});
	if(y>=height or:{y<=0}, {
		dy= -1*dy;
		Synth(\bd, [\freq, y.linexp(0, height, 700, 1700)]);
	});
	x= x+(dx*~posx*(sin(cnt)));
	y= y+(dy*~posy*(cos(cnt)));
	Pen.fillColor= Color.blue(sin(cnt)*0.5+0.5, 0.5);
	Pen.fillOval(Rect.aboutPoint(Point(x, y), 5, 5));
	cnt= cnt+0.05;
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;
	});
}).play(AppClock);
)
~posx= 5
~posx= 7
~posy= -10

