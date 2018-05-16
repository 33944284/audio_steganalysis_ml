methods = {'jin', 'ren', 'wang_new'};
stegos = {'yan', 'eecs'};
bitrates = {'128', '320'};
embedding_rates = {'01', '03', '05', '08', '10'};
index = 1;
times = 3;

for i = 1:length(methods)
    for j = 1:length(bitrates)
        cover_feature_name = strcat(methods{i}, '_cover_', bitrates{j});
%         fprintf('cover:%s\n', cover_feature_name);
        for m = 1:length(stegos)
            for n = 1:length(embedding_rates)
                stego_feature_name = strcat(methods{i}, '_', stegos{m}, '_w_2_', bitrates{j}, '_', embedding_rates{n});
                command = strcat('training(', cover_feature_name, ',',stego_feature_name, ',0.8,10, ''model.mat'', ', '''True'')');
                result = eval(command);
                while result.ACC < 0.5 && times > 0
                    result = eval(command);
                    times = times - 1;
                end
                result.name = stego_feature_name;
                results(index) = result;                                    %#ok<SAGROW>
                index = index + 1;
            end
        end
    end
end