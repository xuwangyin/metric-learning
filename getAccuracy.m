function accu = getAccuracy(classConstrains, theta)
  %% GETACCURACY compute the accuray of parameter theta, which is
  %% defined as the portion of data pairs (include must-link and cannot-link data pairs)
  %% that are correctly clustered.
  nclasses = numel(classConstrains);
  ndataPairs = 0;
  ncorrects = 0;
  for c = 1: nclasses
    constrain = classConstrains(c);
    %% every two data points in constrain.mustlink form a mustlink data pair;
    %% there are |constrain.mustlink| choose 2 of them
    for i = 1: size(constrain.mustlink, 1) - 1
      for j = i + 1: size(constrain.mustlink, 1)
        ndataPairs = ndataPairs + 1;
        if sigmoid(similarityVector(constrain.mustlink(i, :), constrain.mustlink(j, :))' * theta) < 0.5
          ncorrects = ncorrects + 1;
        end
      end
    end

    %% every two data points in constarin.mustlink and constrain.cannotlink
    %% form a cannotlink data pair;
    %% there are |constrain.mustlink| * |constrain.cannotlink| of them
    for i = 1: size(constrain.mustlink, 1)
      for j = 1: size(constrain.cannotlink, 1)
        ndataPairs = ndataPairs + 1;
        if sigmoid(similarityVector(constrain.mustlink(i, :), constrain.cannotlink(j, :))' * theta) > 0.5
          ncorrects = ncorrects + 1;
        end
      end
    end
  end
  accu = ncorrects / ndataPairs;
end         

function x = similarityVector(point1, point2)
  %% feature vector of two data points
  t = (point1 - point2)';
  x = [1; t(2: end)];
end
