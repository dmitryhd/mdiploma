function [sync_time] = tpm(n_epoch, N, L, pn)
    % Creates 2 perceptrons. and train them with one another.
    function res = get_perc_answer(w, x)
        res = sign(w*x');
        if res == 0
            res = -1;
        end
    end

    function w = init_perc(N, L, perc_num)
        w = randi(2*L,perc_num,N)-L;
    end

    function w_out = update_perc(w, x, t, L)
        sigma = get_perc_answer(w, x);
        if sigma ~= t
            w_out = w;
            return
        end
        upd = t * x;
        w_out = w + upd;
        for i = 1:length(w_out)
            if (w_out(i) > L) 
                w_out(i) = L;
            end
            if (w_out(i) < -L) 
                w_out(i) = -L;
            end
        end
        %fprintf('before=%s\n', sprintf('%d ',w));
        %fprintf('after=%s\n', sprintf('%d ',w_out));
    end

    function res = get_tpm_answer(ws, xs)
        perc_num = size(ws,1);
        res = 1;
        answs = zeros(perc_num,1);
        for i = 1:perc_num
            answs(i) = get_perc_answer(ws(i,:), xs(i,:));
            res = res * answs(i);
        end
    end

    function w_out = update_tpm(ws, xs, t, L)
        w_out = zeros(size(ws));
        perc_num = size(ws, 1);
        for i = 1:perc_num            
            w_out(i,:) = update_perc(ws(i,:), xs(i,:), t, L);
        end 
        
    end

    function xs = get_random_x(N, pn)
        xs = randi(2, pn, N) - 1;
        xs(xs == 0) = -1;
    end

    %N = 1000;
    %L = 3;
    %pn = 3;
    ws01 = init_perc(N,L,pn);
    ws02 = init_perc(N,L,pn);
    %dist_t = zeros(n_epoch,1);
    zeros_in_row = 0;
    converge_zeros = 2;
    n_converge = 0;
    for tr_index = 1:n_epoch
        xs = get_random_x(N, pn);
        %fprintf('i=%d, x=%s\n', tr_index, sprintf('%d ',xs));
        %fprintf('\tperc01 weights = %s\n', sprintf('%.2f ',ws01));
        %fprintf('\tperc02 weights = %s\n', sprintf('%.2f ',ws02));

        ans01 = get_tpm_answer(ws01, xs);
        ans02 = get_tpm_answer(ws02, xs);
        if ans01 ~= ans02
            continue
        end
        %fprintf('\ta1 = %d a2 = %d\n', ans01, ans02);
        ws01 = update_tpm(ws01, xs, ans01, L);
        ws02 = update_tpm(ws02, xs, ans02, L); 
        
        dist = sqrt(sum((ws01(:) - ws02(:)) .^ 2));
        if dist == 0
            zeros_in_row = zeros_in_row + 1;
            if zeros_in_row == converge_zeros
                n_converge = tr_index;
                break;
            end
        else
            zeros_in_row = 0;
        end
        %}
    end
    if ~n_converge
        n_converge = n_epoch;
    end

    sync_time = n_converge;
    fprintf('perc01 weights = %s\n', sprintf('%.2d ', ws01));
    fprintf('perc02 weights = %s\n', sprintf('%.2d ', ws02));
    %dist_t_ans = dist_t;
end

