function [ stc_decoded_msg ] = ssrextract( stego_path,raw_msg_len,location_map )

S_STRUCT = jpeg_read(stego_path);
S_COEFFS=S_STRUCT.coef_arrays{1};
[m,n]=size(S_COEFFS);

ptr=0;stego_elements=[];
for i=1:floor(m/8)*8
    for j=1:floor(n/8)*8
        x=mod(i,8);y=mod(j,8);
        if x==0
            x=8;
        end
        if y==0
            y=8;
        end
        if (location_map(x,y)==0 && S_COEFFS(i,j)~=0)
            ptr=ptr+1;
            if(S_COEFFS(i,j)>0)
                stego_elements(ptr)=1;
            else
                stego_elements(ptr)=0;
            end
        end
    end
end

h=10;

stc_decoded_msg = stc_extract(uint8(stego_elements'),raw_msg_len, h);

end



