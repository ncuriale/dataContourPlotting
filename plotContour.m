function plotContour(Wq,Mq,Aq,DATAq,DATA,cmin,cmax,spacing,titleData,imageTitle,numPlot,jMorph,iplot)

%if (mod(iplot,numPlot)~=9); return; end; 
    
    figure(iplot)   
    %main contours
    slice(Wq,Mq,Aq,DATAq,[61500 86200 110900],[],[]);
    shading interp
    %contour lines
    cont=[cmin+spacing:spacing:cmax-spacing];
    h=contourslice(Wq,Mq,Aq,DATAq,[61500 86200 110900],[],[],cont);
    hold on
    if (mod(iplot,numPlot)==1) 
        MLD98=max(max(max(DATAq)))*0.98;
        h98=contourslice(Wq,Mq,Aq,DATAq,[61500 86200 110900],[],[],[0,MLD98]);
        hold on       
    end
    
    %plot textboxes
    if (mod(iplot,numPlot)==1)   
        %Max ML/D
        mTextBox = uicontrol('style','text');
        %variables
        maxval=round(max(max(max(DATAq))),5,'significant');
        max98val=round(0.98*max(max(max(DATAq))),5,'significant');
        %textboxes
        t=strcat({'         '},'Max ML/D = ',{' '},sprintf('%0.3f', maxval),{'           '},'Solid Line = 98% Max ML/D',{'  '},' = ',{' '},sprintf('%0.3f', max98val));
        set(mTextBox,'String',t);
        set(mTextBox,'Position',[22 510 235 75],'FontName','Calibri','FontSize',14,'FontWeight','Bold');
        set(mTextBox,'BackgroundColor',[1 1 1]);
               
%       isovalue = max(reshape(DATA,[27,1]))*0.98;
%       [faces,verts,fcolors] = isosurface(Wq,Mq,Aq,DATAq,isovalue,DATAq);
%       p = patch('Vertices',verts,'Faces',faces,'FaceVertexCData',fcolors, ...
%       'FaceColor','interp','EdgeColor','none');
    end
    
    %plot limits and ticks
%     xlim([27400 50800])
%     set(gca,'Xtick',27900:11200:50300)
    xlim([60500 111500])
    set(gca,'Xtick',61500:24700:110900)
    ylim([0.735 0.825])
    set(gca,'Ytick',0.74:0.04:0.82)
    zlim([30500 41500])    
    set(gca,'Ztick',31000:5000:41000)    
    set(gca,'FontName','Calibri','FontSize',12,'FontWeight','Bold');
    
    %colormap size/levels
    set(gca, 'CLim', [cmin, cmax]); 
    M = (cmax-cmin)/spacing; %number of levels
    G = fliplr(linspace(0,1,M)) .';
    newmap = horzcat(zeros(size(G)), G, zeros(size(G)));
    colormap(newmap);                %activate # of levels
    if(mod(iplot,numPlot)==1); newmap = jet;
    elseif(mod(iplot,numPlot)==2); newmap = jet;
    elseif(mod(iplot,numPlot)==3); newmap = hsv;
    elseif(mod(iplot,numPlot)==4); newmap = jet;
    elseif(mod(iplot,numPlot)==5); newmap = jet;
    elseif(mod(iplot,numPlot)==6); newmap = jet;
    elseif(mod(iplot,numPlot)==7); newmap = jet;
    elseif(mod(iplot,numPlot)==8); newmap = jet;
    elseif(mod(iplot,numPlot)==9); newmap = jet;
    elseif(mod(iplot,numPlot)==10); newmap = jet;
    elseif(mod(iplot,numPlot)==0); newmap = jet;
    end;        
    colormap(newmap);                %activate it    
    if (mod(iplot,numPlot)==1); set(h98,'edgecolor',[0 0 0],'linestyle','-','linewidth',2.0); end;  %set MLD98 style
    set(h,'edgecolor','black','linestyle',':','linewidth',0.5);  %set contour line style
    
    %colorbar
    cb=colorbar('EastOutside');
    set(cb, 'Position', [.93 .25 .025 .7],'FontName','Calibri','FontSize',14,'FontWeight','Bold');    
    if(mod(iplot,numPlot)==2); set(cb, 'Position', [.92 .25 .025 .7],'FontName','Calibri','FontSize',14,'FontWeight','Bold'); end;
     
    %view of plot
    az = 25;
    el = 10;
    view(az, el);
    set(gcf, 'Position', [50, 100, 1000, 600])
    set(gcf,'color','w');

    %Labels
    xlabel('Weight (lbs)','FontName','Calibri','FontSize',14,'FontWeight','Bold');
    ylabel('Mach Number (-)','FontName','Calibri','FontSize',14,'FontWeight','Bold');
    zlabel('Altitude (ft)','FontName','Calibri','FontSize',14,'FontWeight','Bold');
    set(gca,'xticklabel',num2str(get(gca,'xtick')'))
    set(gca,'zticklabel',num2str(get(gca,'ztick')'))
    
    %Titles
    if (mod(iplot,numPlot)==1);titleName=strcat('ML/D Contours for',{' '},titleData); end;
    if (mod(iplot,numPlot)==2);titleName=strcat('CD Contours for',{' '},titleData); end;
    if (mod(iplot,numPlot)==3);titleName=strcat('Delta ML/D Contours for',{' '},titleData); end;
    if (mod(iplot,numPlot)==4);titleName=strcat('Delta CD Contours for',{' '},titleData,{' '},'in Counts'); end;
    if (mod(iplot,numPlot)==5);titleName=strcat('Delta CD% Contours for',{' '},titleData); end;
    if (mod(iplot,numPlot)==6);titleName=strcat('Delta Max Mach Number Contours for',{' '},titleData); end;
    if (mod(iplot,numPlot)==7);titleName=strcat('Delta CDp Contours for',{' '},titleData,{' '},'in Counts'); end;
    if (mod(iplot,numPlot)==8);titleName=strcat('Delta CDp% Contours for',{' '},titleData); end;
    if (mod(iplot,numPlot)==9);titleName=strcat('Delta CDf Contours for',{' '},titleData,{' '},'in Counts'); end;
    if (mod(iplot,numPlot)==10);titleName=strcat('Delta CDf% Contours for',{' '},titleData); end;
    if (mod(iplot,numPlot)==0);titleName=strcat('CM Contours for',{' '},titleData); end;
    title(titleName,'FontName','Calibri','FontSize',16,'FontWeight','Bold');
   
    %Print images
    if(1)
        if (mod(iplot,numPlot)==1);imageName=char(strcat(imageTitle,'MLD')); end;
        if (mod(iplot,numPlot)==2);imageName=char(strcat(imageTitle,'CD')); end;
        if (mod(iplot,numPlot)==3);imageName=char(strcat(imageTitle,'MLDdelta')); end;
        if (mod(iplot,numPlot)==4);imageName=char(strcat(imageTitle,'CDdelta')); end;
        if (mod(iplot,numPlot)==5);imageName=char(strcat(imageTitle,'CD%delta')); end;
        if (mod(iplot,numPlot)==6);imageName=char(strcat(imageTitle,'machdelta')); end;
        if (mod(iplot,numPlot)==7);imageName=char(strcat(imageTitle,'CDpdelta')); end;
        if (mod(iplot,numPlot)==8);imageName=char(strcat(imageTitle,'CDp%')); end;
        if (mod(iplot,numPlot)==9);imageName=char(strcat(imageTitle,'CDfdelta')); end;
        if (mod(iplot,numPlot)==10);imageName=char(strcat(imageTitle,'CDf%')); end;
        if (mod(iplot,numPlot)==0);imageName=char(strcat(imageTitle,'CM')); end;
        set(gcf,'PaperPositionMode','auto')
        print(imageName,'-dpng','-r0')
    end

end