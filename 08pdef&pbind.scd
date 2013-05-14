//udk oct2009-feb2010 / fredrikolofsson.com
//091217

s.boot

//pdef and pbind

(
SynthDef(\ping, {|amp= 0.1, freq= 400, atk= 0.01, rel= 0.1, mod= 10|
	var env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	var src= SinOsc.ar(0, SinOsc.ar(freq, 0, 2pi*mod), amp);
	var noise= WhiteNoise.ar(0.05);
	Out.ar(0, Pan2.ar(src+noise*env));
}).add;
)


Pdef(\seq).play(quant:4);	//start sequencer

(	//define sequencer
Pdef(\seq, Pbind(
	\instrument, \ping,	//which instrument/synthdef
	\dur, 0.25,		//time between events
	\freq, 1200	//synth argument
))
)

(
Pdef(\seq, Pbind(
	\instrument, \ping,
	\dur, 2,
	\freq, 800,
	\atk, 0.1,
	\rel, 1.2,
	\mod, 0.4
))
)

//adding a Pseq.  Pseq repeats inf many times
(
Pdef(\seq, Pbind(
	\instrument, \ping,
	\dur, 0.25,
	\freq, Pseq([1800, 900, 500, 1100, 1200], inf),
	\atk, 0.01,
	\rel, 0.2,
	\mod, 1
))
)


(
Pdef(\seq, Pbind(
	\instrument, \ping,
	\dur, Pseq([0.25, 0.25, 0.125], inf),
	\freq, Pseq([400, 900, 500, 800], inf),
	\atk, 0.01,
	\rel, Pseq([0.2, 0.2, 0.2, 0.7], inf),
	\mod, Pseq([1, 2, 10, 2, 1], inf)
))
)


//making a kickdrum from the same synthdef
(
Pdef(\bassdrum, Pbind(
	\instrument, \ping,
	\atk, 0,
	\rel, 0.1,
	\freq, 80,
	\dur, Pseq([0.5, 0.5, 0.5, 0.1, 0.4], inf),
	\mod, 0.1,
	\amp, 1
))
)

//start and stop our 2 sequences with .play and .stop
Pdef(\bassdrum).play(quant:4);
Pdef(\bassdrum).stop
Pdef(\seq).play(quant:4)
Pdef(\seq).stop

//quant:4 means to keep sequences in sync - wait until next 4 beat to start



//--
(
SynthDef(\hat, {|amp= 0.1, freq= 5000, atk= 0.01, rel= 0.1, pan= 0|
	var env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	var src= BPF.ar(PinkNoise.ar(amp), freq, 0.3)+Saw.ar(freq, 0.1);
	Out.ar(0, Pan2.ar(src*env, pan));
}).add;
)

Pdef(\hh).play(quant:4)

(
Pdef(\hh, Pbind(
	\instrument, \hat,
	\dur, 0.25,
	\amp, 2,
	\freq, 5000
))
)

//example using pan and Prand
(
Pdef(\hh, Pbind(
	\instrument, \hat,
	\dur, Pseq([0.3, 0.2], inf),
	\amp, Pseq([1, 0, 1, 0, 1, 0.5, 1, 0.5, 1, 0, 1, 0, 1, 0.5, 0, 0.5], inf),
	\rel, Pseq([0.1, 0.3], inf),
	\freq, Prand([5000, 4700], inf),
	\pan, Pseq([-1, 1], inf)
))
)
Pdef(\bassdrum).play(quant:4)


//a second hihat
Pdef(\hat2).play(quant:4)
(
Pdef(\hat2, Pbind(
	\instrument, \hat,
	\dur, 0.125,
	\atk, 0.005,
	\rel, Pseq([0.01, 0.01, 0.01, 0.1], inf),
	\amp, Pseq([0, 1, 0, 0.5, 1, 0.5, 1, 0.3], inf)*5,
	\freq, 9000,
	\pan, Pseq([0.5, 0, -0.5, 0], inf)
))
)


//--
//look at kraftwerk cover in folder examples/pieces/spacelab.scd


//--
//for connecting processing and supercollider
//try OpenObject quark
Quarks.checkoutAll	//download quarks with this command, press 'p' to accept permanently
Quarks.gui	//open installation gui window