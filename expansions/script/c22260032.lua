--华欲侍奉 专属
function c22260032.initial_effect(c)
    --to hand
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(22260032,0))
    e1:SetCategory(CATEGORY_TOHAND)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetCondition(c22260032.tgcon)
    e1:SetTarget(c22260032.tgtg)
    e1:SetOperation(c22260032.tgop)
    c:RegisterEffect(e1)
    --index
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_TOHAND)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_TO_GRAVE)
    e2:SetProperty(EFFECT_FLAG_DELAY)
    e2:SetCondition(c22260032.ixcon)
    e2:SetTarget(c22260032.ixtg)
    e2:SetOperation(c22260032.ixop)
    c:RegisterEffect(e2)
end
--
c22260032.named_with_AzayakaSin=1
c22260032.Desc_Contain_AzayakaSin=1
function c22260032.IsAzayakaSin(c)
    local m=_G["c"..c:GetCode()]
    return m and m.named_with_AzayakaSin
end
--
function c22260032.tgconfilter(c)
    return c:GetControler()~=c:GetOwner()
end
function c22260032.tgcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
        and Duel.IsExistingMatchingCard(c22260032.tgconfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c22260032.tgfilter(c)
    return c22260032.IsAzayakaSin(c) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c22260032.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c22260032.tgfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c22260032.tgop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c22260032.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    Duel.BreakEffect()
    Duel.Draw(1-tp,1,REASON_EFFECT)
end
--
function c22260032.ixcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsReason(REASON_COST) and re:IsHasType(0x7f0)
        and re:GetHandler():IsAzayakaSin(c)
end
function c22260032.ixfilter(c)
    return c22260032.IsAzayakaSin(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and not c:IsCode(22260032)
end
function c22260032.ixtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c22260032.ixfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c22260032.ixop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c22260032.ixfilter,tp,LOCATION_DECK,0,1,1,nil)
    Duel.SendtoHand(g,nil,REASON_EFFECT)
    Duel.ConfirmCards(1-tp,g)
    Duel.BreakEffect()
    Duel.Draw(1-tp,1,REASON_EFFECT)
end