program game_falling_cubes ;

uses
 GraphABC;
 
type 
 int = word;
 arr = array of int;



var arrStartX :arr ;
var arrEndX : arr;
var arrStartY : arr;
var arrEndY : arr;
var arrRandColor : array of System.Drawing.Color;
var size : int;
var gameover : boolean := false;
var centerX : int := 22;
var drawCheck : set of string ;
var color : System.Drawing.Color ;
var speedUp : boolean := false;
var scorePoint :int := 0;
var min : int := 800;







procedure DrawGameover;
    begin
    var pic : Picture; 
    var pic2 : Picture;
    var r : System.Drawing.Rectangle ;
    var arrRectangle : array of System.Drawing.Rectangle;
    var y : int := 280;
    var minY : int := 450;
    var x: int := 0;
    var forY: int := 0;
    var counter : int := 0 ;
    
    
    Pic := Picture.Create ('background_game_falling_cubes.png');
    
    Pic.Load('background_game_falling_cubes.png');
    
    Pic2 := Picture.Create('score_game_falling_cubes.png');
    Pic2.Load ('score_game_falling_cubes.png');
    
    arrRectangle := new System.Drawing.Rectangle[8];
    r.X := 1;
    r.Y := 5;
    r.Width := 41 ;
    r.Height := 150;

    arrRectangle[0] := r;
    
    r.Width := 76 ;

    arrRectangle[1] := r;
    
    r.Width := 122 ;

    arrRectangle[2] := r;

    r.Width := 158 ;

    arrRectangle[3] := r;

    r.Width := 189 ;
    
    arrRectangle[4] := r;
   
    r.Width := 221 ;

    arrRectangle[5] := r;
   
    r.Width := 257 ;
    
    arrRectangle[6] := r;
    
    r.Width := 304 ;
    
    arrRectangle[7] := r;
    
     
    for var i:= 0 to 810 do
        begin
        x := 0;
        for var j:= 0 to 605 do
            begin
            setPixel(x , forY , clWhite);
            x += 1;
            end;
        
        if(forY > minY) then
           begin
           if ( counter < arrRectangle.Length ) then
               begin
               Pic.Draw (150 , y , arrRectangle[counter] );
               minY += 25;
               counter += 1;
               end;
           end;
        
        
        if( forY > minY + 25) then
            begin
            Pic2.Draw (160 , y + 100);
            end;    
       
        if( forY > minY + 50) then
            begin
            setBrushColor (clWhite);
            SetFontSize(45);
            TextOut (315 , y + 95 , scorePoint);
            end;
        
        
        forY += 1;
        end;
       
    end;




procedure drawUp ;
    begin
    speedUp := false;
    end;

procedure drawDown ;
    begin
    speedUp := true;
    end;

procedure drawLeft ;
    begin
    if( speedUp = false) then
        begin
        
        for var i :=0 to size -1 do
           begin
           if (arrEndY[i] < min - 10 ) then
              begin
              color := GetPixel (arrStartX[i] + 5 , arrEndY[i] - 5);
        
              setBrushColor ( ARGB(255, 0 ,0 ,0) );
              rectangle ( arrStartX[i] , arrStartY[i] , arrEndX[i] , arrEndY[i]);
        
              if( arrStartX[i] < 10) then
                    begin
                    arrStartX[i] := 555;
                    arrEndX[i] := 600;
                    end
                else 
                    begin
                    arrStartX[i] := arrStartX[i] - 50;
                    arrEndX[i] := arrEndX[i] - 50;
                    end;
                setBrushColor ( color );
                rectangle ( arrStartX[i]  , arrStartY[i] , arrEndX[i]  , arrEndY[i]);
                end;
            end;
        sleep(50);
        end;
    end;
    
procedure drawRight ;
    begin
    if( speedUp = false) then
        begin
        for var i :=0 to size -1 do
            begin
            if( arrEndY[i] < min - 10) then
                begin
                color := GetPixel (arrStartX[i] + 5 , arrEndY[i] - 5);
        
                setBrushColor ( ARGB(255, 0 ,0 ,0) );
                rectangle ( arrStartX[i] , arrStartY[i] , arrEndX[i] , arrEndY[i]);
        
                if( arrStartX[i] > 540 ) then
                    begin
                    arrStartX[i] := 5;
                    arrEndX[i] := 50;
                    end
                else
                    begin
                    arrStartX[i] := arrStartX[i] + 50;
                    arrEndX[i] := arrEndX[i] + 50;
                    end;
                setBrushColor ( color );
                rectangle ( arrStartX[i]  , arrStartY[i] , arrEndX[i]  , arrEndY[i]);
                end;
            end;
        sleep(50);
        end;
    end;    

procedure  KeyDown(Key: integer);
    begin
      case Key of
      VK_Left:  
      drawLeft();
      VK_Right: 
      drawRight() ;
      VK_Down: 
      drawDown() ;
      VK_Up: 
      drawUp() ;
      end;
    
    end;

procedure forPerformance ( i : int ; x1 : smallint ; x2 : smallint ; x3 : smallint ; y1 : smallint ; y2 : smallint ; y3 : smallint ; addY : smallint) ;
    begin
    var topY : int := 55;
                         
    while( GetPixel(arrStartX[i] + x1 + 5 , arrEndY[i] -  topY + y1) <> ARGB(255, 0 ,0 ,0)  ) do
        begin
                              
        color := GetPixel( arrStartX[i] + x1 + 5 , arrEndY[i] -  topY  + y1);      
                              
        setBrushColor( ARGB(255, 0 ,0 ,0 ) );
        rectangle( arrStartX[i] + x1 , arrStartY[i] - topY + 5  , arrEndX[i] + x1   , arrEndY[i] - topY + 5 + y1 );
                              
        setBrushColor ( color ) ;
        rectangle( arrStartX[i] + x1 , arrStartY[i] - topY + addY + 55 , arrEndX[i] + x1 , arrEndY[i] - topY + addY +55 + y1);
                              
        topY += 50;
        end;
                              
    topY  := 55;
                         
    while( GetPixel(arrStartX[i] + x2 + 5 , arrEndY[i] -  topY  + y2) <> ARGB(255, 0 ,0 ,0)  ) do
       begin
                              
       color := GetPixel( arrStartX[i] + x2 + 5 , arrEndY[i] -  topY  + y2 );
                                        
       setBrushColor( ARGB(255, 0 ,0 ,0 ) );
       rectangle( arrStartX[i] + x2  , arrStartY[i] - topY + 5 , arrEndX[i] + x2 , arrEndY[i] - topY + 5 + y2);
                              
       setBrushColor ( color ) ;
       rectangle( arrStartX[i] + x2 , arrStartY[i] - topY + addY + 55 , arrEndX[i] + x2 , arrEndY[i] - topY + addY + 55 + y2);
                              
       topY += 50;
       end;  
   topY  := 55;
               
    while( GetPixel(arrStartX[i] + x3 + 5 , arrEndY[i] -  topY  + y3) <> ARGB(255, 0 ,0 ,0)  ) do
       begin
                              
       color := GetPixel( arrStartX[i] + x3 + 5 , arrEndY[i] -  topY + y3 );
                              
       setBrushColor( ARGB(255, 0 ,0 ,0 ) );
       rectangle( arrStartX[i] + x3 , arrStartY[i] - topY + 5 + y3 , arrEndX[i] + x3 , arrEndY[i] - topY + 5 + y3);
                              
       setBrushColor ( color ) ;
       rectangle( arrStartX[i] + x3 , arrStartY[i] - topY + addY + 55 + y3 , arrEndX[i] + x3 , arrEndY[i] - topY + addY +55 + y3);
                              
       topY += 50;
       end;     
    
    end;


procedure DrawBlackRect (i : int ;  xStart : smallint ; yStart : smallint ; xEnd : smallint ; yEnd : smallint ; xStart2 : smallint ; yStart2 : smallint ; XEnd2 : smallint ; yEnd2 : smallint) ;
    begin
    setBrushColor( ARGB(255 , 0 , 0, 0) );
    
        rectangle( arrStartX[i]  , arrStartY[i] , arrEndX[i]  , arrEndY[i]);
        rectangle( arrStartX[i] + xStart , arrStartY[i] + yStart , arrEndX[i] + xEnd , arrEndY[i] + yEnd);
        rectangle( arrStartX[i] + xStart2 , arrStartY[i] + yStart2 , arrEndX[i] + XEnd2 , arrEndY[i] + yEnd2);
       
   
  
      
        
        
    end;




procedure LineDrawRect(counter : int) ;
    begin
    arrRandColor := new System.Drawing.Color[counter];
    arrStartX := new int[counter];
    arrEndX := new int[counter];
    arrStartY := new int[counter];
    arrEndY := new int[counter];
    size := 0;
    var startX :int := 0; 
    var endX :int := 0; 
    var rand : int;
    var randColor : int ;
    var score : int := 0;
    var draw : boolean := true;
    var alreadyThere : boolean := false;
    
    while (counter <> 0) do
        begin
        
        rand := random(12) * 50;
        
        alreadyThere := false;
        
        for var i := 0 to size do
            begin
            if ( (arrStartX[i] - 5) = rand ) then  
                begin
                alreadyThere := true;
                end;
            end;
        
        if(alreadyThere = false) then
            begin
            startX := rand + 5;
            arrStartX[size] := startX;
          
            endX := rand + 50;
            arrEndX[size] := endX;
            
            randColor := random(5);
        
            if(randColor = 0) then arrRandColor[size] := ARGB(255, 255 ,0,0);
            if(randColor = 1) then arrRandColor[size] := ARGB(255, 0 ,255,0);
            if(randColor = 2) then arrRandColor[size] := ARGB(255, 0 , 0 ,255);
            if(randColor = 3) then arrRandColor[size] := ARGB(255, 128 , 0 , 128);
            if(randColor = 4) then arrRandColor[size] := ARGB(255, 255 , 255 , 0);
        
            arrStartY[size] := 5;
            arrEndY[size] := 50;
        
            
            
            size += 1;
            counter -= 1;
            end;
          
        
        end;
        
       
     
    
    speedUp := false;
    while ( draw )  do
       begin
       
       setPenColor(clWhite);
       line( 0 , 33, 605 , 33);
       setPenColor(clBlack);
       
       score := 0;
       
       for var i:= 0 to size - 1 do
          begin
          
          OnKeyDown := KeyDown;
            if (   (arrEndY[i] > windowHeight() - 5) or ( GetPixel(arrStartX[i] + 5 , arrEndY[i] + 5) <> ARGB(255, 0 ,0 ,0) ) )  then 
              begin
                 if( arrEndY[i] < 80) then gameover := true;
                 score += 1;
                 continue;
              end;                
                setBrushColor( arrRandColor[i] ); 
                rectangle(arrStartX[i] , arrStartY[i] , arrEndX[i] , arrEndY[i]);
                arrStartY[i] += 1;
                arrEndY[i] += 1;
                if(speedUp = false) then
                    begin
                    sleep(3);
                    end;
          end;
          if(score = size  ) then draw := false;
       end;   
       
       min := arrStartY[0];
       
       for var i := 1 to size - 1 do
          begin
          if( min  > arrStartY[i] ) then min := arrStartY[i];
          end;
       
       drawCheck := [] ;
       
       for var i:=0 to size - 1 do 
          begin
           if(  (arrStartX[i]  < 540) ) then
              begin
              if( GetPixel (arrStartX[i] + centerX + 50 , arrEndY[i] - 10 ) =  arrRandColor[i] ) then 
                  begin
                  if  ( (arrStartX[i]  > 10 ) ) then
                      begin
                      if( GetPixel (arrStartX[i] + centerX - 50 , arrEndY[i] - 10 ) =  arrRandColor[i] ) then
                          begin
                          write(1);
                          drawCheck := ['Default'];

                          DrawBlackRect(i ,  -50 , 0 , -50 ,0 , 50 , 0 , 50, 0);
                          
                          forPerformance(i , 0 , 50 , -50 , 0 ,0 , 0 , 0);
                          
                          scorePoint += 10;
         
                          
                          continue;
                          end;
                      end;
                 
                  if( arrStartX[i] < 490 ) then
                      begin
                      if( GetPixel (arrStartX[i] + centerX + 100 , arrEndY[i] - 10 ) =  arrRandColor[i] ) then
                          begin
                          write(2);
                          drawcheck := ['ToTo'];
   
                          DrawBlackRect(i ,  50 , 0 , 50 , 0 , 100 , 0 , 100 , 0);
                          
                          forPerformance (i , 0 , 50 , 100 , 0 , 0 , 0 , 0);
                          
                          scorePoint += 10;
   
                          
                          continue;
                          end;
                      end;
                  end;
              end;
           
           
           if( (arrStartX[i]  > 50) ) then
              begin
               if( GetPixel (arrStartX[i] + centerX - 50 , arrEndY[i] - 10 ) =  arrRandColor[i] ) then 
                  begin
                  if(arrStartX[i] > 100) then
                      begin
                      if( GetPixel (arrStartX[i] + centerX - 100 , arrEndY[i] - 10 ) =  arrRandColor[i] ) then
                          begin
                          write(4);   
                          drawCheck := ['Before'];
                          DrawBlackRect(i , 0 , -50 , 0 , -50 , 0 , -100 , 0 , -100 );
                          
                          forPerformance (i , 0 , -50 , -100 , 0 , 0 , 0 , 0);
                          
                          scorePoint += 10;
            
                          
                          continue;
                          end;
                      end;
                  end;
              end;
          if(arrEndY[i] < 740) then
              begin
              if(  (GetPixel( arrStartX[i] + 5 , arrEndY[i] + 45) =  arrRandColor[i]) and (GetPixel( arrStartX[i] + 5 , arrEndY[i] + 90) =  arrRandColor[i]) ) then
                  begin
                  write(5);
                  drawCheck := ['DownDown'];
                  DrawBlackRect(i ,  0 , 50 , 0 , 50 , 0 , 100 , 0 , 100);
                  
                  forPerformance (i , 0 , 0 , 0 , -50 , -50 , -50 , 0);
                  
                  scorePoint += 10;
      
                  
                  continue
                  end;
              end;
          if( arrStartX[i] < 540) then
              begin
              if( (GetPixel( arrStartX[i] + 55 , arrEndY[i] - 5) = arrRandColor[i]) and (GetPixel( arrStartX[i] + 55 , arrEndY[i] - 55) = arrRandColor[i] ) ) then
                  begin
                  write(6);
                  drawCheck := ['RightUp'];
                  DrawBlackRect(i ,  50 , 0 , 50 , 0 , 50 , -50 , 50 , -50);
                  
                  forPerformance (i , 0 , 50 , 50 , 0 , 0 , -50 , 50);
                  
                  scorePoint += 10;
      
                  
                  continue
                  end;
              end;
          if( arrStartX[i] > 10) then
              begin
              if( (GetPixel( arrStartX[i] - 45 , arrEndY[i] - 5) = arrRandColor[i]) and (GetPixel( arrStartX[i] - 45 , arrEndY[i] - 55) = arrRandColor[i] ) ) then
                  begin
                  write(7);
                  drawCheck := ['LeftUp'];
                  DrawBlackRect(i ,  -50 , 0 , -50 , 0 , -50 , -50 , -50 ,-50);
                  
                  forPerformance (i , 0 , -50 , -50 , 0 , 0 , -50 , 50);
                  
                  scorePoint += 10;
           
                  
                  continue
                  end;
              end;  
          if( (arrEndY[i] < 780) and (arrStartX[i] > 10)) then
              begin
              if( (GetPixel( arrStartX[i] + 5  , arrEndY[i] + 45) = arrRandColor[i]) and (GetPixel( arrStartX[i] - 45 , arrEndY[i] + 45) = arrRandColor[i] ) ) then
                  begin
                  write(8);
                  drawCheck := ['DownLeft'];
                  DrawBlackRect(i ,  0 , 50 , 0 , 50 , -50 , 50 , -50 , 50);
                  
                  forPerformance (i , 0 , 0 , -50 , 0 , 50 , 50 , 0);
                  
                  scorePoint += 10;
            
                  
                  continue
                  end;
              end; 
          if( (arrEndY[i] < 780) and (arrStartX[i] > 10)) then
              begin
              if( (GetPixel( arrStartX[i] + 5  , arrEndY[i] + 45) = arrRandColor[i]) and (GetPixel( arrStartX[i] + 55 , arrEndY[i] + 45) = arrRandColor[i] ) ) then
                  begin
                  write(8);
                  drawCheck := ['DownRight'];
                  DrawBlackRect(i ,  0 , 50 , 0 , 50 , 50 , 50 , 50, 50);
                  
                  forPerformance (i , 0 , 0 , 50 , 0 , 50 , 50 , 0);
                  
                  scorePoint += 10;
            
                  
                  continue
                  end;
              end; 
          if( (arrEndY[i] < 780) and (arrStartX[i] < 540)) then
              begin
              if( (GetPixel( arrStartX[i] + 5  , arrEndY[i] + 45) = arrRandColor[i]) and (GetPixel( arrStartX[i] + 55 , arrEndY[i] - 5) = arrRandColor[i] ) ) then
                  begin
                  write(9);
                  drawCheck := ['DownAndRight'];
                  DrawBlackRect(i ,  0 , 50 , 0 , 50 , 50 , 0 , 50 , 0);
                  
                  forPerformance (i , 0 , 0 , 50 , -50 , -50 , 0 , 0);
                  
                  scorePoint += 10;
           
                  
                  continue
                  end;
              end;
          if( (arrEndY[i] < 780) and (arrStartX[i] > 10)) then
              begin
              if( (GetPixel( arrStartX[i] + 5  , arrEndY[i] + 45) = arrRandColor[i]) and (GetPixel( arrStartX[i] - 45 , arrEndY[i] - 5) = arrRandColor[i] ) ) then
                  begin
                  write(9);
                  drawCheck := ['DownAndLeft'];
                  DrawBlackRect(i ,  0 , 50 , 0 , 50 , -50 , 0 , -50 , 0);
                  
                  forPerformance (i , 0 , 0 , -50 , -50 , -50 , 0 , 0);
                  
                  scorePoint += 10;
           
                  
                  continue
                  end;
              end; 
          if( (arrEndY[i] < 780) and (arrStartX[i] > 10)) then
              begin
              if( (GetPixel( arrStartX[i] - 45  , arrEndY[i] + 45) = arrRandColor[i]) and (GetPixel( arrStartX[i] - 45 , arrEndY[i] - 5) = arrRandColor[i] ) ) then
                  begin
                  write(9);
                  drawCheck := ['LeftAndDown'];
                  DrawBlackRect(i ,  -50 , 0 , -50 , 0 , -50 , 50 , -50 , 50);
                  
                  forPerformance (i , 0 , -50 , -50 , 0 , 0 , 50 , 50);
                  
                  scorePoint += 10;
            
                  
                  continue
                  end;
              end; 
          if( (arrEndY[i] < 780) and (arrStartX[i] > 10)) then
              begin
              if( (GetPixel( arrStartX[i] + 55  , arrEndY[i] + 45) = arrRandColor[i]) and (GetPixel( arrStartX[i] + 55 , arrEndY[i] - 5) = arrRandColor[i] ) ) then
                  begin
                  write(9);
                  drawCheck := ['RightAndDown'];
                  DrawBlackRect(i ,  50 , 0 , 50 ,0 , 50, 50, 50, 50);
                  
                  forPerformance (i , 0 , 50 , 50 , 0 , 0 , 0 , 50);
                  
                  scorePoint += 10;
           
                  
                  continue
                  end;
              end;                
              
          end;
       
      
      var arrClearColor : array  of  array of System.Drawing.Color;
      var height : int := windowHeight() - 20;
      var widthX : int := 10;
   
      setLength (arrClearColor , 16);
      for var i:= 0 to 15 do
          begin
          setLength(arrClearColor[i] , 12);
          end;
      
      for var j := 0 to 15 do
          begin
          widthX := 10;
          for var i := 0 to 11 do
              begin
            
             arrClearColor[j][i] := GetPixel ( widthX , height);
              widthX += 50;
              end;
        
          height -= 50;
          end;
          
       window.Clear(clBlack);
       
     height  := windowHeight () - 50;
    
     
     for var j := 0 to 15 do
          begin
          widthX := 5;
          for var i := 0 to 11 do
              begin
              setBrushColor ( arrClearColor[j][i] );
              rectangle(widthX , height ,widthX + 45, height + 45);
              widthX += 50;
              end;
          
          height -= 50;
          end;    
      
       
       while(gameover = false) do LineDrawRect(random(9) + 3);

    
    
    end;



begin

setBrushStyle(bsSolid);

initWindow(0 , 0 , 605 , 810 , clBlack);

centerWindow();





LineDrawRect(random(11) + 2);

sleep(1500); 

DrawGameover ();


end. 