clear
clc
cover_num=100;
addpath(fullfile('E:\Sign_steganography_revisited\JPEG_Toolbox'));
cover_dir='E:\Sign_steganography_revisited\image\cover75\';
rho_dir='E:\Sign_steganography_revisited\rho\';if ~exist(rho_dir,'dir'); mkdir(rho_dir); end
parfor i_img=1:cover_num
    disp(i_img);
    cover_path = fullfile([cover_dir,'\',num2str(i_img),'.jpg']);
    [rho] = J_UNIWARD_D(cover_path,1);
    parsave(['E:\Sign_steganography_revisited\rho\rho_',num2str(i_img),'.mat'],rho);
end
