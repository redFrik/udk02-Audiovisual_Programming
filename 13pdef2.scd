//udk oct2009-feb2010 / fredrikolofsson.com
//100122

s.boot

(
SynthDef(\poing, {|freq= 700, amp= 0.3, pan= 0, atk= 0.004, rel= 0.4|
	var env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	var src= SinOsc.ar(freq, 1-env*5pi, amp);
	Out.ar(0, Pan2.ar(src*env, pan));
}).memStore;
)

Synth(\poing)

Pdef(\s1).play(quant:1)
Pdef(\s1, Pbind(\instrument, \poing, \dur, 0.25))

Pdef(\s1, Pbind(\instrument, \poing, \dur, 0.25, \rel, Pseq([0.1, 0.1, 0.5], inf)))

Pdef(\s1, Pbind(\instrument, \poing, \dur, 0.25, \rel, Pseq([0.1, 0.1, 0.5], inf), \atk, Pseq([0.004, 0.004, 0.01, 0.1], inf)))

Pdef(\s1, Pbind(\instrument, \poing, \dur, 0.25, \rel, Pseq([0.1, 0.1, 0.5], inf), \atk, Pseq([0.004, 0.004, 0.01, 0.1], inf), \freq, Pseq([440, 440, 440, 440, 660], inf)))

Pdef(\s1, Pbind(\instrument, \poing, \dur, 0.25, \rel, Pseq([0.1, 0.1, 0.5], inf), \atk, Pseq([0.004, 0.004, 0.01, 0.1], inf), \freq, Pseq([440, 440, 440, 440, 660], inf), \pan, Pseq([-0.8, -0.3, 0.3, 0.8, 0.3, -0.3], inf)))


Pdef(\s2).play(quant:1)
Pdef(\s2, Pbind(\instrument, \poing, \dur, Pseq([Pseq([0.75], 6), Pseq([0.5], 16)], inf), \freq, 150, \rel, Pseq([1, 0.1], inf), \pan, 0))

Pdef(\s3).play(quant:1)
Pdef(\s3, Pbind(\instrument, \poing, \dur, Pseq([4, 2, 2, 2], inf), \freq, Pseq([880, 770, 660, 550], inf), \rel, Pseq([1, 0.1], inf), \rel, 1, \pan, 0))

Pdef(\s1).stop;
Pdef(\s2).stop;
Pdef(\s3).stop;


//--
~s1= Point(0, 0);
~s2= Point(0, 0);
~s3= Point(0, 0);
(
var width= 500, height= 500;
var win= Window("poing", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.black;
usr.drawFunc= {
	Pen.strokeColor= Color.grey(0.9);
	Pen.strokeRect(Rect.aboutPoint(~s1, 40, 40));
	Pen.strokeColor= Color.grey(0.9);
	Pen.strokeRect(Rect.aboutPoint(~s2, 40, 40));
	Pen.strokeColor= Color.grey(0.9);
	Pen.strokeRect(Rect.aboutPoint(~s3, 40, 40));
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;
	});
}).play(AppClock);
)

Pdef(\s1).play(quant:1);
Pdef(\s2).play(quant:1);
Pdef(\s3).play(quant:1);


Pdef(\s1, Pbind(\instrument, \poing, \dur, 0.25, \rel, Pseq([0.1, 0.1, 0.5], inf), \atk, Pseq([0.004, 0.004, 0.01, 0.1], inf), \freq, Pseq([440, 440, 440, 440, 660], inf), \pan, Pseq([-0.8, -0.3, 0.3, 0.8, 0.3, -0.3], inf), \gfx, Pfunc({|ev| ~s1= Point(ev.freq.explin(100, 1000, 0, 400), 50)})))

Pdef(\s2, Pbind(\instrument, \poing, \dur, Pseq([Pseq([0.75], 6), Pseq([0.5], 16)], inf), \freq, Pseq([150, 250], inf), \rel, Pseq([1, 0.1], inf), \pan, 0, \gfx, Pfunc({|ev| ~s2= Point(ev.freq.explin(100, 1000, 0, 400), 150)})))

Pdef(\s3, Pbind(\instrument, \poing, \dur, Pseq([4, 2, 2, 2], inf), \freq, Pseq([880, 770, 660, 550], inf), \rel, Pseq([1, 0.1], inf), \rel, 1, \pan, 0, \gfx, Pfunc({|ev| ~s3= Point(ev.freq.explin(100, 1000, 0, 400), 250)})))


Pdef(\s1).stop
Pdef(\s2).stop
Pdef(\s3).stop
