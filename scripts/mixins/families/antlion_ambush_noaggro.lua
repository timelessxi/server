-- Antlion family mixin (for ones that ambush and are non-aggressive)
-- Not hiding upon DISENGAGE event, since mob would be spawned and no longer be accessible
-- Example: Alastor Antlion has ambush animation when popped [1], but does not burrow when going unclaimed [2]
-- [1] Alastor Antlion https://www.youtube.com/watch?v=Q3L0SAxiK54
-- [2] Alastor Antlion duo part 2 of 5 https://www.youtube.com/watch?v=-hAyx56fVnE

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.antlion_ambush_noaggro = function(antlionAmbushNoaggroMob)
    local pitAmbush = 278

    antlionAmbushNoaggroMob:addListener('SPAWN', 'ANTLION_AMBUSH_NOAGGRO_SPAWN', function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
        mob:setAnimationSub(0)
    end)

    antlionAmbushNoaggroMob:addListener('ENGAGE', 'ANTLION_AMBUSH_NOAGGRO_ENGAGE', function(mob, target)
        mob:useMobAbility(pitAmbush)
    end)

    -- Ensures an interupted pit ambush doesn't let the mob stay hidden underground
    antlionAmbushNoaggroMob:addListener('WEAPONSKILL_STATE_EXIT', 'ANTLION_AMBUSH_FINISH', function(mob, skillID)
        if skillID == pitAmbush then
            -- ensure name doesn't show up until mobskill completes
            mob:setAnimationSub(1)
            mob:hideName(false)
            mob:setUntargetable(false)
        end
    end)
end

return g_mixins.families.antlion_ambush_noaggro
