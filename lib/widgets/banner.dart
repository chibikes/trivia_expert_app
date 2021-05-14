import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//Add this CustomPaint widget to the Widget Tree
// 	CustomPaint(
// 	    size: Size(WIDTH, (WIDTH*1.4142857142857144).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
// 	    painter: RPSCustomPainter(),
// 	)

	//Copy this CustomPainter code to the Bottom of the File
	class RPSCustomPainter extends CustomPainter {
    @override
	    void paint(Canvas canvas, Size size) {
    	double initialDx = 5;
    	double initialDy = 5;
    	double height = size.width /2;
    	double quarterRectWidth = initialDx + (1/4 * size.width);
    	double threeQuarterRectWidth = initialDx + (3/4 * size.width);
				Paint paintStroke = Paint()
						..color = Color(0xff4fc3f7)
						..style = PaintingStyle.fill;

				canvas.drawRect(Offset(initialDx, initialDy) & Size(size.width, height), paintStroke);

				Paint paintLine = Paint()
				..color = Colors.purple
				..style = PaintingStyle.fill;

				var path = Path();
				path.moveTo(quarterRectWidth, height);
				path.lineTo(quarterRectWidth - 20, height + 100);
				path.lineTo(threeQuarterRectWidth, -100);
				path.close();
				//
				canvas.drawPath(path, paintLine);



	// Path path_0 = Path();
	//
	// Paint paint0Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.01028443;
	// paint0Stroke.color=Color(0xff000000).withOpacity(0);
	// canvas.drawPath(path_0,paint0Stroke);
	//
	// Paint paint0Fill = Paint()..style=PaintingStyle.fill;
	// paint0Fill.color = Color(0xff00ffff).withOpacity(1.0);
	// canvas.drawPath(path_0,paint0Fill);
	//
	// Paint paint1Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.0009523810;
	// paint1Stroke.color=Color(0xff000000).withOpacity(0);
	// canvas.drawRect(Rect.fromLTWH(size.width*0.2267857,size.height*0.1247194,size.width*0.5291667,size.height*0.2061688),paint1Stroke);
	//
	// Paint paint1Fill = Paint()..style=PaintingStyle.fill;
	// paint1Fill.color = Color(0xff00ffff).withOpacity(1.0);
	// canvas.drawRect(Rect.fromLTWH(size.width*0.2267857,size.height*0.1247194,size.width*0.5291667,size.height*0.2061688),paint1Fill);
	//
	// Path path_2 = Path();
	//     path_2.moveTo(size.width*0.8639456,size.height*0.8598070);
	//     path_2.lineTo(size.width*0.8639456,size.height*0.4761905);
	//     path_2.lineTo(size.width*1.857143,size.height*0.4761905);
	//     path_2.lineTo(size.width*2.850340,size.height*0.4761905);
	//     path_2.lineTo(size.width*2.850340,size.height*0.8602382);
	//     path_2.lineTo(size.width*2.850340,size.height*1.244286);
	//     path_2.lineTo(size.width*1.857143,size.height*1.243855);
	//     path_2.lineTo(size.width*0.8639456,size.height*1.243424);
	//     path_2.lineTo(size.width*0.8639456,size.height*0.8598070);
	//     path_2.close();
	//
	// Paint paint2Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.01028443;
	// paint2Stroke.color=Color(0xff000000).withOpacity(0);
	// canvas.drawPath(path_2,paint2Stroke);
	//
	// Paint paint2Fill = Paint()..style=PaintingStyle.fill;
	// paint2Fill.color = Color(0xff00ffff).withOpacity(1.0);
	// canvas.drawPath(path_2,paint2Fill);
	//
	// Path path_3 = Path();
	//     path_3.moveTo(size.width*0.8639456,size.height*0.8598070);
	//     path_3.lineTo(size.width*0.8639456,size.height*0.4761905);
	//     path_3.lineTo(size.width*1.857143,size.height*0.4761905);
	//     path_3.lineTo(size.width*2.850340,size.height*0.4761905);
	//     path_3.lineTo(size.width*2.850340,size.height*0.8602382);
	//     path_3.lineTo(size.width*2.850340,size.height*1.244286);
	//     path_3.lineTo(size.width*1.857143,size.height*1.243855);
	//     path_3.lineTo(size.width*0.8639456,size.height*1.243424);
	//     path_3.lineTo(size.width*0.8639456,size.height*0.8598070);
	//     path_3.close();
	//
	// Paint paint3Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.01028443;
	// paint3Stroke.color=Color(0xff000000).withOpacity(0);
	// canvas.drawPath(path_3,paint3Stroke);
	//
	// Paint paint3Fill = Paint()..style=PaintingStyle.fill;
	// paint3Fill.color = Color(0xff00ffff).withOpacity(1.0);
	// canvas.drawPath(path_3,paint3Fill);
	//
	// Path path_4 = Path();
	//     path_4.moveTo(size.width*0.8639456,size.height*0.8598859);
	//     path_4.lineTo(size.width*0.8639456,size.height*0.4761905);
	//     path_4.lineTo(size.width*1.857143,size.height*0.4761905);
	//     path_4.lineTo(size.width*2.850340,size.height*0.4761905);
	//     path_4.lineTo(size.width*2.850340,size.height*0.8602884);
	//     path_4.lineTo(size.width*2.850340,size.height*1.244386);
	//     path_4.lineTo(size.width*1.857143,size.height*1.243984);
	//     path_4.lineTo(size.width*0.8639456,size.height*1.243581);
	//     path_4.lineTo(size.width*0.8639456,size.height*0.8598859);
	//     path_4.close();
	//
	// Paint paint4Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.01027672;
	// paint4Stroke.color=Color(0xff000000).withOpacity(1);
	// canvas.drawPath(path_4,paint4Stroke);
	//
	// Paint paint4Fill = Paint()..style=PaintingStyle.fill;
	// paint4Fill.color = Color(0xff4fc3f7).withOpacity(1);
	// canvas.drawPath(path_4,paint4Fill);
	//
	// Path path_5 = Path();
	//     path_5.moveTo(size.width*0.4534566,size.height*0.3281530);
	//     path_5.cubicTo(size.width*0.3220215,size.height*0.4837590,size.width*0.3194939,size.height*0.4837590,size.width*0.3194939,size.height*0.4837590);
	//     path_5.lineTo(size.width*0.5217018,size.height*0.3281530);
	//
	// Paint paint5Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.002300024;
	// paint5Stroke.color=Color(0xff000000).withOpacity(1);
	// paint5Stroke.strokeCap = StrokeCap.butt;
	// paint5Stroke.strokeJoin = StrokeJoin.miter;
	// canvas.drawPath(path_5,paint5Stroke);
	//
	// Paint paint5Fill = Paint()..style=PaintingStyle.fill;
	// paint5Fill.color = Color(0xff4fc3f7).withOpacity(1);
	// canvas.drawPath(path_5,paint5Fill);

	}

	@override
	bool shouldRepaint(covariant CustomPainter oldDelegate) {	  return false;	}
}
