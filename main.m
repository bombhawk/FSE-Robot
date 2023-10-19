global key
InitKeyboard();
speed = 30;

brick.SetColorMode(1, 2);

while 1
  %color sensing
     %pause(1);
    color_rgb = brick.ColorRGB(1);  % Get Color on port 1.
    %color notes
    %yellow: Red: 153 Green: 68 Blue: 34
    %green: Red: 29Green: 71 Blue: 40
    %red: Red: 114 Green: 15 Blue: 23
    %blue: Red: 17 Green: 51 Blue: 129
    %black: Red: 10 Green: 11 Blue: 12

    %print color of object
    %fprintf("\tRed: %d\n", color_rgb(1));
    %fprintf("\tGreen: %d\n", color_rgb(2));
    %fprintf("\tBlue: %d\n", color_rgb(3)); 
          
    %Basic move forward, this runs if nothing else takes over
    brick.MoveMotor('A', speed);
    brick.MoveMotor('B', speed);

    %Pauses on red and plays sound
    if color_rgb(1) >= 100 & color_rgb(2) <= 30 & color_rgb(3) <= 30
        brick.playTone(100, 800, 500);
        brick.StopMotor('A');
        brick.StopMotor('B');
        pause(2);
    end
    
    %distance and touch sensing variables
    distance = brick.UltrasonicDist(2);
    reading = brick.TouchPressed(3);
    %display(distance);

    %listens to distance sensor unless there is a touch
    %if touch back up and then turn left
    if reading == 1
            brick.MoveMotor('A', -speed);
            brick.MoveMotor('B', -speed);
            pause(1.5);
            brick.MoveMotor('A', speed);
            brick.MoveMotor('B', -speed); 
            pause(15);
            brick.StopMotor('A');
            brick.StopMotor('B');
            %untested, doubt this will work
            reading = 0;
    else
            %Go straight if there is a wall to the right
            if distance > 40
                 brick.MoveMotor('A', speed);
                 brick.MoveMotor('B', speed);
                 pause(2);
                 brick.MoveMotor('A', -speed);
                 brick.MoveMotor('B', speed);
                 pause(11);
            end
            
            display(distance);
    end

    %manual controls
    switch key
        case 0
            brick.StopMotor('A');
            brick.StopMotor('B');
            brick.StopMotor('C');
        case 'w'
            brick.MoveMotor('A', speed);
            brick.MoveMotor('B', speed);
        case 's'
            brick.MoveMotor('A', -speed);
            brick.MoveMotor('B', -speed);
        case 'a'
            brick.MoveMotor('A', speed);
            brick.MoveMotor('B', -speed);
        case 'd'
            brick.MoveMotor('A', -speed);
            brick.MoveMotor('B', speed);   
        case 'q' %open
            brick.MoveMotor('C', 15);
        case 'e' %close
            brick.MoveMotor('C', -25);
        case 'v'
            break;
   end
end
CloseKeyboard();