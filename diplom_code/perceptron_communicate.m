function perceptron_communicate()
    % Creates 2 perceptrons. and train them with one another.
    training_set = [[0; 0; 0] [0; 0; 1] [0; 1; 1] [0; 1; 1] [1; 1; 1] [1; 1; 0]];
    training_answers = [0 1 1 1 1 1]; % targets
    perc = perceptron;
    
    input_config = [0 1; 0 1; 0 1];
    output_config = [0 1];

    perc = configure(perc, input_config, output_config);
    ls = [];  % learning state 
    for epoch = 1:3
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
            
            perc = train(perc, training_set(:,tr_index), training_answers(tr_index));
        end
    end
    
    perceptron_output = zeros(1,length(training_answers));
    % check output
    for exam_index = 1:length(training_set)
        perceptron_output(exam_index) = perc(training_set(:,exam_index));
    end
    training_answers
    perceptron_output
end

function res = get_random_input(number_of_inputs)
    res = randi(2, number_of_inputs, 1) - 1;
end
