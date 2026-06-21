model   = 'quarter_car';
res_src = 'Controls_Plant.res';
roads   = ["step","random"];
rms     = @(x) sqrt(mean(x.^2));

for use_random = [0 1]
    road_name = roads(use_random+1);

    use_skyhook = 0;
    passive = getsig(sim(model));
    copyfile(res_src, sprintf('%s_passive.res', road_name));

    use_skyhook = 1;
    skyhook = getsig(sim(model));
    copyfile(res_src, sprintf('%s_skyhook.res', road_name));

    comfort_p = rms(passive.var_sprung_acc);
    comfort_s = rms(skyhook.var_sprung_acc);
    holding_p = rms(passive.var_tire_disp);
    holding_s = rms(skyhook.var_tire_disp);
    stroke_p  = rms(passive.var_susp_stroke);
    stroke_s  = rms(skyhook.var_susp_stroke);

    fprintf('=== %s ===\n', road_name);
    fprintf('metric            passive   skyhook\n');
    fprintf('comfort [mm/s^2]  %8.3f  %8.3f\n',   comfort_p, comfort_s);
    fprintf('holding [mm]      %8.3f  %8.3f\n',   holding_p, holding_s);
    fprintf('stroke  [mm]      %8.3f  %8.3f\n\n', stroke_p,  stroke_s);

    figure('Name',road_name)
    subplot(3,1,1)
    plot(passive.t, passive.var_sprung_acc, skyhook.t, skyhook.var_sprung_acc);
    grid on
    ylabel('sprung acc [mm/s^2]'); legend('passive','skyhook');
    title(road_name)
    subplot(3,1,2)
    plot(passive.t, passive.var_susp_stroke, skyhook.t, skyhook.var_susp_stroke);
    grid on
    ylabel('susp stroke [mm]')
    subplot(3,1,3)
    plot(passive.t, passive.var_tire_disp, skyhook.t, skyhook.var_tire_disp);
    grid on
    ylabel('tire disp [mm]');
    xlabel('time [s]')
end

function s = getsig(out)
    log = out.logsout;
    s.t = log.get('var_sprung_acc').Values.Time;
    s.var_sprung_acc = log.get('var_sprung_acc').Values.Data;
    s.var_susp_stroke = log.get('var_susp_stroke').Values.Data;
    s.var_tire_disp = log.get('var_tire_disp').Values.Data;
end