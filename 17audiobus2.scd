//udk oct2009-feb2010 / fredrikolofsson.com
//100205

s.boot

(
SynthDef(\bd, {|amp= 0.1, freq= 500, out= 0|
	var env= EnvGen.ar(Env.perc(0.01, 0.5), doneAction:2);
	var src= SinOsc.ar(XLine.kr(freq, freq*0.5, 0.5), 0, amp);
	Out.ar(out, Pan2.ar(src*env));
}).add;
SynthDef(\hh, {|amp= 0.1, freq= 500, out= 0|
	var env= EnvGen.ar(Env.perc(0.01, 0.05), doneAction:2);
	var src= BPF.ar(WhiteNoise.ar(amp), freq);
	Out.ar(out, Pan2.ar(src*env));
}).add;
SynthDef(\efx_echoRing, {|in= 100, out= 0|
	var dry= InFeedback.ar(in, 2);
	var freq= MouseY.kr(2, 200, 'exponential');
	var decay= MouseY.kr(0.1, 3);
	var mix= MouseX.kr(-1, 1);
	var wet= CombN.ar(dry*SinOsc.ar(freq, 0, 1), 0.125, 0.125, decay);
	Out.ar(out, XFade2.ar(dry, wet, mix));
}).add;
)

//start the effect
a= Synth(\efx_echoRing, [\in, 100, \out, 0])

//create and play 2 sequences
Pdef(\seq_hh).play(quant:2);
Pdef(\seq_hh, Pbind(\instrument, \hh, \dur, 0.125, \out, 100, \freq, Pseq([6000, 4000], inf), \amp, Pseq([0.2, 0.1, 0.2, 0.3], inf)));
Pdef(\seq_bd).play(quant:2);
Pdef(\seq_bd, Pbind(\instrument, \bd, \dur, Pseq([0.4, 0.1], inf), \out, 100, \freq, Pseq([Pseq([160, 160, 160], 8), Pseq([180, 200, 220], 8)], inf), \amp, Pseq([0.75, 0.5], inf)));

a.free
Pdef(\seq_hh).stop
Pdef(\seq_bd).stop
