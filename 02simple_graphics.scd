//udk oct2009-feb2010 / fredrikolofsson.com
//091029

s.boot

(
SynthDef(\udk, {|freq= 600, amp= 0.5|
	var src= SinOsc.ar(freq, 0, amp);
	Out.ar(0, Pan2.ar(src));
}).add;
)



a= Synth(\udk, [\freq, 8900])
b= Synth(\udk, [\freq, 400])
a.free
b.free




//sequencing...
(
Routine({
	20.do{
		a= Synth(\udk, [\freq, 900]);
		0.1.wait;
		a.free;
		0.05.wait;
		a= Synth(\udk, [\freq, 6420]);
		0.04.wait;
		a.free;
		0.02.wait;
	};
}).play;
)

//recommended listening: Ryoji Ikeda


(
SynthDef(\noise, {|amp= 0.5|
	var src= WhiteNoise.ar(amp);
	Out.ar(0, Pan2.ar(src));
}).add;
)


a= Synth(\noise)
a.free


//sequencing with 2 synth definitions...
(
Routine({
	40.do{
		a= Synth(\udk, [\freq, 8700.rrand(9000)]);
		0.1.wait;
		a.free;
		0.05.wait;
		a= Synth(\noise, [\amp, 0.2]);
		0.008.wait;
		a.free;
		0.1.wait;
	};
}).play;
)




//simple window with rectangles
(
var width= 500, height= 500;
var win= Window("simple", Rect(50, 50, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;

usr.drawFunc= {
	20.do{
		Pen.strokeColor= Color.black;
		Pen.strokeRect(Rect(100.rand, 50, 30, 100));
	};
};
win.front;
)


//more drawing
(
var width= 500, height= 500;
var win= Window("simple", Rect(50, 50, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;

usr.drawFunc= {
	120.do{
		Pen.strokeColor= Color.black;
		Pen.strokeRect(Rect((width-30).rand, height/2-50, 30, 100));
		
		Pen.fillColor= Color.red;
		Pen.fillOval(Rect(width.rand, height.rand, 5, 5));
	};
};
win.front;
)



//--put it all together...
(
SynthDef(\udk, {|freq= 700, amp= 0.4, pan= 0|
	var src= SinOsc.ar(freq, 0, amp);
	Out.ar(0, Pan2.ar(src, pan));
}).add;

SynthDef(\noise, {|amp= 0.3|
	var src= WhiteNoise.ar(amp);
	Out.ar(0, Pan2.ar(src));
}).add;
)

(
var width= 400, height= 400, fr= 4000, pan= 0;
var win= Window("together", Rect(50, 50, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.clearOnRefresh= false;
win.front;
Routine({
	40.do{
		pan= -1.0.rrand(1.0);
		fr= fr+50;
		a= Synth(\udk, [\freq, fr, \pan, pan]);
		usr.drawFunc= {
			Pen.strokeColor= Color.black;
			Pen.strokeRect(Rect(pan*0.5+0.5*width, height/2-50, 30, fr/100));
			Pen.fillColor= Color.red;
			Pen.fillOval(Rect(width*(pan*0.5+0.5), fr/50, 10, 5));
		};
		usr.refresh;
		0.1.wait;
		a.free;
		usr.drawFunc= {};
		usr.refresh;
	};
}).play(AppClock);
)

