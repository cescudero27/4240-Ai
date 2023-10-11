// Agent.cc

#include <iostream>
#include "Agent.h"

using namespace std;

Agent::Agent ()
{

}

Agent::~Agent ()
{

}

void Agent::Initialize ()
{
	// setting out location to (1,1)
	this-> agent_position = Location(1,1);
	// setting the agent orientation to RIGHT
	this-> agent_orientation = RIGHT;
}

Action Agent::Process (Percept& percept)
{
	char c;
	Action action;
	bool validAction = false;
	// adding additional booleans to keep track of various elements
	// adding elements based off of the WorldState.h 
	bool hasGold = false;
	bool hasArrow = true;
	bool WumpusAlive = true;
	bool inCave = true;
	bool agentAlive = true; // we may or may not need this since the agent only shoots at Y=4 & X=4 


	// Checks to see if percept Glitter is true
	if(percept.Glitter){
		action = GRAB;
		hasGold = true; // we update the hasGold bool
	}
	// if agent position is at Location(1,1) & hasGold is true we Climb
	else if(agent_position == Location(1,1) && hasGold){
		action = CLIMB;
		inCave = false;
	}
	// considers if the agent has arrow and it's position on Y is at 4 and if the orientation of the agent is right
	else if(hasArrow && ((agent_position.Y == 4) && (agent_orientation == RIGHT))){
		action = SHOOT;
		hasArrow = false; // changes bool of arrow since it was fired
		WumpusAlive = false; // wumpus is dead
	}
	// considers if the agent has arrow and it's position on X is 4 and if the orientation of the agent is UP
	else if(hasArrow && ((agent_position.X == 4) && (agent_orientation == UP))){
		action = SHOOT;
		hasArrow = false; // changes bool of arrow since it was fired
		WumpusAlive = false; // wumpus is dead
	}
	// no other action is viable, so we let the agent wander around
	else{

	}
	return action;
}

void Agent::GameOver (int score)
{

}

