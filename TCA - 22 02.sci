//Primeiros contatos com SCILAB em TCA
//Criando matriz com posto 1
//Sistemas controláveis todas as linhas da matriz devem ser L.I
A = [-1 0;0 -1];
A
B = [1;1];
B
//Matriz Controlabilidade
MC = [B A*B];
MC
//Buscando posto
rank(MC)

//Criando matriz com posto 2
AA = [1 0;3 7];
rank(AA)
