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
