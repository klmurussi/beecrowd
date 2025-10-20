#include <iostream>
#include <vector>
#include <algorithm>
#include <iomanip>
#include <numeric>

struct Residencia {
    int moradores;
    int consumoTotal;
    int consumoMedio() const { // consumo médio arredondado para baixo
        return consumoTotal / moradores;
    }
};

void processar_cidade(int numero_cidade) {
    int n;
    if (!(std::cin >> n) || n == 0) return; // condição de parada

    std::vector<Residencia> residencias(n);
    // Variáveis para cálculo do consumo médio
    int sum_moradores = 0; // máximo de moradores por cidade: 10⁷
    int sum_consumo = 0; // máximo de consumo por cidade: 2×10⁸
    int consumo[201] = {0};

    for (int i = 0; i < n; ++i) {
        std::cin >> residencias[i].moradores >> residencias[i].consumoTotal;
        sum_moradores += residencias[i].moradores;
        sum_consumo += residencias[i].consumoTotal;

        consumo[residencias[i].consumoMedio()] += residencias[i].moradores;
    }

    // Quantidade de moradores por consumo médio > 0
    std::vector<std::pair<int, int>> dados_agrupados;

    for (int i = 0; i < 201; ++i) {
        if (consumo[i] > 0) {
            // Par (número de moradores, consumo médio)
            dados_agrupados.emplace_back(consumo[i], i);
        }
    }

    std::sort(dados_agrupados.begin(), dados_agrupados.end(), 
        [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
        return a.second < b.second; // ordenar pelo consumo médio
        }
    );

    if (numero_cidade > 1) {
        std::cout << "\n";
    }
    std::cout << "Cidade# " << numero_cidade << ":\n";

    for (size_t i = 0; i < dados_agrupados.size(); ++i) {
        const auto& [moradores, consumo] = dados_agrupados[i];
        std::cout << moradores << "-" << consumo;
        if (i < dados_agrupados.size() - 1) {
            std::cout << " ";
        }
    }

    // Consumo médio com duas casas decimais (sem arredondamento)
    // Multiplicamos por 100 antes da divisão para evitar problemas com ponto flutuante
    int valor_x100    = (long long)sum_consumo * 100 / sum_moradores;
    int parte_inteira = valor_x100 / 100;
    int parte_decimal = valor_x100 % 100;

    std::cout << "\nConsumo medio: " 
            << parte_inteira << "." 
            << std::setw(2) << std::setfill('0') << parte_decimal 
            << " m3.\n";
}

int main() {
    std::ios_base::sync_with_stdio(false);
    std::cin.tie(NULL);

    int i = 1;
    while (std::cin.peek() != EOF) {
        processar_cidade(i++);
    }
    return 0;
}