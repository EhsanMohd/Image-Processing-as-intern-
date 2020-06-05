%function [outs] = novel_feature_descriptor(no_of_images,no_of_classes,)
  % ask number of bins for H channel quantization 
  %H_bins = input(prompt("18/36/72"))
  % ask number of bins for S channel quantization 
  %S_bins = input(prompt("10/20"))
  db_fv(1,:) = zeros(1,284);
  for i=1:1000
     %1000 = length of the database
       img_path= strcat('C:\Users\ehsan\Documents\research\cbir at nitw\image database\IMAGE DATABASE\1. Corel-1000\',int2str(i),'jpg');
       img = imread(img_path);
       db_fv(i,:) = img;
  end
    % read images and store in variables
  %img = imread(path);
  %convert image from rgb space to hsv space 
  img = imread('C:\Users\ehsan\Documents\research\cbir at nitw\image database\IMAGE DATABASE\1. Corel-1000\1');
  img1 = rgb2hsv(img);

  % read the query image 
  %q_image0 = input(prompt("enter the query image's path"));
  %q_image = imread(q_image0);
  % extracting saturation value at pixel location i,j
  S_value = img1(:,:,2);
  H=[1,H_bins];
  % statistical feature extraction from the images in database using glcm 
  % implementation of glcm  - extracts 24 features 
  % builtin function in matlab : 
  glcm = graycomatrix(img,'NumLevels',16,'GrayLimits',[]);
  % we have to apply DSCop 
  %extracting the hue matrix from the hsv scaled image img1
  Hue = img1(:,:,1);
  %extracting the saturation matrix from the hsv scaled imafe img1 
  Sat = img1(:,:,2);
  Val = img1(:,:,3);
  %M(l,m) = numel( (a,b),(c,d) where I(a,b) = l , I(c,d) = m );
  %(a,b) ,(c,d) belongs to Ha x Hb 
   %(c,d) = (a + k*si1 , b + k*si2)
   val_pad=padarray(v,[1,1],0,'replicate');
for i=2:size(Val,1)
    for j=2:size(Val,2)
        for m=i-1:i+1
            for n=j-1:j+1
                val_pad(m,n)=val_pad(m,n)-val_pad(i,j);
            end
        end
    end
end
a=zeros(1,6);
for i=2:size(Val,1)
    for j=2:size(Val,2)
       %a81
       a(4) = val_pad(i-1,j-1) * val_pad(i+1,j+1);
       %a11
       a(6)= val_pad(i,j-1) * val_pad(i+1,j);
       %a71
       a(5)= val_pad(i-1,j) * val_pad(i,j+1);
       %a32
       a(3)= val_pad(i,j-1) * val_pad(i-1,j);
       %a22
       a(2)= val_pad(i+1,j-1) * val_pad(i-1,j+1);
       %a12
       a(1)= val_pad(i,j+1) * val_pad(i+1,j);
       for h=1:6
           if(a(h)>=0)
               a(h)=1;
           else
               a(h)=0;
           end
       end
       sum=0;
       d1=0;
       for k=1:6
           d1=a(k) * 2^(k-1);
           sum=sum+d1;
       end
       val_pad(i,j)=sum;
    end
end
  % wavelet tranform for extracting image's texture - data compression 
  % here we use dwt for image searching and indexing 
  % gabor wavelet corellogram as a rotation invariant feature
  glcm = graycomatrix(img,'NumLevels',16,'GrayLimits',[]);
      % imported code 
     % function featureVector = gaborFeatures(img,gaborArray,d1,d2)
  s_vector = zeros(1,S_bins);
  for i=1:size(img,1)
    for j=1:size(img,2)
      bin = Sat(i,j)*18;
      if(bin==0)
      bin=1;
    end
    s_vector(bin) = s_vector(bin) + Sat(i,j);
  end 
end
  h_vector = zeros(1,H_bins);
  for i=1:size(img,1)
    for j=1:size(img,2)
      bin = Hue(i,j)*18;
      if(bin==0)
      bin=1;
    end
    h_vector(bin) = h_vector(bin) + Hue(i,j);
  end 
end
  featureVector = zeroes(1,H_bins+S_bins+16)
  for i=1:H_bins
    featureVector(i) = s_vector(i)
  end 
  for i=H_bins:H_bins+S_bins
    featureVector(i) = h_vector(i)
  end
  for i=H_bins+S_bins:H_bins+S_bins+16
   featureVector(i) = v_vector(i)
   %function for precision and recall 
  end 
  sum = zeros(no_of_images,1)
  for i=1:no_of_images
    for j=1:284
      diffd(i,j)=abs((double(f_vectord(i,j))-double(f_vector(ni,j)))/(1+double(f_vectord(i,j))+double(f_vector(ni,j))));
    end
    for j=1:284
        sum(i,1)=sum(i,1)+diffd(i,j);
        sum(i,2)=i;
    end
end
disp(sum);
% images are ranked 
for i=1:no_of_images
    for j=i+1:no_of_images
        if(sum(i,1)>sum(j,1))
            temp=sum(i,1);
            sum(i,1)=sum(j,1);
            sum(j,1)=temp;
             temp1=sum(i,2);
            sum(i,2)=sum(j,2);
            sum(j,2)=temp1;
        end
    end
end
disp(recall)
disp(precision)
 
 
   
    