#pragma once

#include "parser.hpp"
#include "torrent.hpp"
#include "db.hpp"

typedef std::map<std::string, Torrent> torrentMap;

class RequestHandler {
	private:
		static torrentMap torMap;
		static userMap usrMap;
		static Database *db;
		static std::string announce(const request&);
	public:
		static void init();
		static std::string handle(std::string, std::string);
		static User* getUser(const std::string&);
};
