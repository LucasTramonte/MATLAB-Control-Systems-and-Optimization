clear all, close all, clc
% load the data 
load VolumeItems50.txt
V=VolumeItems50;  % vector of the volumes of the items
N=length(V);      % number of items
C = 2.7;          % capacity of the boxes

%Greedy heuristic

% Step 1: Sort items by volume in non-increasing order
[sortedVolumes, sortedIndices] = sort(V, 'descend');

% Initialize variables
Box = struct('NumberBox', {}, 'Items', {}, 'NumberItems', {}, 'UnusedVolume', {});
boxCounter = 0;



    % Step 2: Greedily pack items into boxes
for i = 1:N    
    itemVolume = sortedVolumes(i);    
    placed = false;
    
    % Try to place the item in existing boxes
    for j = 1:boxCounter
        if Box(j).UnusedVolume >= itemVolume
            % Item can fit into this box
            Box(j).Items = [Box(j).Items sortedIndices(i)];
            Box(j).NumberItems = Box(j).NumberItems + 1;
            Box(j).UnusedVolume = Box(j).UnusedVolume - itemVolume;
            placed = true;
            break;
        end
    end
    
    % If the item couldn't be placed in any existing box, create a new box
    if ~placed
        % Check if the item itself exceeds the box capacity
        if itemVolume <= C
            boxCounter = boxCounter + 1;
            Box(boxCounter).NumberBox = boxCounter;
            Box(boxCounter).Items = sortedIndices(i);
            Box(boxCounter).NumberItems = 1;
            Box(boxCounter).UnusedVolume = C - itemVolume;
        else
            % Item cannot be placed in any box, as it exceeds box capacity
            disp(['Item ', num2str(sortedIndices(i)), ' exceeds box capacity.']);
        end
    end
end

disp(['Number of boxes : ', int2str(boxCounter)])
