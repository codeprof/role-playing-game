Procedure max(a,b)
  If a > b
    ProcedureReturn a
  Else
    ProcedureReturn b
    EndIf
EndProcedure
  


#FIGURE_WIDTH = 432
#FIGURE_HEIGHT = 432

#SHADOW_WIDTH = 368
#SHADOW_HEIGHT = 368
#SHADOW_OFFSETX = #FIGURE_WIDTH/4
#SHADOW_OFFSETY = (#FIGURE_HEIGHT*1)/2


#WIDTH = #SHADOW_OFFSETX + #SHADOW_WIDTH
#HEIGHT = #SHADOW_OFFSETY + #SHADOW_HEIGHT


Global SZ = max(#WIDTH,#HEIGHT)

UsePNGImageDecoder()
UsePNGImageEncoder()

CreateImage(100,SZ*12,SZ*4,32)
StartDrawing(ImageOutput(100))
DrawingMode(#PB_2DDrawing_AllChannels)
Box(0,0,ImageWidth(100), ImageHeight(100),RGBA(0,0,0,0))
StopDrawing()

LoadImage(5,"shadow.png")




For frameNr = 1 To 24 Step 2
  frame$ = RSet(Str(frameNr),4,"0")
  frameSrc$ = "out.png" + frame$ +".png"
  
  
  If LoadImage(1,frameSrc$)
    Debug GrabImage(1,2,(ImageWidth(1)-ImageHeight(1))/2,0,ImageHeight(1),ImageHeight(1))
    
    For x=0 To ImageWidth(1)/432-1
      For y=0 To ImageHeight(1)/432-1
        
        name$= ""
        row = -1
        If x = 0 And y = 1
          name$= "up_left"
          row = 0
        EndIf  
        If x = 0 And y = 3
          name$= "down_left"
          row = 1
        EndIf    
        If x = 4 And y = 1
          name$= "up_right"
          row = 2
        EndIf  
        If x = 4 And y = 3
          name$= "down_right"
          row = 3
        EndIf       
        
        
        ;Debug y*#FIGURE_HEIGHT+#FIGURE_HEIGHT/2 + #FIGURE_HEIGHT
        If row >= 0;name$<>""  
          If GrabImage(2,3,x*#FIGURE_WIDTH,y*#FIGURE_HEIGHT+#FIGURE_HEIGHT/2,#FIGURE_WIDTH,#FIGURE_HEIGHT)
                       
            StartDrawing(ImageOutput(100))
            DrawingMode(#PB_2DDrawing_AllChannels)
            DrawImage(ImageID(5),(frameNr-1)/2 * SZ+#SHADOW_OFFSETX, row*SZ+#SHADOW_OFFSETY + (#HEIGHT-#WIDTH)/2)
            DrawingMode(#PB_2DDrawing_AlphaBlend)
            DrawImage(ImageID(3),(frameNr-1)/2 * SZ, row*SZ + (#HEIGHT-#WIDTH)/2)
            StopDrawing()
            ;SaveImage(3,"test/" + frame$ + "_"+ name$+".png",#PB_ImagePlugin_PNG)
            FreeImage(3)
          EndIf
          EndIf
         
      Next
    Next
  EndIf
Next
ResizeImage(100,12*64,4*64)
SaveImage(100,"astronaut.png",#PB_ImagePlugin_PNG)


; IDE Options = PureBasic 5.42 LTS (Linux - x64)
; CursorPosition = 78
; FirstLine = 26
; Folding = -
; EnableUnicode
; EnableXP