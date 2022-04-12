Nbit = 10;
max_value = 2^(Nbit-1)-1;

%The matrix exact_values contains the modulus of the complex number 
%computed by using square and square-root operations.
exact_values = zeros(max_value);

%The matrix approximated_values contains the modulus of the complex number 
%computed by using the approximated algorithm implemented in the digital
%circuit.
approximated_values = zeros(max_value);

%p represents the real part
%q represents the imaginary part

for p = 1:max_value
    for q = 1:max_value
        exact_values(p,q) = sqrt(p^2 + q^2);
        approximated_values(p,q) = max(p,q) + floor((1/2)*min(p,q)) - floor((1/16)*(max(p,q) + min(p,q)));
    end
end

%Mean Squared Error
MSE = immse(exact_values,approximated_values);


