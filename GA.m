%%Simulation of genetic algorithm for finding the maximum value of 
%%fitness function fcost and output the corresponding set of transmission
%%parameters


%%Maximum and minimum values for transmission parameters
power_max = 24; %maximum power in dB
power_min = -8; %minimum power in dB
bandwidth_max = 32; %maximum bandwidth in Hz
bandwidth_min = 2;  %minimum bandwidth in Hz
tdd_min = 25;   %minimum time for transmitting
tdd_max = 100;  %maximum time for transmitting

%%Transmission parameter ranges
power_list = (power_min:2:power_max);
bandwidth_list = (bandwidth_min:2:bandwidth_max);
frame_list = (100:100:1600);
tdd_list = (tdd_min:25:tdd_max);

%%Constant values for genetic parameters
npar = 4;
%nbits = 4;
%chromosome_length = nbits*npar; %parameter changes with range of transmission parameter values
chromosome_length = 14;
pop_size = 50;
gen_size = 1000;
crossover_rate = 0.60;
mutation_rate = 0.001;

%%Genetic algorithm implementation

gen_itr = 0;

%%initial population of random chromosomes
pop = randi([0,1],pop_size,chromosome_length);

%%iterating over all generations
while gen_itr < gen_size 

    fcost = zeros(1,pop_size); %reserving space for pop_size number of fitness scores for current population
    select_prob = zeros(1,pop_size); %reserving space for pop_size number of selection probabilities for current population
    sorted_pop = zeros(pop_size,chromosome_length); %reserving space for sorted population array
    
    %%Calculating fitness values for current population
    
    for itr_i=1:pop_size
            fcost(1,itr_i) = feval(@fitness_func,pop(itr_i,:));
    end
    [fcost,ind] = sort(fcost,'descend');
    max_cost(gen_itr+1) = max(fcost);   %stores the maximum fitness value for current generation
    mean_fcost = mean(fcost);
    
    %%sort pop based on the indexes in array ind
    for itr_i=1:pop_size
       sorted_pop(itr_i,:) = pop(ind(itr_i),:);
    end
    
    pop = sorted_pop;
    
    gen_itr = gen_itr + 1;
    
    %calculating selection probabilities
    for itr_i=1:pop_size
      select_prob(itr_i) = fcost(itr_i)/mean_fcost;
    end

    %creating population for next generation using crossover and mutation
    idx = 1;

    while select_prob(idx) > 1.00
        idx = idx+1;
    end

    idx_i = idx; %pop(1:idx_i) are promoted to next population
    idx_i = idx_i + 1;

    while idx_i <= pop_size
    
     pick_fa = randi(idx,[1,1]);
     pick_mo = randi(idx,[1,1]);
    
     father = pop(pick_fa,:);
     mother = pop(pick_mo,:);
    
     success_val = randi(10,[1,1]);
    
     if success_val <= 6 %performing crossover with 60% probability
        
        %code for two_point crossover and mutation
        crossover_point = randi(chromosome_length,[1,1]);
        
        offspring1 = [father(1:crossover_point) mother(crossover_point+1:chromosome_length)];
        offspring1 = mutation(offspring1,chromosome_length);
        
        offspring2 = [mother(1:crossover_point) father(crossover_point+1:chromosome_length)];
        offspring2 = mutation(offspring2,chromosome_length);
        
        pop(idx_i,:) = offspring1;
        
        idx_i = idx_i + 1;
        if idx_i == pop_size
            break;
        end
        
        pop(idx_i,:) = offspring2;
        idx_i = idx_i + 1;
        if idx_i == pop_size
            break;
        end
        
     else %perform no crossover on the father and mother, just copy to next population 
        
        father = mutation(father,chromosome_length);
        mother = mutation(mother,chromosome_length);
        
        pop(idx_i,:) = father;
        
        idx_i = idx_i + 1;
        if idx_i == pop_size
            break;
        end
        pop(idx_i,:) = mother;
        
        idx_i = idx_i + 1;
        if idx_i == pop_size
            break;
        end
        
     end %if 

    end %while idx_i
    
    for itr_i=1:pop_size
            fcost(itr_i) = feval(@fitness_func,pop(itr_i,:));
    end
    [fcost,ind] = sort(fcost,'descend');
    max_cost(gen_itr+1) = max(fcost);   %stores the maximum fitness value for current generation
    
    %sort pop based on the indexes in array ind
    for itr_i=1:pop_size
        sorted_pop(itr_i,:) = pop(ind(itr_i),:);
    end
    
    pop = sorted_pop;
    
end %while

x = 1:1:gen_size+1;
plot(x,max_cost);
xlabel('Generations');
ylabel('Fitness Score');

p = power_list(bi2de(pop(ind(1),1:4),'left-msb')+1);
band = bandwidth_list(bi2de(pop(ind(1),5:8),'left-msb')+1);
frame = frame_list(bi2de(pop(ind(1),9:12),'left-msb')+1);
tdd = tdd_list(bi2de(pop(ind(1),13:14),'left-msb')+1);
message1 = ['power:',num2str(p),' bandwidth:',num2str(band),' frame size:',num2str(frame),' tdd:',num2str(tdd)];
message2 = ['Maximum value of fitness score = ',num2str(max(max_cost))];
disp(message2);
disp(message1);


