// Agent.h

#ifndef AGENT_H
#define AGENT_H

#include "Action.h"
#include "Percept.h"
#include "Location.h"
#include "Orientation.h"

class Agent
{
public:
	Agent ();
	~Agent ();
	void Initialize ();
	Action Process (Percept& percept);
	void GameOver (int score);

	Location agent_position;
	Orientation agent_orientation;
	int worldSize = 4; 
	bool hasGold = false;
	bool hasArrow = true;
	Location WumpusLocation = Location(4,4);
	bool WumpusAlive = true;
	bool inCave = true;
	bool agentAlive = true; // we may or may not need this since the agent only shoots at Y=4 & X=4 
};

#endif // AGENT_H
