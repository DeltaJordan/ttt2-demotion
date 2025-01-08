CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "demotion_addon_info"

local function MakeElement(form, name, typ, data, no_help)
	local real_data = table.Merge({
		label = "label_ttt2_demotion_" .. name,
		help = "help_ttt2_demotion_" .. name,
		serverConvar = "ttt2_demotion_" .. name,
		min = 0,
		max = 100,
		decimal = 0,
	}, data or {})

	if not no_help then
		form:MakeHelp({
			label = real_data.help,
			params = real_data.help_params or {},
		})
	end

	return form[typ](form, real_data)
end

function CLGAMEMODESUBMENU:Populate(parent)
	local infected_options = vgui.CreateTTT2Form(parent, "demotion_settings_infected")
	MakeElement(infected_options, "infected", "MakeCheckBox")

	local serialkiller_options = vgui.CreateTTT2Form(parent, "demotion_settings_serialkiller")
	MakeElement(serialkiller_options, "serialkiller", "MakeCheckBox")
end