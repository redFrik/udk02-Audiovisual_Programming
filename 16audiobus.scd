//udk oct2009-feb2010 / fredrikolofsson.com
//100204

s.boot

//define a simple test synth
(
SynthDef(\test, {|amp= 0.1, freq= 500, out= 0|
	var env= EnvGen.ar(Env.perc(0.05, 0.5), doneAction:2);
	var src= SinOsc.ar(freq, 0, amp);
	Out.ar(out, Pan2.ar(src*env));
}).memStore;
)

//start a sequencer
Pdef(\seq).play(quant:2);
//play out on stereo channels 0-1, 2-3, 4-5
//we can only hear 0-1 if laptop speakers.  2-3 and 4-5 will be silent.  bring the localhost window to the front and press 'l' to get a level meter gui.
Pdef(\seq, Pbind(\instrument, \test, \dur, 1, \out, Pseq([0, 2, 4], inf), \freq, Pseq([800, 900, 1000], inf)));


//simple echo/delay effect
(
SynthDef(\efxEcho, {|in= 0, out= 0|
	var src= InFeedback.ar(in, 2);
	var mod= CombN.ar(src, 0.2, 0.2, 1.5);	//0.2 is max delaytime and delaytime, 1.5 is decay time
	Out.ar(out, mod);
}).memStore;
)

//start effect synth taking input from stereo bus 2-3 and send to 0-1 so that we can hear it
a= Synth(\efxEcho, [\in, 2, \out, 0]);
//use a.free to stop this effect


//another effect - ring modulation
(
SynthDef(\efxRing, {|in= 0, out= 0|
	var src= InFeedback.ar(in, 2);
	var mod= src*SinOsc.ar(MouseX.kr(40, 4000, 'exponential'));
	Out.ar(out, mod);
}).memStore;
)

//start effect synth.  listens to 4-5 and sends to 0-1.  move the mouse to hear the effect more clearly
b= Synth(\efxRing, [\in, 4, \out, 0])
//use b.free to stop this effect


//changing the sequence.  playing at random out busses.  sometimes with effectEcho or effectRing, bus most often just out on stereo bus 0
Pdef(\seq, Pbind(\instrument, \test, \dur, 0.25, \out, Prand([0, 0, 0, 0, 0, 0, 2, 4], inf), \freq, Pseq([800, 900, 1000, 220], inf)))


//adding another synth sound
(
SynthDef(\hh, {|out= 0, freq= 5000, amp= 0.1|
	var env= EnvGen.ar(Env.perc(0.001, 0.1), doneAction:2);
	var src= HPF.ar(PinkNoise.ar(amp), freq);
	Out.ar(out, Pan2.ar(src*env));
}).memStore;
)

//sequencer for hihat
Pdef(\hhseq).play(quant:2);
Pdef(\hhseq, Pbind(\instrument, \hh, \amp, 1, \dur, 0.5, \freq, 5000, \out, Pseq([0, 2, 4], inf)));

Pdef(\seq).stop;
Pdef(\hhseq).stop;
a.free;	//stop the echo
b.free;	//stop the ring modulator

//how to build some simple effects...
//delay/echo			CombN
//ring modulation	*SinOsc
//distortion			.clip
//filtering				LPF, BPF, HPF
//reverb					FreeVerb
//pitchshift			PitchShift, ZeroCrossing

//see helpfile 'Tour of Unit Generators'


//additional 3rd party code
Quarks.checkoutAll	//updates your packages
Quarks.gui
