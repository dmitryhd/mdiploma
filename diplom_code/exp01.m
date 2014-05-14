function exp01()
    x = save_converge_vs_eta();
end

function [ n_convs ] = get_n_convs(eta, tries)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    n_convs = zeros(tries, 1);
    for i = 1:tries
        [dt, n_conv] = perct(10000, eta);
        n_convs(i) = n_conv;
        fprintf('n=%d, eta=%.2f n_conv=%d\n', i, eta, n_conv);
    end
end

function [ out ] = save_converge_vs_eta()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    out = zeros(100,length(.2:.4:2));
    i = 1;
    headers = {};
    for eta = .2:.4:2
        headers{i} = sprintf('%.1f', eta);
        n_convs = get_n_convs(eta, 100);
        out(:,i)=n_convs;
        i = i + 1;
    end
    csvwrite_with_headers('data/converge_number.csv', out, headers);
end
