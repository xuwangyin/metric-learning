function classConstrains = getClassConstrains(raw)
  M = size(raw, 1);               %% number of samples
  D = size(raw, 2) - 1;           %% number of features
  rawX = raw(:, 1:D);             %% features
  rawY = raw(:, D+1);             %% labels
  K = numel(unique(rawY));        %% number of classes (clusters)

  classConstrains = [];                         %% struct array containing mustlink and cannotlink constrains for *each* class
  for c = 1: K
    %% mustlink constrain for class c is the set of the data points of class c
    classConstrains(c).mustlink = rawX(rawY == c, :);
    %% add intercept term
    classConstrains(c).mustlink = [ones(size(classConstrains(c).mustlink, 1), 1), classConstrains(c).mustlink];
    %% cannotlink constarin for class c is the set of data points of class non-c
    classConstrains(c).cannotlink = rawX(rawY ~= c, :);
    %% add intercept term
    classConstrains(c).cannotlink = [ones(size(classConstrains(c).cannotlink, 1), 1), classConstrains(c).cannotlink];
  end
  classConstrains = classConstrains';                        %% convert to column vector
end
