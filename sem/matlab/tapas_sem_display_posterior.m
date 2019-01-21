function [] = tapas_sem_display_posterior(posterior)
%% Displays a summary of the posterior estimates.
%
% Input
%       posterior       -- Estimate from the model.
% Output
%       

% aponteeduardo@gmail.com
% copyright (C) 2019
%

% Plot the data.
data = posterior.data;
try
    model = posterior.model.graph{1}.htheta.model;
catch err
    try
        model = posterior.ptheta;
    catch
        error('tapas:sem:display_posterior', 'Improper input')
    end
end

for i = 1:numel(data)
    fig = figure('name', sprintf('Subject #%d', i));

    [edges] = tapas_sem_plot_antisaccades(data(i).y, data(i).u);
    dt = edges(2) - edges(1);
    samples = posterior.ps_theta(i, :);
    fits = tapas_sem_generate_fits(data(i), samples, model);
    tapas_sem_plot_fits(data(i), fits, dt)
    format_figure(fig, data(i), fits, model);
end

end

function format_figure(fig, data, fits, model)

fig.Color = 'w';

conds = unique(data.u.tt);
nconds = numel(conds);

for i = 1:nconds
    ax = subplot(nconds, 2, (i - 1) * 2 + 1);
    title(sprintf('Pro. condition %d', i));
    ylabel('# saccs.')
    xlabel('time')
    ax = subplot(nconds, 2, (i - 1) * 2 + 2);
    title(sprintf('Anti. condition %d', i));
    ylabel('# saccs.')
    xlabel('time')
end

end