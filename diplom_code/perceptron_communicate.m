function perceptron_communicate()
    % Creates 2 perceptrons. and train them with one another.
    training_set = [[0; 0; 0] [0; 0; 1] [0; 1; 1] [0; 1; 1] [1; 1; 1] [1; 1; 0]];
    training_answers = [0 1 1 1 1 1]; % targets
    %training_set = [0; 0; 0];
    %training_answers = [0]; % targets
    
    input_config = [0 1; 0 1; 0 1];
    output_config = [0 1];
    perc = perceptron;
    perc = configure(perc, input_config, output_config);
    inputweights = perc.inputweights{1,1}
    
    % use trainc Cyclical order weight/bias training
    perc = train(perc, training_set, training_answers);
    
    perceptron_output = [perc([0; 0; 0]), perc([0; 0; 1]), perc([0; 1; 0])];
    perceptron_output
end