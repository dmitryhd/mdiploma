function tpm_exp()
    %x = save_tsync_vs_N();
    %x = save_tsync_vs_L();
    x= save_tsync_vs_pn();
end

function [ tsyncs ] = get_tsyncs(tries, N, L, pn)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    tsyncs = zeros(tries, 1);
    for i = 1:tries
        tsync = tpm(10000, N, L, pn);
        tsyncs(i) = tsync;
        fprintf('n=%d, N=%.2f L=%.2f pn=%.2f  tsync=%d\n', i, N, L, pn, tsync);
    end
end

function [ out ] = save_tsync_vs_N()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    tryies = 200;
    Ns = 100:100:1000;
    out = zeros(tryies,length(Ns));
    i = 1;
    headers = {};
    for N = Ns
        headers{i} = sprintf('N=%d', N);
        n_convs = get_tsyncs(tryies, N, 3, 3);
        out(:,i)=n_convs';
        i = i + 1;
    end
    csvwrite_with_headers('../data/l3pn3NvsTsync_100.csv', out, headers);
end

function [ out ] = save_tsync_vs_L()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    tryies = 200;
    Ls = 1:1:10;
    out = zeros(tryies,length(Ls));
    i = 1;
    headers = {};
    for L = Ls
        headers{i} = sprintf('L=%d', L);
        n_convs = get_tsyncs(tryies, 100, L, 3);
        out(:,i)=n_convs';
        i = i + 1;
    end
    csvwrite_with_headers('../data/n100pn3LvsTsync.csv', out, headers);
end


function [ out ] = save_tsync_vs_pn()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    tryies = 100;
    pns = 1:1:10;
    out = zeros(tryies,length(pns));
    i = 1;
    headers = {};
    for pn = pns
        headers{i} = sprintf('n=%d', pn);
        n_convs = get_tsyncs(tryies, 100, 3, pn);
        out(:,i)=n_convs';
        i = i + 1;
    end
    csvwrite_with_headers('../data/n100L3_pn_vs_Tsync.csv', out, headers);
end
