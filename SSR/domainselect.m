function [location_map] = domainselect(cover_path,recompress_l_path,recompress_h_path)

%preprocessing
C_STRUCT = jpeg_read(cover_path);
C_COEFFS = C_STRUCT.coef_arrays{1};
[m,n]=size(C_COEFFS);
C_STRUCT_l = jpeg_read(recompress_l_path);
C_STRUCT_h = jpeg_read(recompress_h_path);
C_COEFFS_l = C_STRUCT_l.coef_arrays{1};
C_COEFFS_h = C_STRUCT_h.coef_arrays{1};
location_map_l=zeros(8,8);
location_map_h=zeros(8,8);
%fun=@
%
for i=1:floor(m/8)*8
    for j=1:floor(n/8)*8
        x=mod(i,8);y=mod(j,8);
        if x==0
            x=8;
        end
        if y==0
            y=8;
        end
        if (C_COEFFS(i,j)~=0 && C_COEFFS_l(i,j)==0) || (C_COEFFS(i,j)>=0 && C_COEFFS_l(i,j)<0) || (C_COEFFS(i,j)<=0 && C_COEFFS_l(i,j)>0)
            location_map_l(x,y)=location_map_l(x,y)+1;
        end
        if (C_COEFFS(i,j)~=0 && C_COEFFS_h(i,j)==0) || (C_COEFFS(i,j)>=0 && C_COEFFS_h(i,j)<0) || (C_COEFFS(i,j)<=0 && C_COEFFS_h(i,j)>0)
            location_map_h(x,y)=location_map_h(x,y)+1;
        end
    end
end
location_map=location_map_l+location_map_h;
location_map(1,1)=1;
location_map(location_map>0)=1;
%------------------------------------------------------------------------------------------------
end
