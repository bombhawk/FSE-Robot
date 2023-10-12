global key
InitKeyboard();

brick.SetColorMode(1, 2);

while 1
  %color sensing
    pause(1);
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
            
    %brick.MoveMotor('A', 100);
    %brick.MoveMotor('B', -100);

    if color_rgb(1) >= 100 & color_rgb(2) <= 30 & color_rgb(3) <= 30
        brick.playTone(100, 800, 500);
        brick.StopMotor('A');
        brick.StopMotor('B');
        pause(2);
    end
    
    %controls
    switch key
        case 0
            brick.StopMotor('A');
            brick.StopMotor('B');
            brick.StopMotor('C');
        case 'w'
            brick.MoveMotor('A', 25);
            brick.MoveMotor('B', -25);
        case 's'
            brick.MoveMotor('A', -25);
            brick.MoveMotor('B', 25);
        case 'q' %open
            brick.MoveMotor('C', 15);
        case 'e' %close
            brick.MoveMotor('C', -25);
   end
end
CloseKeyboard();