function [ new_message ] = encryptFunction( message )
    %Alfabeto con el que vamos a trabajar
    message = strrep(message, ' ', '$');
    %alphabet = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'];
    alphabet = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'ñ' 'o' 'p' 'q' 'r' 's' 't' 'u' 'ü' 'v' 'w' 'x' 'y' 'z' ...
        'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'Ñ' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'Ü' 'V' 'W' 'X' 'Y' 'Z' ...
        'á' 'é' 'í' 'ó' 'ú' 'Á' 'É' 'Í' 'Ó' 'Ú' '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' ' ' '?' '¿' '.' ',' ';' ':' '-' '!' '¡' '_' '$'];
    %Se define el módulo de todas las operaciones
    module = length(alphabet);
    %module = length(alphabet) - 1;
    %Se rellena el mensaje con "_" si no es múltiplo de 4
    mod_message = mod(length(message), 4);
    if  mod_message ~= 0
        for k = 1 : 4 - mod_message
            message(end + 1) = '_';
        end
    end
    clear mod_message;
    
    %Creando la matriz de xi (4xN), matriz que contiene las letras a cifrar
    message_to_matrix = zeros(4, length(message)/4);
    for k = 1 : length(message)/4
        for j = 1 : 4
            message_to_matrix(j, k) = find(alphabet == message(4*k - 4 + j));
        end
    end
    %Definiendo la matriz cuadrada con la que se cifrarán los datos
    K = [8 6 9 5; 6 9 5 10; 5 8 4 9; 10 6 11 4];
    %Creando el mensaje
    y = mod(K * message_to_matrix, module);
    new_message = "";
    for k = 1 : length(message)/4
        for j = 1 : 4
            if y(j,k) == 0
                new_message = strcat(new_message, alphabet(module));
            elseif alphabet(y(j, k)) == ' '
                new_message = strcat(new_message, '#');
            else
                new_message = strcat(new_message, alphabet(y(j, k)));
            end
        end
    end
    new_message = strrep(new_message, '#', ' ');
end

