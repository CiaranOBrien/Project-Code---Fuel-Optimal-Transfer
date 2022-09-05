function pars = PSOSetup(pars)

%% Boundaries for X
lb = [0.1; eps*ones(7,1)];
ub = [ones(8,1)];
nvars = 8; 

pars.PSO.lb = lb;
pars.PSO.ub = ub;
pars.PSO.nvars = nvars;

%% PSO Options

IterNum   = 1e4;
SwarmSize = 60;
ParaFlag  = true;
TimeLim   = 604800;
Tolerance = 1e-6;


%% PSO options
options = optimoptions('particleswarm');

options = optimoptions(options,'PlotFcn','pswplotbestf');

options = optimoptions(options, 'Display', 'iter');     

options = optimoptions(options, 'FunctionTolerance', Tolerance);

options = optimoptions(options, 'HybridFcn', 'fmincon');

options = optimoptions(options, 'MaxIterations', IterNum);

options = optimoptions(options, 'MaxStallIterations', 50);

options = optimoptions(options, 'MaxTime', TimeLim);

options = optimoptions(options, 'OutputFcn', @PSO_Output);

options = optimoptions(options, 'SwarmSize', SwarmSize);
 
options = optimoptions(options, 'UseParallel', ParaFlag);

options = optimoptions(options, 'UseVectorized', false);


pars.PSO.options = options;

end

