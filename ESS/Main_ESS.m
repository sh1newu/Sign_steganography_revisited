clear
clc
addpath(fullfile('E:\Sign_steganography_revisited\JPEG_Toolbox'));
addpath(fullfile('E:\Sign_steganography_revisited\STC'));
%--------------------------------------------------------------------------------
cover_dir='E:\Sign_steganography_revisited\image\cover75\';
recompress_dir='E:\Sign_steganography_revisited\image\recompress';%if ~exist(recompress_dir,'dir'); mkdir(recompress_dir); end %中间图像所在的文件夹
temp_dir='E:\Sign_steganography_revisited\ESS\temp\'; if ~exist(temp_dir,'dir'); mkdir(temp_dir); end
% stego_attack_60_dir='E:\Sign_steganography_revisited\ESS\stego_attack_60\'; if ~exist(stego_attack_60_dir,'dir'); mkdir(stego_attack_60_dir); end
% stego_attack_65_dir='E:\Sign_steganography_revisited\ESS\stego_attack_65\'; if ~exist(stego_attack_65_dir,'dir'); mkdir(stego_attack_65_dir); end
% stego_attack_75_dir='E:\Sign_steganography_revisited\ESS\stego_attack_75\'; if ~exist(stego_attack_75_dir,'dir'); mkdir(stego_attack_75_dir); end
% stego_attack_85_dir='E:\Sign_steganography_revisited\ESS\stego_attack_85\'; if ~exist(stego_attack_85_dir,'dir'); mkdir(stego_attack_85_dir); end
% stego_attack_90_dir='E:\Sign_steganography_revisited\ESS\stego_attack_90\'; if ~exist(stego_attack_90_dir,'dir'); mkdir(stego_attack_90_dir); end
for payload=0.01:0.01:0.01
    disp([num2str(payload),'---------------------------------------']);
    stego_dir=fullfile(['E:\Sign_steganography_revisited\ESS\stego_',num2str(payload),'\']); if ~exist(stego_dir,'dir'); mkdir(stego_dir); end
    cover_num=100;
    sucess_num=cover_num;
    rand('seed',0); %设置种子
    D = round(rand(1,ceil(payload*512*512))*1); %产生稳定随机数
    nn = 31; kk = 15; mm = 5;% RS编码参数
    %-----------------------------------------------------------------------------
    %需保存的变量
    bit_error=zeros(cover_num,1);
    msg_length=zeros(cover_num,1);
    if ~exist('E:\Sign_steganography_revisited\ESS\location_map','dir'); mkdir('E:\Sign_steganography_revisited\ESS\location_map'); end %location_map所在的文件夹
    %-------------------------------------------------------------------------------
    parfor i_img=1:cover_num
        try
            disp(i_img);
            %----------------------------------------------------------
            %路径设置
            cover_path = fullfile([cover_dir,'\',num2str(i_img),'.jpg']);
            stego_path = fullfile([stego_dir,'\',num2str(i_img),'.jpg']);
            temp_path = fullfile([temp_dir,'\',num2str(i_img),'.jpg']);
            %stego_attack_60_path=fullfile([stego_attack_60_dir,'\',num2str(i_img),'.jpg']);
            %stego_attack_65_path=fullfile([stego_attack_65_dir,'\',num2str(i_img),'.jpg']);
            %stego_attack_75_path=fullfile([stego_attack_75_dir,'\',num2str(i_img),'.jpg']);
            %stego_attack_85_path=fullfile([stego_attack_85_dir,'\',num2str(i_img),'.jpg']);
            %stego_attack_90_path=fullfile([stego_attack_90_dir,'\',num2str(i_img),'.jpg']);
            %imwrite(imread(stego_path),stego_attack_60_path,'jpg','Quality',60);
            %imwrite(imread(stego_path),stego_attack_65_path,'jpg','Quality',65);
            %imwrite(imread(stego_path),stego_attack_75_path,'jpg','Quality',75);
            %imwrite(imread(stego_path),stego_attack_85_path,'jpg','Quality',85);
            %imwrite(imread(stego_path),stego_attack_90_path,'jpg','Quality',90);
            %-------------------------------------------------------------
            %秘密信息生成
            C_STRUCT = jpeg_read(cover_path);
            C_COEFFS = C_STRUCT.coef_arrays{1};
            nzAC = nnz(C_COEFFS) - nnz(C_COEFFS(1:8:end,1:8:end));
            raw_msg_len = ceil(ceil(payload*nzAC)/kk/mm)*kk*mm;
            raw_msg=D(1:raw_msg_len); %原始秘密信息的行向量
            %---------------------------------------------------------------------------
            %The secret information is encoded using RS(31,15)
            [rs_encoded_msg] = rs_encode_yxz(raw_msg,nn,kk);
            %rho = J_UNIWARD_D(cover_path,1);%使用J_UNIWARD隐写算法计算DCT系数的嵌入代价
            rho=load(['E:\Sign_steganography_revisited\rho\rho_',num2str(i_img),'.mat']);
            rho=rho.var;
            %------------------------------------------------------------------------------------------
            for k=1:10
                t=76-k;%
                recompress_path=fullfile([ recompress_dir,num2str(t),'\',num2str(i_img),'.jpg']);
                [location_map] = elementselect(cover_path,recompress_path);
                [ suc ] = ssembed(cover_path,temp_path,rs_encoded_msg,location_map,rho);
                temp=imread(temp_path);
                imwrite(temp,temp_path,'jpg','quality',75);%
                %-------------------------------------------------------------------------------
                %提取信息%结果判断并保存结果
                %STC extraction
                [ stc_decoded_msg ] = ssextract( temp_path,length(rs_encoded_msg),location_map );
                %[stc_decoded_msg] = ssextract(stego_attack_60_path, temp1(i_img,1),location_map);
                %decode message by RS锛?1,15锛?
                [rs_decoded_msg] = rs_decode_yxz(double(stc_decoded_msg'), nn, kk);
                error=D(1:length(rs_decoded_msg))-double(rs_decoded_msg);
                if sum(error(:)~=0)==0
                    break;
                end
            end
            parsave(['E:\Sign_steganography_revisited\ESS\location_map\location_',num2str(payload),'_',num2str(i_img),'.mat'],location_map);
            [ suc ] = ssembed(cover_path,stego_path,rs_encoded_msg,location_map,rho);
            %-------------------------------------------------------------------------------
            %提取信息%结果判断并保存结果
            %  STC extraction
            [ stc_decoded_msg ] = ssextract( stego_path,length(rs_encoded_msg),location_map );
            %[stc_decoded_msg] = ssextract(stego_attack_60_path, temp1(i_img,1),location_map);
            %  decode message by RS锛?1,15锛?
            [rs_decoded_msg] = rs_decode_yxz(double(stc_decoded_msg'), nn, kk);
            error=D(1:length(rs_decoded_msg))-double(rs_decoded_msg);
            bit_error(i_img,1)=sum(error(:)~=0);
            msg_length(i_img,1)=length(rs_encoded_msg);
            if bit_error(i_img,1) ~= 0
                disp([num2str(i_img) 'extract error' num2str(bit_error(i_img,1))]);
            end
            %-----------------------------------------------------------------------------
        catch
            disp([num2str(i_img) 'embeded error']);
            bit_error(i_img,1)=0;
            msg_length(i_img,1)=0;
            sucess_num=sucess_num-1;
            continue;
        end
    end
    save(['E:\Sign_steganography_revisited\ESS\E_',num2str(payload),'.mat'],'bit_error')
    save(['E:\Sign_steganography_revisited\ESS\L_',num2str(payload),'.mat'],'msg_length')
    save(['E:\Sign_steganography_revisited\ESS\S_',num2str(payload),'.mat'],'sucess_num')
end