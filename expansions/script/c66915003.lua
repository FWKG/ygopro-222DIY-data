--破坏星曜·解离
function c66915003.initial_effect(c)
    c:SetUniqueOnField(1,0,66915003)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetRange(LOCATION_SZONE)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetCode(EFFECT_LINK_SPELL_KOISHI)
    e2:SetValue(LINK_MARKER_TOP+LINK_MARKER_TOP_LEFT)
    c:RegisterEffect(e2)  
    --atk up/indestructable
    local e22=Effect.CreateEffect(c)
    e22:SetType(EFFECT_TYPE_FIELD)
    e22:SetCode(EFFECT_UPDATE_ATTACK)
    e22:SetRange(LOCATION_SZONE)
    e22:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
    e22:SetTarget(c66915003.tgtg)
    e22:SetValue(1000)
    c:RegisterEffect(e22) 
    --actlimit
    local e222=Effect.CreateEffect(c)
    e222:SetType(EFFECT_TYPE_FIELD)
    e222:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e222:SetCode(EFFECT_CANNOT_ACTIVATE)
    e222:SetRange(LOCATION_MZONE)
    e222:SetTargetRange(0,1)
    e222:SetValue(c66915003.aclimit)
    e222:SetCondition(c66915003.actcon)
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
    e5:SetRange(LOCATION_SZONE)
    e5:SetTargetRange(LOCATION_MZONE,0)
    e5:SetTarget(c66915003.eftg)
    e5:SetLabelObject(e222)
    --spsummon limit
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetTargetRange(1,0)
    e2:SetTarget(c66915003.sumlimit)
    c:RegisterEffect(e2)
end
function c66915003.aclimit(e,re,tp)
    return not re:GetHandler():IsImmuneToEffect(e)
end
function c66915003.actcon(e)
    return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c66915003.eftg(e,c)
    local lg=e:GetHandler():GetLinkedGroup()
    return c:IsType(TYPE_EFFECT) and c:IsSetCard(0x1374) and lg:IsContains(c)
end
function c66915003.tgtg(e,c)
    return e:GetHandler():GetLinkedGroup():IsContains(c) and c:IsType(TYPE_EFFECT) and c:IsSetCard(0x1374)
end
function c66915003.sumlimit(e,c,sump,sumtype,sumpos,targetp)
    return c:IsLocation(LOCATION_EXTRA) and not c:IsSetCard(0x1374)
end