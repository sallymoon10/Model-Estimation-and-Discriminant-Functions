close all;
clear all;

k = 10;
max_iterations = intmax;
load('feat.mat');

data = f32(1:(end-2),:); % feature vector is everything except last two rows

% figure;
aplot(f32);

% Pick k random points from data as centroids
indices = randperm(size(data, 2), k);
centroids = data(:, indices);

[centroids, iterations] = k_means(data, k, centroids, max_iterations);
hold on, plot(centroids(1,:), centroids(2,:), 'd', 'color', 'r', 'markersize', 10);

disp(['Number of Iterations until Convergence ' , num2str(iterations)]);

title(['K-Means using K of ', num2str(k)]);
legend('centroids', 'Location', 'SouthEast');
