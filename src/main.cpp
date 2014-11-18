#include <iostream>
#include "server.hpp"
#include "parser.hpp"
#include "config.hpp"
#include "requestHandler.hpp"

int main()
{
	std::ios_base::sync_with_stdio(false);
	try {
		//Config::load("liquid.conf");
		Server server(Config::getInt("port"));
		Parser::init();
		if (Config::get("type") == "private")
			RequestHandler::init();
		server.run();
	}
	catch (const std::exception& e) {
		std::cerr << e.what() << std::endl;
	}

	return 0;
}
