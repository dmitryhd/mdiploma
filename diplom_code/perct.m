function [dist_t_ans, n_converge] = perct(n_epoch, eta)
    % Creates 2 perceptrons. and train them with one another.
    function res = get_perc_answer(w, x)
        
        res = sign(w'*x);
        if res == 0
            res = -1;
        end
    end

    function w = init_perc(N, L)
        w = randi(2*L,N,1)-L;
    end

    function w_out = update_perc(w, x, other_ans, eta, L)
        ans = get_perc_answer(w, x);
        theta = 0;
        if ans == other_ans
            theta = 1;
        end
        w_out = w + 0.1 * eta * other_ans * theta;
        for i = 1:length(w_out)
            if (w_out(i) > L) 
                w_out(i) = L;
            end
            if (w_out(i) < -L) 
                w_out(i) = -L;
            end
        end
    end

    function x = get_random_x(N, L)
        x = randi(2*L, N, 1) - L;
    end
    L = 5;
    N = 3;
    w01 = init_perc(N,L);
    w02 = init_perc(N,L);
    dist_t = zeros(n_epoch,1);
    
    zeros_in_row = 0;
    converge_zeros = 2;
    n_converge = 0;
    for tr_index = 1:n_epoch
        x = get_random_x(N, L);
        %fprintf('i=%d, x=%s\n', tr_index, sprintf('%d ',x));
        %fprintf('\tperc01 weights = %s\n', sprintf('%.2f ',w01));
        %fprintf('\tperc02 weights = %s\n', sprintf('%.2f ',w02));
        
        ans01 = get_perc_answer(w01, x);
        ans02 = get_perc_answer(w02, x);
        %fprintf('\ta1 = %d a2 = %d\n', ans01, ans02);
        w01 = update_perc(w01, x, ans02, eta, L);
        w02 = update_perc(w02, x, ans01, eta, L); 
        dist_t(tr_index) = sqrt(sum((w01 - w02) .^ 2));
        
        if dist_t(tr_index) == 0
            zeros_in_row = zeros_in_row + 1;
            if zeros_in_row == converge_zeros
                n_converge = tr_index;
                break;
            end
        else
            zeros_in_row = 0;
        end
     end
    if ~n_converge
        n_converge = n_epoch;
    end
    %fprintf('perc01 weights = %s\n', sprintf('%.2d ', w01));
    %fprintf('perc02 weights = %s\n', sprintf('%.2d ', w02));
    dist_t_ans = dist_t;
end

