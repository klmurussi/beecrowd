#include <iostream>
#include <iomanip>

int main () {
    float A, B, C, media;
	std::cin >> A >> B >> C;
    media = (2* A + 3 * B + 5 * C)/10;
    std::cout << "MEDIA = " << std::fixed << std::setprecision(1) << media << std::endl;
	return 0;
}
