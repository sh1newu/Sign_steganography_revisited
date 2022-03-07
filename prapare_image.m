clear
clc
cover_num=100;
file0_dir = 'E:\Sign_steganography_revisited\image\BOSSbase_1.01\';
file1_dir = 'E:\Sign_steganography_revisited\image\cover75\';if ~exist(file1_dir,'dir'); mkdir(file1_dir); end
file60_dir = 'E:\Sign_steganography_revisited\image\recompress60\';if ~exist(file60_dir,'dir'); mkdir(file60_dir); end
file61_dir = 'E:\Sign_steganography_revisited\image\recompress61\';if ~exist(file61_dir,'dir'); mkdir(file61_dir); end
file62_dir = 'E:\Sign_steganography_revisited\image\recompress62\';if ~exist(file62_dir,'dir'); mkdir(file62_dir); end
file63_dir = 'E:\Sign_steganography_revisited\image\recompress63\';if ~exist(file63_dir,'dir'); mkdir(file63_dir); end
file64_dir = 'E:\Sign_steganography_revisited\image\recompress64\';if ~exist(file64_dir,'dir'); mkdir(file64_dir); end
file65_dir = 'E:\Sign_steganography_revisited\image\recompress65\';if ~exist(file65_dir,'dir'); mkdir(file65_dir); end
file66_dir = 'E:\Sign_steganography_revisited\image\recompress66\';if ~exist(file66_dir,'dir'); mkdir(file66_dir); end
file67_dir = 'E:\Sign_steganography_revisited\image\recompress67\';if ~exist(file67_dir,'dir'); mkdir(file67_dir); end
file68_dir = 'E:\Sign_steganography_revisited\image\recompress68\';if ~exist(file68_dir,'dir'); mkdir(file68_dir); end
file69_dir = 'E:\Sign_steganography_revisited\image\recompress69\';if ~exist(file69_dir,'dir'); mkdir(file69_dir); end
file70_dir = 'E:\Sign_steganography_revisited\image\recompress70\';if ~exist(file70_dir,'dir'); mkdir(file70_dir); end
file71_dir = 'E:\Sign_steganography_revisited\image\recompress71\';if ~exist(file71_dir,'dir'); mkdir(file71_dir); end
file72_dir = 'E:\Sign_steganography_revisited\image\recompress72\';if ~exist(file72_dir,'dir'); mkdir(file72_dir); end
file73_dir = 'E:\Sign_steganography_revisited\image\recompress73\';if ~exist(file73_dir,'dir'); mkdir(file73_dir); end
file74_dir = 'E:\Sign_steganography_revisited\image\recompress74\';if ~exist(file74_dir,'dir'); mkdir(file74_dir); end
file75_dir = 'E:\Sign_steganography_revisited\image\recompress75\';if ~exist(file75_dir,'dir'); mkdir(file75_dir); end
file85_dir = 'E:\Sign_steganography_revisited\image\recompress85\';if ~exist(file85_dir,'dir'); mkdir(file85_dir); end
file90_dir = 'E:\Sign_steganography_revisited\image\recompress90\';if ~exist(file90_dir,'dir'); mkdir(file90_dir); end
parfor i_img=1:cover_num
    disp(i_img);
    file0_path = fullfile([file0_dir,num2str(i_img),'.pgm']);
    file1_path = fullfile([file1_dir,num2str(i_img),'.jpg']);
    imwrite(imread(file0_path),file1_path,'jpg','Quality',75);
    %------------------------------------------------------------------
    file60_path = fullfile([file60_dir,num2str(i_img),'.jpg']);  
    file61_path = fullfile([file61_dir,num2str(i_img),'.jpg']);
    file62_path = fullfile([file62_dir,num2str(i_img),'.jpg']);
    file63_path = fullfile([file63_dir,num2str(i_img),'.jpg']);
    file64_path = fullfile([file64_dir,num2str(i_img),'.jpg']);
    file65_path = fullfile([file65_dir,num2str(i_img),'.jpg']);
    file66_path = fullfile([file66_dir,num2str(i_img),'.jpg']);
    file67_path = fullfile([file67_dir,num2str(i_img),'.jpg']);
    file68_path = fullfile([file68_dir,num2str(i_img),'.jpg']);
    file69_path = fullfile([file69_dir,num2str(i_img),'.jpg']);
    file70_path = fullfile([file70_dir,num2str(i_img),'.jpg']);
    file71_path = fullfile([file71_dir,num2str(i_img),'.jpg']);
    file72_path = fullfile([file72_dir,num2str(i_img),'.jpg']);
    file73_path = fullfile([file73_dir,num2str(i_img),'.jpg']);
    file74_path = fullfile([file74_dir,num2str(i_img),'.jpg']);
    file75_path = fullfile([file75_dir,num2str(i_img),'.jpg']);
    file85_path = fullfile([file85_dir,num2str(i_img),'.jpg']);
    file90_path = fullfile([file90_dir,num2str(i_img),'.jpg']);
    %------------------------------------------------------------------
    imwrite(imread(file1_path),file60_path,'jpg','Quality',60);
    imwrite(imread(file1_path),file61_path,'jpg','Quality',61);
    imwrite(imread(file1_path),file62_path,'jpg','Quality',62);
    imwrite(imread(file1_path),file63_path,'jpg','Quality',63);
    imwrite(imread(file1_path),file64_path,'jpg','Quality',64);
    imwrite(imread(file1_path),file65_path,'jpg','Quality',65);
    imwrite(imread(file1_path),file66_path,'jpg','Quality',66);
    imwrite(imread(file1_path),file67_path,'jpg','Quality',67);
    imwrite(imread(file1_path),file68_path,'jpg','Quality',68);
    imwrite(imread(file1_path),file69_path,'jpg','Quality',69);
    imwrite(imread(file1_path),file70_path,'jpg','Quality',70);
    imwrite(imread(file1_path),file71_path,'jpg','Quality',71);
    imwrite(imread(file1_path),file72_path,'jpg','Quality',72);
    imwrite(imread(file1_path),file73_path,'jpg','Quality',73);
    imwrite(imread(file1_path),file74_path,'jpg','Quality',74);
    imwrite(imread(file1_path),file75_path,'jpg','Quality',75);
    imwrite(imread(file1_path),file85_path,'jpg','Quality',85);
    imwrite(imread(file1_path),file90_path,'jpg','Quality',90);
end
