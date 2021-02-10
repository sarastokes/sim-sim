function p = viewMesh3(vol)

    figure(); hold on;
    p = patch(isosurface(vol),...
        'FaceColor', rgb('green blue'),...
        'EdgeColor', 'none');
    material dull;
    lightangle(45, 30); lightangle(225, 30);
    grid on;
    view(3);
