face_folder = 'C:\Users\mandar pande\Documents\MATLAB\Face';  %LOCATION OF FACE IMAGES
file_ext = '.pgm';
out_max = 0.9;  % DESIRED OUTPUT FOR DETECTING A FACE          
out_min = -0.9; % DESIRED OUTPUT FOR NOT DETECTING A FACE      
if exist('imgdb.mat','file')
    load imgdb;
else
    IMGDB = cell (3,[]);
    cellplot(IMGDB);
end
fprintf ('Loading Faces...');
folder_content = dir ([face_folder,'*',file_ext]);
nface = size (folder_content,1);
string = [face_folder,folder_content(k,1).name];
    image = imread(string);    
    [m,n] = size(image);
    if (m~=112 || n~=92)
        continue;
    end
    f=0;
    for i=1:length(IMGDB)
        if strcmp(IMGDB{1,i},string)
            f=1;
        end
    end
    if f==1
        continue;
    end
    fprintf ('.');    
    IM {1} = im2vec (image);% ORIGINAL FACE IMAGE
    IM {2} = im2vec (fliplr(image));    % MIRROR OF THE FACE 
    IM {3} = im2vec (circshift(image,1)); 
    IM {4} = im2vec (circshift(image,-1));
    IM {5} = im2vec (circshift(image,[0 1]));
    IM {6} = im2vec (circshift(image,[0 -1]));
    IM {7} = im2vec (circshift(fliplr(image),1));
    IM {8} = im2vec (circshift(fliplr(image),-1));
    IM {9} = im2vec (circshift(fliplr(image),[0 1]));
    IM {10} = im2vec (circshift(fliplr(image),[0 -1]));
     for i=1:10
        IMGDB {1,end+1}= string;
        IMGDB {2,end} = out_max;
        IMGDB (3,end) = {IM{i}};
     end    
     