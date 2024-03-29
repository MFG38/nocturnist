/*
Base class definition from where all weapons in Nocturnist inherit from.

This code is licensed under the MIT license. See docs/license.code for
details.
*/

class NoctWeapon : DoomWeapon
{
    Default
    {
        Weapon.SelectionOrder 9000;
        +WEAPON.NOALERT;
    }

    bool IsInfiniteAmmo() {
        return (sv_infiniteammo || FindInventory("PowerInfiniteAmmo", true) );
    }

    action void A_NoctMeleeAttack(
        int damage, double offset_h = 0.0, double offset_v = 0.0,
        sound atksound = "", sound hitsound = "", bool alertonhit = true,
        int alertradius = 512, class<Actor> puff = "BulletPuff"
    ) {
        if (player == null) return;
        FTranslatedLineTarget t;

        LineAttack(angle + offset_h, DEFMELEERANGE, pitch + offset_v, damage, 'Normal', puff, LAF_ISMELEEATTACK, t);

        if(t.linetarget) {
            A_AlertMonsters(alertradius);
            if(hitsound != "") A_StartSound(hitsound, CHAN_WEAPON);
        }
        else {
            if(atksound != "") A_StartSound(atksound, CHAN_WEAPON);
        }
    }

    action void A_NoctBulletAttack(
        int bullets, int damage, double spread_h = 0.0, double spread_v = 0.0,
        sound atksound = "", bool useammo = true, bool alert = true, class<Actor> puff = "BulletPuff"
    ) {
        if (player == null) return;

        if(alert) A_AlertMonsters();
        if(atksound != "") A_StartSound(atksound, CHAN_WEAPON);

		Weapon weap = player.ReadyWeapon;
		if (weap != null && invoker == weap && stateinfo != null && stateinfo.mStateType == STATE_Psprite)
		{
			if (useammo) weap.DepleteAmmo (weap.bAltFire, true, -1);
			player.SetPsprite(PSP_FLASH, weap.FindState('Flash'), true);
		}
		player.mo.PlayAttacking2();

        for(int i = 1; i <= bullets; i++) {
            double xs = angle + (Random2() * (spread_h / 256));
            double ys = pitch + (Random2() * (spread_v / 256));

            LineAttack(xs, PLAYERMISSILERANGE, ys, damage, 'Normal', puff);
        }
    }

    action void A_NoctFireProjectile(
        class<Actor> projectile, double offset_x = 0.0, double offset_y = 0.0, double offset_z = 0.0,
        double offset_a = 0.0, sound atksound = "", bool useammo = true, bool alert = true
    ) {
        if (player == null) return;

        if(alert) A_AlertMonsters();
        if(atksound != "") A_StartSound(atksound, CHAN_WEAPON);

		Weapon weap = player.ReadyWeapon;
		if (weap != null && invoker == weap && stateinfo != null && stateinfo.mStateType == STATE_Psprite)
		{
			if (useammo) weap.DepleteAmmo (weap.bAltFire, true, -1);
			player.SetPsprite(PSP_FLASH, weap.FindState('Flash'), true);
		}
		player.mo.PlayAttacking2();

        SpawnPlayerMissile(projectile, angle + offset_a, offset_x, offset_y, offset_z);
    }

    // A copy of the above function with an extra argument for limited alert radius.
    action void A_NoctFireProjectile2(
        class<Actor> projectile, double offset_x = 0.0, double offset_y = 0.0, double offset_z = 0.0,
        double offset_a = 0.0, sound atksound = "", bool useammo = true, bool alert = true,
        int alertradius = 512
    ) {
        if (player == null) return;

        if(alert) A_AlertMonsters(alertradius);
        if(atksound != "") A_StartSound(atksound, CHAN_WEAPON);

		Weapon weap = player.ReadyWeapon;
		if (weap != null && invoker == weap && stateinfo != null && stateinfo.mStateType == STATE_Psprite)
		{
			if (useammo) weap.DepleteAmmo (weap.bAltFire, true, -1);
			player.SetPsprite(PSP_FLASH, weap.FindState('Flash'), true);
		}
		player.mo.PlayAttacking2();

        SpawnPlayerMissile(projectile, angle + offset_a, offset_x, offset_y, offset_z);
    }
}
