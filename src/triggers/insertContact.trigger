trigger insertContact on Account (after insert) {
	//adding some comments
    Contact cont = new Contact();
    cont.LastName = Trigger.new[0].name;
    cont.AccountId = Trigger.new[0].ID; 
    insert cont;
}