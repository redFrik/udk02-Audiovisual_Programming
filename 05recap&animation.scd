//udk oct2009-feb2010 / fredrikolofsson.com
//091119

s.boot

//recap and animaiton


//first some frequency modulation like last time
(
SynthDef(\fm, {|freq= 750, amp= 0.5, depth= 4, fmrate= 100|
	var env= EnvGen.ar(Env.perc(0.1, 0.6), doneAction:2);
	var src= SinOsc.ar(freq+SinOsc.ar(fmrate, 0, depth), 0, amp);
	Out.ar(0, Pan2.ar(src*env));
}).add;
)

Synth(\fm, [\depth, 100])
Synth(\fm, [\depth, 50, \fmrate, 2])
Synth(\fm, [\depth, 150, \fmrate, 12, \freq, 280])
Synth(\fm, [\depth, 50, \fmrate, 2000, \freq, 1280])




// remake of the graphics in this musicvideo
// http://vimeo.com/3980306

(
var width= 500, height= 500;
var win= Window("grid", Rect(100, 200, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.black;
usr.drawFunc= {
	7.do{|y|
		5.do{|x|
			var colIndex= 10.rand; //give random integers between 0-9
			if(colIndex==0, {
				Pen.fillColor= Color.black;
			});
			if(colIndex==1, {
				Pen.fillColor= Color(0.5, 0.5, 1);
			});
			if(colIndex>1, {
				Pen.fillColor= Color.white;
			});
			Pen.fillOval(Rect(x*(width/5)+25, y*(height/7)+12.5, 50, 50));
		};
	};
};
win.front;

Routine({while({win.isClosed.not}, {usr.refresh; (1/3).wait})}).play(AppClock);
)



//--
(
var width= 500, height= 500, cnt= 0;
var win= Window("scroll", Rect(100, 200, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.black;
usr.drawFunc= {
	Pen.fillColor= Color(1, 0.5, 0);
	7.do{|y|
		6.do{|x|
			var xpos= x*(width/5)+25-(cnt*2);
			//if(xpos<0, {xpos= xpos+width});
			if(xpos< -50, {xpos= xpos%width});
			Pen.fillOval(Rect(xpos, y*(height/7)+12.5, 50, 50));
		};
	};
	cnt= cnt+1;
};
win.front;

Routine({while({win.isClosed.not}, {usr.refresh; (1/40).wait})}).play(AppClock);
)




//--
(
var width= 500, height= 500, cnt= 0;
var win= Window("levels", Rect(100, 200, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.black;
usr.drawFunc= {
	5.do{|x|
		var test= 7.rand;
		7.do{|y|	//y is counting from 0 to 6
			if(y>=test or:{y==6}, {
				if(y==0, {
					Pen.fillColor= Color.red;
				});
				if(y==1 or:{y==2}, {
					Pen.fillColor= Color.yellow;
				});
				if(y>2, {
					Pen.fillColor= Color.green;
				});
				Pen.fillRect(Rect(width/5*x+(width/5*0.1), height*0.5/7*y+40, width/5*0.8, height*0.5/7*0.8));
			});
		};
	};
};
win.front;
Routine({while({win.isClosed.not}, {usr.refresh; (1/40).wait})}).play(AppClock);
)




//--
(
var width= 500, height= 500, cnt= 0;
var win= Window("levels", Rect(100, 200, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
var scene1, scene2;
usr.background= Color.black;
scene1= {
	5.do{|x|
		var test= 7.rand;
		7.do{|y|	//y is counting from 0 to 6
			if(y>=test or:{y==6}, {
				if(y==0, {
					Pen.fillColor= Color.red;
				});
				if(y==1 or:{y==2}, {
					Pen.fillColor= Color.yellow;
				});
				if(y>2, {
					Pen.fillColor= Color.green;
				});
				Pen.fillRect(Rect(width/5*x+(width/5*0.1), height*0.5/7*y+40, width/5*0.8, height*0.5/7*0.8));
			});
		};
	};
	cnt= cnt+1;
};
scene2= {
	Pen.fillColor= Color(1, 0.5, 0);
	7.do{|y|
		6.do{|x|
			var xpos= x*(width/5)+25-(cnt*2);
			//if(xpos<0, {xpos= xpos+width});
			if(xpos< -50, {xpos= xpos%width});
			Pen.fillOval(Rect(xpos, y*(height/7)+12.5, 50, 50));
		};
	};
	cnt= cnt+1;
};
win.front;
Routine({while({win.isClosed.not}, {if(cnt%200==0, {usr.drawFunc= scene1}); if(cnt%200==100, {usr.drawFunc= scene2}); usr.refresh; (1/40).wait})}).play(AppClock);
)




//--more fm
(
SynthDef(\fm2, {|freq= 987, amp= 0.4, mf= 10, atk= 0.1, rel= 0.6|
	var env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	var env2= EnvGen.ar(Env.perc(rel, atk));
	var src= SinOsc.ar(freq+SinOsc.ar(freq*(1-env2), 0, mf*(1-env)), 0, amp);
	Out.ar(0, Pan2.ar(src*env));
}).add;
)
Synth(\fm2, [\mf, 150, \atk, 0.01, \rel, 0.2])
Synth(\fm2, [\mf, 1050, \atk, 0.01, \rel, 0.2])
Synth(\fm2, [\mf, 4000, \freq, 400, \atk, 0.01, \rel, 0.2])
Synth(\fm2, [\mf, 1400, \freq, 40, \atk, 0.1, \rel, 0.2])


(
Routine({
	6.do{|j|
		7.do{|i|
			Synth(\fm2, [\freq, (i*100+100+(j*250)).postln, \atk, 0.01, \rel, 0.1, \mf, i*j*40]);
			0.125.wait;
		};
	};
}).play;
)






//--same but different
(
var width= 640, height= 480;
var win= Window("test", Rect(100, 200, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.black;
usr.drawFunc= {
	7.do{|x|
		8.do{|y|
			var colIndex= 6.rand;
			if(colIndex==0, {
				Pen.fillColor= Color.black;
			});
			if(colIndex==1, {
				Pen.fillColor= Color(0.5, 0.5, 1);
			});
			if(colIndex>1, {
				Pen.fillColor= Color.white;
			});
			Pen.fillOval(Rect(x/7*width+(width/7/2-20), y/8*height+(height/8/2-20), 40, 40));

		};
	};
};
win.front;
Routine({while({win.isClosed.not}, {win.refresh; 1.wait})}).play(AppClock);
)


(
var width= 640, height= 480, cnt= 0;
var win= Window("test", Rect(100, 200, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.black;
usr.drawFunc= {
	8.do{|x|	//here 8 instead of 7 to conver for the jump
		8.do{|y|
			var xpos= x/7*width-(cnt%(width/7));

			//another option...
			//var xpos= x/7*width-cnt;
			//if(xpos< -40, {xpos= xpos+width+40});

			Pen.fillColor= Color(1, 0.5, 0);
			Pen.fillOval(Rect(xpos, y/8*height, 40, 40));
		};
	};
	cnt= cnt+1;
};
win.front;
Routine({while({win.isClosed.not}, {win.refresh; (1/60).wait})}).play(AppClock);
)


(
var width= 640, height= 480;
var win= Window("test", Rect(100, 200, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.black;
usr.drawFunc= {
	5.do{|x|
		var r= 6.rand;
		6.do{|y|
			if(r>=y, {
				if(y<3, {
					Pen.fillColor= Color.green;
				}, {
					if(y<5, {
						Pen.fillColor= Color.yellow;
					}, {
						Pen.fillColor= Color.red;
					});
				});
				Pen.fillRect(Rect(x/5*width+10, height/2-(13*y), width/5*0.8, 10));
			});
		};
	};
};
win.front;
Routine({while({win.isClosed.not}, {win.refresh; (1/15).wait})}).play(AppClock);
)


(
var width= 640, height= 480, cnt= 0;
var win= Window("test", Rect(100, 200, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.black;
usr.drawFunc= {
	var lfo= sin(cnt*0.02)*50;
	Pen.strokeColor= Color.white;
	5.do{|i|
		var xdist= 35*(i+1)+(cnt%35);
		var ydist= 200+(35*(i+1))+(cnt%35);
		Pen.width= i*3+5+(cnt%35*0.1);
		Pen.moveTo(Point(width/2-xdist+lfo, height));
		Pen.lineTo(Point(width/2-xdist+lfo, height-ydist));
		Pen.lineTo(Point(width/2+xdist+lfo, height-ydist));
		Pen.lineTo(Point(width/2+xdist+lfo, height));
		Pen.stroke;
	};
	cnt= cnt+1;
};
win.front;
Routine({while({win.isClosed.not}, {win.refresh; (1/60).wait})}).play(AppClock);
)

