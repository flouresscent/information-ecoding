%% Алгоритм кодирования Шеннона-Фано
%
% Основные этапы кодирования:
% 1. Символы первичного алфавита m1 выписывают по убыванию вероятностей.
% 2. Символы полученного алфавита делят на две части, суммарные вероятности символов которых максимально близки друг другу.
% 3. В префиксном коде для первой части алфавита присваивается двоичная цифра «0», второй части — «1».
% 4. Полученные части рекурсивно делятся, и их частям назначаются соответствующие двоичные цифры в префиксном коде.
%
% Когда размер подалфавита становится равен нулю или единице, то дальнейшего удлинения префиксного кодадля соответствующих ему
% символов первичного алфавита не происходит, таким образом, алгоритм присваивает различным символам префиксные коды разной длины.
% На шаге деления алфавита существует неоднозначность, так как разность суммарных вероятностей p0 - p1 может быть одинакова
% для двух вариантов разделения (учитывая, что все символы первичного алфавита имеют вероятность больше нуля).
%%

clear all;
clc;

% Вводим фразу
text = input('Введите фразу: ','s');

% Находим длину фразы
text_len = length(text);
% Находим уникальные символы
uniq_symb = unique(text);
% Находим длину алфавита
alph_len = length(unique(text));

% Вычисляем энтропию исходного сообщения
entr = entropy(text);
[symbs_, probs] = alphabet_probabilities(text);
freqs = probs * length(text);
freqs = uint32(freqs);
% Считаем общее кол-во
M = uint32(sum(freqs));
extra_state = zeros(1, length(text), "uint32");
 
% fprintf('\n Символ \t Количество \t Частота \n')%таблица

%% Кодирование фразы
% Берем i от 1 до количество алфавита
for i = 1:length(uniq_symb)
    % Ищем длину каждого уникального символа
    uniq_symb_len = length(findstr(text, uniq_symb(i)));
    % Частота
    freq = uniq_symb_len / text_len;
    AA(i, 1) = freq;
    % Строим таблицу
    % fprintf('\n %c \t %d \t %d \n', uniq_symb(i), uniq_symb_len, freq);
    % Присваиваем эту таблицу
    matrix(i,:) = {uniq_symb(i), uniq_symb_len, freq};
end
 
for j = 1:length(uniq_symb)
    % Присваиваем столбец частот
    P(j) = matrix{j, 3};
end

% Преобразуем столбец частот в ASCII-код
S = abs(P);
% Сортируем по убыванию
[z, ind] = sort(-S);
% Выводим отсортированную таблицу
full_tab_of_symbs = matrix(ind,:);

% Создаем квадратную матрицу из нулей
A = zeros(length(uniq_symb));
 
alfa = length(uniq_symb);
 
[z, ind] = sort(-AA);
AAA = AA(ind, 1);
yv = 0;
yt = 0;
first = 1;
final = alfa;
 
XXX = zeros(length(uniq_symb));
XXX(1:length(uniq_symb), 1:length(uniq_symb)) = 9;
 
for XX = 1:alfa
    if yv <= yt yv = yv + AAA(first,1);  XXX(first, 1)=0; 
        XX1(first, 1) = AAA(first, 1); first = first+1;
    else yt = yt + AAA(final, 1); XXX(final, 1) = 1 ;
        XX2(final, 1) = AAA(final, 1); final = final - 1;
    end
end

% disp(XXX)
% disp(XX1)
% disp(XX2)
 
yv = 0;
yt = 0;
first1 = 1;
final1 = first;
for YY = 1:first
    if yv <= yt yv = yv + XX1(first1, 1); XXX(first1, 2) = 0; 
        XX3(first1, 1) = XX1(first1, 1); first1 = first1 + 1;
    else yt = yt + AAA(final1, 1); XXX(final1, 2) = 1 ;
        XX4(final1, 1) = AAA(final1, 1); final1 = final1 - 1;
    end
end

% disp(XX3)
% disp(XX4)
% disp(XXX)

% Создаем матрицу-столбец из единиц
B = ones(length(uniq_symb), 1);
% Присваиваем к последнему столбцу нулевой матрицы эту матрицу-столбец
A(:, length(uniq_symb)) = B;
 
for l = 1:length(uniq_symb) - 1
    for m = length(uniq_symb) - 1:-1:l
        % Заменяем ненужные нули девятками
        A(l, m) = 9;
    end
end
 
symbs = full_tab_of_symbs(:, 1);
code_matr = A;
 
for w = 1:text_len
    for e = 1:length(uniq_symb)
        if text(w) == full_tab_of_symbs{e,1}
            % Кодируем фразу
            J(w,:) = A(e,:);
        end
    end
end

% Создаем единичную матрицу
W = ones(1, text_len * length(uniq_symb)); 
 
W = J.';
% Записываем матрицу в массив
a = W(:);
H = 9;
% Исключаем 9
a(a == H) = [];
enc_mes = a';
 

%% Декодирование фразы
% Находим длину кода
code_len = length(enc_mes);
mes_len = 0;

for n = 1:code_len
    if enc_mes(n) == 1
        % Находим длину фразы(количество символов = количество 1) 
       mes_len = mes_len + 1;
    end
end
 
mes_len;
% Находим длину алфавита(по таблице)
alph_mes_len = length(symbs);
 
for b = 1:alph_mes_len
    % Находим количество нулей для каждого символа
    zeros_quant(1, b) = length(findstr(code_matr(b,:), 0));
end
 
x = zeros(1, mes_len); 
S = 1;
 
while S <= mes_len
    for t = 1:code_len
        if enc_mes(t) == 0
            % Считаем количество 0 перед кадой единицей
            x(S) = x(S) + 1;
        else
            x(S) = x(S);
            S = S + 1;
        end 
    end
end
 
for y = 1:mes_len
    for q = 1:alph_mes_len
        % Сравниваем количество нулей в коде перед каждой единицей и количество нулей каждого символа
        if x(y) == zeros_quant(q)
            % Выводим фразу
            message(y) = symbs(q);
        end
    end
end

%% Вывод
fileID = fopen('original_message.txt','w+');
% Записываем исходное сообщение в файл
fprintf(fileID, text);
fclose(fileID);
disp("[INFO] Создан файл с исходным сообщением");

enc_mes_str = "";
for k = 1:length(enc_mes)
    enc_mes_str = enc_mes_str + string(enc_mes(k));
end

message_str = "";
for j = 1:length(message)
    message_str = message_str + string(message(j));
end

match_quant = 0;
for m = 1:text_len
    if text == message_str
        match_quant = match_quant + 1;
    end
end

fileID = fopen('decoded_message.txt','w+');
% Записываем закодированное сообщение в файл
fprintf(fileID, message_str);
fclose(fileID);
disp("[INFO] Создан файл с декодированным сообщением");

fileID = fopen('encoded_message.txt','w+');
% Записываем декодированным сообщением в файл
fprintf(fileID, enc_mes_str);
fclose(fileID);
disp("[INFO] Создан файл с декодированным сообщением");
fprintf(newline);

text_file_size = dir('original_message.txt').bytes * 8;
decode_file_size = 32 + sum(extra_state ~= 0) * 32;

% disp("[INFO] Закодированное сообщение " + string(enc_mes_str))
% disp("[INFO] Декодированное сообщение " + string(message_str))
disp("[INFO] Cовпадения исходного сообщения и декодированного " + string(match_quant/length(text) * 100) + "%");
disp("[INFO] Энтропия сообщения " + string(entr)); 
disp("[INFO] Среднее кол-во бит на символ в закодированном сообщении " + string(decode_file_size / double(M)));
disp("[INFO] Разница в объемах памяти оргинального сообщения и закодированного составила " + string(text_file_size - decode_file_size) + " бит");
