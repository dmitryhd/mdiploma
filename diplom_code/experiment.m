function experiment()
    n_epoch = 100;
    input_number = 3;
    % Creates 2 perceptrons. and train them with one another.
    function out = theta(a, b)
        if (a ~= b)
            out = 0;
        else
            out = a;
        end
    end 
    function normal_weights = g(weights, L)
        for i = 1:length(weights)
            if (weights(i) > L) 
                weights(i) = L;
            end
            if (weights(i) < -L) 
                weights(i) = -L;
            end
        end
    end
    function x = get_random_x(input_number)
        x = randi(5, input_number, 1) - 1;
    end
    perc01 = perceptron;
    perc02 = perceptron;
    
    input_config = [0 1; 0 1; 0 1];
    output_config = [0 1];

    perc01 = configure(perc01, input_config, output_config);
    perc02 = configure(perc02, input_config, output_config);
    perc01.trainParam.showWindow=0;
    perc02.trainParam.showWindow=0;
    ls = [];  % learning state 
    for tr_index = 1:n_epoch
        x = get_random_x(input_number);
        ans01 = perc01(x);
        ans02 = perc02(x);
        perc01 = train(perc01, x, ans02);
        perc02 = train(perc02, x, ans01);
    end
    fprintf('perc01 weights = %s\n', sprintf('%d ',perc01.iw{1,1}));
    fprintf('perc02 weights = %s\n', sprintf('%d ',perc02.iw{1,1}));
end

