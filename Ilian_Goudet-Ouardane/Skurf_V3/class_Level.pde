
class Level {

  int agentNumber;
  int agentRatePop;
  int meteorNumber;
  int meteorRatePop;
  int agentEaten;
  float meteorSpeed;

  Level(int agentNumber, int meteorNumber, int agentRatePop, int meteorRatePop, int agentEaten, float meteorSpeed) {
    this.agentNumber = agentNumber;
    this.meteorNumber = meteorNumber;
    this.agentRatePop = agentRatePop;
    this.meteorRatePop = meteorRatePop;
    this.agentEaten = agentEaten;
    this.meteorSpeed = meteorSpeed;
    println(agentNumber, meteorNumber);
  }
}
