//udk oct2009-feb2010 / fredrikolofsson.com
//100129

s.boot

//simple lfo with decay
(
SynthDef(\sine2, {|out= 100, freq= 1, phase= 0, amp= 1, dur= 10, t_trig= 1|
	var src= SinOsc.kr(freq, phase, amp);
	var decay= Decay.kr(t_trig, dur).clip(0, 1);
	Out.kr(out, src*decay);
}).memStore;
)

//a simple sound that is controlled by lfo
(
SynthDef(\test2, {|lfo= 100, lfo2= 101, freq= 500, amp= 0.5|
	var ctrl= In.kr(lfo, 1);	//read from 1st control bus
	var ctrl2= In.kr(lfo2, 1);//read from 2nd control bus
	var src= BPF.ar(Saw.ar(freq*ctrl2.exprange(2, 0.5), ctrl*amp), freq);
	Out.ar(0, Pan2.ar(src, ctrl));
}).memStore;
)

//--
c= Bus.control(s, 1);
d= Bus.control(s, 1);
(
var width= 500, height= 500, duration= 160;//duration is damping factor
var x= 0, y= 0, prevPoint;
var win= Window("harmonograph", Rect(100, 100, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
~clear= false;
a= Synth(\sine2, [\out, c, \freq, 3.0.rand, \dur, duration]);
b= Synth(\sine2, [\out, d, \freq, 3.0.rand, \dur, duration]);
e= Synth(\test2, [\lfo, c, \lfo2, d, \amp, 0.5, \freq, width]);
usr.drawFunc= {
	var currentPoint;
	if(~clear, {
		usr.clearOnRefresh= true;
		~clear= false;
	}, {
		usr.clearOnRefresh= false;
	});
	c.get({|val| x= val});
	d.get({|val| y= val});
	Pen.width= 1;
	Pen.translate(width*0.5, height*0.5);
	Pen.strokeColor= Color.grey(0.5, 0.5);
	if(prevPoint.notNil, {
		Pen.moveTo(prevPoint);
	});
	currentPoint= Point(x*width*0.5, y*height*0.5);
	Pen.lineTo(currentPoint);
	Pen.stroke;
	prevPoint= currentPoint;
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;
	});
}).play(AppClock);
win.onClose= {a.free; b.free; e.free; f.free};
)

(
~clear= true;
a.set(\t_trig, 1);
b.set(\t_trig, 1);
)

(
~clear= true;
a.set(\freq, 0.5, \t_trig, 1);
b.set(\freq, 0.4, \t_trig, 1);
)

(
~clear= true;
a.set(\freq, 0.2, \t_trig, 1);
b.set(\freq, 0.3, \t_trig, 1);
)

(
~clear= true;
a.set(\freq, 0.1, \t_trig, 1);
b.set(\freq, 5, \t_trig, 1);
)

(
~clear= true;
a.set(\freq, 10, \t_trig, 1);
b.set(\freq, 20, \t_trig, 1);
)

(
~clear= true;
a.set(\freq, 100, \t_trig, 1);
b.set(\freq, 101, \t_trig, 1);
)

(
~clear= true;
a.set(\freq, 1, \dur, 20, \phase, 0, \t_trig, 1);
b.set(\freq, 2, \dur, 10, \phase, 0, \t_trig, 1);
)

//now we play something more complex on the 2 busses
(
SynthDef(\sine3, {|out= 100, freq= 1, phase= 0, amp= 1, dur= 10, t_trig= 1|
	var src= SinOsc.ar(SinOsc.kr(freq, 0, 2pi), phase, amp);
	var decay= Decay.kr(t_trig, dur).clip(0, 1);
	Out.kr(out, src*decay);
}).memStore;
)
a.free;
b.free;
(
~clear= true;
a= Synth(\sine3, [\out, c, \freq, 0.001, \dur, 300]);
b= Synth(\sine3, [\out, d, \freq, 0.002, \dur, 300]);
)

(
~clear= true;
a.set(\freq, 0.17, \dur, 200, \t_trig, 1);
b.set(\freq, 0.16, \dur, 200, \t_trig, 1);
)

(
~clear= true;
a.set(\freq, 1, \dur, 8, \t_trig, 1);
b.set(\freq, 1, \dur, 8, \t_trig, 1);
)

(
~clear= true;
a.set(\freq, 10, \dur, 8, \phase, 0, \amp, 1, \t_trig, 1);
b.set(\freq, 11, \dur, 8, \phase, 0, \amp, 1, \t_trig, 1);
)

a.free
b.free
c.free
d.free
e.free
