% Uses kmeans algorithm to find new centroids
% data - array were columns are samples and rows are features
% k - number of centroids
% centroids - initial centroids where columns are samples (k of them) and
%           rows are features
function [centroids, iterations] = k_means(data, k, centroids, max_iterations)
    number_of_samples = size(data, 2);
    % row i would be vector of distances from the data to the centroid i
    dist_from_centroids = zeros(k, number_of_samples); 
    iterations = 0;
    
    while(iterations < max_iterations)
        for i = 1:k
            z_i = centroids(:,i);
            dist_from_centroids(i,:) = -1*z_i'*data + 1/2*z_i'*z_i;
        end
        
        % vector size k where elements correspond to which centroid is closest
        [~, closest_centroid] = min(dist_from_centroids, [], 1);
        converged = true;
        for i = 1:k
            mask = closest_centroid == i;
            
            % there are no points closest to that centroid
            % should never happen, if you choose a data point as centroid
            if(sum(mask) == 0), continue; end
            
            cluster = data(:,mask);
            new_centroid = mean(cluster, 2);
            % check for convergence
            if(~isequal(new_centroid, centroids(:,i))), converged = false; end
            centroids(:,i) = new_centroid;
        end
        
        if(converged), break; end
        iterations = iterations + 1;
    end
end

