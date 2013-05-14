//udk oct2009-feb2010 / fredrikolofsson.com
//091112

s.boot

//lines and frequency modulation

(
SynthDef(\asd, {|freq= 500, amp= 0.4, atk= 0.01, rel= 0.2|
	var env= EnvGen.kr(Env.perc(atk, rel), doneAction:2);
	var src= SinOsc.ar(freq*(env+1), 0, env);
	Out.ar(0, Pan2.ar(src*amp));
}).add;
)

Synth(\asd, [\freq, 100, \amp, 0.3]);

(
Routine({
	20.do{|i|
		Synth(\asd, [\freq, 100*(i%6), \amp, 0.3, \rel, i.linlin(0, 9, 0.01, 0.1)]);
		[0.1, 0.4, 0.1, 0.1].wrapAt(i).wait;
	};
}).play;
)

(
var width= 500, height= 500;
var win= Window("test", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
o= 0;
usr.drawFunc= {
	100.do{|i|
		Pen.moveTo(Point(width*0.5, height*0.5));
		Pen.lineTo(Point(i*(30+o)%width, height));
		Pen.lineTo(Point(i*(30+o)%width, 0));
	};
	Pen.stroke;
};
win.front;
Routine({while({win.isClosed.not}, {(1/25).wait; o= o+0.01; usr.refresh})}).play(AppClock);
)
