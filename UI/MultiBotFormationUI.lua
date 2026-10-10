if not MultiBot then return end

local FORMATION_FRAME_NAME = "Format"
local FORMATION_BUTTON_NAME = "Format"
local FORMATION_DEFAULT_ICON = "Interface\\AddOns\\ProjectJaina_MultiBot\\Icons\\formation_near.blp"
local FORMATION_FRAME_X = -2
local FORMATION_FRAME_Y = 34
local FORMATION_CELL_WIDTH = 40
local FORMATION_CELL_HEIGHT = 30

local latestFormationToken = nil
local latestFormationQueryToken = nil
local latestFormationTooltipToken = nil

local FORMATION_BUTTONS = {
    { name = "Arrow", icon = "Interface\\AddOns\\ProjectJaina_MultiBot\\Icons\\formation_arrow.blp", value = "arrow" },
    { name = "Queue", icon = "Interface\\AddOns\\ProjectJaina_MultiBot\\Icons\\formation_queue.blp", value = "queue" },
    { name = "Near", icon = "Interface\\AddOns\\ProjectJaina_MultiBot\\Icons\\formation_near.blp", value = "near" },
    { name = "Melee", icon = "Interface\\AddOns\\ProjectJaina_MultiBot\\Icons\\formation_melee.blp", value = "melee" },
    { name = "Line", icon = "Interface\\AddOns\\ProjectJaina_MultiBot\\Icons\\formation_line.blp", value = "line" },
    { name = "Circle", icon = "Interface\\AddOns\\ProjectJaina_MultiBot\\Icons\\formation_circle.blp", value = "circle" },
    { name = "Chaos", icon = "Interface\\AddOns\\ProjectJaina_MultiBot\\Icons\\formation_chaos.blp", value = "chaos" },
    { name = "Shield", icon = "Interface\\AddOns\\ProjectJaina_MultiBot\\Icons\\formation_shield.blp", value = "shield" },
}

local function formationText(key)
    if MultiBot and type(MultiBot.L) == "function" then
        local value = MultiBot.L(key)
        if type(value) == "string" and value ~= "" then
            return value
        end
    end

    return key
end

local function formationLabel(value)
    local normalized = string.lower(tostring(value or "?"))
    local key = "formation.name." .. normalized

    if normalized == "?" then
        key = "formation.name.unknown"
    end

    local label = formationText(key)
    if label == key then
        return normalized
    end

    return label
end

local function hideFormationTooltip(token, owner)
    if token ~= latestFormationTooltipToken then
        return
    end

    latestFormationTooltipToken = nil

    if not GameTooltip or not GameTooltip.GetOwner or not GameTooltip.Hide then
        return
    end

    if GameTooltip:GetOwner() ~= owner then
        return
    end

    GameTooltip:Hide()
end

local function showFormationTooltip(button, result)
    if not button or not GameTooltip then
        return
    end

    local token = result and result.token or tostring(GetTime and GetTime() or 0)
    latestFormationTooltipToken = token

    GameTooltip:SetOwner(button, "ANCHOR_TOPRIGHT", 0 - (button.size or 32), 2)
    GameTooltip:ClearLines()
    GameTooltip:AddLine(formationText("formation.query.title"), 1, 0.82, 0)

    if not result or result.status == "unavailable" then
        GameTooltip:AddLine(formationText("formation.query.unavailable"), 1, 0.25, 0.25, true)
    elseif result.status == "timeout" then
        GameTooltip:AddLine(formationText("formation.query.timeout"), 1, 0.25, 0.25, true)
    else
        local items = result.items or {}
        local count = #items

        if count == 0 then
            GameTooltip:AddLine(formationText("formation.query.empty"), 0.8, 0.8, 0.8, true)
        else
            local commonFormation = items[1] and items[1].formation or "?"
            local mixed = false

            for index = 2, count do
                if items[index].formation ~= commonFormation then
                    mixed = true
                    break
                end
            end

            if mixed then
                GameTooltip:AddLine(formationText("formation.query.mixed"), 1, 0.65, 0.2)
            else
                GameTooltip:AddLine(
                    string.format(
                        formationText("formation.query.common"),
                        formationLabel(commonFormation),
                        count
                    ),
                    0.35,
                    1,
                    0.35
                )
            end

            GameTooltip:AddLine(" ")
            for _, item in ipairs(items) do
                GameTooltip:AddDoubleLine(
                    tostring(item.botName or "?"),
                    formationLabel(item.formation),
                    1,
                    1,
                    1,
                    0.5,
                    0.82,
                    1
                )
            end
        end
    end

    GameTooltip:Show()

    if MultiBot and type(MultiBot.TimerAfter) == "function" then
        MultiBot.TimerAfter(8.0, function()
            hideFormationTooltip(token, button)
        end)
    end
end

local function applyFormationSelection(parent, texture)
    if not parent or not parent.frames or not parent.buttons then
        return
    end

    local frame = parent.frames[FORMATION_FRAME_NAME]
    local button = parent.buttons[FORMATION_BUTTON_NAME]
    if not frame or not button then
        return
    end

    button.setTexture(texture)
    frame:Hide()
    if MultiBot.RequestClickBlockerUpdate then
        MultiBot.RequestClickBlockerUpdate(frame)
    end
end

local function addFormationButton(frame, definition, column, row)
    frame.addButton(
        definition.name,
        (column - 1) * FORMATION_CELL_WIDTH,
        (row - 1) * FORMATION_CELL_HEIGHT,
        definition.icon,
        MultiBot.L("tips.format." .. string.lower(definition.name))
    ).doLeft = function(button)
        if not MultiBot.Comm or not MultiBot.Comm.RunFormationCommand then
            return
        end

        local parent = button.parent and button.parent.parent
        local token
        token = MultiBot.Comm.RunFormationCommand("GROUP", "", definition.value, function(result)
            if not result or result.token ~= latestFormationToken then
                return
            end

            latestFormationToken = nil
            if result.success > 0
                and result.failure == 0
                and result.formation == definition.value
            then
                applyFormationSelection(parent, definition.icon)
            end
        end)

        if token then
            latestFormationToken = token
        end
    end
end

function MultiBot.BuildFormationUI(tLeft)
    if not tLeft or not tLeft.addButton or not tLeft.addFrame then
        return nil
    end

    local formatButton = tLeft.addButton(
        FORMATION_BUTTON_NAME,
        0,
        0,
        FORMATION_DEFAULT_ICON,
        MultiBot.L("tips.format.master")
    )

    formatButton.doLeft = function(button)
        MultiBot.ShowHideSwitch(button.parent.frames[FORMATION_FRAME_NAME])
    end

    formatButton.doRight = function(button)
        if not MultiBot.Comm or not MultiBot.Comm.RequestFormations then
            showFormationTooltip(button, { status = "unavailable" })
            return
        end

        local token
        token = MultiBot.Comm.RequestFormations(function(result)
            if not result or result.token ~= latestFormationQueryToken then
                return
            end

            latestFormationQueryToken = nil
            showFormationTooltip(button, result)
        end)

        if token then
            latestFormationQueryToken = token
        else
            latestFormationQueryToken = nil
            showFormationTooltip(button, { status = "unavailable" })
        end
    end

    local formatFrame = tLeft.addFrame(FORMATION_FRAME_NAME, FORMATION_FRAME_X, FORMATION_FRAME_Y)
    formatFrame:Hide()

    for index, definition in ipairs(FORMATION_BUTTONS) do
        addFormationButton(formatFrame, definition, 1, index)
    end

    if MultiBot.BindShiftRightSwapButtons then
        MultiBot.BindShiftRightSwapButtons(tLeft, "LeftRoot", {
            { name = FORMATION_BUTTON_NAME, frameName = FORMATION_FRAME_NAME },
        })
    end

    return {
        rootButton = formatButton,
        frame = formatFrame,
    }
end