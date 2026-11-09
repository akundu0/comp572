%%AI Usage Report
%{
1.  Which AI tool(s) you used:
Claude (Anthropic), Sonnet 5.5
2.  One or two example prompts:
Write a third method, addressing the artifacts in these two preexisting
methods.
3.  What parts of the MATLAB code were AI-generated:
The method 3 function and the starburst kernel change for the koi fish
image (image 2)
4.  What changes, debugging, or refinements you performed yourself:
I adjusted the radius of each image, until the image had the desired
effect.
%}

%{

YOUR COMMENTS:

Please include brief comments here describing the effects and quality of
results (3-5 lines).  Include anything else about the images you would like
to share.

(Optional) Also mention if you obtained more compelling results by using a 
different filter shape than a disk.

Method 3 removes both artifacts from the baseline methods: the foreground no
longer bleeds into the blurred background, and there is no dark halo along the
subject's edge. The best results were the koi and lychee, where the subject is
clearly separated from the background and my polygon follows the edge closely.
I tuned the radius per image (6 for the portrait up to 20 for the dog) to get
a noticeable blur without making the background unrecognizable. The dog is my
failure case: its fuzzy fur does not match the hard polygon edge, so you can
see a cutout look and a ring of unblurred background around the fur.

For the koi image I used a 5-point starburst kernel (radius 20) instead of a
disk. The starburst gave subtle star-shaped highlights on the water, which gave a
more interesting result than the plain disk blur.

%}

close('all');   % close all open figures so we start with a clean slate!

I=im2double(imread('couple.jpg'));

% Get foreground mask (part that stays sharp) from the user

% For the given image, a mask is provided as an image
mask = im2double(imread('mask.png'));

% Define the bokeh filter shape
% A simple disk filter is provided as default
% For extra credit you may optionally define a different shape, e.g., hexagon, starburst, heart etc.

radius = 15;            % choose this carefully for each image
bokeh_shape = fspecial('disk', radius);

result1a = method1(I, mask, bokeh_shape);
result1b = method2(I, mask, bokeh_shape);
result1 = method3(I, mask, bokeh_shape);

figure; montage({I, result1a, result1b, result1});


%%
% -------------------------------------------------------------------------
% IMPORTANT NOTE (please read carefully)
% -------------------------------------------------------------------------
% Repeat your method for 5 more sets of images.  But remember that for
% these you must interactively specify the mask ONE TIME.
%
% Work in the Matlab computer app or the full Matlab Online version
% (https://matlab.mathworks.com) first to get the coordinates for alignment
% and cropping.  Then hard-code these in your program before migrating to
% the Matlab Grader website for submission.
%
% -------------------------------------------------------------------------


I=im2double(imread('https://raw.githubusercontent.com/akundu0/comp572/main/assn8/koi.png'));

% Interactively draw the foreground mask as a polygon

% [poly_x, poly_y] = getPolygonForMask(I);
% disp("Copy the values of the vectors poly_x and poly_y from the " + ...
%     "Command Window below and hard code them inside your code for " + ...
%     "submission via the Grader website.");
% poly_x        % display x coords of polygon
% poly_y        % display y coords of polygon
% Once you have these coordinates, comment out the call to getPolygonForMask() 
% and hard code the coordinates instead.
poly_x = [579.2451  574.1707  529.7701  498.0554  494.2496  472.6836  456.1920  453.6548  381.3452    305.2299  254.4863  221.5030  193.5941  187.2511  187.2511  210.0857  213.8915  244.3376   297.6184  349.6305  404.1798  452.3862  440.9689  456.1920  479.0266  510.7413  548.7989];
poly_y = [521.2557  547.8961  570.7307  582.1480  610.0569  629.0857  606.2511  587.2223  597.3710  589.7595  570.7307  540.2845  513.6442  487.0038  471.7807  487.0038  513.6442  536.4788  547.8961  537.7473  521.2557  509.8384  476.8551  476.8551  502.2269  499.6897  507.3012];

mask = poly2mask(poly_x, poly_y, size(I, 1), size(I, 2));

% Define the bokeh filter shape
% A simple disk filter is provided as default
% For extra credit you may optionally define a different shape, e.g., hexagon, starburst, heart etc.

radius = 20;            % choose this carefully for each image
% bokeh_shape = fspecial('disk', radius);
% result2 = method3(I, mask, bokeh_shape);
% figure; montage({I, result2});

% Starburst
r = radius;
n = 5;                                   % number of points
ang = linspace(0, 2*pi, 2*n+1); ang(end) = [];
rad = repmat([r, r*0.45], 1, n);         % outer, inner
vx = rad.*cos(ang) + r + 1;
vy = rad.*sin(ang) + r + 1;
bokeh_shape = double(poly2mask(vx, vy, 2*r+1, 2*r+1));
bokeh_shape = bokeh_shape / sum(bokeh_shape(:));

result2 = method3(I, mask, bokeh_shape);

figure; montage({I, result2});


%%
% REPEAT ABOVE FOR IMAGE 3

I=im2double(imread('https://raw.githubusercontent.com/akundu0/comp572/main/assn8/lychee.png'));

% Interactively draw the foreground mask as a polygon

% [poly_x, poly_y] = getPolygonForMask(I);
% disp("Copy the values of the vectors poly_x and poly_y from the " + ...
%     "Command Window below and hard code them inside your code for " + ...
%     "submission via the Grader website.");
% poly_x        % display x coords of polygon
% poly_y        % display y coords of polygon
% Once you have these coordinates, comment out the call to getPolygonForMask() 
% and hard code the coordinates instead.

poly_x = [557.4514  574.3589  626.9598  658.8961  711.4970  782.8839  852.3923  912.5076  940.6866  936.9294  908.7504  880.5713  844.8778  790.3983  732.1616  703.9825  666.4105  615.6882  581.8733  576.2375  563.0873  553.6942];
poly_y = [322.6806  283.2299  219.3574  198.6927  159.2420  153.6062  208.0857  258.8080  350.8596  433.5182  480.4833  495.5121  534.9628  585.6851  593.1995  565.0205  536.8414  514.2982  518.0554  491.7549  446.6684  399.7033];

mask = poly2mask(poly_x, poly_y, size(I, 1), size(I, 2));

% Define the bokeh filter shape
% A simple disk filter is provided as default
% For extra credit you may optionally define a different shape, e.g., hexagon, starburst, heart etc.

radius = 14;            % choose this carefully for each image
bokeh_shape = fspecial('disk', radius);

result3 = method3(I, mask, bokeh_shape);

figure; montage({I, result3});

%%
% REPEAT ABOVE FOR IMAGE 4

I=im2double(imread('https://raw.githubusercontent.com/akundu0/comp572/main/assn8/emma.png'));

% Interactively draw the foreground mask as a polygon

% [poly_x, poly_y] = getPolygonForMask(I);
% disp("Copy the values of the vectors poly_x and poly_y from the " + ...
%     "Command Window below and hard code them inside your code for " + ...
%     "submission via the Grader website.");
% poly_x        % display x coords of polygon
% poly_y        % display y coords of polygon
% Once you have these coordinates, comment out the call to getPolygonForMask() 
% and hard code the coordinates instead.
poly_x = [391.4939  373.7337  377.5395  392.7625  418.1343  442.2375  463.8035  480.2951  476.4894   465.0721  487.9067  520.8900  524.6958  514.5470  520.8900  520.8900  509.4727  487.9067  491.7124  491.7124  494.2496  487.9067  407.9856  309.0357  326.7959  312.8414  312.8414  305.2299  312.8414  311.5728  320.4530  334.4074];
poly_y = [376.6366  346.1904  301.7898  270.0751  252.3149  252.3149  270.0751  317.0129  362.6821  384.2481  395.6654  408.3513  437.5288  484.4666  525.0615  563.1191  627.8171  629.0857  659.5319  692.5152  768.6305  833.3285  830.7914  834.5971  658.2633  651.9203  627.8171  559.3134  530.1358  495.8839  448.9461  399.4712];

mask = poly2mask(poly_x, poly_y, size(I, 1), size(I, 2));

% Define the bokeh filter shape
% A simple disk filter is provided as default
% For extra credit you may optionally define a different shape, e.g., hexagon, starburst, heart etc.

radius = 6;            % choose this carefully for each image
bokeh_shape = fspecial('disk', radius);

result4 = method3(I, mask, bokeh_shape);

figure; montage({I, result4});

%%
% REPEAT ABOVE FOR IMAGE 5
% example of bad image to use (fuzzy borders on subject)
I=im2double(imread('https://raw.githubusercontent.com/akundu0/comp572/main/assn8/dog.png'));

% Interactively draw the foreground mask as a polygon

% [poly_x, poly_y] = getPolygonForMask(I);
% disp("Copy the values of the vectors poly_x and poly_y from the " + ...
%     "Command Window below and hard code them inside your code for " + ...
%     "submission via the Grader website.");
% poly_x        % display x coords of polygon
% poly_y        % display y coords of polygon
% Once you have these coordinates, comment out the call to getPolygonForMask() 
% and hard code the coordinates instead.
poly_x = [2.856016691957511e+02,2.143270106221548e+02,2.632010622154780e+02,2.632010622154780e+02,2.998566009104704e+02,3.181843702579668e+02,3.222572078907435e+02,4.037139605462824e+02,4.709157814871016e+02,5.075713201820940e+02,5.686638846737483e+02,5.197898330804248e+02,5.666274658573598e+02,5.849552352048559e+02,5.625546282245828e+02,5.788459787556906e+02,5.625546282245828e+02,5.910644916540214e+02,6.480842185128985e+02,6.847397572078908e+02,7.071403641881641e+02,7.458323216995451e+02,8.252526555386951e+02,9.352192716236724e+02,1.014639605462823e+03,1.079805007587254e+03,1.104242033383915e+03,1.061477238239757e+03,1.000384673748103e+03,9.107822458270107e+02,8.598717754172990e+02,8.109977238239758e+02,7.804514415781489e+02,7.376866464339910e+02,6.765940819423370e+02,6.460477996965099e+02,6.704848254931715e+02,6.460477996965099e+02,6.419749620637331e+02,6.541934749620639e+02,6.725212443095600e+02,6.541934749620639e+02,5.564453717754175e+02,4.648065250379364e+02,3.853861911987860e+02,3.405849772382398e+02,3.100386949924127e+02,2.998566009104704e+02,2.733831562974203e+02,2.387640364188164e+02,2.082177541729893e+02,1.959992412746585e+02,1.939628224582700e+02,1.450887708649469e+02,1.165789074355083e+02,96.214719271623608,96.214719271623608,1.084332321699544e+02,1.287974203338391e+02,1.328702579666161e+02,1.471251896813353e+02,1.817443095599392e+02,2.367276176024279e+02];
poly_y = [2.927261001517447e+02,2.255242792109252e+02,2.458884673748098e+02,2.316335356600907e+02,2.458884673748098e+02,2.458884673748098e+02,2.682890743550831e+02,2.255242792109252e+02,2.275606980273137e+02,2.581069802731408e+02,3.191995447647948e+02,2.988353566009100e+02,3.497458270106217e+02,4.149112291350527e+02,4.760037936267069e+02,4.963679817905915e+02,5.309871016691955e+02,5.554241274658571e+02,5.696790591805764e+02,6.287352048558419e+02,6.592814871016689e+02,6.857549317147190e+02,6.653907435508343e+02,6.714999999999997e+02,6.959370257966615e+02,7.224104704097114e+02,7.651752655538691e+02,8.201585735963580e+02,8.181221547799694e+02,8.181221547799694e+02,8.486684370257963e+02,8.384863429438541e+02,8.731054628224581e+02,8.731054628224581e+02,8.873603945371773e+02,8.873603945371773e+02,9.219795144157814e+02,9.830720789074353e+02,1.056383156297420e+03,1.111366464339909e+03,1.186713960546282e+03,1.227442336874051e+03,1.215223823975721e+03,1.227442336874051e+03,1.257988619119878e+03,1.284462063732929e+03,1.148022003034901e+03,1.076747344461305e+03,1.007509104704097e+03,9.647443095599390e+02,9.158702579666158e+02,8.201585735963580e+02,7.835030349013655e+02,7.529567526555383e+02,7.142647951441576e+02,6.735364188163882e+02,6.185531107738996e+02,5.676426403641879e+02,5.309871016691955e+02,4.658216995447644e+02,4.271297420333835e+02,3.782556904400603e+02,3.253088012139601e+02];

mask = poly2mask(poly_x, poly_y, size(I, 1), size(I, 2));

% Define the bokeh filter shape
% A simple disk filter is provided as default
% For extra credit you may optionally define a different shape, e.g., hexagon, starburst, heart etc.

radius = 20;            % choose this carefully for each image
bokeh_shape = fspecial('disk', radius);

result5 = method3(I, mask, bokeh_shape);

figure; montage({I, result5});

%%
% REPEAT ABOVE FOR IMAGE 6

I=im2double(imread('https://raw.githubusercontent.com/akundu0/comp572/main/assn8/alpaca.png'));

% Interactively draw the foreground mask as a polygon

% [poly_x, poly_y] = getPolygonForMask(I);
% disp("Copy the values of the vectors poly_x and poly_y from the " + ...
%     "Command Window below and hard code them inside your code for " + ...
%     "submission via the Grader website.");
% poly_x        % display x coords of polygon
% poly_y        % display y coords of polygon
% % Once you have these coordinates, comment out the call to getPolygonForMask() 
% % and hard code the coordinates instead.
poly_x = [1.557276176024278e+02,2.082253414264035e+02,2.590295902883154e+02,3.149142640364187e+02,3.707989377845217e+02,4.351509863429437e+02,4.757943854324733e+02,4.978095599393019e+02,5.028899848254930e+02,4.978095599393019e+02,5.028899848254930e+02,4.910356600910468e+02,4.876487101669196e+02,5.367594840667678e+02,5.384529590288314e+02,5.028899848254930e+02,4.910356600910468e+02,4.774878603945369e+02,4.724074355083458e+02,4.707139605462822e+02,4.622465857359635e+02,4.707139605462822e+02,4.724074355083458e+02,4.707139605462822e+02,4.707139605462822e+02,4.249901365705614e+02,3.691054628224581e+02,3.437033383915020e+02,3.301555386949922e+02,2.979795144157813e+02,2.979795144157813e+02,2.183861911987859e+02,2.319339908952956e+02,2.217731411229133e+02,2.268535660091046e+02,2.268535660091046e+02,2.268535660091046e+02,2.217731411229133e+02,2.133057663125948e+02,2.133057663125948e+02,2.082253414264035e+02,1.862101669195749e+02,1.608080424886190e+02,1.506471927162365e+02,1.506471927162365e+02,1.506471927162365e+02,1.557276176024278e+02,1.608080424886190e+02,1.472602427921091e+02,1.455667678300454e+02,1.201646433990894e+02,1.150842185128982e+02,1.015364188163884e+02,1.116972685887707e+02,1.201646433990894e+02,1.303254931714717e+02,1.049233687405158e+02,1.421798179059180e+02,1.218581183611532e+02];
poly_y = [1.791616084977240e+02,1.469855842185132e+02,1.266638846737484e+02,1.080356600910472e+02,1.266638846737484e+02,1.520660091047043e+02,1.893224582701064e+02,2.282723823975723e+02,2.536745068285284e+02,2.756896813353569e+02,3.061722306525040e+02,3.349613050075875e+02,3.806851289833082e+02,4.433437025796663e+02,4.924544764795146e+02,5.043088012139608e+02,5.398717754172992e+02,5.940629742033386e+02,6.160781487101673e+02,6.414802731411231e+02,6.499476479514418e+02,7.007518968133538e+02,7.566365705614570e+02,8.176016691957514e+02,8.734863429438545e+02,8.955015174506831e+02,9.242905918057666e+02,9.547731411229138e+02,9.801752655538696e+02,9.767883156297423e+02,9.903361153262522e+02,9.767883156297423e+02,9.463057663125951e+02,9.056623672230654e+02,8.751798179059183e+02,8.294559939301975e+02,7.786517450682854e+02,7.227670713201823e+02,6.855106221547802e+02,6.753497723823978e+02,6.550280728376329e+02,6.313194233687408e+02,5.906760242792111e+02,5.601934749620640e+02,5.026153262518970e+02,4.416502276176027e+02,4.213285280728379e+02,3.959264036418818e+02,3.552830045523523e+02,3.163330804248865e+02,3.095591805766314e+02,2.807701062215480e+02,2.604484066767832e+02,2.587549317147195e+02,2.333528072837634e+02,2.248854324734448e+02,2.028702579666164e+02,2.130311077389988e+02,1.825485584218515e+02];

mask = poly2mask(poly_x, poly_y, size(I, 1), size(I, 2));

% Define the bokeh filter shape
% A simple disk filter is provided as default
% For extra credit you may optionally define a different shape, e.g., hexagon, starburst, heart etc.

radius = 15;            % choose this carefully for each image
bokeh_shape = fspecial('disk', radius);

result6 = method3(I, mask, bokeh_shape);

figure; montage({I, result6});

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This are the functions that implement bokeh
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function result = method1(I, mask, filter)
    I_blur = imfilter(I, filter, 'replicate');
    result = I_blur .* (1 - mask) + I .* mask;
end

function result = method2(I, mask, filter)
    bg = I .* (1 - mask);
    bg_blur = imfilter(bg, filter, 'replicate');
    result = bg_blur .* (1 - mask) + I .* mask;
end

function result = method3(I, mask, filter)
    bg_mask = 1 - mask;
    num = imfilter(I .* bg_mask, filter, 'replicate'); 
    den = imfilter(bg_mask,      filter, 'replicate'); 
    bg_blur = num ./ den; 
    bg_blur(isnan(bg_blur)) = 0; 
    result = bg_blur .* bg_mask + I .* mask; 
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Below are helper functions.  You DO NOT NEED TO MODIFY
% any of the code below.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [poly_x, poly_y] = getPolygonForMask(im)
    % Asks user to draw polygon around input image.  
    disp('Draw polygon around source object in clockwise order, q to stop');
    fig=figure; hold off; imagesc(im); axis image;
    poly_x = [];
    poly_y = [];
    while 1
        figure(fig)
        [x, y, b] = ginput(1);
        if b=='q'
            break;
        end
        poly_x(end+1) = x;
        poly_y(end+1) = y;
        hold on; plot(poly_x, poly_y, '*-');
    end
    close(fig);
end