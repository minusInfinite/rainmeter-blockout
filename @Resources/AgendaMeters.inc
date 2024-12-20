[MeterRefreshAgenda]
Meter=String
MeterStyle=IconBase
Text=[\[#featherrefresh]]
X=(155*#Scale#)
Y=(24*#Scale#)r
DynamicVariables=1
LeftMouseUpAction=[!Refresh][!Refresh]
[MeterAddAgenda]
Meter=String
MeterStyle=IconBase
Text=[\[#featherplus]]
X=4R
Y=r
DynamicVariables=1
LeftMouseUpAction=[!CommandMeasure MeasureInput "ExecuteBatch 1-2"]
[Block1]
Meter=Shape
X=(35*#Scale#)
Y=([Hour9:Y]+(8*#Scale#))
Shape=Rectangle 0,0,(140*#Scale#),(((584*#Scale#)*((2*3600)/86400))) | Extend BlockE
BlockE=Fill Color 1,165,15,(#blockAFade1#) | StrokeWidth (2*#Scale#) | Stroke Color 0,255,0,(#blockSFade1#)
Shape2=Rectangle 0,0,(140*#Scale#),(((584*#Scale#)*((2*3600)/86400))) | Extend BlockA
BlockA=Fill Color 200,55,35,(175-#blockAFade1#) | StrokeWidth (2*#Scale#) | Stroke Color 255,0,0,(255-#blockSFade1#)
ToolTipTitle=block1
ToolTipText=Duration:2
DynamicVariables=1
[Block1Del]
Meter=String
MeterStyle=IconDel
FontColor=255,255,255,(255-#blockSFade1#)
Text=[\[#featherdelete]]
X=(([Block1:X])+([Block1:W])*0.5)
Y=(([Block1:Y])+([Block1:H])*0.5)
FontSize=((([Block1:H])*0.5)*#Scale#)
StringAlign=CenterCenter
MouseOverAction=[!SetVariable blockAFade1 "(-175+#blockAFade1#)"][!SetVariable blockSFade1 "(-255+#blockSFade1#)"][!UpdateMeter "#CURRENTSECTION#"][!UpdateMeter "Block1Del"][!Redraw]
MouseLeaveAction=[!SetVariable blockAFade1 "(175+#blockAFade1#)"][!SetVariable blockSFade1 "(255+#blockSFade1#)"][!UpdateMeter "#CURRENTSECTION#"][!UpdateMeter "Block1Del"][!Redraw]
LeftMouseDoubleClickAction=[!CommandMeasure "MeasureAgenda" "RemoveBlock(1)"][!Refresh][!Refresh]
DynamicVariables=1
[Block2]
Meter=Shape
X=(35*#Scale#)
Y=([Hour13:Y]+(8*#Scale#))
Shape=Rectangle 0,0,(140*#Scale#),(((584*#Scale#)*((5*3600)/86400))) | Extend BlockE
BlockE=Fill Color 1,165,15,(#blockAFade2#) | StrokeWidth (2*#Scale#) | Stroke Color 0,255,0,(#blockSFade2#)
Shape2=Rectangle 0,0,(140*#Scale#),(((584*#Scale#)*((5*3600)/86400))) | Extend BlockA
BlockA=Fill Color 200,55,35,(175-#blockAFade2#) | StrokeWidth (2*#Scale#) | Stroke Color 255,0,0,(255-#blockSFade2#)
ToolTipTitle=block
ToolTipText=Duration:5
DynamicVariables=1
[Block2Del]
Meter=String
MeterStyle=IconDel
FontColor=255,255,255,(255-#blockSFade2#)
Text=[\[#featherdelete]]
X=(([Block2:X])+([Block2:W])*0.5)
Y=(([Block2:Y])+([Block2:H])*0.5)
FontSize=((([Block2:H])*0.5)*#Scale#)
StringAlign=CenterCenter
MouseOverAction=[!SetVariable blockAFade2 "(-175+#blockAFade2#)"][!SetVariable blockSFade2 "(-255+#blockSFade2#)"][!UpdateMeter "#CURRENTSECTION#"][!UpdateMeter "Block2Del"][!Redraw]
MouseLeaveAction=[!SetVariable blockAFade2 "(175+#blockAFade2#)"][!SetVariable blockSFade2 "(255+#blockSFade2#)"][!UpdateMeter "#CURRENTSECTION#"][!UpdateMeter "Block2Del"][!Redraw]
LeftMouseDoubleClickAction=[!CommandMeasure "MeasureAgenda" "RemoveBlock(2)"][!Refresh][!Refresh]
DynamicVariables=1