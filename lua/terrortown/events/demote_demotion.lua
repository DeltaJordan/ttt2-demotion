if SERVER then
    AddCSLuaFile()

    resource.AddFile("materials/vgui/ttt/vskin/events/demote_demotion.vmt")

    function EVENT:Trigger(demoted_ply)
        self:AddAffectedPlayers(
            { demoted_ply:SteamID64() },
            { demoted_ply:GetName() }
        )

        return self:Add({
            serialname = self.event.title,
            ply_name = demoted_ply:GetName(),
            ply_role = demoted_ply:GetSubRole()
        })
    end

    function EVENT:Serialize()
        return self.event.serialname
    end
end

if CLIENT then
    EVENT.title = "title_event_demote_demotion"
    EVENT.icon = Material("materials/vgui/ttt/vskin/events/demote_demotion.vmt")

    function EVENT:GetText()
        return {
            {
                string = "desc_event_demote_demotion",
                params = {
                    name = self.event.ply_name,
                    oldRole = roles.GetByIndex(self.event.ply_role).name
                },
                translateParams = true
            }
        }
    end
end