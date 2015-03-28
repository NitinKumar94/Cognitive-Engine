function new_chrome = mutation( chromosome,chromosome_length )

%   Carries out bit-flip mutation on a chromosome 

mutation_prob = randi(1000,[1,14]);

for itr=1:chromosome_length
    if mutation_prob(itr) == 1
        chromosome(itr) = ~chromosome(itr);
    end %if
end %itr

new_chrome = chromosome;
