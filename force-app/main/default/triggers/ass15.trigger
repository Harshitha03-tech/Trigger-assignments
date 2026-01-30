trigger ass15 on Account (after insert, after update) {
     Helperclass15.updateRisk(Trigger.newMap.keySet());
}