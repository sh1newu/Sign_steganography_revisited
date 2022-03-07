function [ stc_decoded_msg ] = ssextract( stego_path,msg_len,location_map )

S_STRUCT = jpeg_read(stego_path);
S_COEFFS=S_STRUCT.coef_arrays{1};
[m,n]=size(S_COEFFS);

ptr=0;stego_elements=[];
for i=1:m
    for j=1:n
        if location_map(i,j)==0
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

stc_decoded_msg = stc_extract(uint8(stego_elements'),msg_len, h);

end



