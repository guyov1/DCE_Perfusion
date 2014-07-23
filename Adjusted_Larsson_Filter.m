
function Filter = Adjusted_Larsson_Filter(time_vec_min, F, Vb, E, Ve)

% Create Larsson's filter (as described in article)
Vtis                   = ( 1 - (Vb/100) )*100; % Convert to [mL/100g]

PS     =  ( E * F ) / (1 - E);                             % [mL/100g/min]
alpha  = ( F + PS ) / Vb;                   % [1/min]
beta   = ( Vtis * PS ) / (Vb*Ve); % [1/min]
gamma  =  PS / Vtis;                         % [1/min]
theta  =  PS / Ve;               % [1/min]
a      = (1/2) * (theta + alpha + sqrt(theta^2 + alpha^2 - 2*theta*alpha + 4*gamma*beta) ); % [1/min]
b      = (1/2) * (theta + alpha - sqrt(theta^2 + alpha^2 - 2*theta*alpha + 4*gamma*beta) ); % [1/min]

IRF    = ( (a - theta - (PS/Vb) )*exp(-a*time_vec_min) - (b - theta - (PS/Vb) )*exp(-b*time_vec_min) ) / (a - b); % No units

Filter = IRF;

end