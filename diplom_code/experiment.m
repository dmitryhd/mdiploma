function experiment()
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
    training_set = [[0; 0; 0] [0; 0; 1] [0; 1; 1] [0; 1; 1] [1; 1; 1] [1; 1; 0]];
    training_answers = [0 1 1 1 1 1]; % targets
    perc = perceptron;
    
    input_config = [0 1; 0 1; 0 1];
    output_config = [0 1];

    perc01 = configure(perc, input_config, output_config);
    perc02 = configure(perc, input_config, output_config);
    ls = [];  % learning state 
    for tr_index = 1:length(training_set)
            % use trainc Cyclical order weight/bias training
            %{
            w = perc.iw{1,1};
            p = training_set(:,tr_index);
            a = perc(p);
            e = training_answers(tr_index) - a;
            fprintf('W = %s, p = %s, a = %s, e = %s\n', sprintf('%d ',w), sprintf('%d ',p), sprintf('%d ',a), sprintf('%d ',e));
            %dw, ls = learnp(w,p,[],[],[],[],e,[],[],[],[],ls);
            dw = e*p';
            fprintf('dw = %s\n', sprintf('%d ',dw))
            w = w + dw;
            perc.iw{1,1} = w;
            %}
        ans01 = perc01(training_set(:,tr_index));
        ans02 = perc02(training_set(:,tr_index));
        perc01 = train(perc01, training_set(:,tr_index), training_answers(tr_index));
        perc02 = train(perc02, training_set(:,tr_index), training_answers(tr_index));
    end
    perceptron_output = zeros(1,length(training_answers));
    % check output
    for exam_index = 1:length(training_set)
        perceptron_output(exam_index) = perc01(training_set(:,exam_index));
    end
    training_answers
    perceptron_output
    perc01.iw{1,1}
    perc02.iw{1,1}
end

