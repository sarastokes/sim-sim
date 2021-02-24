function equalSpanAxes(ax)
    % EQUALSPANAXES
    %
    % Syntax:
    %   equalSpanAxes(ax)
    %
    % History:
    %   21Feb2021 - SSP
    % ---------------------------------------------------------------------

    lims = [diff(ax.XLim), diff(ax.YLim)];
    [~, loc] = min(lims);

    if loc == 1
        ax.XLim(2) = ax.XLim(2) + abs(diff(lims));
    else
        ax.YLim(2) = ax.YLim(2) + abs(diff(lims));
    end