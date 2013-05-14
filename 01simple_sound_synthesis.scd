//udk oct2009-feb2010 / fredrikolofsson.com
//091022

s.boot

//fn+return
//enter button
//ctrl+c


1+1
400-20

(
100*500;
303+30;		//always the last thing in a block
)

//semicolons are needed at the end of multiple lines

(
SynthDef(\udk, {|freq= 500|
	Out.ar(0, SinOsc.ar(freq, 0, 1));
}).add;
)

Synth(\udk, [\freq, 600])
//stop the sound with cmd+.

Synth(\udk, [\freq, 600])
Synth(\udk, [\freq, 700])
Synth(\udk, [\freq, 800])


(
SynthDef(\udk2, {|freq= 500|
	Out.ar(0, Saw.ar(freq, 1));
}).add;
)
Synth(\udk2, [\freq, 550])
Synth(\udk2, [\freq, 290])
Synth(\udk2, [\freq, 590])

(
SynthDef(\udk3, {|freq= 500, amp= 0.5|
	Out.ar(0, Saw.ar(freq, amp));
}).add;
)
Synth(\udk3, [\freq, 700, \amp, 0.5])
Synth(\udk3, [\freq, 950, \amp, 0.2])
Synth(\udk3, [\freq, 1700, \amp, 0.1])


a= Synth(\udk3, [\freq, 400, \amp, 0.4])
b= Synth(\udk3, [\freq, 800, \amp, 0.6])
c= Synth(\udk3, [\freq, 600, \amp, 0.5])
a.free
b.free
c.free


(
Routine({
	40.do{
		b= Synth(\udk2, [\freq, 1000.rand, \amp, 0.4]);
		0.1.wait;		//one tenth of a second delay
		b.free;
		0.05.wait;		//0.05 sec delay
	}
}).play
)



(
SynthDef(\udk4, {|freq= 500, amp= 0.5|
	var src, efx;
	src= PinkNoise.ar(amp);
	efx= BPF.ar(src, freq);
	Out.ar(0, efx);
}).add;
)

a= Synth(\udk4, [\amp, 0.7])
a.free
b= Synth(\udk4, [\freq, 900, \amp, 0.7])
b.free

//a-z declared for you already in supercollider

(
Routine({
	10.do{
		a= Synth(\udk4, [\freq, 900, \amp, 0.9]);
		0.1.wait;
		a.free;
		0.05.wait;
		a= Synth(\udk3, [\freq, 900, \amp, 0.4]);
		0.2.wait;
		a.free;
		0.1.wait;
		a= Synth(\udk4, [\freq, 400, \amp, 0.9]);
		0.1.wait;
		a.free;
		0.05.wait;
	}
}).play
)


//using a counter (b) to set the frequencies
(
Routine({
	b= 50;
	10.do{
		a= Synth(\udk4, [\freq, b, \amp, 0.9]);
		0.1.wait;
		a.free;
		0.05.wait;
		a= Synth(\udk3, [\freq, b, \amp, 0.4]);
		0.2.wait;
		a.free;
		0.1.wait;
		a= Synth(\udk4, [\freq, b, \amp, 0.9]);
		0.1.wait;
		a.free;
		0.05.wait;
		b= b+100;
	}
}).play;
)		


