% Parzen - compute 2-D density estimates
%
% [p,x,y] = parzen( data, res, win )
%
%  data - two-column matrix of (x,y) points
%         (third row/col optional point frequency)
%  res  - resolution (step size)
%         optionally [res lowx lowy highx highy]
%  win  - optional, gives form of window
%          if a scalar - radius of square window
%          if a vector - radially symmetric window
%          if a matrix - actual 2D window shape
%
%  x    - locations along x-axis
%  y    - locations along y-axis
%  p    - estimated 2D PDF
%
% P. Fieguth
% Nov. 1997
%
%   Further documentation:
%
%   [p,x,y] = parzen( data, res, win )
%
%   Input Parameters:
%
%     data - a two-column matrix; each row [x y] defines one point
%
%     res  - determines the spatial step between PDF estimates
%            This should be a vector of five values  [res lowx lowy highx highy],
%            giving the limits along the x and y axes for which the PDF should be
%            estimated.
%            For example, to estimate a PDF over -1 < x < 1  and 3 < y < 7,
%            and the estimates should be spaced 0.01 units apart, then the
%            vector should be  [0.01 -1 3 1 7]
%
%     win  - The code says this is optional, but the default window in the code
%            is not the one you need to use for lab 2, so that means this is NOT
%            optional.
%            You should define the window as a matrix.  For example, a rectangular
%            window would be the easiest one to do.  To get a 10x10 rectangular
%            window we would pass in ones(10,10).  In your case you need a Gaussian
%            window - this takes a bit more thought:  how do you create a matrix
%            with a Gaussian shape?  How big should the matrix be?
%
%   Returned Parameters:
%
%     x    - estimated locations along x-axis; this is just  [lowx:res(1):highx]
%     y    - estimated locations along y-axis; this is just  [lowy:res(1):highy]
%     p    - estimated 2D PDF, a matrix of values

function [p,x,y] = parzen( data, res, win )

if (size(data,2)>size(data,1)), data = data'; end;
if (size(data,2)==2), data = [data ones(size(data))]; end;
numpts = sum(data(:,3));

dl = min(data(:,1:2));
dh = max(data(:,1:2));
if length(res)>1, dl = [res(2) res(3)]; dh = [res(4) res(5)]; res = res(1); end;

if (nargin == 2), win = 10; end;
if (max(dh-dl)/res>1000),
    error('Excessive data range relative to resolution.');
end;

if length(win)==1, win = ones(1,win); end;
if min(size(win))==1, win = win(:) * win(:)'; end;
win = win / (res*res*sum(sum(win)));

p = zeros(2+(dh(2)-dl(2))/res,2+(dh(1)-dl(1))/res);
fdl1 = find(data(:,1)>dl(1));
fdh1 = find(data(fdl1,1)<dh(1));
fdl2 = find(data(fdl1(fdh1),2)>dl(2));
fdh2 = find(data(fdl1(fdh1(fdl2)),2)<dh(2));

for i=fdl1(fdh1(fdl2(fdh2)))',
    j1 = round(1+(data(i,1)-dl(1))/res);
    j2 = round(1+(data(i,2)-dl(2))/res);
    p(j2,j1) = p(j2,j1) + data(i,3);
end;

p = conv2(p,win,'same')/numpts;
x = [dl(1):res:(dh(1)+res)]; x = x(1:size(p,2));
y = [dl(2):res:(dh(2)+res)]; y = y(1:size(p,1));
