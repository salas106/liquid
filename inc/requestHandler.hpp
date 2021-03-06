#pragma once

#include <ev++.h>
#include "parser.hpp"
#include "db.hpp"

class RequestHandler {
	private:
		static TorrentMap torMap;
		static UserMap usrMap;
		static Database *db;
		static std::string announce(const Request*, const std::string&, const bool&);
		static std::string scrape(const std::forward_list<std::string>*, const bool&);
		static std::string update(const Request*, const std::string&);
		static std::string changePasskey(const Request*);
		static std::string addTorrent(const Request*);
		static std::string deleteTorrent(const Request*);
		static std::string updateTorrent(const Request*);
		static std::string addUser(const Request*);
		static std::string removeUser(const Request*);
		static std::string addToken(const Request*, const std::string&);
		static std::string removeToken(const Request*, const std::string&);
	public:
		static void init();
		static std::string handle(std::string, std::string);
		static User* getUser(const std::string&);
		static void stop();
		static void clearTorrentPeers(ev::timer&, int);
};
