

function ui = registrationui(fig, def_scale, def_angle, def_dx, def_dy, callback)
   ui = struct();
   ui.scale = def_scale;
   ui.angle = def_angle;
   ui.dx = def_dx;
   ui.dy = def_dy;
   ui.inc = 0.75;
   ui.blend = 0.5;
   ui.format = '%f';
   ui.callback = callback;
   
   xsize = 0.19;
   ysize = 0.05;
   yspace = 0.005;
   xspace = 0.002;
   posy = 0.05;
   posx = 0.8;
   ui.up=uicontrol('Style','push', 'Units', 'Normalized', 'Position', [posx, posy, xsize, ysize], 'String', 'DWN');
   set(ui.up, 'Callback', {@button_click, 4, fig});
   posy = posy + ysize + yspace;
   ui.left=uicontrol('Style','push', 'Units', 'Normalized', 'Position', [posx, posy, xsize/2-xspace/2, ysize], 'String', 'LFT');
   set(ui.left, 'Callback', {@button_click, 5, fig});
   ui.right=uicontrol('Style','push', 'Units', 'Normalized', 'Position', [posx+xsize/2+xspace/2, posy, xsize/2-xspace/2, ysize], 'String', 'RGHT');
   set(ui.right, 'Callback', {@button_click, 6, fig});
   posy = posy + ysize + yspace;
   ui.down=uicontrol('Style','push', 'Units', 'Normalized', 'Position', [posx, posy, xsize, ysize], 'String', 'UP');
   set(ui.down, 'Callback', {@button_click, 7, fig});
   posy = posy + ysize + yspace;
   
   
   uicontrol('Style','Text', 'Units', 'Normalized', 'Position', [posx, posy, xsize/4, ysize], 'String', 'dX');
   ui.dx_edit=uicontrol('Style','Edit', 'Units', 'Normalized', 'Position', [posx+xsize/4, posy, xsize*3/4, ysize]);
   set(ui.dx_edit, 'Callback', {@text_edit, fig});
   posy = posy + ysize + yspace;
   uicontrol('Style','Text', 'Units', 'Normalized', 'Position', [posx, posy, xsize/4, ysize], 'String', 'dY');
   ui.dy_edit=uicontrol('Style','Edit', 'Units', 'Normalized', 'Position', [posx+xsize/4, posy, xsize*3/4, ysize]);
   set(ui.dy_edit, 'Callback', {@text_edit, fig});
   posy = posy + ysize*2 + yspace;
   
   
   ui.rccw=uicontrol('Style','push', 'Units', 'Normalized', 'Position', [posx, posy, xsize/2-xspace/2, ysize], 'String', 'RCCW');
   set(ui.rccw, 'Callback', {@button_click, 2, fig});
   ui.rcw=uicontrol('Style','push', 'Units', 'Normalized', 'Position', [posx+xsize/2+xspace/2, posy, xsize/2-xspace/2, ysize], 'String', 'RCW');
   set(ui.rcw, 'Callback', {@button_click, 3, fig});
   posy = posy + ysize + yspace;
   uicontrol('Style','Text', 'Units', 'Normalized', 'Position', [posx, posy, xsize/4, ysize], 'String', 'ANGL');
   ui.angle_edit=uicontrol('Style','Edit', 'Units', 'Normalized', 'Position', [posx+xsize/4, posy, xsize*3/4, ysize]);
   set(ui.angle_edit, 'Callback', {@text_edit, fig});
   posy = posy + ysize*2 + yspace;
   ui.scale_minus=uicontrol('Style','push', 'Units', 'Normalized', 'Position', [posx, posy, xsize/2-xspace/2, ysize], 'String', '-');
   set(ui.scale_minus, 'Callback', {@button_click, 0, fig});
   ui.scale_plus=uicontrol('Style','push', 'Units', 'Normalized', 'Position', [posx+xsize/2+xspace/2, posy, xsize/2-xspace/2, ysize], 'String', '+');
   set(ui.scale_plus, 'Callback', {@button_click, 1, fig});
   posy = posy + ysize + yspace;
   uicontrol('Style','Text', 'Units', 'Normalized', 'Position', [posx, posy, xsize/4, ysize], 'String', 'SCALE');
   ui.scale_edit=uicontrol('Style','Edit', 'Units', 'Normalized', 'Position', [posx+xsize/4, posy, xsize*3/4, ysize]);
   set(ui.scale_edit, 'Callback', {@text_edit, fig});

   posy = posy + ysize*2 + yspace;
   ui.inc_slide=uicontrol('Style','slider', 'Units', 'Normalized', 'Position', [posx, posy, xsize, ysize/2], 'Value', ui.inc);
   set(ui.inc_slide, 'Callback', {@button_click, 8, fig});
   
   posy = posy + ysize/2 + yspace;
   uicontrol('Style','Text', 'Units', 'Normalized', 'Position', [posx, posy, xsize/4, ysize], 'String', 'Incr');
   ui.inc_edit=uicontrol('Style','Edit', 'Units', 'Normalized', 'Position', [posx+xsize/4, posy, xsize*3/4, ysize], 'String', '0.0');
   posy = posy + ysize + yspace;
   
   ui.blend_slide=uicontrol('Style','slider', 'Units', 'Normalized', 'Position', [posx, posy, xsize, ysize/2], 'Value', ui.blend);
   set(ui.blend_slide, 'Callback', {@button_click, 9, fig});
   
   setappdata(fig, 'ui', ui);
   update_image(fig);
   ui.callback(fig);
endfunction

function exp_inc = calc_inc(inc)
  exp_inc = 10 ^ ((inc-0.75)*4);
endfunction

function update_image(fig)
  ui=getappdata(fig, 'ui');
  set(ui.scale_edit, 'String', sprintf(ui.format, ui.scale));
  set(ui.dy_edit, 'String', sprintf(ui.format, ui.dy));
  set(ui.dx_edit, 'String', sprintf(ui.format, ui.dx));
  set(ui.angle_edit, 'String', sprintf(ui.format, ui.angle));
  set(ui.inc_edit, 'String', sprintf(ui.format, calc_inc(ui.inc))); 
endfunction

function text_edit(src, event, fig)
  ui=getappdata(fig, 'ui');
  get(ui.dx_edit, 'String');
  ui.dx = str2num(get(ui.dx_edit, 'String'));
  ui.dy = str2num(get(ui.dy_edit, 'String'));
  ui.angle = str2num(get(ui.angle_edit, 'String'));
  ui.scale = str2num(get(ui.scale_edit, 'String'));
  setappdata(fig, 'ui', ui);
  ui.callback(fig);
endfunction

function button_click(src, event, button, fig)
   ui = getappdata(fig, 'ui');
   exp_inc = calc_inc(ui.inc);
   
   switch button
     case 0 
       ui.scale = ui.scale - exp_inc/10;    
     case 1 
       ui.scale = ui.scale + exp_inc/10;
     case 2 
       ui.angle = ui.angle - exp_inc;    
     case 3 
       ui.angle = ui.angle + exp_inc;        
     case 7 
       ui.dy = ui.dy + exp_inc;        
     case 4 
       ui.dy = ui.dy - exp_inc;      
     case 5 
       ui.dx = ui.dx - exp_inc;        
     case 6 
       ui.dx = ui.dx + exp_inc;    
     case 8
       ui.inc = get(ui.inc_slide, 'Value');
     case 9
       ui.blend = get(ui.blend_slide, 'Value');
   end     
   setappdata(fig, 'ui', ui);
   update_image(fig);
   ui.callback(fig);
endfunction








