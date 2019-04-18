function[final] = hsvHistogram(imagine, count_bins)
	img1 = imread(imagine);
	matR = img1(:,:,1);
	matG = img1(:,:,2);
	matB = img1(:,:,3);

	matR = double(matR)./255;
	matG = double(matG)./255;
	matB = double(matB)./255;

	val_max = numel(matR); % nr de elemente din matrice
	
	for i = 1:val_max
		r = matR(i);
		g = matG(i);
		b = matB(i);
		v = [r, g, b];
		Cmax = max(v);
		Cmin = min(v);
		delta = Cmax - Cmin;
		
		if delta == 0
			H(i) = 0;
		elseif Cmax == r
			H(i) = double(60 * mod((g - b)/delta, 6));
		elseif Cmax == g
			H(i) = double(60 * (((b - r)/delta) + 2));
		elseif Cmax == b
			H(i) = double(60*(((r - g)/delta) + 4));
		end

		H(i) = double(H(i)/360);

		if Cmax == 0
			S(i) = 0;
		else
			S(i) = double(delta/Cmax);
		end
		V(i) = Cmax;
	end

	j = 1;
	n = 1.01/count_bins;

	for i = 0:count_bins-1
		inf = n*i;
		sup = n*(i+1);

		% pentru H
		aux1 = H(H >= inf);
		aux2 = aux1(aux1 < sup);
		vH(j) = length(aux2);

		% pentru S
		aux1 = S(S >= inf);
		aux2 = aux1(aux1 < sup);
		vS(j) = length(aux2);

		% pentru V
		aux1 = V(V >= inf);
		aux2 = aux1(aux1 < sup);
		vV(j) = length(aux2);
		
		j = j + 1;
	end
	final = [vH, vS, vV];
endfunction