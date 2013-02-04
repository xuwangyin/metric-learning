function accu = getAccuracy(classConstrains, theta)
  nclasses = numel(classConstrains);
  ndataPairs = 0;
  ncorrects = 0;
  for c = 1: nclasses
    constrain = classConstrains(c);
    for i = 1: size(constrain.mustlink, 1) - 1
      for j = i + 1: size(constrain.mustlink, 1)
        ndataPairs = ndataPairs + 1;
        if sigmoid(similarityVector(constrain.mustlink(i, :), constrain.mustlink(j, :))' * theta) < 0.5
          ncorrects = ncorrects + 1;
        end
      end
    end

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
