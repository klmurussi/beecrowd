#include <iostream>
#include <iomanip>
#include <string.h>

int main () {
    std::string nome;
    double salario, vendas, total;
	std::cin >> nome >> salario >> vendas;
    total = vendas * 0.15 + salario;
    std::cout << "TOTAL = R$ " << std::fixed << std::setprecision(2) << total << std::endl;
	return 0;
}
