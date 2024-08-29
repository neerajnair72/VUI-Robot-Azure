run_all_in_parallel:
	make -j test_Windows_10_chrome_103 

# 	robot -x 'outputxunit.xml' --variable platform:"Windows 11" --variable browserName:MicrosoftEdge --variable version:103 --variable ROBOT_BROWSER:chrome --variable visual:true --variable network:false --variable console:true --outputdir Results/Windows11/Edge 'rf-tests/Find A Dealer.robot'

test_Windows_10_chrome_103:
	robot --variable version:16 --variable platformName:"MacOS Ventura" --variable smartUI.project:'Boston Whaler' --variable browserName:Safari --variable isRealMobile:false --variable visual:false --variable network:false --variable w3c:true --variable console:false --outputdir Results/Windows11/Edge 'rf-tests/Find A Dealer.robot'

test_MacOS_Sierra_chrome_103:	
 	robot -x 'outputxunit.xml' --variable platform:"macOS Sierra" --variable browserName:chrome --variable version:103 --variable ROBOT_BROWSER:chrome --variable visual:true --variable network:false --variable console:true --outputdir Results/macOSSierra/Chrome 'rf-tests/Find A Dealer.robot'
	
