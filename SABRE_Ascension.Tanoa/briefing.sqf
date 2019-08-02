// Sabre Team's Objectives
[ sabre, 
	
	["primTasks", "These are your primary objectives. In order to finish the mission, all of these tasks must be completed.", "Primary Objectives", ""],   
    
	[["meetTask", "primTasks"], "Meet up with <font color='#D22E2E'>Agent Fox</font>, in the <marker name='ctrgMkr'>Village of Nasua</marker>, which he and his <font color='#D22E2E'>CTRG</font> team cleared for you.", "Meet Agent Fox", "", Fox, "assigned", "meet"],
	
	[["stealTasks", "primTasks"], "Assist Agent Fox in aquiring a <font color='#D22E2E'>CSAT Y-32 Xi'an VTOL</font> that is located at <marker name='vtolBaseMkr'>Comms Bravo</marker>.","Help Steal VTOL", ""],
	
	[["clearTask", "stealTasks"], "<font color='#D22E2E'>Clear out</font> the CSAT outpost at <marker name='vtolBaseMkr'>Comms Bravo</marker> so Fox's VTOL pilot can attempt to <font color='#D22E2E'>steal the VTOL</font>.","Clear Comms Bravo","",getMarkerPos "vtolBaseMkr", "created", "attack"],
	
	[["empTask", "primTasks"], "Place a GPS tracker on the <font color='#D22E2E'>CSAT EMP</font> stored somewhere at <marker name='empMkr'>Comms Alpha</marker>.","Place Tracker on EMP","",getMarkerPos "empMkr", "created", "interact"],
	
	[["intelTask", "primTasks"], "<font color='#D22E2E'>Download</font> all the intel CSAT has stored on their research <font color='#D22E2E'>data terminals</font> located in <marker name='volMkr'>Mount Tanoa</marker>. Fox believes there are <font color='#D22E2E'>only two data terminals</font> at the research site.","Download Intel","",getMarkerPos "volMkr", "created", "intel"]
	
] call FHQ_fnc_ttAddTasks;

// Sabre team's briefing
[ sabre,

	// MISSION BRIEF *********************************************************************
	["Situation", "<img image='images\agents.jpg' width='370' height='208'/><br/><br/>Last week we received information from one of our agents operating in the southern Pacific Island of Tanoa. He said that <font color='#D22E2E'>CSAT is planning something big</font>. The agent goes by the codename ''<font color='#D22E2E'>Fox</font>'', and he has been running intelligence gathering oprerations on Tanoa for about 6 years now. He's in command of a CTRG spec ops team and a small two man Tier One unit. However, he said that he needs more men so he can figure out CSAT's plan before it's to late. So we decided to send the best men we had for the job. You'll be deep in CSAT territory on Tanoa, so watch your backs.<br/><br/>Your team will be <font color='#D22E2E'>brought to the Tanoan shoreline via a civilian boat</font> so as not to draw attention. Once on shore, you are to wait for Fox's contact, who will arrive in a truck to bring you to him.<br/><br/>Also, we wanted to inform you that the <font color='#D22E2E'>coup in Altis</font> has almost been contained and we've managed to retake the Capital thanks to your team's efforts a couple of weeks ago. However, we still haven't been able to locate the main coup conspirator, AAF General Zane."],
	
	["Mission", "<font color='#D22E2E'>Assist Agent Fox</font> by acquiring CSAT assets and gathering information on their operations on Tanoa."],  
	
	["Supports", "<img image='images\drone.jpg' width='370' height='208'/><br/><br/>Agent Fox is providing your squad with a <font color='#D22E2E'>A-2 Darter UAV</font>."],
	
	["Signal", "<font color='#D22E2E'>Sabre</font> - Your team<br/><br/><font color='#D22E2E'>Spectre</font> - Agent Fox"],
	
	["Resupply Boxes", "If you need to rearm, <font color='#D22E2E'>look for CSAT resupply boxes</font>.<br/><br/><img image='images\ammo1.jpg' width='370' height='208'/><br/><img image='images\ammo2.jpg' width='370' height='208'/>"],
	
	["Team Abilities", "<img image='images\commandos.jpg' width='370' height='208'/><br/><br/>The members of Sabre Team are hardened veterans who have undergone extreme conditioning and training. All the units of <font color='#D22E2E'>Sabre Team can carry 25% more gear</font> than the standard soldier without getting tired as quickly."],
	
	// CREDITS **************************************************************************
	["Credits", "Developer", "<font color='#D22E2E' size='20'>Mission Developer:</font><br/>AlphaDog"],    
	
	["Credits", "Testing/Feedback", "<font color='#D22E2E' size='20'>Mission Testers:</font><br/>Garrett S.<br/><br/>Thanks for the feedback!"],
	
	["Credits", "Music", "<font color='#D22E2E' size='20'>Music Credits:</font><br/><font color='#D22E2E'>Paint It, Black</font> by The Rolling Stones<br/><font color='#D22E2E'>Top Secret</font> by Sovereign<br/><font color='#D22E2E'>All Along the Watchtower</font> by Jimi Hendrix"],
	
	["Credits", "Special Thanks", "<font color='#D22E2E' size='20'>Thank You:</font><br/><font color='#D22E2E'>Varanon</font> for FHQ Tasktracker (Great tool for making multiplayer compatible tasks)<br/><font color='#D22E2E'>Revo</font> for 3den Enhanced (Excellent improvements to the 3D editor)<br/><font color='#D22E2E'>LSD</font> for ZEC - Zeus and Eden Templates / Building Compositions (Saved me so much time)<br/><font color='#D22E2E'>Psycho</font> for his excellent revive script<br/><font color='#D22E2E'>Sovereign</font> for his incredible stealth music."],
	
	// CODEX ****************************************************************************
	["Sabre Codex", "Sabre Universe Summary", "<font color='#D22E2E' size='20'>Universe Summary:</font><br/>The Sabre Series takes place in an alternate universe than Arma 3's. The series starts off twelve years after the botched invasion of the Republic of Altis by CSAT in the year 2023, now known as the November Offensive. This event sparked global tensions that have only been growing increasingly more hostile in the following years. With CSAT attempting to destablize the world in their favor, NATO assembled a commando team of the five most elite soldiers they had. The commandos would be sent on only the most danagerous of missions where the odds of survival would be minimal. They would almost always be outnumbered, but never out gunned. These commandos are known as Sabre Team."],
	
	["Sabre Codex", "The November Offensive","<img image='images\Planes.jpg' width='420' height='236'/><br/><font color='#D22E2E' size='20'>The November Offensive</font><br/><br/><font color='#D22E2E'>Length:</font> November 23rd, 2023 - November 17th, 2024<br/><br/><font color='#D22E2E'>Outcome:</font> Stalemate - Treaty signed by NATO and CSAT<br/><br/><font color='#D22E2E'>About:</font><br/>The CSAT invasion of Altis and Stratis, also known as the November Offensive, was a massive CSAT military operation with the goal of taking over both of the islands in order to gain a foothold in the Mediterranean. On November 23rd, 2023 CSAT launched a large scale aerial assault on Altis and Stratis. Within days, CSAT seemed like it had already won because NATO had lost 90 percent of Stratis and had abandoned Pyrgos, the Captial of Altis. However, CSAT failed to capture Stratis Airbase for months because the base commander went against his orders to evacuate and had his troops defend it ferociously. This meant that CSAT couldn't use the airbase to continuously launch aerial assaults on Altis, which crippled their initial plan. With the lack of the onslaught of aerial bombardments, CSAT began to lose the war because they were now fighting against the combined forces of NATO, the AAF, and the FIA on Altis, as well as exhausting their resources trying to take Stratis Airbase. However, they did eventually take the airbase when NATO evacuated and raised it, but by that time it was far to late to make repairs and attempt to make a comeback. On November 6th, 2024 after a deserate failed attempt to try and lay siege to Atlis Airbase, CSAT withdrew their forces from Altis. On November 17th a treaty was signed between NATO and CSAT, which ended the fighting and allowed NATO to keep their forces on Altis and CSAT to maintain their forces on Stratis. For the past 11 years, NATO and CSAT have still continued to remain hostile towards each other, and CSAT has sometimes been caught on Altis doing nefarious things."],
	
	["Sabre Codex", "Sabre Team", "<img image='images\Commandos.jpg' width='370' height='208'/><br/><font color='#D22E2E'>Summary:</font><br/>The NATO commando team: Sabre, was created to quickly and efficiently complete tasks behind enemy lines. These tasks are deemed too difficult for normal soldiers. The Team is comprised of effective, highly skilled, heavily trained, and intelligent individuals hand picked by NATO High Command. When NATO needs to accomplish a goal in a swift and deadly manner, they activate Sabre Team. The commandos are often tasked with rescue, capture, assassination or sabotage operations, but are sometimes assigned other ''miscellaneous'' objectives."],
	
	["Sabre Codex", "Caesar", "<img image='images\Caesar.jpg' width='420' height='236'/><br/><font color='#D22E2E'>Name:</font> Jason ''Caesar'' Bradley<br/><br/><font color='#D22E2E'>Rank:</font> Lieutenant<br/><br/><font color='#D22E2E'>DOB:</font> Febuary 22nd, 1998<br/><br/><font color='#D22E2E'>Squad Role:</font> Team Leader<br/><br/><font color='#D22E2E'>Place of Origin:</font> New York, United States<br/><br/><font color='#D22E2E'>Preferred Weapon:</font> TRG-21 EGLM 5.56mm<br/><br/><font color='#D22E2E'>Bio:</font><br/>Jason Bradley, or Caesar as he has been nicknamed, is a renowned leader and soldier. Caesar joined up with the United States Army when he was 18 years old. He quickly became recognized as someone who could be a capable leader, but when asked about being promoted, he denied the offer because of the responsibility that it came with. When his tour with the army was done, he was offered a very well paying job by ION, a private military corporation. As an ION mercenary, Caesar began to head up special operation contracts for the company. However, he began to grow suspicious of ION's business decisions and started to watch his back. When ION's delta convoy was questionably ambushed, which resulted in the deaths of most of Caesar's friends, as well as the Altian politicians the convoy was escorting, Caesar was forced to lead the remaining mercenaries out of the chaotic slaughter. Later that day he resigned from ION and fell off the face of the Earth. Soon after Caesar's disappearance, the officer that oversaw Delta convoy's activities was found shot to death along with his whole security team on his estate. It was believed the FIA had sent assassins to kill him because he was known to make shady deals with the wrong people, but know one knows for sure what happened. Then, after CSAT's failed invasion of Atlis, Caesar re-emerged and signed up for another tour with the U.S. Army. Having overcome the stress of leading men into battle from his experience with ION, Caesar then decided that he would except the offer of being promoted. He was assigned a role as a squad leader and quickly rose through the ranks due to his intelligence, prior combat experience, and excellent leadership skills. Some men even claimed that he did a better job at commanding his men than some of NATO's high ranking officers did. He eventually caught NATO's attention when they were looking for a soldier to lead their new commando team. Which is why he was given the role as the leader of the now infamous Sabre Team."],
	
	["Sabre Codex", "Taz", "<img image='images\Taz.jpg' width='420' height='236'/><br/><font color='#D22E2E'>Name:</font> Marcus ''Taz'' Abrams<br/><br/><font color='#D22E2E'>Rank:</font> Sergeant<br/><br/><font color='#D22E2E'>DOB:</font> August 9th, 2000<br/><br/><font color='#D22E2E'>Squad Role:</font> Anti-Tank<br/><br/><font color='#D22E2E'>Place of Origin:</font> England<br/><br/><font color='#D22E2E'>Preferred Weapon:</font> His bare hands<br/><br/><font color='#D22E2E'>Bio:</font><br/>Taz is somewhat mentally unstable, but loyal to his comrades and one of the most efficient killing machines NATO has ever possessed. Taz served as a royal marine during the CSAT offensive on the islands of Altis and Stratis 12 years ago. He and about 200 royal marines and 900 U.S. soldiers defended the island of Stratis. However, when NATO evacuated the airbase, Taz was left behind. Angry and alone, Taz believed he was going to die on the island, but not before he could cause as much chaos as he could. For seven months he waged a one man war with CSAT forces on Stratis using fast guerilla style attacks. CSAT could never kill him because of his overwhelming speed and aggression. Thus he became known as the ‘’Tasmanian Devil’’ by CSAT forces, and kept the name for himself. Taz eventually found and rescued some POWs from CSAT, which forced him to somehow get a hold of his old commander, who sent SAS forces to Stratis to have Taz and the POWs extracted. However, Taz’s mind was far gone from reality. He wanted to stay on the island to die violently at the hands of his enemies. Luckily the SAS team ‘’convinced him’’ to leave. Upon his return, the Royal Navy deemed him unfit for duty due to his mental health, but his old commander evaluated him and countered their decision. After some debate, Taz was reinstated to active duty and given the Victoria Cross for his actions on Stratis, and is now part of the Sabre Commandos."],
	
	["Sabre Codex", "Hawkes", "<img image='images\Hawkes.jpg' width='420' height='236'/><br/><font color='#D22E2E'>Name:</font> Adam ''Hawkes'' [REDACTED]<br/><br/><font color='#D22E2E'>Rank:</font> Sergeant<br/><br/><font color='#D22E2E'>DOB:</font> [REDACTED], 2002<br/><br/><font color='#D22E2E'>Squad Role:</font> Sniper<br/><br/><font color='#D22E2E'>Place of Origin:</font> [REDACTED]<br/><br/><font color='#D22E2E'>Preferred Weapon:</font> M320 LRR .408 or the GM6 Lynx 12.7mm<br/><br/><font color='#D22E2E'>Bio:</font><br/>Unavailable to view due to security clearance level.<br/><br/>Side note - Hawkes's details are hard to come by because most of his military career has been blacked out. All we know is that he is a very efficient marksman who has had some advanced sniper training."],
	
	["Sabre Codex", "Foster", "<img image='images\Foster.jpg' width='420' height='236'/><br/><font color='#D22E2E'>Name:</font> Jerome ''Foster'' Wilcox <br/><br/><font color='#D22E2E'>Rank:</font> Corporal<br/><br/><font color='#D22E2E'>DOB:</font> July 13, 2006<br/><br/><font color='#D22E2E'>Squad Role:</font> Engineer<br/><br/><font color='#D22E2E'>Place of Origin:</font> Michigan, United States<br/><br/><font color='#D22E2E'>Preferred Weapon:</font> His custom MX 6.5mm<br/><br/><font color='#D22E2E'>Bio:</font><br/>Before Foster made a military career of being an engineer, he was a mechanic that worked on cars, particularly street racing cars. He was a master of his craft. However, when his racing crew started getting arrested, he felt that he was next in line. So he decided it was time to high tail it out of Chicago. With his life and business now in shambles and nothing to lose, he chose to join up with the U.S. Army. After training, he was assigned to an EOD squad. One day, the squad was ambushed when they were attempting to disarm an IED. The insurgents managed to disable the armored vehicle that Foster and his squad were using at the time. When all seemed lost and the squad had no means of escape, that's when Foster's repair skills came in handy. While under heavy fire, he managed to collect parts from vehicles and garages that were in the area and used them to repair the squad's vehicle, which they then used to escape from the area. This action earned Foster the Army's Distinguished Service Medal, as well as an engineer position in another squad. In time, he was selected to be a part of Sabre Team because they needed a reliable and courageous engineer to assist them in their missions."],
	
	["Sabre Codex", "Apollo","<img image='images\Apollo.jpg' width='420' height='236'/><br/><font color='#D22E2E'>Name:</font> Dameon ''Apollo'' Scafidi <br/><br/><font color='#D22E2E'>Rank:</font> Corporal<br/><br/><font color='#D22E2E'>DOB:</font> December 3, 2001<br/><br/><font color='#D22E2E'>Squad Role:</font> Medic<br/><br/><font color='#D22E2E'>Place of Origin:</font> Altis<br/><br/><font color='#D22E2E'>Preferred Weapon:</font> Zubr .45 Revolver<br/><br/><font color='#D22E2E'>Bio:</font><br/>Apollo is one of the best combat medics out there, bar none. He originally was a combat medic in the AAF during the November Offensive. He is fearless and will run into heavy fire to provide aid to his fallen comrades, which is exactly what he did during the siege of Kavala in 2024. While the area was being bombarded by CSAT artillery, he was grabbing the wounded and pulling them off the fields and streets. During all the chaos he was shot twice, suffered multiple shrapnel wounds, and had a house partially collapse on him. Somehow he survived all of that and continued to make runs to help the wounded until he collapsed from blood loss and exhaustion hours later. When he awoke, he realized that he had been captured along with several badly wounded soldiers. Using what little tools he had, he assisted the men without tending to his own wounds. Apollo remained a POW for the next 4 months until the FIA attacked the prison camp he was being held in, which the captives took as their chance to escape, but Apollo had other plans. He used the distraction of the attack to search for the camp's commanding officer, who had tortured the captives of the camp including Apollo himself. Eventually Apollo came face-to-face with the officer and brutally killed him. He then stole a medical truck, gathered the surviving captives, and left the camp unaware he had just killed one of CSAT's most notorious commanders. However, Apollo's actions did not go unnoticed. He received many medals for his courageous acts at Kavala and the prison camp, which he believed should've gone to the families of those he couldn't save. Years after the conflict he signed up to be a part of Task Force Aegis where he was still recognized as the hero of Kavala by many of the U.S. soldiers. When Colonel Maxis was choosing a medic for Sabre Team and came across Apollo's name, he immediately chose him to fill the squad's medic slot."],
	
	["Sabre Codex","Duke (Blazerunner)","<img image='images\Duke.jpg' width='420' height='236'/><br/><font color='#D22E2E'>Name:</font> Jonathan ''Duke'' Weyner <br/><br/><font color='#D22E2E'>Rank:</font> Captain<br/><br/><font color='#D22E2E'>DOB:</font> May 17th, 1997<br/><br/><font color='#D22E2E'>Squad Role:</font> Pilot<br/><br/><font color='#D22E2E'>Place of Origin:</font> Nebraska, United States<br/><br/><font color='#D22E2E'>Preferred Weapon:</font> N/A<br/><br/><font color='#D22E2E'>Bio:</font><br/>Since Duke was young, all he wanted to do was fly. He wanted to be a commercial pilot like his father was. He couldn't wait to get his pilots license, but before he could, tragedy struck when his father died piloting a Boeing 747 that experienced a massive engine failure. This sent Duke into a deep alcoholic depression for 4 years. Eventually, he realized that his father would be ashamed of what he had become. So he decided to clean up his act and go back to flight school. After getting his pilots license and becoming a commercial pilot, he came to the conclusion that he wanted to do something more with his skills. So he joined up with the U.S. Airforce and has become somewhat infamous from his quote-on-quote ''ballsy'' flying during the chaotic first few hours of the November Offensive. During that time he saved the lives of many AAF and NATO soldiers, as well as some civilians. Also, he got his callsign, Blazerunner, because of all the flak his chopper took during the invasion, which to the ground troops, made it look like he was outrunning a blaze of explosions. Nowadays, Duke pilots an experimental variant of the Ghosthawk, which has vastly more improved stealth capabilities than the standard Ghosthawk. To quote Duke, ''She may look like a dove on radar, but when she gets within eyesight, she's a demonic lead spittin' bitch.'' Duke was also hand picked by Colonel Maxis to be Sabre Team's personal helicopter pilot because he and his tight-knit crew are heavily experienced airmen and have cheated death for years."],
	
	["Announcements", "Updates", "<font color='#D22E2E' size='20'>Announcements:</font><br/>If you are new to my missions, then welcome! If you are a returning player, then thanks once again for playing my missions. Please see my <font color='#D22E2E'>mission collection</font> on Steam for up-to-date announcements and info.<br/><br/>Thank you,<br/><font color='#D22E2E'>AlphaDog</font>"]
] call FHQ_fnc_ttAddBriefing;