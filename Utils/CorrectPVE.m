function [ AIF_estimated_ICA_Corrected ] = CorrectPVE( AIF_estimated_ICA, Vein_estimated_ICA, time_vec )

Integral_Art                = trapz(time_vec,AIF_estimated_ICA);
Integral_Vein               = trapz(time_vec,Vein_estimated_ICA);
Scale_Factor                = Integral_Vein / Integral_Art;
AIF_estimated_ICA_Corrected = Scale_Factor * AIF_estimated_ICA;

end

