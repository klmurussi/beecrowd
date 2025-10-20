#include <iostream>
#include <iomanip>

int main () {
    int numFuncionario, horasTrabalhadas;
    float valorHora, salario;
	std::cin >> numFuncionario >> horasTrabalhadas >> valorHora;
    salario = horasTrabalhadas * valorHora;
    std::cout << "NUMBER = " << numFuncionario << std::endl;
    std::cout << "SALARY = U$ " << std::fixed << std::setprecision(2) << salario << std::endl;
	return 0;
}
