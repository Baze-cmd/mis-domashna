import 'package:flutter/material.dart';

class QuartersToSemisLines extends CustomPainter
{
    @override
    void paint(Canvas canvas, Size size)
    {
        final paint = Paint()
            ..color = Colors.grey
            ..strokeWidth = 2;

        canvas.drawLine(
            Offset(0, size.height * 0.068),
            Offset(size.width * 0.5, size.height * 0.068),
            paint
        );

        canvas.drawLine(
            Offset(size.width * 0.5, size.height * 0.068),
            Offset(size.width * 0.5, size.height * 0.356),
            paint
        );

        canvas.drawLine(
            Offset(0, size.height * 0.356),
            Offset(size.width * 1, size.height * 0.356),
            paint
        );

        canvas.drawLine(
            Offset(0, size.height * 0.645),
            Offset(size.width * 1, size.height * 0.645),
            paint
        );

        canvas.drawLine(
            Offset(0, size.height * 0.936),
            Offset(size.width * 0.5, size.height * 0.936),
            paint
        );

        canvas.drawLine(
            Offset(size.width * 0.5, size.height * 0.936),
            Offset(size.width * 0.5, size.height * 0.645),
            paint
        );
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SemisToGrandsLines extends CustomPainter
{
    @override
    void paint(Canvas canvas, Size size)
    {
        final paint = Paint()
            ..color = Colors.grey
            ..strokeWidth = 2;

        canvas.drawLine(
            Offset(0, size.height * 0.345),
            Offset(size.width * 0.5, size.height * 0.345),
            paint
        );
        canvas.drawLine(
            Offset(size.width * 0.5, size.height * 0.345),
            Offset(size.width * 0.5, size.height * 0.656),
            paint
        );

        canvas.drawLine(
            Offset(0, size.height * 0.656),
            Offset(size.width * 0.5, size.height * 0.656),
            paint
        );
        canvas.drawLine(
            Offset(size.width * 0.5, size.height * 0.5),
            Offset(size.width, size.height * 0.5),
            paint
        );
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) => false;
}
