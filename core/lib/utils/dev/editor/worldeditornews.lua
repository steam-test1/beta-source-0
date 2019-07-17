- 2010-03-31

#	Helpers can be hidden with F3 and unhidden with Ctrl+F3

- 2010-02-11

#	Possible to open sequence manager files for units from the editor again

- 2009-06-17

#	Added a mission element to play music (func_music)

- 2009-06-10

#	Global select unit dialog now uses short names as default

#	Code change: Editor layers have now started to use the module code system. There
	might be funtionality, that I haven't found, that might crash because of this. Report
	it if you find anything.

#	Code change: Select unit function in editor has been rewritten, please report
	anything that you feel behaves differently cause of this.

#	Added option in brush layer to be able to brush on editor body type

#	Added option in brush layer to override surface normal alignment (means that the
	brush unit will be spawned with it Z rotation in  world up)

- 2009-05-13

#	World camera fov is now limited to game max fov.

#	The editor camera can now again use a higher fov value. Change it using
	the "Camera transform type-in.

- 2009-05-04

#	Missions scripts are now created and handled using continents. A new script will be
	created in current script and cannot be edited without selecting that continent.
	
	The mission files are saved in each continent subfolder. The mission.mission file
	in dir of the level contains information on where the different mission files are
	located.

#	It is now possible to simulate with the current selected mission as start mission.
	There is a button right next to the mission scripts combobox, if it is toggled on,
	the mission script in the combobox will be started when simulating.
	
#	Added possibility to delete and rename scripts.

- 2009-04-24

#	Fixed issues with autosave and incremental. Everything wasn't saved and some was in
	wrong format. The saves are now placed in folders named with the date and time from
	when it occured.

- 2009-04-23

#	Added possibility to create several missions in the same level. Also possibility 
	to start a certain mission if the name of it is provided to the mission manager.
	
#	Added mission element to be able to activate other mission scripts

- 2009-04-15

#	Added a binding to change continent by unit. Point at a unit a press "c"(default) and
	the continent will be changed to what the unit belongs to.

#	Fixed issues with replace unit(s). Units are only replaced in the current continent. This
	prevents units from ending up in the current continent instead of the source from the unit.
	Also added extra check to move the unit to the correct continent if needed.

#	Fixed issue where selected units where not unselected when locking the continent.

#	Added gui for creating and modifying world setting files. Also added possibility to select
	a world setting fil to use when running simulation.

#	Worldholder can now take a table as in param. Added to that it can receive a world setting
	file containing information on continents to exclude when loading a level. Added a gui in
	the editor in "Continents" for creating and editing world setting file.

- 2009-04-14

#	Continents has been added to the editor. This is a big change and should be considered by 
	all level designers (and probably artists). Documentation can be found on the wiki
	in "Using Editor".

- 2009-03-31

#	Remade saving and loading of external files. They are now saved with only the filename and
	not the entire path. When loading the dir is added to it, this makes it possibly to copy or move
	levels without editing the world file.

#	Fortress: When runing ingame the level world file will be used.

- 2009-03-26

#	Added and on screen mission debug text when running simulation in the editor. It can be  toggled on 
	with a button in the Mission layer. Also added an on screen gui for displaying event placeholder text
	using the point_debug mission element.

#	Camera far range in editor is now kept after a simulation.

#	Commited a new level mission script implementation. The layer where missions are created are now
	called Mission, the HubElements layer is gone. Saved data for a hub element mission script will
	be lost upon loading a old level. For quick reference of to work with the new system, ask me
	Martin Waern. Documentation will arrive shortly. 
	
	Names of mission element unit will soon change as well. They are currently only located in 
	Fortress project and should be moved to core with a proper prefix added to them.

- 2009-02-24

#	Added a edit light dialog. To use it, turn on the option in configuration and then restart
	the editor.
	
#	The replace unit dialog when loading a level where a unit no longer exists will now be populates
	from the types in the editor_types.xml.

- 2009-02-18

#	Added a flag to prevent starting of simulation directly after stopping simulation. It would 
	cause hub element and dynamics to never have the change to be recreated, which then
	could be lost from the level.

- 2009-02-16

#	Added an option in editor to lock application window to 1280x720. The option can be toggled
	on/off in menu "View->Lock 1280x720". While having it turned on the application window will
	always keep that size, even if it doesn't fit in the frame of the editor.

- 2009-02-13

#	When editing many lightsources at the same time, only the edited controller will be updated
	for all the lights. Before, all settings would change when one setting was edited.

#	Created a toolbar in Edit Triggable gui. To this toolbar a button was added to be able to
	select a unit from a select unit by name dialog.

#	Increased editor camera far range to 1000m as default.

#	Changed how external files are saved (read for example world_cameras.xml). Before it saved
	the entire path to the file, which meant a level couldn't be copied without changing the
	path manually in xml. Now it only saves the file name and loades it from the folder of the
	world.xml file.

#	Added a hub element called he_spawn_unit. This can be used to spawn a dynamic unit
	from the mission script. A physics push can be applied on it as well.

- 2009-02-05

#	Extended functionality for play effect hub element. The effect can now be repeated
	for X amount of times, with a specifies interval using a base time plus a random time.

#	Replaced the buttons in hub element gui with a toolbar. Added a button there to turn on
	always draw edited data for the element.

#	Actions and trigger hub elements are now sorted alphabetically in hub combo boxes.

#	Added a button in HubElements toolbar to turn on draw connections for selected 
	hub element only.
	
#	Added a toolbar button in HubElements layer to update draw of all edited hub elements.

#	Deleting units from "Select by name" will display a confirm dialog.

#	Added a shortkey to center view at selected unit (default key is "i" ).

#	Added possibility in sound layer to set the sounds to always be on. Meaning it will be
	on even when leaving the sound layer.

#	Possibility to set editor camera fov and far range in camera transform type-in.

#	Reload unit now reloads all selected units.

#	Reload units and replace units keeps the selection.

#	Prevent crash when loading a level with Ctrl+O (started added units to selection which then
	could cause crash for transform type ins).

#	Prevent crash in transform type ins when result is not a valid numver (23--232- for example).

#	Changed "Hide All" and "Unhide All" buttons in layers to be icons on a toolbar instead
	of buttons with names. (Icons need to be updated to represent the action).
	
#	Fix for editor hud gui not resizing with resolution. The rotation gui would offen cut at
	right border.

- 2009-02-03

#	Fixed crash when drag selecting dynamic units when not using "Always global select units" option.

- 2009-02-02

#	Display a confirm dialog before deleting a world camera.

- 2008-10-14

#	Prevent all attempts to save when a simulation is running.

- 2008-10-08

#	Added possibility to change selected action or trigger for a hub by clicking on the units.
	Have a hub selected, hold down keyboard "s" (default) and click on any unit connected to it.
	The hub gui will then be updated showing that specific action or trigger. It will also update
	the selection in the hub timeline.
	
#	Resolved annoying issue where adding or removing action or trigger to hub would
	unselect the hub. Happened when accidentaly clicking void instead of a unit.
	
	I did some additional updates on the select function for the hub elements, cleaned it up a bit.
	Let me know if you experience anything weird with that.

#	Resolved crash that could happen after a simulation if, when started, Edit Element on a hub
	element	was used. The crash would happen if the hub element had added keyboard or mouse bindings,
	using these would then try to call destroyed functions.

#	Prompt user to save group in an other location of trying to save outside the project
	file tree (as when saving a world file)

#	Added possibility to capture screenshots. It is found in menu "Debug->Capture Screenshot"
	and also as default shortkey F12. Screenshots are stored in the editor_temp folder for each
	level, as with autosaves and incrementals. The name will be date and time from when
	screenshot is captured.

- 2008-10-03

#	Bionic Commando: Added a new hub element called controller_instructions. Use it to add and 
	remove controller intructions on screen.

- 2008-09-26

#	Added a timeline for editing actions connected to a hub. To access it, select a hub and
	click the Timeline button in the hub gui. You can then move the actions on the timeline aswell
	as directly access the action gui and more. Adding actions to the hub will automaticly add
	them to the timeline. For much more information, go to the wiki documentation on hubs.
	(http://ganonbackup/wiki_artistwiki/index.php/Hub)

- 2008-09-24

#	Bionic Commando: Added a hub element called bc_taunt. With this you can make BC comment
	on things from the mission script.

#	Extended functionality for Unit debug list. It now shows all the same information saved
	in unit_stats.txt. It also has a statistics field showing total unit, total unique units and 
	total geometry memory. These stats are not automaticly updated when placing or deleting single
	units. It is only updated on load or when it first opened. To force update it, press
	the Update button.

#	Cubemap creation disables lensflares in Bionic Commando.

- 2008-09-19

#	Bionic Commando: Added something called fake relay save (unit fake_relay_save). It does
	the same thing as when exiting a relay, which is saving. To make load from it work, you'll need
	to set up an hub and select the fake_relay_save hub element as you would with a relay. You'll
	also ofcourse need to perform an action on it to do the save.

- 2008-09-17

#	I've moved the overlay effect hub element from BC to core. The unit is called overlay_effect.
	Each project can add their own presets overlay effects, but there is also one called custom
	where you easily can set up	own timers.
	
	Note: In BC you will have to overlay effect units, he_overlay_effect and overlay_effect, use
	the new one but you don't need to replace the old.
	
#	Made updates to the arrows drawn between hub elements. It is much smaller now and I also 
	changed the drawn routine which supposed to make the arrows more sollid. Tell me if it sucks
	to much, kinda liked it myself though.

- 2008-09-16

#	Changes made by Andreas finally made it possible to expose a fade timer for environment
	areas. Note though that it is still not possible to have nice fade between several environments.
	But if we are fading from environment A to environment B, we can at any time fade nicely back
	to A again.

#	Bionic Commando: Grunts can now be disabled and enabled from the mission script. Add them to
	a hub as an action and select action type disable or enable. Disable grunts costs almost nothing
	on gpu and cpu and should be used for optimization.

#	Generate cube maps now also hides all helpers. But it will then unhide helpers that should
	be shadowcasters and hides the graphics objects instead.

#	Generating cube maps now hides hub elements and world origo debug draw.

- 2008-09-15

#	Fixed bug crash in some filters which would happen when using characters that are considered
	"magic" (for example [). Crash was reported in "Global select unit" and found in some
	more.

#	It is now possible to move a camera clip in a camera sequence. To the right of
	the camera clips are up and down buttons, click them to have selected camera clip moved.

#	I've increased the target position distance from camera for world cameras. It was 5cm
	before and is now 10m. Hopefully this will reduce the shaking cameras in Faith due to
	precision problems far from origo. Haven't seen any negative effects of this change anyway.
	
	Note: Old camera points will need to be replaced or moved to get the new target positions.

#	Saving a group to file will now also save any edited unit settings. Such as light sources,
	edited guis and	material and mesh variation.

- 2008-09-10

#	Finaly got a render template for the hub element texts. They are now white and shiny in
	any environment condition.

- 2008-09-06

#	Scene effects placed in the editor is now enabled/disabled through portals. Let me know if
	you find something weird with this.
	
	Note: This is not done when running in editor at the moment.

- 2008-09-05

#	Made updates to world camera. It is now possible to set the dof padding value and dof amount
	for each camera. The dof padding value decides the fade distance between the focused area
	and max blur (default before has been 100cm). Dof amount is a value between 0 and 1 and 
	sets how blurry the max blur should be. Setting this value to 0 will disable the dof.
	
	Also found a bug where the fade between near dof and padding was inverted. Fixed that now
	so should look correct.

- 2008-09-04

#	Option to disable shadows is now enabled.

- 2008-09-02

#	Environment areas can now be positioned as on statics

#	Moved the "Edit Settings" gui from BC and made it a part of Core. The cutscene actor is 
	therefor now core. Other settings are still BC specific. To this I've added a setting
	called "Disable Shadows". Simply check it to disable shadows for the selected unit. If you
	have several units selected, the value will be applied to all of them.
	
	Note: The option is disabled for now due to a crash when removing a unit with disabled
	shadows. Only special need people will be allowed to use it for now.

#	It is now possible to reload a unit without having it spawned first. In "Global select unit"
	dialog there is Reload button. Simply select a unit in the list and press it. This is only
	a artist tool, level designers should probably stay away.

- 2008-09-01

#	It is now possible to keep dialog positions, sizes and visible states between restarts of
	the editor. To enable it, go to "Advanced->Configuration->Edit" and check the "Keep dialog
	states" check box. The settings will be saved to the file:
		
		"\data\lib\utils\dev\editor\xml\editor_layout.xml"
		
	To reset the states (should you somehow lose a dialog) you either edit the layout file or
	uncheck the configuration option and restart.
	
	This support has been added to the dialogs "Select by name", "Select group by name", 
	"Browse availible units", "Global select unit", "Workviews", "Unhide by name"
	and "Controller bindings". Let me know if you find some other dialog that you desperatly
	need added.

- 2008-08-29

#	Bionic Commando: A he_location hub element has been added. Use it to show location on
	screen.

- 2008-08-27

#	Bionic Commando: Possible to set a unit to be considered a cutscene actor. This is done
	in the "Edit Settings" menu (left toolbar). Press plus button to add/change name of the actor
	(will require user input, if name is allready taken, new input is required). Remove unit
	as actor with the remove button.

#	Unit stats now lists if any object in a unit is intanced (true/false).

#	Added a new hub element called worldcamera_trigger. It should be used when you want triggers
	during a world camera sequence. Right now it only works to trigger after each clip in the
	sequence (idea is to add more options later). In the gui for the hub element, choose sequence
	you are interested in and then the clip you want to trigger after.
	
	The element only functions as trigger, not as an action.

- 2008-08-26

#	Added a hub element called environment_effect. With it you can use and stop environments
	effects whenever you feel like it.

#	Bionic Commando: Added he_give_reward hub element. Use this to give the green matrix.

- 2008-08-25

#	Bionic Commando: Revived the environment bubble effect around camera. Using new effect
	system now and can be set per level in environment layer.

#	Bionic Commando: Added another raindrop on screen environment effect.

- 2008-08-19

#	Editor headlight uses the new intensity. Actually lit stuff up now.

#	Made updates to the "Browse availible units" dialog. I've removed the [+] and [-] for
	nodes and changed them to be using icons instead. Units without preview image will get 
	a red icon next to them and units with preview will get another. The number after each
	layer and category shows how many units have previews of the total amount.
	
	Also added a filter text field and a check box to only list units with previews. Each
	time any of these are updated the tree structure is rebuilt, causing it to collaps,
	haven't solved a way to stay in the same place.

- 2008-08-18

#	Some more layout changes to the hub hub element. All checkboxes are at the top. And
	the Bionic Commando specific controllers are neater.

#	Added a info text to workviews. Open workview dialog, select a workview and write
	in the text field. Writing on several lines will created an ugly xml but it should be
	allright. This was added as a temporary bug reporting tool for Bionic Commando.
	
	Note: The text will be set to the view both on enter and when focus lost. But apperantly
	focus lost doesn't trigger in correct order when marking another view in the list. So make
	sure you finish the text in other way then pressing another view or you will have to
	rewrite it.

#	Minor layout change to hub hub element. Takes less space and is hopefully better structured.
	Will probably change some more on it later.

- 2008-08-15

#	Possible to add a hub as an action from another hub (instead of using trigger). The gain
	is that you can set a start time for when the hub should be activated. Add it as any other
	action and choose type "trigger_actions". 
	
	It will ofcourse intefere with triggers to the same hub, meaning if a hub has triggers 
	aswell as activation through an action, the trigger status will be ignored. Furtermore, 
	to make it work I had to add a "Start hub" checkbox in the hub element. Because if you
	use an action to trigger the hub, that hub might think it is the starting hub (has no triggers). 
	So if you use it, remember to set the start hub (in BC this will still be overriden if
	there is a start from zone and default set).
	
#	I've changed how some of the mission hub data is saved and used. I've tested it in all 
	projects and I found nothing that didn't work. But please be observant if you think
	something doesn't float the boat as it used to.

- 2008-08-14

#	Added a crude ruler. Set start point by clicking shift+r. Then point around to see
	the length. Press shift+r again to stop. This thing doesn't block anything so you will 
	be able to do other weird stuff at the same time and will probably generate bugs, so
	please don't.

#	Moved where all the test files are saved when running a simulation. They are now created
	in editor_temp/simulation. This will prevent the compiler from failing on those files if
	there by some reason was a crash when saving, generating corrupt files, when running
	a simulation.

#	Fixed problem with selecting cubemap_gizmo and environment_area units. It didn't work
	when "Always global select unit" in configuration was unchecked.

#	Cubemaps can now be generated one by one. Have a cubemap_gizmo unit selected and click
	the new button "Generate selected".

#	Fixed problem that would happen when loading a level with old units and replacing them
	with none. If this would leave a group empty from units, the editor would crash on save.
	The group is now simply removed with a friendly warning.

- 2008-08-13

#	Possible to turn the visibility of brushes on and off. Look for the Visible check box
	in Brush layer. When it's uncheck you wont be able to create or remove and brushes.

#	Several cubemaps can now be generated. Simply place more cubemap gizmos. The name of
	the files will start with the name of the unit.

#	For cubemaps it is now possible to place a unit called cubemap_gizmo in the environment
	layer. When pressing button "Create cubemap" it will generate using that units position.
	Right now only one unit is used.

#	Bionic Commando. Added custom params to he_overlay_effect hub element. You still select
	effect like before but below it you can set fade in, sustain and fade out time. The values
	to the right are the defaults for the effect. Any edited custom param will override the
	default. Clear the field to use the default again.

#	Tried to make actions be runned in the correct order even if the framerate is low. What
	could happen was that if you have two action with start time 1 and 1.1 you would expect
	them to always be activated in that order. However, if the framerate would be low, both
	those actions would activate the same frame and the order could be lost. What I've done
	is to make sure that all actions are sorted from the beginning according to the time, so
	even if they would happen the same frame, they should happen in the correct order.

- 2008-08-12

#	While holding ctrl, grid size and snap rotation will temporary be 1 cm/degree. This works
	for grab move, move keys, snap rotation as well as move and rotation widgets.
	
	To make move keys work with this I had to change the change grid altitude toggle from
	ctrl to shift (hoping it wasn't used like crazy by someone, you have to unlearn what
	you have learned).

#	Set mesh variation on all selected units should know work. All units in the selection
	that share the same mesh variation name will be affected.

#	Added workviews. Meaning you can add a workview at current camera position/rotation and
	then use it to fly directly there.
	
	To add a workview, click menu "Debug->Add workview". If you type in an allready existing
	name you will be forced to do it again (workviews are prepared for continents so it 
	is ok to have same name for two workviews if they are in different workviews)
	
	To use and handle workviews you click menu "Debug->Show workviews". This will display
	a dialog with a list of the workviews. It has a filtering option and it will also be
	possible to filter between continent workviews (right now you only have the option
	for world).
	
	In the dialog you can goto a workview by selecting one view and click button "Goto" or
	simply dubbelclick a view in the list. You can also delete a workview by clicking
	"Delete" button, or select one in the list and click delete on keyboard. It is also
	possible to add new workviews directly from here. Note though that the enter name 
	dialog think its a good idea to show up behind the dialog. If you can't move it or
	whatever because you can't see it, simply input a name and click enter (or alt-f4
	to cancel the dialog)
	
	The workviews are saved to the world.xml and to each seperate continent file. Meaning
	it belongs to a level.
	
- 2008-08-11

#	Fixed a bug where portals was still selectable when using "Only draw current" and
	configuration option "Always global select unit" was not checked.

- 2008-08-08 (Stockholm i mitt hjääärta!)

#	Fixed crash that occured when deleting several portal_point units from different portal shapes
	in "Select by name".

#	Box drag select can no longer be triggered while grab moving a unit. It became a serious
	problem when grab moving a unit in surface move and wanting to inherit the surface normal.

#	You can now set the check interval for an area group. The default is to check every 0.1sec,
	you can usually get away with a higher value and thus gain performance. If you set it to
	0, it will be checked every frame.

#	Area shapes start altitude and height values can now be edited with better precision. I've 
	added text controller input and a spin controller as an addition to the sliders. Values are
	in cm.

- 2008-08-07

#	A hub element to set music mode has been added (called music_mode). You select which song that
	should be playing and select the mode for it. If you change song and that song doesn't have
	the selected mode, the mode will be reset.

#	It is now possible to debug draw areas while running a simulation in editor. Turn it on or off
	in menu Mission->Draw areas during simulation. None activated areas will be drawn red, activated
	and currently checking areas will be drawn green.

#	Portal units are no longer click selectable when the portal isn't draw (when using "Only draw
	current"). Meaning you should no longer accidentaly click a unit belonging to another portal
	and then change selected portal.
	
	I've used hide unit functionality to achieve this, so you will se them as hidden units in 
	"Unhide by name" list. And it will override any user hidden portal point units.

#	The world cameras have been upgraded. It is now possible to key fov and dof for a camera, look
	through a camera using a time slider and created sequences.
	
	In the keys option there is a time slider. Using it will display current time (between 0 and 1),
	current fov and current near and far dof. Below the slider is some buttons. Click the first
	one to position the camera on the camera path. Using the slider will now move the camera to
	the right position and set the fov and dof values. 
	
	Add a key by moving the slider to desired time and click the add key button. The key will get 
	the fov and dof values that is shown above the time slider. Now you can change the fov and 
	dof using the controllers below the buttons. Move a key by selecting it and then enter another
	time in the "Key Time" text box. Select a key using the combobox "Select Key" or use the buttons
	for Previous and Next key to step between them. Note that moving the timeline will not change 
	the current key. You will always edit the key shown	in the combobox. Also note that key 1 cannot
	be deleted or removed.
	
	Near and far dof can be sampled by pointing and pressing Home and End on keyboard.
	
	Create, delete, test and stop a sequence using the buttons in the Sequence gui. Create a new
	sequence and it will end up in the list to the right of the buttons. Having a sequence selected
	you can choose cameras below by dubbelclicking on a camera in the left box (this box always
	mirrors whats in the Cameras listbox at the top). Remove a camera from a sequence by
	dubbleclicking it in the right listbox.
	
	For each camera in the sequence start and stop time can be edited. The camera will then start 
	and stop at those times specified. Select a camera in the right listbox to edit it. 
	Start and stop values should be between 0 and 1 (start should always be less then starts).
	Its prefectly ok to add the same camera several times to the sequence and they can still then
	be edited seperatly.
	
	The world camera hub element has a new option called sequence. Triggering from camera
	or sequence should work as before. 
	
	Todo: Move camera up and down in a sequence. Dof seems not to work in Faith, will investigate.
	Add the possibility to trigger on many different things in a sequence (time, camera change, etc)
	
	Note: The brief fov slider for a world camera has been removed. You'll need to edit 
	the first key in the camera instead.
	

- 2008-07-31

#	Created a Select group by name dialog. Here you can see a list of all groups and filter them.
	Open the dialog from the menu Group -> Select Group By Name or in find it in the toolbar.
	
	It is possible to select, ungroup and delete a group. It is even possible to ungroup and delete
	several groups at once by marking them in the list. You can however only select one.
	
	Select a group by dubbel clicking, or marking one group and click select.
	
	Delete by marking one or several groups, then click Delete button or delete on keyboard.
	
	Ungroup by marking one or several groups, then click the Ungroup button.
	
	The list should update automaticly if you create a new group, ungroup or delete a group. 
	Let me know if you found something that makes it out of sync.

- 2008-07-30

#	Made a dialog for the Check Unit Duality option in Debug menu. It will list all colliding
	units and where they are. For each collision listed it's possible to delete one of the two
	units (the field will then be disabled) and also choose goto if you wan't to look at the 
	situation first (will position the camera to see the units).
	
	There are two kinds of collisions reported. "Collisions with both position and rotation"
	is the important one and should be adressed. "Collision with only position" could be
	interesting to investigate but probably ok.
	
	I've also removed the text message in the output windows for these collisions.
	
#	It is now possible to toggle draw of marker ball and stick for static layers on and off. 
	In the View Menu, uncheck or check Show Marker.

- 2008-07-29

#	Camera far range has been added below camera rotation.

#	Decrease and increase speed of camera far range is no longer affected by framerate.

#	Global select unit dialog now always sets keyboard focus to the filter and selects
	the text when shown.

#	It is now possible to specify units that should be replaced when loading a level
	direclty in an xml file. The file should be located in and called:
	
		\data\lib\utils\dev\editor\xml\replace_units.xml
		
	and look like this:
	
		<units>
			<old_unit replace_with="new_unit"/>
		</units>
		
	All units will with name old_unit will be replaced with the unit new_unit automaticly
	upon loading a level in the editor.

#	Replace a removed/renamed unit when loading a level should now work again.

- 2008-07-28

#	It is now possible to specify fov value for a world camera. When changing the fov the
	editor camera will use that fov directly giving instant feedback.

#	I'm back, missed you all and so on ..

- 2008-07-02

#	Bionic Commando: Added support for an additional mine type. In the minefield hub element
	it will be possible to choose what kind of mine to use. Default will still be
	the air proximity mine. The other one is a wall attached mine that have a different editing
	mode assign to it.
	
	Note: The new mine isn't done yet. But as soon as it is, magic will be released.

- 2008-07-01

#	Bionic Commando: Added hub element for Groeder mecha. The unit the hub element creates
	is not configured correctly yet though, it will crash.

#	Started move of music hub element from Bionic Commando to Core.

#	I will go on vacation from july 7 - july 28. Be nice to each other! /Martin Waern

- 2008-06-25

#	Found and solved a crash that happend when choosing new or load world and the Edit Element 
	button was enabled. Pressing the button afterwards would crash the editor. It could also
	happen after simulation.

- 2008-06-24

#	Bionic Commando: Added editing support for speaker hub element. Simply create the hub element
	unit speaker and select the once you would like. 
	
	Note: No options are listed yet since they are not available from the sound department.
	
#	Bionic Commando: Added editing support for grunt_dialog hub element unit. Create the unit
	grunt_dialog and select which one you would like. Then choose Edit Element, you can now select
	two grunts to play out the dialogue. Select grunt A by holding down keyboard button "1" and 
	click on a grunt hub element. Select grunt B by holding down keyboard button "2" and click
	on a grunt hub element.
	
	Make sure that both grunts are created before you try to run the dialogue.
	
	Note: No dialogues are listed yet, waiting for the sound department. The GP support to
	have a dialogue between two specific grunts are also not implemented yet.

- 2008-06-23

#	Added an interface in portal layer to create groups based on one or several box shapes.
	The idea is to use these for model locker for faster rendering (we used something like
	this in GRAW, and Tobias wanted to look into it again). All units inside a shape of a group
	will be added to it. Nothing else will happen at this moment though since the engine support
	isn't written yet. Only simple none editable or destroyable units should be added to it when
	the time comes.
	
	To edit, go to portal layer, click the "Create New" button in the Groups interface and select
	the unit portal_shape from the units list. Create a shape by creating the unit. When creating
	and selecting a portal_shape unit a gui for shape parameters will be displayed. To select
	a portal_shape unit, you need to click the small box in the corner of the shape (which is
	the actual unit). Changing group is done by clicking in the interface list or by selecting
	a portal_shape unit. Delete a group by clicking the "Delete" button.
		
#	The draw of units belonging to groups are now turned off as default. They will only be
	visible when turning on "Using groups". You can turn on the draw in menu Groups->Draw Groups.

- 2008-06-19

#	Possible to set an environment area to be permanent. Meaning that it will keep that environment
	even if we leave the area.
	
	Note: In the editor it might be confusing if changing through a permanent area since the default
	environment gui not will represent what you see. But will be what the world will use from beginning.

#	Moved the play_effect hub element from Bionic Commando project to Core. Here you can select
	an effect to be spawned from the mission script. It will use the position and rotation from
	the hub element unit. If the "Play in Screen Space" option is selected, the effect will spawn 
	on screen (if it is set up to behave like that)

	To keep better track of the effects I've created a CoreEnvironmentEffectManager from 
	Bionic Commando	EnvironmentEffectManager. All effects are now registered here which allows 
	stopping them after	running a simulation. It also adds new actions to the element that BC didn't 
	have before. You can select between actions spawn, kill and fade_kill. Kill kills the effects 
	instantly while fade_kill stops creating new particals and when the last one is gone, the effect 
	is killed.

- 2008-06-18

#	All editable lightsources now uses presets from LightIntensityDB for multiplier. Saved and new
	lights using number value for multiplier will be converted to closest preset. Always try to use the
	correct preset for correct type of lightsource, since it then can be tweaked globaly.
	
	Artists should probably start using this aswell. For example, a streetlight in BC will be converted
	to candlelight, cause the multiplier is set to low (they should use preset streetlight).
	
	Later on the max exporter will convert an animated multiplier in max so scale the set preset.
	Which should eliminate the conflict we have now between animation and editing.

- 2008-06-17

#	Bionic Commando: Set up hub element for terracotta. Don't try to activate it yet though,
	the actual terracotta unit can't be created.

#	Possible to specify top an bottom values for portals, making it a 3D check. Change it using
	the spin controllers in portal layer or by sampling top and bottom from camera position
	using default keys "home" and "end". Make it back to 2D by setting 0 for both top and bottom.
	
	Note: Make sure that top always is bigger then bottom or it won't work.

#	Added support to create sound area emitter in sound layer. Create the unit 
	called sound_area_emitter. The gui for selecting emitter soundbank and cue will be
	enabled. Additionally the size properties for the area shape will appear. The area emitters
	uses the same soundbanks and cues as with point emitters.
	
	To select a shape you need to click on the actuall unit for the shape, represented as a
	white box in the middle of the shape.
	
	Note: Make sure you get the new exe since set_rotation on sound object has been added.
	
#	Added a checkbox in sound layer to toggle debug draw of sounds on and off.

#	Crash fix when adding nil unit to group with Ctrl+click

- 2008-06-16

# 	This is the new News list for the editor. I've added this since the forum is down and
	we need a way to better communicate changes about the editor. I will still post mayor
	things in the editor as well, when it get back up.
	
	Some additions might be project specific and in that case a will make a note of that to.

#	The News list will only be displayed on start up when new news are available. It can
	also always be reach through menu View->News...

# 	I've changed the grouping functionality. Which means that grouphandler no longer exists. 
	All groups from grouphandler will be converted to the new group system. There is a new menu
	called Group where group and ungroup area availible. Also possible to save and load a group
	to and from file. Dumping is also possible. Loading of a group saved from grouphandler
	is also supported. 
	
	There is a menu called Group presets. It will display a list of group xml files from
	the folder \data\levels\groups

	Units belonging to a group are drawn with a dark bounding box. To enable group selection, 
	click the icon in the toolbar (default shortkey l). When having a group selected, adding units
	are doing by holding Ctrl and cliking a unit. Removing is done by holding alt and clicking a unit
	(alternative ctrl+click a unit in the group). Change reference for the group with shift+click.
	
	A unit can belong to many groups. Clicking on the unit will select the "top" group.
	
	Only one group can be selected at time. Drag select will only select one group. 
	Groups and other units cannot be selected at the same time. Grouping of, for example, 
	hub elements and dynamics is possible (although dynamics don't make to much sense)

#	All temporary editor files are now saved to \editor_temp\. The folder structure will look
	like the one in \levels\. All incremental and autosaves will end up here.
