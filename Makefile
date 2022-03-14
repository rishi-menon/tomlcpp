
all:
	g++ -Wall -Wextra -o main main.cpp tomlcpp.cpp toml.cpp

run:
	./main