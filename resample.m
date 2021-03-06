function [X, y, graphStat] = resample(classConstrains, theta, nfeatures)
  nclassConstrains = numel(classConstrains);
  %% nfeatures = size(classConstrains(1).mustlink, 2);
  %% one CC will generate two samples
  X = zeros(2 * nclassConstrains, nfeatures);
  y = zeros(2 * nclassConstrains, 1);
  graphStat = zeros(2 * nclassConstrains, 2);
  for i = 1: 2: 2 * nclassConstrains
    %% printf('resampling: %d/%d\n', i, nclassConstrains);
    %% fflush(stdout);
    [X(i, :), y(i), graphStat(i, :)] = sampleMustlink(classConstrains((i + 1) / 2), theta);
    [X(i + 1, :), y(i + 1), graphStat(i + 1, :)] = sampleCannotlink(classConstrains((i + 1) / 2), theta);
  end
end

function [X, y, graphStat] = sampleMustlink(classConstrain, theta)
  [i, j] = getMaxEdgeMST(classConstrain.mustlink, theta);
  X = similarityVector(classConstrain.mustlink(i, :), classConstrain.mustlink(j, :));
  %% covert to row vector
  X = X';
  y = 0;
  graphStat = [i j];
end

function [X, y, graphStat] = sampleCannotlink(classConstrain, theta)
  minSimilarity = Inf;
  for i = 1: size(classConstrain.cannotlink, 1)
    for j = 1: size(classConstrain.mustlink, 1)
      sv = similarityVector(classConstrain.cannotlink(i, :), classConstrain.mustlink(j, :));
      if sv' * theta < minSimilarity
        X = sv;
        minSimilarity = sv' * theta;
      end
    end
  end
  %% convert to row vector
  X = X';
  y = 1;
  graphStat = [i j];
end

function [row, col] = getMaxEdgeMST(points, theta)
  %% GETMAXEDGEMST compute the maximal weight edge
  %% of Miniminum Spanning Tree generated by data points
  %% using distance function parametered by theta,
  %% the weight edge should connect points[row] and points[col]
         
  %% squareform(pdist([1:npoints]', @pdistMetric, points, theta))
  %% MST = linkage([1:npoints]', 'single', {@pdistMetric, points, theta});

  npoints = size(points, 1);
  p = pdist([1:npoints]', @pdistMetric, points, theta);
  MST = linkage(p, 'single');
  [m, mi] = max(MST(:, 3));
  idx = find(abs(p - m) < 0.00000001);
  [row, col] = findRowCol(idx, npoints);
%% [row, col]
end

function t = pdistMetric(x, y, points, theta)
  %% PDISTMETRIC is the distance function used for clustering
  N = size(y, 1);
  t = zeros(N, 1);
  for i = 1: N
    t(i) = theta' * similarityVector(points(x, :), points(y(i), :));
  end

end

function x = similarityVector(point1, point2)
  %% feature vector of two data points
  t = (point1 - point2)';
  x = [1; t(2: end)];
end

function [x, y] = findRowCol(idx, base)
  x = 1;
  y = 1;
  n = 0;
  for i = 1: base - 1
    for j = i + 1: base
      n = n + 1;
      if n == idx
        x = i;
        y = j;
        return;
      end
    end
  end
end


