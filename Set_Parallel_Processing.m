function [] = Set_Parallel_Processing( Sim_Struct, Verbosity )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
tic;

if ~strcmp(Verbosity,'None')
    display('-I- Setting Parallel Processing parameters...');
end

% Enable parallel processing
if ( ~Sim_Struct.FORCE_SERIAL || ~Sim_Struct.FORCE_MAIN_LOOP_SERIAL )
    try
        num_processes = getenv('NUMBER_OF_PROCESSORS');
        % Maximum allowed processes are 12 in matlab 2012
        if (num_processes > 12)
            num_processes = 12;
        end
        
        myCluster = parcluster('local');
        myCluster.NumWorkers = num_processes; % 'Modified' property now TRUE
        saveProfile(myCluster);   % 'local' profile now updated,
        
        if ~strcmp(Verbosity,'None')
            fprintf('\n');
            display('-I- Initiating matlab pool for parallel processing...');
            fprintf('\n');
        end
        
        matlabpool;
        
        if ~strcmp(Verbosity,'None')
            fprintf('\n');
            display('-I- Finished matlab pool initiation.');
            fprintf('\n');
            
        end
        
    catch error
        
        if ~strcmp(Verbosity,'None')
            fprintf('\n');
            fprintf('\n');
            display('-I- Matlab pool already running!');
            fprintf('\n');
        end
        
    end
end

% Add needed functions to parallel workers
if ( (Sim_Struct.num_iterations > 1) || ~Sim_Struct.FORCE_SERIAL || ~Sim_Struct.FORCE_MAIN_LOOP_SERIAL)
    
    if strcmp(Verbosity,'Full')
        display('-I- Starting Parallel Processing Setting...');
    end
    
    myPool  = gcp;
    myFiles = {'Summarize_Iteration.m', 'Estimate_ht_Wiener.m', 'Simulation.m', ...
               'Print2Pdf.m', 'gprint.m', 'AddToLog.m', 'Regularized_Sol.m', 'AIF_Parker.m', 'ReScale_AIF.m'};
    addAttachedFiles(myPool, myFiles);
    
    if strcmp(Verbosity,'Full')
        display('-I- Finished Parallel Processing Setting...');
    end
end

time_finish = toc;

if ~strcmp(Verbosity,'None')
    display(sprintf('-I- Setting Parallel Processing paramteres took %.2f seconds to finish...',time_finish));
end


if strcmp(Verbosity,'Full')
    display('-I- Finished setting Parallel Processing parameters...');
end


end

