//udk oct2009-feb2010 / fredrikolofsson.com
//100128

s.boot

//four different lfo synthdefs.  the all are control rate (.kr) and 1 channel only
//we will use them in various combinations to control sound and graphics.
(
SynthDef(\sine, {|out= 100, freq= 2, amp= 1|
	var src= SinOsc.ar(freq, 0, amp);
	Out.kr(out, src);
}).add;
SynthDef(\tri, {|out= 100, freq= 2, amp= 1|
	var src= LFTri.ar(freq, 0, amp);
	Out.kr(out, src);
}).add;
SynthDef(\saw, {|out= 100, freq= 2, amp= 1|
	var src= LFSaw.ar(freq, 0, amp);
	Out.kr(out, src);
}).add;
SynthDef(\saw2, {|out= 100, freq= 2, amp= 1|
	var src= LFSaw.ar(freq, 0, amp)+BrownNoise.ar(0.3);
	Out.kr(out, src);
}).add;
)

//control bus = .kr
//also known as lfo (low-frequency-oscillator)


//a simple sound that take input from a control rate bus and change frequency accordingly
(
SynthDef(\test, {|lfo= 100, freq= 500, amp= 0.5, pan= 0|
	var ctrl= In.kr(lfo, 1);	//read from control bus
	var src= SinOsc.ar(freq*ctrl, 0, amp);
	Out.ar(0, Pan2.ar(src, pan));
}).add;
)


b= Bus.control(s, 1);	//create a control bus object
b.index							//bus index is allocated automatically, but if we really need to know use .index

a= Synth(\test, [\lfo, b, \amp, 0.1])	//create a synth that will sound
c= Synth(\sine, [\out, b])	//create a lfo synth that writes to bus b
c.free	//stop it
c= Synth(\saw, [\out, b, \freq, 0.5])		//create another type of lfo that writes to bus b
c.free
b.get({|value| value.postln})//read value from bus b

//play two lfos on the same bus (signals mix)
c= Synth(\sine, [\out, b, \freq, 0.6])
d= Synth(\tri, [\out, b, \freq, 0.7])

c.free
d.free


e= Synth(\saw2, [\out, b, \freq, 1])
e.free
a.free		//stop listening




//--
c= Bus.control(s, 1);
d= Bus.control(s, 1);
(
var width= 500, height= 500, sin1= 0, sin2= 0, cnt= 0;
var win= Window("sines", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
a= Synth(\sine, [\out, c, \freq, 0.5]);
b= Synth(\sine, [\out, d, \freq, 0.6]);
e= Synth(\test, [\lfo, c, \pan, -1, \amp, 0.1]);
f= Synth(\test, [\lfo, d, \pan, 1, \amp, 0.1]);
usr.background= Color.black;
usr.clearOnRefresh= true;	//try with false
usr.drawFunc= {
	var x, y;
	c.get({|val| sin1= val});	//read value from bus
	d.get({|val| sin2= val});
	Pen.translate(width*0.5, height*0.5);
	Pen.fillColor= Color.white;
	x= sin1*width*0.5;
	y= sin2*height*0.5;
	Pen.fillOval(Rect.aboutPoint(Point(x, y), 5, 5));
	cnt= cnt+1;
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;
	});
}).play(AppClock);
)

a.set(\freq, 10)
a.set(\freq, 2)
b.set(\freq, 3)
b.set(\freq, 30)
b.set(\amp, 0.4)

a.free
b.free
e.free
f.free
c.free	//free bus
d.free	//free bus



//--
c= Bus.control(s, 1);
d= Bus.control(s, 1);
(
var width= 500, height= 500, sin1= 0, sin2= 0;
var win= Window("sines2", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
a= {|i|
	Synth(\sine, [\out, c, \freq, i+0.1, \amp, i/3*0.4+0.1])
}.dup(4);
b= {|i|
	Synth(\sine, [\out, d, \freq, i+0.11, \amp, i/3*0.3+0.11])
}.dup(4);
e= Synth(\test, [\lfo, c, \pan, -1, \amp, 0.1]);
f= Synth(\test, [\lfo, d, \pan, 1, \amp, 0.1]);
usr.background= Color.black;
usr.clearOnRefresh= true;
usr.drawFunc= {
	var x, y;
	c.get({|val| sin1= val});	//read value from bus
	d.get({|val| sin2= val});
	Pen.translate(width*0.5, height*0.5);
	Pen.strokeColor= Color.white;
	x= sin1*width*0.5;
	y= sin2*height*0.5;
	Pen.moveTo(Point(0, 0));
	Pen.lineTo(Point(x, y));
	Pen.stroke;
	Pen.fillColor= Color.blue;
	Pen.fillOval(Rect.aboutPoint(Point(x, y), 4, 4));
};
win.front;
Routine({
	while({win.isClosed.not}, {
		usr.refresh;
		(1/60).wait;
	});
}).play(AppClock);
)

a[0].set(\freq, 10)
a[1].set(\freq, 2)
b[0].set(\freq, 3)
b[1].set(\freq, 30)
b[2].set(\amp, 0.4)
a[3].set(\freq, 100)
a[3].set(\freq, 1000)

a.do{|x| x.free}
b.do{|x| x.free}
e.free
f.free
c.free	//free bus
d.free	//free bus
