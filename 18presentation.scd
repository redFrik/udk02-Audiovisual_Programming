//udk oct2009-feb2010 / fredrikolofsson.com
//100211

s.boot

(
SynthDef(\fluct, {|freq= 500, surface= 1, amount= 50, atk= 0.1, rel= 0.9|
	var vary= Decay2.ar(Dust2.ar(surface)*amount, atk, rel);
	var src= SinOsc.ar(freq+vary, 0, 0.1);
	Out.ar(0, Pan2.ar(src));
}).memStore;
)

a= Synth(\fluct)
a.set(\amount, 500)
a.free

{Dust2.ar(1000)}.plot
{Decay.ar(Dust2.ar(1000), 0.001)}.plot
{Decay2.ar(Dust2.ar(1000), 0.01, 0.001)}.plot



//--
(
var width= 600, height= 400;
var win= SCWindow("ttest", Rect(100, 100, width, height), false, false);	//3rd argument for Window is resize, 4th argument is border on/off
win.front;
~mywin= win;	//use a 'global' variable to access window later
)

//access window, change size&position and close it
~mywin.bounds= Rect(400, 400, 300, 200);
~mywin.close;


EZKnob
EZSlider

//check out ixiViews quark.  install with command...
Quarks.checkoutAll
Quarks.gui
//then click ixiViews and 'save' and recompile (apple+k)
