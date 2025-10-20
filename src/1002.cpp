#include <iostream>
#include <iomanip>

int main () {
    double pi = 3.14159, raio, area;
	std::cin >> raio;
    area = pi * raio * raio;
    std::cout << "A=" << std::fixed << std::setprecision(4) << area << std::endl;
	return 0;
}
