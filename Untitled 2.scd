(
var width= 500, height= 500, cnt= 0;
var win= Window("test", Rect(100, 100, width, height));
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.strokeColor= Color.red;
	Pen.fillColor= Color.black;
	Pen.translate(width/2, height/2);
	80.do{|i|
		Pen.rotate(i*0.05+cnt);
		Pen.scale(1.01, 1.02);
		Pen.addOval(Rect(0, 0, i+1, i+1));
	};
	Pen.draw(1);
	cnt= cnt+0.0001;
};
Routine({while({win.isClosed.not}, {usr.refresh; (1/60).wait})}).play(AppClock);
win.front;
)