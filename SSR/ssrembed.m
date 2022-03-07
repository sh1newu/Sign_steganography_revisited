function [ suc ] = ssrembed(cover_path,stego_path,raw_msg,location_map,rho)
%---------------------------------------------------------------------------------------------
h = 10;      % use STCs with constraint_height = 10. Try values between 7 and 12.
%wetConst = 10^13;
C_STRUCT = jpeg_read(cover_path);
C_COEFFS = C_STRUCT.coef_arrays{1};
[m,n]=size(C_COEFFS);
%-----------------------------------------------------------------------------------------------
%载体选择
cover=[];cost=[];ptr=0;
for i=1:floor(m/8)*8
    for j=1:floor(n/8)*8
        x=mod(i,8);y=mod(j,8);
        if x==0
            x=8;
        end
        if y==0
            y=8;
        end
        if (location_map(x,y)==0 && C_COEFFS(i,j)~=0)
            ptr=ptr+1;
            cover(ptr)=C_COEFFS(i,j);
            %cost(ptr)=abs(cover(ptr))*rho(i,j); %1
            cost(ptr)=power(abs(cover(ptr)),2)*rho(i,j); %2
            %cost(ptr)=power(abs(cover(ptr)),3)*rho(i,j); %3
            %cost(ptr)=power(abs(cover(ptr)),4)*rho(i,j); %4
            %cost(ptr)=power(abs(cover(ptr)),5)*rho(i,j); %5
        end
    end
end
cover(cover>0)=1;
cover(cover<0)=0;
% if raw_msg_len>length(cover)/2
% error('The relative payload is greater than 1/2. This may result in poor embedding efficiency.')
% end
%----------------------------------------------------------------------------------
%STC2

 [d, stego_elements] = stc_embed(uint8(cover'),uint8(raw_msg'),cost, h);
 stc_decoded_msg = stc_extract(uint8(stego_elements),length(raw_msg), h);
%% 验证STC解码是否正常工作
if all(uint8(raw_msg') == stc_decoded_msg)
    %disp('Message can be extracted by STC2 correctly.');
else
    error('Some error occured in the extraction process of STC2.');
end
%-------------------------------------------------------------------------------
%实际修改
ptr=0;S_COEFFS=C_COEFFS;
for i=1:floor(m/8)*8
    for j=1:floor(n/8)*8
        x=mod(i,8);y=mod(j,8);
        if x==0
            x=8;
        end
        if y==0
            y=8;
        end
        if (location_map(x,y)==0 && C_COEFFS(i,j)~=0)
            ptr=ptr+1;
            if(stego_elements(ptr)==0)
                S_COEFFS(i,j)=-abs(C_COEFFS(i,j));
            else
                S_COEFFS(i,j)=abs(C_COEFFS(i,j));
            end
        end
    end
end
    S_STRUCT=C_STRUCT;
    S_STRUCT.coef_arrays{1}=S_COEFFS;
    jpeg_write(S_STRUCT, stego_path); 
    suc=1;
end
