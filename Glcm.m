function r=Glcm(rgb1)
%%
rgb1 = rgb2gray(rgb1);
i = rgb1;
glcm = graycomatrix(i);
t = graycoprops(glcm);
r = [t.Contrast t.Correlation t.Energy t.Homogeneity];