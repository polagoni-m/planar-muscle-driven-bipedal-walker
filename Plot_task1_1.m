% Plotting Script for HW2 Task 1-1 
% Forces white background and black text to match the example style.

if ~exist('out', 'var')
    error('Run the simulation first!');
end

% Extract Data
try
    % Kinematics
    p_HL = out.log_phi_H_L; p_HR = out.log_phi_H_R;
    p_KL = out.log_phi_K_L; p_KR = out.log_phi_K_R;
    % Torques
    t_NetH = out.log_T_Hip_Net; t_GLU = out.log_T_GLU; t_HFL = out.log_T_HFL;
    t_NetK = out.log_T_Knee_Net; t_VAS = out.log_T_VAS; t_BFSH = out.log_T_BFSH;
catch
    error('Missing logged data! Check your "To Workspace" blocks.');
end

% 1. Create Figure with forced White Background
fig = figure('Name', 'Task 1-1: Muscle Driven Walker', 'Color', 'w', 'Position', [100 50 800 900]);


% --- Subplot 1: Hip Joint Angles ---
ax1 = subplot(4,1,1);
plot(p_HL.Time, p_HL.Data * 180/pi, 'b', 'LineWidth', 2); hold on;
plot(p_HR.Time, p_HR.Data * 180/pi, 'r', 'LineWidth', 2);
ylabel('Hip Angle [deg]', 'FontWeight', 'bold', 'Color', 'k');
title('Task 1-1: Hip Joint Angles', 'FontWeight', 'bold', 'Color', 'k');
lgd1 = legend({'Left', 'Right'}, 'Location', 'best');
set(lgd1, 'TextColor', 'k', 'Color', 'w', 'EdgeColor', 'k'); % Force Legend Style
grid on;

% --- Subplot 2: Hip Torques ---
ax2 = subplot(4,1,2);
plot(t_NetH.Time, t_NetH.Data, 'k', 'LineWidth', 2); hold on;
plot(t_GLU.Time, t_GLU.Data, 'g--', 'LineWidth', 1.5); 
plot(t_HFL.Time, t_HFL.Data, 'm--', 'LineWidth', 1.5); 
ylabel('Hip Torque [Nm]', 'FontWeight', 'bold', 'Color', 'k');
title('Left Hip Torques', 'FontWeight', 'bold', 'Color', 'k');
lgd2 = legend({'Net', 'GLU (Ext)', 'HFL (Flex)'}, 'Location', 'best');
set(lgd2, 'TextColor', 'k', 'Color', 'w', 'EdgeColor', 'k');
grid on;

% --- Subplot 3: Knee Joint Angles ---
ax3 = subplot(4,1,3);
plot(p_KL.Time, p_KL.Data * 180/pi, 'b', 'LineWidth', 2); hold on;
plot(p_KR.Time, p_KR.Data * 180/pi, 'r', 'LineWidth', 2);
ylabel('Knee Angle [deg]', 'FontWeight', 'bold', 'Color', 'k');
title('Knee Joint Angles', 'FontWeight', 'bold', 'Color', 'k');
lgd3 = legend({'Left', 'Right'}, 'Location', 'best');
set(lgd3, 'TextColor', 'k', 'Color', 'w', 'EdgeColor', 'k');
grid on;

% --- Subplot 4: Knee Torques ---
ax4 = subplot(4,1,4);
plot(t_NetK.Time, t_NetK.Data, 'k', 'LineWidth', 2); hold on;
plot(t_VAS.Time, t_VAS.Data, 'g--', 'LineWidth', 1.5); 
plot(t_BFSH.Time, t_BFSH.Data, 'm--', 'LineWidth', 1.5); 
ylabel('Knee Torque [Nm]', 'FontWeight', 'bold', 'Color', 'k');
xlabel('Time [s]', 'FontWeight', 'bold', 'Color', 'k');
title('Left Knee Torques', 'FontWeight', 'bold', 'Color', 'k');
lgd4 = legend({'Net', 'VAS (Ext)', 'BFSH (Flex)'}, 'Location', 'best');
set(lgd4, 'TextColor', 'k', 'Color', 'w', 'EdgeColor', 'k');
grid on;

% --- GLOBAL STYLE ENFORCEMENT ---
% This loop forces the axes (the box) to be white with black lines
all_axes = [ax1, ax2, ax3, ax4];
for i = 1:length(all_axes)
    set(all_axes(i), ...
        'Color', 'w', ...           % White background inside box
        'XColor', 'k', ...          % Black X-axis line/numbers
        'YColor', 'k', ...          % Black Y-axis line/numbers
        'GridColor', 'k', ...       % Black Grid lines
        'GridAlpha', 0.15, ...      % Faint grid
        'LineWidth', 1.2, ...       % Thicker box border
        'FontSize', 10, ...         % Size of numbers
        'FontWeight', 'bold', ...   % Bold numbers
        'Box', 'on');               % Ensure box is closed
end