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
	worldSize = 4; 
	hasGold = false;
	hasArrow = true;
	WumpusLocation = Location(4,4);
	WumpusAlive = true;
	inCave = true;
	agentAlive = true; // we may or may not need this since the agent only shoots at Y=4 & X=4 
}

Action Agent::Process (Percept& percept)
{
	char c;
	Action action;
	bool validAction = false;
	// adding additional booleans to keep track of various elements
	// adding elements based off of the WorldState.h 
	
	

	//Reflex Rules
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
		// this will randomize our actions
		action = static_cast<Action> (rand()%3);
		// if statement to check if the movement of the randomized action 
		if(action == GOFORWARD){
			switch(agent_orientation) // using a switch statement to differentiate between the 4 possible positions
			{
				case UP:
					agent_position.X++;
					break;
				case RIGHT:
					agent_position.Y++;
					break;
				case DOWN:
					agent_position.X++;
					break;
				case LEFT:
					agent_position.Y++;
					break;
			}

			// we need to make sure the agent stays within the parameters of the worldSize
			// 
			if((agent_position.X > worldSize)||(agent_position.X < 1)
			   || (agent_position.Y > worldSize)|| (agent_position.Y < 1)){
				return;
			}
			else{
				agent_position = Location(agent_position.X,agent_position.Y); // updates the position of the agent
			}
		}
		// switch statement for each of the positions depending on its current orientation
		//updates what the orientation is at each case
		else if(action == TURNLEFT){
			switch(agent_orientation) 
			{
				case UP:
					agent_orientation=LEFT;
					break;
				case RIGHT:
					agent_orientation=UP;
					break;
				case DOWN:
					agent_orientation=RIGHT;
					break;
				case LEFT:
					agent_orientation = DOWN;
					break;
			}
			
		}
		// switch statement for each of the positions depending on its current orientation
		//updates what the orientation is at each case
		else if(action == TURNRIGHT){
			switch(agent_orientation)
			{
				case UP:
					agent_orientation = RIGHT;
					break;
				case RIGHT:
					agent_orientation = DOWN;
					break;
				case DOWN:
					agent_orientation= LEFT;
					break;
				case LEFT:
					agent_orientation = UP;
					break;
			}

		}
	}
	return action;
}

void Agent::GameOver (int score)
{

}

