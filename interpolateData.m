clc 
close all
format long g

%PLot title and image title data
%titleData={'27-Point Multipoint';
%    '27-Point Multipoint with Dive';
%    'Single Point';
%    '12-Point Multipoint';
%    'Full Morphing with 27-Point Baseline';
%    'TE Morphing with 27-Point Baseline';
%    'LE Morphing with 27-Point Baseline';
%    'US Morphing with 27-Point Baseline';				
%    'TE Morphing with Single-Point Baseline';			
%    'Flap Morphing with 27-Point Baseline';				
%    'Flap Morphing with Single-Point Baseline'};				
titleData={'27-Point Multipoint';
    'Multipoint Baseline';
    'Single Point';
    '12-Point Multipoint';
    'Full Morphing';
    'TE Morphing';
    'LE Morphing';
    'US Morphing';				
    'TE Morphing 1pt';			
    'Flap Morphing';				
    'Flap Morphing 1pt'};
    
imageTitle={'27pt';
    '27ptDive';
    '1pt';
    '12pt';
    'FullMorph27pt';
    'TEMorph27pt';
    'LEMorph27pt';
    'USMorph27pt';				
    'TEMorph1pt';			
    'FlapMorph27pt';				
    'FlapMorph1pt'};

%Initial data points 
[W,M,A]=meshgrid(61500:24700:110900,0.74:0.04:0.82,31000:5000:41000);

%New grid of points
n=148;%dims
fprintf('Number of dimensions: %d\n\n',n+1)
[Wq,Mq,Aq]=meshgrid(61500:(110900-61500)/n:110900,0.74:(0.82-0.74)/n:0.82,31000:(41000-31000)/n:41000);

%inputs
numMorphType=11;
numPlot=11;
dataRowInit=163;
% dataRowInit=15;

%setup
DATA=zeros(27,numPlot,numMorphType);
% DATA=zeros(125,numPlot,numMorphType);
filename = 'Multipoint Baseline Flowsolves.xlsm';
sheet = '27pt Morphing Comparisons';
% sheet = '5x5x5';
k=1;
for i=1:numMorphType
        
    fprintf('READING DATA FILE: %g\n',i);
    cd ..
        
    %Morphing Data
    rowA=dataRowInit+(i-1)*32;
%     rowB=(dataRowInit+124)+(i-1)*32;
    rowB=(dataRowInit+26)+(i-1)*32;
    xlRange1 = strcat('AM',num2str(rowA),':AM',num2str(rowB));%ML/D
    xlRange2 = strcat('AJ',num2str(rowA),':AJ',num2str(rowB));%CD
    xlRange3 = strcat('AN',num2str(rowA),':AN',num2str(rowB));%deltaML/D
    xlRange4 = strcat('AK',num2str(rowA),':AK',num2str(rowB));%deltaCD
    xlRange5 = strcat('AL',num2str(rowA),':AL',num2str(rowB));%deltaCD%
    xlRange6 = strcat('AA',num2str(rowA),':AA',num2str(rowB));%deltamaxMach
    xlRange7 = strcat('AR',num2str(rowA),':AR',num2str(rowB));%deltaCDp
    xlRange8 = strcat('AS',num2str(rowA),':AS',num2str(rowB));%deltaCDp%
    xlRange9 = strcat('AU',num2str(rowA),':AU',num2str(rowB));%deltaCDf
    xlRange10 = strcat('AV',num2str(rowA),':AV',num2str(rowB));%deltaCDf%
    xlRange11 = strcat('AD',num2str(rowA),':AD',num2str(rowB));%CM
    [num1,txt1,raw1]= xlsread(filename,sheet,xlRange1,'basic');
    [num2,txt2,raw2]= xlsread(filename,sheet,xlRange2,'basic');
    [num3,txt3,raw3]= xlsread(filename,sheet,xlRange3,'basic');
    [num4,txt4,raw4]= xlsread(filename,sheet,xlRange4,'basic');
    [num5,txt5,raw5]= xlsread(filename,sheet,xlRange5,'basic');
    [num6,txt6,raw6]= xlsread(filename,sheet,xlRange6,'basic');
    [num7,txt7,raw7]= xlsread(filename,sheet,xlRange7,'basic');
    [num8,txt8,raw8]= xlsread(filename,sheet,xlRange8,'basic');
    [num9,txt9,raw9]= xlsread(filename,sheet,xlRange9,'basic');
    [num10,txt10,raw10]= xlsread(filename,sheet,xlRange10,'basic');
    [num11,txt11,raw11]= xlsread(filename,sheet,xlRange11,'basic');
    cd ('InterpolateData')
   
    %excel data to data array
    DATA(:,1,i) = num1;
    DATA(:,2,i) = num2;
    DATA(:,3,i) = num3;
    DATA(:,4,i) = num4*1000;
    DATA(:,5,i) = num5;
    DATA(:,6,i) = num6;
    DATA(:,7,i) = num7*1000;
    DATA(:,8,i) = num8;
    DATA(:,9,i) = num9*1000;
    DATA(:,10,i) = num10;
    DATA(:,11,i) = num11+.005;
   
    
    %plot contours
    cmax    = [16,      0.045,      1.8,    0,      0,      0.1,      0.5,      2,     0.5,    2,     -0.055];
    cmin    = [9,       0.015,      0,      -3.5,   -11,    -0.4,    -3.5,    -15,   -3.5,   -0.3,  -0.175];
    spacing = [0.25,    0.00125,     0.1,    0.25,   0.5,    0.025,    0.1,   1,     0.1,   0.1,  0.005];
    
    for j=1:numPlot          
        %interpolate
        V(1,:,:)=[DATA(1,j,i),DATA(2,j,i),DATA(3,j,i);
            DATA(4,j,i),DATA(5,j,i),DATA(6,j,i);
            DATA(7,j,i),DATA(8,j,i),DATA(9,j,i);];
        V(2,:,:)=[DATA(10,j,i),DATA(11,j,i),DATA(12,j,i);
            DATA(13,j,i),DATA(14,j,i),DATA(15,j,i);
            DATA(16,j,i),DATA(17,j,i),DATA(18,j,i);];
        V(3,:,:)=[DATA(19,j,i),DATA(20,j,i),DATA(21,j,i);
            DATA(22,j,i),DATA(23,j,i),DATA(24,j,i);
            DATA(25,j,i),DATA(26,j,i),DATA(27,j,i);];
        DATAq=interp3(W,M,A,V,Wq,Mq,Aq,'cubic');
        
        %plot contours
        if(i>4 || j==1 || j==2 )  
            k=numPlot*(i-1)+j;            
            plotContour(Wq,Mq,Aq,DATAq,DATA(:,j,i),cmin(j),cmax(j),spacing(j),titleData(i),imageTitle(i),numPlot,i,k)       
        end  
        
        %plot contours
%         if((i==1 || i==2) && j==1 )  
%             k=k+numPlot*(i-1);
%             plot2D(Wq,Mq,Aq,DATAq,DATA(:,j,i),cmin(j),cmax(j),spacing(j),titleData(i),imageTitle(i),numPlot,k)       
%         end  
        
        if(j==1)
            %integrate values
            trap=0;
            simp=0;
            integrate(Wq,Mq,Aq,DATAq,trap,simp)
        end
        
    end
    
end






%             V(1,1,:)=[DATA(1,j,i),DATA(4,j,i),DATA(2,j,i),DATA(5,j,i),DATA(3,j,i)];
%             V(2,1,:)=[DATA(76,j,i),DATA(79,j,i),DATA(77,j,i),DATA(80,j,i),DATA(78,j,i)];
%             V(3,1,:)=[DATA(26,j,i),DATA(29,j,i),DATA(27,j,i),DATA(30,j,i),DATA(28,j,i)];
%             V(4,1,:)=[DATA(101,j,i),DATA(104,j,i),DATA(102,j,i),DATA(105,j,i),DATA(103,j,i)];
%             V(5,1,:)=[DATA(51,j,i),DATA(54,j,i),DATA(52,j,i),DATA(55,j,i),DATA(53,j,i)];
%                   
%             V(1,2,:)=[DATA(16,j,i),DATA(19,j,i),DATA(17,j,i),DATA(20,j,i),DATA(18,j,i)];
%             V(2,2,:)=[DATA(91,j,i),DATA(94,j,i),DATA(92,j,i),DATA(95,j,i),DATA(93,j,i)];
%             V(3,2,:)=[DATA(41,j,i),DATA(44,j,i),DATA(42,j,i),DATA(45,j,i),DATA(43,j,i)];
%             V(4,2,:)=[DATA(116,j,i),DATA(119,j,i),DATA(117,j,i),DATA(120,j,i),DATA(118,j,i)];
%             V(5,2,:)=[DATA(66,j,i),DATA(69,j,i),DATA(67,j,i),DATA(70,j,i),DATA(68,j,i)];
%                   
%             V(1,3,:)=[DATA(6,j,i),DATA(9,j,i),DATA(7,j,i),DATA(10,j,i),DATA(8,j,i)];
%             V(2,3,:)=[DATA(81,j,i),DATA(84,j,i),DATA(82,j,i),DATA(85,j,i),DATA(83,j,i)];
%             V(3,3,:)=[DATA(31,j,i),DATA(34,j,i),DATA(32,j,i),DATA(35,j,i),DATA(33,j,i)];
%             V(4,3,:)=[DATA(106,j,i),DATA(109,j,i),DATA(107,j,i),DATA(110,j,i),DATA(108,j,i)];
%             V(5,3,:)=[DATA(56,j,i),DATA(59,j,i),DATA(57,j,i),DATA(60,j,i),DATA(58,j,i)];
%                   
%             V(1,4,:)=[DATA(21,j,i),DATA(24,j,i),DATA(22,j,i),DATA(25,j,i),DATA(23,j,i)];
%             V(2,4,:)=[DATA(96,j,i),DATA(99,j,i),DATA(97,j,i),DATA(100,j,i),DATA(98,j,i)];
%             V(3,4,:)=[DATA(46,j,i),DATA(49,j,i),DATA(47,j,i),DATA(50,j,i),DATA(48,j,i)];
%             V(4,4,:)=[DATA(121,j,i),DATA(124,j,i),DATA(122,j,i),DATA(125,j,i),DATA(123,j,i)];
%             V(5,4,:)=[DATA(71,j,i),DATA(74,j,i),DATA(72,j,i),DATA(75,j,i),DATA(73,j,i)];
%                  
%             V(1,5,:)=[DATA(11,j,i),DATA(14,j,i),DATA(12,j,i),DATA(15,j,i),DATA(13,j,i)];
%             V(2,5,:)=[DATA(86,j,i),DATA(89,j,i),DATA(87,j,i),DATA(90,j,i),DATA(88,j,i)];
%             V(3,5,:)=[DATA(36,j,i),DATA(39,j,i),DATA(37,j,i),DATA(40,j,i),DATA(38,j,i)];
%             V(4,5,:)=[DATA(111,j,i),DATA(114,j,i),DATA(112,j,i),DATA(115,j,i),DATA(113,j,i)];
%             V(5,5,:)=[DATA(61,j,i),DATA(64,j,i),DATA(62,j,i),DATA(65,j,i),DATA(63,j,i)];





% %length of data
% Mlen=.82-.74;
% Wlen=50300-27900;
% Alen=41000-31000;
%%%%%%%%%%Other way to calculate trap rule%%%%%%%%
% if(trap==1)
%     int=0;
%     for i=1:numel(Mq(:,1,1))-1
%         for j=1:numel(Wq(1,:,1))-1
%             for k=1:numel(Aq(1,1,:))-1
%                 
%                 dx=(Mq(i+1,j,k)-Mq(i,j,k))/Mlen;
%                 dy=(Wq(i,j+1,k)-Wq(i,j,k))/Wlen;
%                 dz=(Aq(i,j,k+1)-Aq(i,j,k))/Alen;
%                 dV=dx*dy*dz;
%                 
%                 sum1=DATAq(i,j,k)+DATAq(i+1,j,k)+DATAq(i,j+1,k)+DATAq(i+1,j+1,k);
%                 sum2=DATAq(i,j,k+1)+DATAq(i+1,j,k+1)+DATAq(i,j+1,k+1)+DATAq(i+1,j+1,k+1);
%                 f=dV*(sum1+sum2)/8;
%                 
%                 int=int+f;
%                 
%             end
%         end
%     end
% end
