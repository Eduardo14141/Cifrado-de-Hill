function [ new_message ] = decryptFunction( message )
    %Alfabeto con el que vamos a trabajar
    %alphabet = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'];
    alphabet = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'ñ' 'o' 'p' 'q' 'r' 's' 't' 'u' 'ü' 'v' 'w' 'x' 'y' 'z' ...
        'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'Ñ' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'Ü' 'V' 'W' 'X' 'Y' 'Z' ...
        'á' 'é' 'í' 'ó' 'ú' 'Á' 'É' 'Í' 'Ó' 'Ú' '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' ' ' '?' '¿' '.' ',' ';' ':' '-' '!' '¡' '_' '$'];
    %Se define el módulo de todas las operaciones
    module = length(alphabet);
    %Creando la matriz de xi (4xN), matriz que contiene las letras a descifrar
    message_to_matrix = zeros(4, length(message)/4);
    for k = 1 : length(message)/4
        for j = 1 : 4
            message_to_matrix(j, k) = find(alphabet == message(4*k - 4 + j));
        end
    end
    %Definiendo la matriz inversa de K con la que se descifrarán los datos
    %K = inv([8 6 9 5; 6 9 5 10; 5 8 4 9; 10 6 11 4]);
    K = mod([-3 20 -21 1; 2 -41 44 1; 2 -6 6 -1; -1 28 -30 -1], module);
    %Creando el mensaje
    y = mod(K * message_to_matrix, module);
    new_message = "";
    for k = 1 : length(message)/4
        for j = 1 : 4
            if y(j,k) == 0
                y(j, k) = module;
            end
            new_message = strcat(new_message, alphabet(y(j, k)));
        end
    end
    new_message = strrep(new_message, '$', ' ');
    %Removes all "_" from new_message
    new_message = erase(new_message,'_');
end

