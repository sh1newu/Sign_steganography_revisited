function [location_map] = elementselect(cover_path,recompress_path)

%preprocessing
C_STRUCT = jpeg_read(cover_path);
C_COEFFS = C_STRUCT.coef_arrays{1};
[m,n]=size(C_COEFFS);
C_STRUCT2 = jpeg_read(recompress_path);
C_COEFFS2 = C_STRUCT2.coef_arrays{1};
location_map=zeros(512,512);

for i=1:m
    for j=1:n
        if ((mod(i,8)==1 && mod(j,8)==1) || C_COEFFS(i,j)==0 || C_COEFFS2(i,j)==0)
            location_map(i,j)=1;
        end
    end
end

%------------------------------------------------------------------------------------------------
end
