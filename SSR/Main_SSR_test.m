clear
clc
addpath(fullfile('E:\Sign_steganography_revisited\JPEG_Toolbox'));
addpath(fullfile('E:\Sign_steganography_revisited\STC'));
%--------------------------------------------------------------------------------
l=60;h=90;%Range against compression attack.
cover_dir='E:\Sign_steganography_revisited\image\cover75\';
% recompress_l_dir =fullfile(['E:\Sign_steganography_revisited\image\recompress',num2str(l),'\']);
% recompress_h_dir =fullfile(['E:\Sign_steganography_revisited\image\recompress',num2str(h),'\']);
% temp_dir='E:\Sign_steganography_revisited\SSR\temp\'; if ~exist(temp_dir,'dir'); mkdir(temp_dir); end
% temp_l_dir=fullfile(['E:\Sign_steganography_revisited\SSR\temp',num2str(l),'\']); if ~exist(temp_l_dir,'dir'); mkdir(temp_l_dir); end
% temp_h_dir=fullfile(['E:\Sign_steganography_revisited\SSR\temp',num2str(h),'\']); if ~exist(temp_h_dir,'dir'); mkdir(temp_h_dir); end
stego_attack_60_dir='E:\Sign_steganography_revisited\SSR\stego_attack_60\'; if ~exist(stego_attack_60_dir,'dir'); mkdir(stego_attack_60_dir); end
stego_attack_65_dir='E:\Sign_steganography_revisited\SSR\stego_attack_65\'; if ~exist(stego_attack_65_dir,'dir'); mkdir(stego_attack_65_dir); end
stego_attack_75_dir='E:\Sign_steganography_revisited\SSR\stego_attack_75\'; if ~exist(stego_attack_75_dir,'dir'); mkdir(stego_attack_75_dir); end
stego_attack_85_dir='E:\Sign_steganography_revisited\SSR\stego_attack_85\'; if ~exist(stego_attack_85_dir,'dir'); mkdir(stego_attack_85_dir); end
stego_attack_90_dir='E:\Sign_steganography_revisited\SSR\stego_attack_90\'; if ~exist(stego_attack_90_dir,'dir'); mkdir(stego_attack_90_dir); end
%-------------------------------------------------------------------------------
for payload=0.01:0.01:0.01
    disp([num2str(payload),'---------------------------------------']);
    stego_dir=fullfile(['E:\Sign_steganography_revisited\SSR\stego_',num2str(payload),'\']); %cif ~exist(stego_dir,'dir'); mkdir(stego_dir); end
    cover_num=100;
    sucess_num=cover_num;
    rand('seed',0); %设置种子
    D = round(rand(1,ceil(payload*512*512))*1); %产生稳定随机数
    %-----------------------------------------------------------------------------
    %需保存的变量
    bit_error1=zeros(cover_num,1);bit_error2=zeros(cover_num,1);bit_error3=zeros(cover_num,1);
    bit_error4=zeros(cover_num,1);bit_error5=zeros(cover_num,1);
    load(['E:\Sign_steganography_revisited\SSR\L_',num2str(payload),'.mat'])%msg_length=zeros(cover_num,1);
    %-------------------------------------------------------------------------------
    parfor i_img=1:cover_num
        try
            disp(i_img);
            %----------------------------------------------------------
            %路径设置
            cover_path = fullfile([cover_dir,'\',num2str(i_img),'.jpg']);
            %temp_path = fullfile([temp_dir,'\',num2str(i_img),'.jpg']);
            stego_path = fullfile([stego_dir,'\',num2str(i_img),'.jpg']);
            %recompress_l_path = fullfile([recompress_l_dir,'\',num2str(i_img),'.jpg']);
            %recompress_h_path = fullfile([recompress_h_dir,'\',num2str(i_img),'.jpg']);
            stego_attack_60_path=fullfile([stego_attack_60_dir,'\',num2str(i_img),'.jpg']);
            stego_attack_65_path=fullfile([stego_attack_65_dir,'\',num2str(i_img),'.jpg']);
            stego_attack_75_path=fullfile([stego_attack_75_dir,'\',num2str(i_img),'.jpg']);
            stego_attack_85_path=fullfile([stego_attack_85_dir,'\',num2str(i_img),'.jpg']);
            stego_attack_90_path=fullfile([stego_attack_90_dir,'\',num2str(i_img),'.jpg']);
            imwrite(imread(stego_path),stego_attack_60_path,'jpg','Quality',60);
            imwrite(imread(stego_path),stego_attack_65_path,'jpg','Quality',65);
            imwrite(imread(stego_path),stego_attack_75_path,'jpg','Quality',75);
            imwrite(imread(stego_path),stego_attack_85_path,'jpg','Quality',85);
            imwrite(imread(stego_path),stego_attack_90_path,'jpg','Quality',90);
            %-------------------------------------------------------------
            %%秘密信息生成
            %C_STRUCT = jpeg_read(cover_path);
            %C_COEFFS = C_STRUCT.coef_arrays{1};
            %nzAC = nnz(C_COEFFS) - nnz(C_COEFFS(1:8:end,1:8:end));
            %raw_msg_len = ceil(payload*nzAC);
            %raw_msg=D(1:raw_msg_len);
            %%---------------------------------------------------------------------------
            %%初次选择嵌入域并嵌入信息
            %[location_map_origin] = domainselect(cover_path,recompress_l_path,recompress_h_path);
            %[rho] = J_UNIWARD_D(cover_path,1);
            %rho=load(['E:\Sign_steganography_revisited\rho\rho_',num2str(i_img),'.mat']);
            %rho=rho.var;
            %[suc] = ssrembed(cover_path,temp_path,raw_msg,location_map_origin,rho);
            %%---------------------------------------------------------------------------
            %%判断是否需要重新选择嵌入域
            %location_map=ones(8,8);
            %for times=1:64
            %temp_l_path=fullfile([temp_l_dir,'\',num2str(i_img),'.jpg']);
            %imwrite(imread(temp_path),temp_l_path,'jpg','Quality',l);%The low QF can be modified.
            %temp_h_path=fullfile([temp_h_dir,'\',num2str(i_img),'.jpg']);
            %imwrite(imread(temp_path),temp_h_path,'jpg','Quality',h);%The high QF can be modified.
            %[location_map_modified] = domainselect(temp_path,temp_l_path,temp_h_path);
            %if all(location_map_origin(location_map_modified>0))==1
            %location_map=location_map_origin;
            %break;
            %else
            %location_map_origin(location_map_modified>0)=1;
            %[suc] = ssrembed(cover_path,temp_path,raw_msg,location_map_origin,rho);
            %end
            %end
            %[suc] = ssrembed(cover_path,stego_path,raw_msg,location_map,rho);
            location_map=load(['E:\Sign_steganography_revisited\SSR\location_map\location_',num2str(payload),'_',num2str(i_img),'.mat']);
            location_map=location_map.var;
            %-------------------------------------------------------------------------------
            %提取信息60
            %[ stc_decoded_msg ] = ssrextract( stego_path,raw_msg_len,location_map );
            [ stc_decoded_msg ] = ssrextract( stego_attack_60_path,msg_length(i_img,1),location_map );
            error=D(1:length(stc_decoded_msg))-double(stc_decoded_msg');
            bit_error1(i_img,1)=sum(error(:)~=0);
            %msg_length(i_img,1)=length(stc_decoded_msg);
            if bit_error1(i_img,1) ~= 0
                disp([num2str(i_img) 'extract error' num2str(bit_error1(i_img,1))]);
            end
            %-------------------------------------------------------------------------------
            %提取信息65
            %[ stc_decoded_msg ] = ssrextract( stego_path,raw_msg_len,location_map );
            [ stc_decoded_msg ] = ssrextract( stego_attack_65_path,msg_length(i_img,1),location_map );
            error=D(1:length(stc_decoded_msg))-double(stc_decoded_msg');
            bit_error2(i_img,1)=sum(error(:)~=0);
            %msg_length(i_img,1)=length(stc_decoded_msg);
            if bit_error2(i_img,1) ~= 0
                disp([num2str(i_img) 'extract error' num2str(bit_error2(i_img,1))]);
            end
            %-------------------------------------------------------------------------------
            %提取信息75
            %[ stc_decoded_msg ] = ssrextract( stego_path,raw_msg_len,location_map );
            [ stc_decoded_msg ] = ssrextract( stego_attack_75_path,msg_length(i_img,1),location_map );
            error=D(1:length(stc_decoded_msg))-double(stc_decoded_msg');
            bit_error3(i_img,1)=sum(error(:)~=0);
            %msg_length(i_img,1)=length(stc_decoded_msg);
            if bit_error3(i_img,1) ~= 0
                disp([num2str(i_img) 'extract error' num2str(bit_error3(i_img,1))]);
            end
            %-------------------------------------------------------------------------------
            %提取信息85
            %[ stc_decoded_msg ] = ssrextract( stego_path,raw_msg_len,location_map );
            [ stc_decoded_msg ] = ssrextract( stego_attack_85_path,msg_length(i_img,1),location_map );
            error=D(1:length(stc_decoded_msg))-double(stc_decoded_msg');
            bit_error4(i_img,1)=sum(error(:)~=0);
            %msg_length(i_img,1)=length(stc_decoded_msg);
            if bit_error4(i_img,1) ~= 0
                disp([num2str(i_img) 'extract error' num2str(bit_error4(i_img,1))]);
            end
            %---------------------------------------------------------------------------
            %提取信息90
            %[ stc_decoded_msg ] = ssrextract( stego_path,raw_msg_len,location_map );
            [ stc_decoded_msg ] = ssrextract( stego_attack_90_path,msg_length(i_img,1),location_map );
            error=D(1:length(stc_decoded_msg))-double(stc_decoded_msg');
            bit_error5(i_img,1)=sum(error(:)~=0);
            %msg_length(i_img,1)=length(stc_decoded_msg);
            if bit_error5(i_img,1) ~= 0
                disp([num2str(i_img) 'extract error' num2str(bit_error5(i_img,1))]);
            end
        catch
            disp([num2str(i_img) 'embeded error']);
            bit_error1(i_img,1)=0;
            bit_error2(i_img,1)=0;
            bit_error3(i_img,1)=0;
            bit_error4(i_img,1)=0;
            bit_error5(i_img,1)=0;
            %msg_length(i_img,1)=0;
            sucess_num=sucess_num-1;
            continue;
        end
    end
    bit_error=[bit_error1,bit_error2,bit_error3,bit_error4,bit_error5];
    save(['E:\Sign_steganography_revisited\SSR\E_',num2str(payload),'.mat'],'bit_error')
    %save(['E:\Sign_steganography_revisited\SSR\L_',num2str(payload),'.mat'],'msg_length')
    save(['E:\Sign_steganography_revisited\SSR\S_',num2str(payload),'.mat'],'sucess_num')
end

%----------------------------------------------------------------------------
sum60=0;sum65=0;sum75=0;sum85=0;sum90=0;
for i=1:cover_num
    if msg_length(i,1)==0
        continue;
    end
    rate60=bit_error(i,1)/msg_length(i,1);
    rate65=bit_error(i,2)/msg_length(i,1);
    rate75=bit_error(i,3)/msg_length(i,1);
    rate85=bit_error(i,4)/msg_length(i,1);
    rate90=bit_error(i,5)/msg_length(i,1);
    sum60=sum60+rate60;
    sum65=sum65+rate65;
    sum75=sum75+rate75;
    sum85=sum85+rate85;
    sum90=sum90+rate90;
end
sum60/sucess_num
sum65/sucess_num
sum75/sucess_num
sum85/sucess_num
sum90/sucess_num