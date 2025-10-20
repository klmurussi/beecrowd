#include <iostream>
#include <iomanip>

int main () {
    float A, B, media;
	std::cin >> A >> B;
    media = (3.5* A + 7.5 * B)/11;
    std::cout << "MEDIA = " << std::fixed << std::setprecision(5) << media << std::endl;
	return 0;
}
