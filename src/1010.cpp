#include <iostream>
#include <iomanip>
#include <vector>

struct pecas {
    int num, qtd;
    float valor;
    float total() const {
        return qtd * valor;
    }
};

int main () {
    std::vector<pecas> p(2);
    float total = 0.0;
    for (int i = 0; i < 2; i++) {
        std::cin >> p[i].num >> p[i].qtd >> p[i].valor;
        total += p[i].total();
    }
    std::cout << "VALOR A PAGAR: R$ " << std::fixed << std::setprecision(2) << total << std::endl;
	return 0;
}
