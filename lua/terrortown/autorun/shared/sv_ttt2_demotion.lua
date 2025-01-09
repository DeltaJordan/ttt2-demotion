CreateConVar("ttt2_demotion_infected", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_demotion_serialkiller", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})

if SERVER then
    local function DemoteTraitor(ply, base_role)
        if ply:IsTerror() and ply:Alive() and base_role == ROLE_TRAITOR then
            events.Trigger(EVENT_DEMOTE_TRAITOR, ply)
            ply:SetRole(ROLE_INNOCENT)
            timer.Simple(0.1, function()
                ply:SetCredits(0)
            end)
            --Call this function whenever a role change occurs during an active round.
            SendFullStateUpdate()
        end
    end

    hook.Add("TTTBeginRound", "DemotionDemoteTraitors", function()
        local demotion_infected = GetConVar("ttt2_demotion_infected"):GetBool()
        local demotion_serialkiller = GetConVar("ttt2_demotion_infected"):GetBool()
        if not demotion_infected and not demotion_serialkiller then return end

        local should_demote = false
        for _, ply in pairs(player.GetAll()) do
            if demotion_infected and ROLE_INFECTED and ply:GetSubRole() == ROLE_INFECTED then
                should_demote = true
                break
            end
            if demotion_serialkiller and ROLE_SERIALKILLER and ply:GetSubRole() == ROLE_SERIALKILLER then
                should_demote = true
                break
            end
        end

        if should_demote then
            for _, ply in pairs(player.GetAll()) do
                if ply:GetBaseRole() == ROLE_TRAITOR then
                    DemoteTraitor(ply, ply:GetBaseRole())
                end
            end
        end
    end)
end