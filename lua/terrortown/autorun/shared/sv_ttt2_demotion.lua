CreateConVar("ttt2_demotion_infected", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_demotion_serialkiller", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})

if SERVER then
    hook.Add("TTT2ModifyFinalRoles", "DemotionDemoteTraitors", function(finalRoles)
        local demotion_infected = GetConVar("ttt2_demotion_infected"):GetBool()
        local demotion_serialkiller = GetConVar("ttt2_demotion_infected"):GetBool()
        if not demotion_infected and not demotion_serialkiller then return end

        local traitor_roles = {}
        local troles = roles.GetByIndex(ROLE_TRAITOR):GetSubRoles()
        for _, role in ipairs(troles) do
            table.insert(traitor_roles, role.index)
        end

        local IsTraitor = function(roleIndex)
            return table.HasValue(traitor_roles, roleIndex)
        end

        local role_count = {}
        for _, role in pairs(finalRoles) do
            role_count[role] = (role_count[role] or 0) + 1
        end

        local HasAny = function(role)
            return (role_count[role] or 0) > 0
        end

        local players = player.GetAll()
        table.Shuffle(players)

        if (demotion_infected and HasAny(ROLE_INFECTED)) or (demotion_serialkiller and HasAny(ROLE_SERIALKILLER)) then
            for _, ply in ipairs(players) do
                if IsTraitor(finalRoles[ply]) then
                    finalRoles[ply] = ROLE_INNOCENT
                end
            end
        end
    end)
end