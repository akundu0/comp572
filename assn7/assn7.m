%%AI Usage Report
%{
1.  Which AI tool(s) you used:
I used Claude (Anthropic, Sonnet 5.5)
2.  One or two example prompts: Guide me through how to write this
function.
3.  What parts of the MATLAB code were AI-generated:
The functions dot_mosaic_gray, dot_mosaic_color, and make_tile.
4.  What changes, debugging, or refinements you performed yourself:
I adjusted the parameters to fit the image better.
%}

close all;

% Image 1
% For grayscale dot mosaic
im = im2double(rgb2gray(imread('https://raw.githubusercontent.com/akundu0/comp572/main/assn7/cat.png')));
% resize if necessary
mosaic = dot_mosaic_gray(im, 60);  % Choose Size carefully!
figure; montage({im, mosaic});

%Image 2
% For grayscale dot mosaic
im = im2double(rgb2gray(imread('https://raw.githubusercontent.com/akundu0/comp572/main/assn7/dog.png')));
% resize if necessary
mosaic = dot_mosaic_gray(im, 47);  % Choose Size carefully!
figure; montage({im, mosaic});

% image 3

% For color dot mosaic
im = im2double(imread('https://raw.githubusercontent.com/akundu0/comp572/main/assn7/fat_koi.png'));
% resize if necessary
mosaic = dot_mosaic_color(im, 42);  % Choose Size carefully!
figure; montage({im, mosaic});

%Image 4

% For grayscale dot mosaic
im = im2double(rgb2gray(imread('https://raw.githubusercontent.com/akundu0/comp572/main/assn7/wonderwoman.png')));
% resize if necessary
mosaic = dot_mosaic_gray(im, 40);  % Choose Size carefully!
figure; montage({im, mosaic});

%Image 5

% For color dot mosaic
im = im2double(imread('https://raw.githubusercontent.com/akundu0/comp572/main/assn7/koi.png'));
% resize if necessary
mosaic = dot_mosaic_color(im, 30);  % Choose Size carefully!
figure; montage({im, mosaic});

% Image 6

% For color dot mosaic
im = im2double(imread('https://raw.githubusercontent.com/akundu0/comp572/main/assn7/dog_swing.png'));
% resize if necessary
mosaic = dot_mosaic_color(im, 53);  % Choose Size carefully!
figure; montage({im, mosaic});

function result = dot_mosaic_gray(im, Size)
    [h, w] = size(im);
    shorter = min(h, w);

    % Step 3: initial (real-valued) grid square size, then force it odd
    k = shorter / Size;
    k = 2*round((k - 1)/2) + 1;   % nearest odd integer
    k = max(k, 3);                % need at least 3 px to draw a dot

    % Step 4: shrink so each k-by-k block becomes one pixel (block average)
    nShort = round(shorter / k);
    if h <= w
        small = imresize(im, [nShort, NaN], 'box');
    else
        small = imresize(im, [NaN, nShort], 'box');
    end
    small = min(max(small, 0), 1);
    [nR, nC] = size(small);

    % Step 5: build mosaic as a cell array of k-by-k squares
    tiles = cell(nR, nC);
    for r = 1:nR
        for c = 1:nC
            tiles{r, c} = make_tile(small(r, c), k);
        end
    end

    % Step 6: combine
    result = cell2mat(tiles);
end

function sq = make_tile(p, k)
    sq = ones(k);                       % white background
    % Dot area proportional to (1 - p)  ->  radius ~ sqrt(1 - p)
    radius = (k/2) * sqrt(1 - p);
    if radius < 0.5                     % too small to draw: leave white
        return;
    end
    d = fspecial('disk', radius);       % size 2*ceil(radius)+1, may exceed k
    d = d / max(d(:));                  % max value 1.0
    s = size(d, 1);
    if s > k                            % crop symmetrically to fit the square
        t = (s - k) / 2;
        d = d(t+1:end-t, t+1:end-t);
        s = k;
    end
    off = (k - s) / 2;                  % both odd, so integer
    idx = off+1 : off+s;
    sq(idx, idx) = 1 - d;               % flip: black disk on white
end

function result = dot_mosaic_color(im, Size)
    R = dot_mosaic_gray(im(:,:,1), Size);
    G = dot_mosaic_gray(im(:,:,2), Size);
    B = dot_mosaic_gray(im(:,:,3), Size);
    result = cat(3, R, G, B);
end