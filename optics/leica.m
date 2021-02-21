function S = leica(obj)
    % LEICA
    %
    % Description:
    %   Get parameters associated with Leica confocal data
    %
    % Syntax:
    %   S = leica(objective)
    %
    % History:
    %   20Feb2021 - SSP
    % ---------------------------------------------------------------------

    S = struct();
    switch obj 
        case 10
            S.NA = 0.4;
            S.n = 1;
            S.voxelSize = [0.4212, 0.4212, 2.413];
        case 20
            S.NA = 0.75;
            S.n = 1.518;
            S.voxelSize = [0.2727, 0.2727, 0.7486];
        otherwise
            error('%ux objective not found', obj);
    end