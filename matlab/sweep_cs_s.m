model = 'quarter_car';
rms = @(x) sqrt(mean(x.^2));

use_random = 1;
cs_list = 2:1:12;

use_skyhook = 0;
base = getsig(sim(model));
holding_p = rms(base.var_tire_disp);
comfort_p = rms(base.var_sprung_acc);

use_skyhook = 1;
holding = zeros(size(cs_list));
comfort = zeros(size(cs_list));
for i = 1:numel(cs_list)
    cs_s = cs_list(i);
    s = getsig(sim(model));
    holding(i) = rms(s.var_tire_disp);
    comfort(i) = rms(s.var_sprung_acc);
end

figure
subplot(2,1,1)
plot(cs_list, holding, 'o-');
yline(holding_p, '--', 'passive');
grid on
ylabel('tire disp RMS [mm]');
title('Road holding vs cs_s (random road)')
subplot(2,1,2)
plot(cs_list, comfort, 'o-');
yline(comfort_p, '--', 'passive');
grid on
ylabel('sprung-acc RMS [mm/s^2]');
xlabel('cs_s [N\cdot s/mm]')

function s = getsig(out)
    log = out.logsout;
    s.t = log.get('var_sprung_acc').Values.Time;
    s.var_sprung_acc = log.get('var_sprung_acc').Values.Data;
    s.var_tire_disp  = log.get('var_tire_disp').Values.Data;
end
