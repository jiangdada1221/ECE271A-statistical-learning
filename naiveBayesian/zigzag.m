function zigOutput = zigzag(input) % send DCT in
    zig_zag = [0,1  , 5 ,  6 , 14 , 15 , 27 , 28;

2 ,  4 ,  7 , 13 , 16 , 26 , 29 , 42;

3 ,  8 , 12 , 17 , 25 , 30 , 41 , 43;

9 , 11 , 18 , 24 , 31 , 40 , 44 , 53;

10 , 19 , 23 , 32 , 39 , 45 , 52 , 54;

20 , 22 , 33 , 38 , 46 , 51 , 55 , 60;

21 , 34 , 37  ,47  ,50 , 56  ,59 , 61;

35 , 36 , 48 , 49 , 57 , 58 , 62 , 63];

    zig_zag = zig_zag + 1;


    zigOutput = zeros(1,64);
    for row=1:8
        for col=1:8
            zigOutput(zig_zag(row,col)) = input(row,col);
        end
    end
end