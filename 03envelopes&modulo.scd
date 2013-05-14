//udk oct2009-feb2010 / fredrikolofsson.com
//091105

s.boot

//envelopes & modulo

Env.perc(0.1, 0.9).plot		//0.1 is attacktime, 0.9 releasetime
Env.perc(0.1, 0.9).test


(
SynthDef(\env, {|freq= 600, amp= 0.5|
	var src= SinOsc.ar(freq, 0, amp);
	var env= EnvGen.ar(Env.perc(1, 0.9), doneAction:2);
	Out.ar(0, Pan2.ar(src*env));
}).add;
)

Synth(\env)
Synth(\env, [\freq, 700])
Synth(\env, [\freq, 900, \amp, 0.1])//softer


Env.perc.plot	//percussive envelope. it only has attack and release
Env.sine(0.5).plot	//sine envelope.  only duration
Env.sine(0.5).test
Env.adsr(0.1, 0.2, 0.7, 0.1).plot//attack, decay, sustain, release

Env	//look into Env helpfile for a complete listing




//--one synthdef using 2 enveloples
//rule of thumb: always only 1 doneAction:2 in each synthdef
(
SynthDef(\another, {|freq= 600, amp= 0.5|
	var env1= EnvGen.ar(Env.perc(0.1, 1.2), doneAction:2);
	var env2= EnvGen.ar(Env.perc(0.4, 0.3));
	var src= SinOsc.ar(freq*(1-env2)+500, 0, amp);
	Out.ar(0, Pan2.ar(src*env1));
}).add;
)
Synth(\another)
Synth(\another, [\freq, 900])


(
var cnt= 400;
Routine({
	10.do{
		Synth(\another, [\freq, cnt]);
		0.5.wait;
		cnt= cnt+100;
	};
}).play;
)


//--modulo
1%3
2%3
3%3
4%3
5%3
6%3
500%3
//cycles 0, 1, 2, 0, 1, 2, 0, 1, 2...
//modulo is the remainder of division.

1%1.5
1.3%1.5
1.6%1.5
3.2%1.5

500.do{|i| i.postln};	//post all 500 values
500.do{|i| (i%100).postln};	//compare with % 100, wraps all 500 values between 0 and 99

(
var cnt= 400;
Routine({
	10.do{
		Synth(\another, [\freq, cnt%300]);//constrain 0-299
		0.5.wait;
		cnt= cnt+100;
		cnt.postln;
	};
}).play;
)

//so modulo gives the remainder of a division
7%3
//you can divide 7 with 3 and get 2. 2*3 is 6 and the remainder will be 1



//--
//50 ovals next to eachother.  i*2%100 is used for the x position
(
var width= 500, height= 500;
var win= Window("mod", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	50.do{|i|
		Pen.strokeColor= Color.grey(0.5);
		Pen.strokeOval(Rect(i*2%100, 10, 20, 20));
	};
};
win.front;
)


//also use % on y position
(
var width= 500, height= 500;
var win= Window("mod", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	350.do{|i|
		Pen.strokeColor= Color.grey(0.5);
		Pen.strokeOval(Rect(i*2%100, i%75, 20, 20));
	};
};
win.front;
)



//using widht and height variables with % to never exceed the bounds of the screen (wrap around)
(
var width= 500, height= 500;
var win= Window("mod", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	2500.do{|i|
		Pen.strokeColor= Color.grey(i/2500);
		Pen.strokeOval(Rect(i*5.5%width, i*23%height, 20, 20));
	};
};
win.front;
)


(
var width= 600, height= 400;
var win= Window("mod", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	500.do{|i|
		Pen.strokeColor= Color.red(i/500);
		Pen.strokeOval(Rect(i%width, i*144%height, i*0.3, 20));
	};
};
win.front;
)


