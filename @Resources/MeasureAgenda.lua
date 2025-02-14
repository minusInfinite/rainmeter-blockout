function Initialize()
    JSON = dofile(SKIN:GetVariable('@') .. 'json.lua')
    DynamicMeterFile = SELF:GetOption('DynamicMeterFile')
    AgendaFile = SELF:GetOption('AgendaFile')
    DefaultDuration = SELF:GetNumberOption('Duration', 1)
    DefaultR = SELF:GetNumberOption('R', 1)
    DefaultG = SELF:GetNumberOption('G', 165)
    DefaultB = SELF:GetNumberOption('B', 15)
end

function GetAgenda()
    local file = io.open(AgendaFile, "r")
    if not file then
        print('GetAgenda:Unable to open file at' .. AgendaFile)
        return
    end

    local content = file:read("*a")
    file:close()

    local agenda = JSON.decode(content)

    return agenda
end

function Update()
    -- agenda scheme
    -- - name
    -- - starttime
    -- - duration
    -- - Red
    -- - Green
    -- - Blue

    DynamicOutput = {}
    Agenda = GetAgenda()

    DynamicOutput[#DynamicOutput + 1] = "[Variables]"

    for i = 1, #Agenda, 1 do
        DynamicOutput[#DynamicOutput + 1] = "blockAFade" .. i .. "=175"
        DynamicOutput[#DynamicOutput + 1] = "blockSFade" .. i .. "=255"
    end

    DynamicOutput[#DynamicOutput + 1] = "\n[MeterRefreshAgenda]"
    DynamicOutput[#DynamicOutput + 1] = "Meter=String"
    DynamicOutput[#DynamicOutput + 1] = "MeterStyle=IconBase"
    DynamicOutput[#DynamicOutput + 1] = "Text=[\\[#featherrefresh]]"
    DynamicOutput[#DynamicOutput + 1] = "X=(155*#Scale#)"
    DynamicOutput[#DynamicOutput + 1] = "Y=(24*#Scale#)r"
    DynamicOutput[#DynamicOutput + 1] = "DynamicVariables=1"
    DynamicOutput[#DynamicOutput + 1] = "LeftMouseUpAction=[!Refresh][!Refresh]"

    DynamicOutput[#DynamicOutput + 1] = "\n[MeterAddAgenda]"
    DynamicOutput[#DynamicOutput + 1] = "Meter=String"
    DynamicOutput[#DynamicOutput + 1] = "MeterStyle=IconBase"
    DynamicOutput[#DynamicOutput + 1] = "Text=[\\[#featherplus]]"
    DynamicOutput[#DynamicOutput + 1] = "X=4R"
    DynamicOutput[#DynamicOutput + 1] = "Y=r"
    DynamicOutput[#DynamicOutput + 1] = "DynamicVariables=1"
    DynamicOutput[#DynamicOutput + 1] = "LeftMouseUpAction=[!CommandMeasure MeasureInput \"ExecuteBatch 1-2\"]"

    for i = 1, #Agenda, 1 do
        local strokeColorR = Agenda[i]['R'] >= 115 and 255 or 0
        local strokeColorG = Agenda[i]['G'] >= 115 and 255 or 0
        local strokeColorB = Agenda[i]['B'] >= 115 and 255 or 0

        DynamicOutput[#DynamicOutput + 1] = "\n[Block" .. i .. "]"
        DynamicOutput[#DynamicOutput + 1] = "Meter=Shape"
        DynamicOutput[#DynamicOutput + 1] = "X=(35*#Scale#)"
        DynamicOutput[#DynamicOutput + 1] = "Y=([Hour" .. Agenda[i]['starttime'] .. ":Y]+(8*#Scale#))"
        DynamicOutput[#DynamicOutput + 1] = "Shape=Rectangle 0,0,(140*#Scale#),(((584*#Scale#)*((" ..
            Agenda[i]['duration'] .. "*3600)/86400))) | Extend BlockE"
        DynamicOutput[#DynamicOutput + 1] =
            "BlockE=Fill Color " .. Agenda[i]['R'] .. "," .. Agenda[i]['G'] .. "," .. Agenda[i]['B'] ..
            ",(#blockAFade" ..
            i ..
            "#) | StrokeWidth (2*#Scale#) | Stroke Color " ..
            strokeColorR .. "," .. strokeColorG .. "," .. strokeColorB .. ",(#blockSFade" .. i .. "#)"
        DynamicOutput[#DynamicOutput + 1] =
            "Shape2=Rectangle 0,0,(140*#Scale#),(((584*#Scale#)*((" ..
            Agenda[i]['duration'] .. "*3600)/86400))) | Extend BlockA"
        DynamicOutput[#DynamicOutput + 1] =
            "BlockA=Fill Color 200,55,35,(175-#blockAFade" ..
            i .. "#) | StrokeWidth (2*#Scale#) | Stroke Color 255,0,0,(255-#blockSFade" .. i .. "#)"
        DynamicOutput[#DynamicOutput + 1] = "ToolTipTitle=" .. Agenda[i]['name'] .. ""
        DynamicOutput[#DynamicOutput + 1] = "ToolTipText=Duration:" .. Agenda[i]['duration'] .. ""
        DynamicOutput[#DynamicOutput + 1] = "DynamicVariables=1"
        DynamicOutput[#DynamicOutput + 1] = "\n[Block" .. i .. "Del]"
        DynamicOutput[#DynamicOutput + 1] = "Meter=String"
        DynamicOutput[#DynamicOutput + 1] = "MeterStyle=IconDel"
        DynamicOutput[#DynamicOutput + 1] = "FontColor=255,255,255,(255-#blockSFade" .. i .. "#)"
        DynamicOutput[#DynamicOutput + 1] = "Text=[\\[#featherdelete]]"
        DynamicOutput[#DynamicOutput + 1] = "X=(([Block" .. i .. ":X])+([Block" .. i .. ":W])*0.5)"
        DynamicOutput[#DynamicOutput + 1] = "Y=(([Block" .. i .. ":Y])+([Block" .. i .. ":H])*0.5)"
        DynamicOutput[#DynamicOutput + 1] = "FontSize=((([Block" .. i .. ":H])*0.5)*#Scale#)"
        DynamicOutput[#DynamicOutput + 1] = "StringAlign=CenterCenter"
        DynamicOutput[#DynamicOutput + 1] =
            "MouseOverAction=[!SetVariable blockAFade" ..
            i ..
            " \"(-175+#blockAFade" ..
            i ..
            "#)\"][!SetVariable blockSFade" ..
            i .. " \"(-255+#blockSFade" .. i .. "#)\"][!UpdateMeter \"#CURRENTSECTION#\"][!UpdateMeter \"Block" ..
            i .. "Del\"][!Redraw]"
        DynamicOutput[#DynamicOutput + 1] =
            "MouseLeaveAction=[!SetVariable blockAFade" ..
            i ..
            " \"(175+#blockAFade" ..
            i ..
            "#)\"][!SetVariable blockSFade" ..
            i .. " \"(255+#blockSFade" .. i .. "#)\"][!UpdateMeter \"#CURRENTSECTION#\"][!UpdateMeter \"Block" ..
            i .. "Del\"][!Redraw]"
        DynamicOutput[#DynamicOutput + 1] =
            "LeftMouseDoubleClickAction=[!CommandMeasure \"MeasureAgenda\" \"RemoveBlock(" ..
            i .. ")\"][!Refresh][!Refresh]"
        DynamicOutput[#DynamicOutput + 1] = "DynamicVariables=1"
    end

    local file = io.open(DynamicMeterFile, 'w')

    if not file then
        print("Update: unable to open file " .. DynamicMeterFile)
        return
    end

    Output = table.concat(DynamicOutput, '\n')

    file:write(Output)
    file:close()

    return true
end

function AddBlock(addAgenda)
    local rFile = io.open(AgendaFile, 'r')
    local aFile = rFile:read("*a")
    rFile:close()

    local cJson = JSON.decode(aFile)
    local agendaText = SplitText(addAgenda, '%,')
    local newAgenda = {
        ['name'] = agendaText[1],
        ['starttime'] = agendaText[2],
        ['duration'] = agendaText[3] and agendaText[3] + 0 or DefaultDuration,
        ['R'] = agendaText[4] and agendaText[4] + 0 or DefaultR,
        ['G'] = agendaText[5] and agendaText[5] + 0 or DefaultG,
        ['B'] = agendaText[6] and agendaText[6] + 0 or DefaultB
    }

    table.insert(cJson, newAgenda)

    local eJson = JSON.encode(cJson)
    local wFile = io.open(AgendaFile, "w")
    wFile:write(eJson)
    wFile:close()

    return true
end

function RemoveBlock(nBlock)
    local rFile = io.open(AgendaFile, 'r')
    local aFile = rFile:read("*a")
    rFile:close()

    local cJson = JSON.decode(aFile)
    table.remove(cJson, nBlock)
    local eJson = JSON.encode(cJson)
    local wFile = io.open(AgendaFile, "w")
    wFile:write(eJson)
    wFile:close()

    return true
end

function SplitText(inputstr, sep)
    sep = sep or '%|'
    local t = {}
    for field, s in string.gmatch(inputstr, "([^" .. sep .. "]*)(" .. sep .. "?)") do
        table.insert(t, field)
        if s == "" then return t end
    end
end
