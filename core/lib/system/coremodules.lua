--[[

C o r e M o d u l e s
---------------------

In this file all Core Modules that uses the new module
system are registered.

]]--

-- register modules for the Core System Setup
core:register_module( "core/lib/system/CoreExtendLua" )
core:register_module( "core/lib/system/CoreEngineAccess" )

-- register modules for the utilities library
core:register_module( "core/lib/utils/CoreApp" )
core:register_module( "core/lib/utils/CoreClass" )
core:register_module( "core/lib/utils/CoreCode" )
core:register_module( "core/lib/utils/CoreSerialize" )
core:register_module( "core/lib/utils/CoreDebug" )
core:register_module( "core/lib/utils/CoreEvent" )
core:register_module( "core/lib/utils/CoreEws" )
core:register_module( "core/lib/utils/CoreInput" )
core:register_module( "core/lib/utils/CoreKeywordArguments" )
core:register_module( "core/lib/utils/CoreMath" )
core:register_module( "core/lib/utils/CoreOldModule" )
core:register_module( "core/lib/utils/CoreString" )
core:register_module( "core/lib/utils/CoreTable" )
core:register_module( "core/lib/utils/CoreUnit" )
core:register_module( "core/lib/utils/CoreXml" )
core:register_module( "core/lib/utils/CoreLogic" )
core:register_module( "core/lib/utils/CoreLinkedStackMap" )
core:register_module( "core/lib/utils/CoreFiniteStateMachine" )
core:register_module( "core/lib/utils/CoreStack" )
core:register_module( "core/lib/utils/CoreSwitchStateMachine" )

-- register modules for the color picker
core:register_module( "core/lib/utils/dev/ews/color_picker/CoreColorPickerDialog" )
core:register_module( "core/lib/utils/dev/ews/color_picker/CoreColorPickerPanel" )
core:register_module( "core/lib/utils/dev/ews/color_picker/CoreColorPickerDraggables" )
core:register_module( "core/lib/utils/dev/ews/color_picker/CoreColorPickerFields" )

-- register modules for the float spin ctrl
core:register_module( "core/lib/utils/dev/ews/CoreFloatSpinCtrl" )

-- register modules for the vector3 spin ctrl
core:register_module( "core/lib/utils/dev/ews/CoreVector3SpinCtrl" )

core:register_module( "core/lib/utils/dev/ews/CoreScriptGraph" )

-- register modules for the vector slider
core:register_module( "core/lib/utils/dev/ews/CoreVectorSliderBox" )

-- register modules for the point picker
core:register_module( "core/lib/utils/dev/CorePointPicker" )
core:register_module( "core/lib/utils/dev/ews/CorePointPickerPanel" )

-- register modules for drawing a pointer
core:register_module( "core/lib/utils/dev/CorePointerDraw" )

-- register modules for the subtitle manager
core:register_module( "core/lib/managers/subtitle/CoreSubtitleManager" )
core:register_module( "core/lib/managers/subtitle/CoreSubtitlePresenter" )
core:register_module( "core/lib/managers/subtitle/CoreSubtitleSequence" )
core:register_module( "core/lib/managers/subtitle/CoreSubtitleSequencePlayer" )

-- register modules for the luaprofiler viewer
core:register_module( "core/lib/utils/dev/tools/luaprofiler_viewer/CoreLuaProfilerViewer" )
core:register_module( "core/lib/utils/dev/tools/luaprofiler_viewer/CoreLuaProfilerTreeBox" )
core:register_module( "core/lib/utils/dev/tools/luaprofiler_viewer/CoreLuaProfilerGridBox" )

-- register modules for the toolhub
core:register_module( "core/lib/utils/dev/CoreToolHub" )

-- register modules for the dependency mapper
core:register_module( "core/lib/utils/dev/dependencymapper/CoreDependencyParser" )
core:register_module( "core/lib/utils/dev/dependencymapper/CoreDependencyNode" )
core:register_module( "core/lib/utils/dev/dependencymapper/dependencynodes/CoreGameDn" )
core:register_module( "core/lib/utils/dev/dependencymapper/dependencynodes/CoreLevelDn" )
core:register_module( "core/lib/utils/dev/dependencymapper/dependencynodes/CoreUnitDn" )
core:register_module( "core/lib/utils/dev/dependencymapper/dependencynodes/CoreObjectDn" )
core:register_module( "core/lib/utils/dev/dependencymapper/dependencynodes/CoreModelDn" )
core:register_module( "core/lib/utils/dev/dependencymapper/dependencynodes/CoreMaterialfileDn" )
core:register_module( "core/lib/utils/dev/dependencymapper/dependencynodes/CoreMaterialconfigDn" )
core:register_module( "core/lib/utils/dev/dependencymapper/dependencynodes/CoreTextureDn" )
core:register_module( "core/lib/utils/dev/dependencymapper/dependencynodes/CoreCutsceneDn" )
core:register_module( "core/lib/utils/dev/dependencymapper/dependencynodes/CoreEffectDn" )

-- register modules for the spreadsheat lib
core:register_module( "core/lib/utils/dev/spreadsheat/CoreSpreadsheet" )
core:register_module( "core/lib/utils/dev/spreadsheat/CoreWorkbook" )
core:register_module( "core/lib/utils/dev/spreadsheat/CoreWorksheet" )
core:register_module( "core/lib/utils/dev/spreadsheat/CoreSsRow" )

-- register modules for the managers
core:register_module( "core/lib/managers/managerbase/CoreManagerBase" )
core:register_module( "core/lib/managers/managerbase/CoreAccessObjectBase" )
core:register_module( "core/lib/managers/CoreLocalizationManager" )
core:register_module( "core/lib/managers/CoreNewsReportManager" )
core:register_module( "core/lib/managers/CoreSettingsManager" )
core:register_module( "core/lib/managers/CoreSequenceManager" )
core:register_module( "core/lib/managers/controller/CoreControllerManager" )
core:register_module( "core/lib/managers/controller/CoreControllerWrapperSettings" )
core:register_module( "core/lib/managers/controller/CoreControllerWrapper" )
core:register_module( "core/lib/managers/controller/CoreControllerWrapperGamepad" )
core:register_module( "core/lib/managers/controller/CoreControllerWrapperPC" )
core:register_module( "core/lib/managers/controller/CoreControllerWrapperXbox360" )
core:register_module( "core/lib/managers/controller/CoreControllerWrapperPS3" )
core:register_module( "core/lib/managers/controller/CoreControllerWrapperDebug" )
core:register_module( "core/lib/managers/CoreListenerManager" )
core:register_module( "core/lib/managers/CoreSlotManager" )
core:register_module( "core/lib/managers/CoreExpressionManager" )
core:register_module( "core/lib/managers/CoreDebugManager" )
core:register_module( "core/lib/managers/CorePortalManager" )
core:register_module( "core/lib/managers/CoreShapeManager" )
core:register_module( "core/lib/managers/CoreDOFManager" )
core:register_module( "core/lib/managers/CoreRumbleManager" )
core:register_module( "core/lib/managers/CoreDatabaseManager" )
core:register_module( "core/lib/managers/CoreGTextureManager" )
core:register_module( "core/lib/managers/CoreOverlayEffectManager" )
core:register_module( "core/lib/managers/CoreEnvironmentAreaManager" )
core:register_module( "core/lib/managers/CoreEnvironmentEffectsManager" )
core:register_module( "core/lib/managers/slave/CoreSlaveManager" )
core:register_module( "core/lib/managers/slave/CoreSlaveUpdators" )
core:register_module( "core/lib/managers/CoreAiDataManager" )
core:register_module( "core/lib/managers/CoreHelperUnitManager" )
core:register_module( "core/lib/managers/CoreGuiDataManager" )

-- viewport system
core:register_module( "core/lib/managers/viewport/CoreScriptViewport" )
core:register_module( "core/lib/managers/viewport/CoreViewportManager" )
core:register_module( "core/lib/managers/viewport/CoreEnvironmentMixer" )
core:register_module( "core/lib/managers/viewport/CoreEnvironmentData" )
core:register_module( "core/lib/managers/viewport/CoreEnvironmentHandle" )
core:register_module( "core/lib/managers/viewport/CoreEnvironmentCache" )
core:register_module( "core/lib/managers/viewport/feeders/CoreEnvironmentFeeder" )
core:register_module( "core/lib/managers/viewport/feeders/CoreEnvironmentNetworkFeeder" )
core:register_module( "core/lib/managers/viewport/feeders/CoreEnvironmentPostProcessorFeeder" )
core:register_module( "core/lib/managers/viewport/feeders/CoreEnvironmentUnderlayFeeder" )
core:register_module( "core/lib/managers/viewport/feeders/CoreEnvironmentOthersFeeder" )
core:register_module( "core/lib/managers/viewport/interfaces/CoreEnvironmentDebugInterface" )
core:register_module( "core/lib/managers/viewport/interfaces/CoreEnvironmentSkyOrientationInterface" )
core:register_module( "core/lib/managers/viewport/interfaces/CoreEnvironmentShadowInterface" )
core:register_module( "core/lib/managers/viewport/interfaces/CoreEnvironmentShadowSharedInterface" )
core:register_module( "core/lib/managers/viewport/interfaces/CoreEnvironmentDOFInterface" )
core:register_module( "core/lib/managers/viewport/interfaces/CoreEnvironmentDOFSharedInterface" )
core:register_module( "core/lib/managers/viewport/interfaces/CoreEnvironmentFogInterface" )
core:register_module( "core/lib/managers/viewport/interfaces/CoreEnvironmentRadialBlurInterface" )

-- register modules for mission manager
core:register_module( "core/lib/managers/mission/CoreMissionManager" )
core:register_module( "core/lib/managers/mission/CoreMissionScriptElement" )
core:register_module( "core/lib/managers/mission/CoreElementDebug" )
core:register_module( "core/lib/managers/mission/CoreElementWorldCamera" )
core:register_module( "core/lib/managers/mission/CoreElementArea" )
core:register_module( "core/lib/managers/mission/CoreElementCounter" )
core:register_module( "core/lib/managers/mission/CoreElementToggle" )
core:register_module( "core/lib/managers/mission/CoreElementPlayEffect" )
core:register_module( "core/lib/managers/mission/CoreElementPhysicsPush" )
core:register_module( "core/lib/managers/mission/CoreElementSpawnUnit" )
core:register_module( "core/lib/managers/mission/CoreElementActivateScript" )
core:register_module( "core/lib/managers/mission/CoreElementUnitSequence" )
core:register_module( "core/lib/managers/mission/CoreElementUnitSequenceTrigger" )
core:register_module( "core/lib/managers/mission/CoreElementMusic" )
core:register_module( "core/lib/managers/mission/CoreElementOperator" )
core:register_module( "core/lib/managers/mission/CoreElementOverlayEffect" )
core:register_module( "core/lib/managers/mission/CoreElementPlaySound" )
core:register_module( "core/lib/managers/mission/CoreElementRandom" )
core:register_module( "core/lib/managers/mission/CoreElementExecuteInOtherMission" )
core:register_module( "core/lib/managers/mission/CoreElementLogicChance" )
core:register_module( "core/lib/managers/mission/CoreElementGlobalEventTrigger" )
core:register_module( "core/lib/managers/mission/CoreElementTimer" )

-- register modules for the world holder and definition
core:register_module( "core/lib/utils/dev/editor/CoreWorldDefinition" )

-- register modules for the world editor
core:register_module( "core/lib/utils/dev/editor/CoreLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreStaticLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreDynamicLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreWorldCameraLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreBrushLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreWireLayer" )
core:register_module( "core/lib/utils/dev/editor/CorePortalLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreSoundLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreEnvironmentLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreStaticsLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreDynamicsLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreMissionLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreAiLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreHeatmapLayer" )
core:register_module( "core/lib/utils/dev/editor/CoreLevelSettingsLayer" )
core:register_module( "core/lib/utils/dev/editor/utils/CoreEditorWidgets" )
core:register_module( "core/lib/utils/dev/editor/utils/CoreEditorUtils" )
core:register_module( "core/lib/utils/dev/editor/utils/CoreEditorSave" )

-- The interaction manager and editor.
core:register_module( "core/lib/utils/dev/tools/interaction_editor/CoreInteractionEditor" )
core:register_module( "core/lib/utils/dev/tools/interaction_editor/CoreInteractionEditorUI" )
core:register_module( "core/lib/utils/dev/tools/interaction_editor/CoreInteractionEditorUIEvents" )
core:register_module( "core/lib/utils/dev/tools/interaction_editor/CoreInteractionEditorPropUI" )
core:register_module( "core/lib/utils/dev/tools/interaction_editor/CoreInteractionEditorSystem" )
core:register_module( "core/lib/utils/dev/tools/interaction_editor/CoreInteractionEditorSystemEvents" )
core:register_module( "core/lib/utils/dev/tools/interaction_editor/CoreInteractionEditorConfig" )
core:register_module( "core/lib/utils/dev/tools/interaction_editor/CoreInteractionEditorOpStack" )

core:register_module( "core/lib/utils/dev/tools/interaction_editor/prop_panels/CoreInteractionEditorGenericPanel" )

-- register modules for the game state machine
core:register_module( "core/lib/utils/game_state_machine/CoreGameStateMachine" )
core:register_module( "core/lib/utils/game_state_machine/CoreInternalGameState" )
core:register_module( "core/lib/utils/game_state_machine/CoreInitState" )

-- register modules for the freeflight system
core:register_module( "core/lib/utils/dev/freeflight/CoreFreeFlight" )
core:register_module( "core/lib/utils/dev/freeflight/CoreFreeFlightAction" )
core:register_module( "core/lib/utils/dev/freeflight/CoreFreeFlightModifier" )

-- register modules for the camera system
core:register_module( "core/lib/managers/camera/CoreCameraManager" )
core:register_module( "core/lib/managers/camera/CoreUnitCamera" )
core:register_module( "core/lib/managers/camera/CoreCameraMixer" )
core:register_module( "core/lib/managers/camera/CoreCameraDataInterpreter" )
core:register_module( "core/lib/managers/camera/CoreTransformCameraNode" )
core:register_module( "core/lib/managers/camera/CoreUnitLinkCameraNode" )
core:register_module( "core/lib/managers/camera/CoreSpringCameraNode" )
core:register_module( "core/lib/managers/camera/CoreAimCameraNode" )
core:register_module( "core/lib/managers/camera/CoreCollisionCameraNode" )

-- register modules for the session system
core:register_module( "core/lib/managers/session/CoreSessionManager" )
core:register_module( "core/lib/managers/session/CoreRequester" )
core:register_module( "core/lib/managers/session/CoreSessionFactory" )
core:register_module( "core/lib/managers/session/CoreSessionInfo" )
core:register_module( "core/lib/managers/session/CoreProfileHandler" )
core:register_module( "core/lib/managers/session/CoreSessionResponse" )
core:register_module( "core/lib/managers/session/CoreSessionGenericState" )

-- register debug stuff
core:register_module( "core/lib/managers/session/debug/CoreSessionDebug" )
core:register_module( "core/lib/utils/dev/tools/CorePrefHud" )
core:register_module( "core/lib/utils/dev/CoreLuaDump" )

-- avatar
core:register_module( "core/lib/managers/session/avatar/CoreAvatar" )
core:register_module( "core/lib/managers/session/avatar/CoreAvatarHandler" )

-- register session state
core:register_module( "core/lib/managers/session/session_state/CoreSessionState" )
core:register_module( "core/lib/managers/session/session_state/CoreSessionHandler" )

-- register session sub states
core:register_module( "core/lib/managers/session/session_state/state/CoreSessionStateCreateSession" )
core:register_module( "core/lib/managers/session/session_state/state/CoreSessionStateFindSession" )
core:register_module( "core/lib/managers/session/session_state/state/CoreSessionStateInit" )
core:register_module( "core/lib/managers/session/session_state/state/CoreSessionStateInSession" )
core:register_module( "core/lib/managers/session/session_state/state/CoreSessionStateInSessionEnd" )
core:register_module( "core/lib/managers/session/session_state/state/CoreSessionStateInSessionStart" )
core:register_module( "core/lib/managers/session/session_state/state/CoreSessionStateInSessionStarted" )
core:register_module( "core/lib/managers/session/session_state/state/CoreSessionStateJoinSession" )
core:register_module( "core/lib/managers/session/session_state/state/CoreSessionStateQuitSession" )

-- register session creators
core:register_module( "core/lib/managers/session/session_creator/CorePortableSessionCreator" )
core:register_module( "core/lib/managers/session/session_creator/CoreSession" )
core:register_module( "core/lib/managers/session/session_creator/fake/CoreFakeSessionCreator" )
core:register_module( "core/lib/managers/session/session_creator/fake/CoreFakeSession" )

-- register local user
core:register_module( "core/lib/managers/session/local_user/CoreLocalUser" )
core:register_module( "core/lib/managers/session/local_user/CoreLocalUserHandler" )
core:register_module( "core/lib/managers/session/local_user/CoreLocalUserManager" )

-- register local user storage
core:register_module( "core/lib/managers/session/local_user/storage/CorePortableLocalUserStorage" )
core:register_module( "core/lib/managers/session/local_user/storage/CoreLocalUserStorage" )

core:register_module( "core/lib/managers/session/local_user/storage/state/CoreLocalUserStorageStates" )

-- register fake local user storage
core:register_module( "core/lib/managers/session/local_user/storage/fake/CoreFakeLocalUserStorage" )

-- register player
core:register_module( "core/lib/managers/session/player/CorePlayer" )
core:register_module( "core/lib/managers/session/player/CorePlayerHandler" )


-- register player slot
core:register_module( "core/lib/managers/session/player_slot/CorePlayerSlots" )
core:register_module( "core/lib/managers/session/player_slot/CorePlayerSlot" )

-- register player slot states
core:register_module( "core/lib/managers/session/player_slot/state/CorePlayerSlotStateInit" )
core:register_module( "core/lib/managers/session/player_slot/state/CorePlayerSlotStateDetectLocalUser" )
core:register_module( "core/lib/managers/session/player_slot/state/CorePlayerSlotStateLocalUserBound" )
core:register_module( "core/lib/managers/session/player_slot/state/CorePlayerSlotStateLocalUserDebugBind" )

-- register game states
core:register_module( "core/lib/managers/session/game_state/CoreGameState" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStateFrontEnd" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStateInGame" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStateInit" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStatePreFrontEnd" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStatePrepareLoadingFrontEnd" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStatePrepareLoadingGame" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStateLoadingFrontEnd" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStateLoadingGame" )

-- register game states related to the editor
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStateInEditor" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStateInEditorPrepareStartSimulation" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStateInEditorPrepareStopSimulation" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStateInEditorSimulation" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStateInEditorStartSimulation" )
core:register_module( "core/lib/managers/session/game_state/state/CoreGameStateInEditorStopSimulation" )

-- register menu states
core:register_module( "core/lib/managers/session/menu_state/CoreMenuState" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateAttract" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateFreeze" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateInGame" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateInEditor" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStatePreFrontEnd" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStatePreFrontEndOnce" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateFrontEnd" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateStart" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateLegal" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateIntroScreens" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateNone" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStatePrepareLoadingGame" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStatePrepareLoadingFrontEnd" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateLoadingGame" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateLoadingFrontEnd" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateStopLoadingGame" )
core:register_module( "core/lib/managers/session/menu_state/state/CoreMenuStateStopLoadingFrontEnd" )

-- register freeze states
core:register_module( "core/lib/managers/session/freeze_state/CoreFreezeState" )
core:register_module( "core/lib/managers/session/freeze_state/state/CoreFreezeStateFreezing" )
core:register_module( "core/lib/managers/session/freeze_state/state/CoreFreezeStateFrozen" )
core:register_module( "core/lib/managers/session/freeze_state/state/CoreFreezeStateMelted" )
core:register_module( "core/lib/managers/session/freeze_state/state/CoreFreezeStateMelting" )

-- register dialog states
core:register_module( "core/lib/managers/session/dialog_state/CoreDialogState" )
core:register_module( "core/lib/managers/session/dialog_state/state/CoreDialogStateNone" )

-- register input
core:register_module( "core/lib/managers/input/CoreInputContext" )
core:register_module( "core/lib/managers/input/CoreInputContextDescription" )
core:register_module( "core/lib/managers/input/CoreInputContextFeeder" )
core:register_module( "core/lib/managers/input/CoreInputContextStack" )
core:register_module( "core/lib/managers/input/CoreInputDeviceLayoutDescription" )
core:register_module( "core/lib/managers/input/CoreInputLayer" )
core:register_module( "core/lib/managers/input/CoreInputLayerDescription" )
core:register_module( "core/lib/managers/input/CoreInputLayerDescriptionPrioritizer" )
core:register_module( "core/lib/managers/input/CoreInputLayoutDescription" )
core:register_module( "core/lib/managers/input/CoreInputManager" )
core:register_module( "core/lib/managers/input/CoreInputProvider" )
core:register_module( "core/lib/managers/input/CoreInputTargetDescription" )
core:register_module( "core/lib/managers/input/CoreInputSettingsReader" )

-- register menu
core:register_module( "core/lib/managers/menu/CoreMenuCallbackHandler" )
core:register_module( "core/lib/managers/menu/CoreMenuData" )
core:register_module( "core/lib/managers/menu/CoreMenuLogic" )
core:register_module( "core/lib/managers/menu/CoreMenuManager" )
core:register_module( "core/lib/managers/menu/CoreMenuNode" )
core:register_module( "core/lib/managers/menu/reference_input/CoreMenuInput" )
core:register_module( "core/lib/managers/menu/reference_renderer/CoreMenuNodeGui" )
core:register_module( "core/lib/managers/menu/reference_renderer/CoreMenuRenderer" )

-- register menu items
core:register_module( "core/lib/managers/menu/items/CoreMenuItem" )
core:register_module( "core/lib/managers/menu/items/CoreMenuItemOption" )
core:register_module( "core/lib/managers/menu/items/CoreMenuItemSlider" )
core:register_module( "core/lib/managers/menu/items/CoreMenuItemToggle" )


-- register smoketest
core:register_module( "core/lib/utils/dev/smoketest/CoreSmoketestManager" )
core:register_module( "core/lib/utils/dev/smoketest/CoreSmoketestReporter" )
core:register_module( "core/lib/utils/dev/smoketest/CoreSmoketestSuite" )
core:register_module( "core/lib/utils/dev/smoketest/suites/CoreSmoketestCommonSuite" )
core:register_module( "core/lib/utils/dev/smoketest/suites/CoreSmoketestEditorSuite" )
core:register_module( "core/lib/utils/dev/smoketest/suites/CoreSmoketestLoadLevelSuite" )

-- register modules for the Setup
core:register_module( "core/lib/setups/CoreSetup" )