From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Sun, 18 Jun 2023 16:02:40 +0200
Subject: patches dropped from drm-misc-next [Was: Re: [PATCH 00/53] drm:
 Convert to platform remove callback returning] void
In-Reply-To: <20230618123915.hmy66z7e532jhwgk@pengutronix.de>
References: <20230507162616.1368908-1-u.kleine-koenig@pengutronix.de>
 <20230601154002.uv2wfatpb7b45duz@pengutronix.de>
 <CAD=FV=WvP--wJwBQtnSoW_xb57R1Wf9dH0XzWxe+NorczXfeAw@mail.gmail.com>
 <20230617161222.wy55pbomnrrlfy5u@pengutronix.de>
 <CAD=FV=U5gbMUNteyyFcTvHVBDWzfthM0aDirJC+yXGovDwMOBA@mail.gmail.com>
 <20230618123915.hmy66z7e532jhwgk@pengutronix.de>
Message-ID: <20230618140240.4gx4hmcf6rv5qvfi@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello again,

On Sun, Jun 18, 2023 at 02:39:15PM +0200, Uwe Kleine-K?nig wrote:
> > Actually, it was probably a mistake that these patches got merged to
> > linuxnext during the 4 days that you noticed. However, your patches
> > aren't dropped and are still present in drm-misc-next.
> > 
> > drm-misc has a bit of a unique model and it's documented fairly well here:
> > 
> > https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html
> 
> Is there a flaw then in this unique model (or its implementation) when
> drm-misc/for-linux-next moves in a non-fast-forward manner? This isn't
> expected, is it?

FTR, I checked historic next trees to find other trees where
for-linux-next were moved in a non-fast-forward manner[1]. I found:

	$ git for-each-ref --format='%(refname)' refs/tags/next-* | while read n; do hn=$(git show $n:Next/SHA1s 2>/dev/null | awk '$1 == "drm-misc" { print $2 }'); if test -z "$hn"; then continue; fi; if test -n "$prevhn" && ! git merge-base --is-ancestor "$prevhn" "$hn"; then if git merge-base --is-ancestor "$hn" linus/master; then merged=x; else merged="-"; fi; echo "$n ($prevhn -> $hn) [$merged]"; fi; prevhn=$hn; done
	refs/tags/next-20151231 (e8b4855b5dd3e285d0ec18ed15468025abc1be9a -> e112e593b215c394c0303dbf0534db0928e87967) [x]
	refs/tags/next-20160212 (e24bfdd5052ca65e99fb835838da9d64b36ddc88 -> 382ab95d1af85381d8a5dff09b16a80c7e492534) [x]
	refs/tags/next-20170613 (18e51064c42ca3945b94dd4652156b62457962bc -> 2d7b56378d32b0cf006f8944cbba4046df45dd25) [x]
	refs/tags/next-20180406 (3ae7fb202d86b7847f237daa474f3946bdc3b0c6 -> 41613a1a7df27a0aa34bf77d51278bbe8e108a8f) [x]
	refs/tags/next-20180517 (3131f209468d1514af378dd46eb34123d0af84ff -> 2045b22461c07a88dc3d2bab3cbfc6dc0c602fd4) [x]
	refs/tags/next-20190320 (e552f0851070fe4975d610a99910be4e9bf5d7bd -> 29054230f3e11ea818eccfa7bb4e4b3e89544164) [x]
	refs/tags/next-20190617 (9f9b25593ab4197318e3621201588ad8cd525c9b -> b1622cb3be4557fd086831ca7426eafe5f1acc2e) [x]
	refs/tags/next-20190723 (7aaddd96d5febcf5b24357a326b3038d49a20532 -> d808097627e51d53cf9b1aa13239b5c4a6adaefb) [x]
	refs/tags/next-20190829 (66c2dee4ae10a2d841c40b9dd9c7141eb23eee76 -> 578d2342ec702e5fb8a77983fabb3754ae3e9660) [x]
	refs/tags/next-20191004 (d7d44b6fe40a98e960be92ea8617954c2596d140 -> 4092de1ba34eb376791809fb366bc15f8a9e0b7c) [x]
	refs/tags/next-20191106 (8a537de0f3d8b655cb901c948ed863bf0b23277b -> cea35f5ad5ffac06ea29e0d7a7f748683e1f1b7d) [x]
	refs/tags/next-20191216 (0a5239985a3bc084738851afdf3fceb7d5651b0c -> d4e6a62d3769ef09bfe116b261a61ef871dea4f9) [x]
	refs/tags/next-20200123 (73896f60d4865657740c64821a7b18825a9bf96c -> db735fc4036bbe1fbe606819b5f0ff26cc76cdff) [x]
	refs/tags/next-20200415 (152cce0006abf7e17dfb7dc94896b044bda4e588 -> 74aae1c42f4a7f69934762f9e9f90a3ec335fef2) [x]
	refs/tags/next-20200521 (5bebaeadb30e8d1ed694bd9b63d4e424d333fe36 -> 0df3ff451287d71c620384eb7bb2cd3a8106412c) [x]
	refs/tags/next-20200617 (291ddeb621e4a9f1ced8302a777fbd7fbda058c6 -> cfe28f909ddd6ca854568870a7a9b46454e52b6f) [x]
	refs/tags/next-20200724 (9fadd6d1e2977bbd449d4fb99cde41ed6f71f668 -> 206739119508d5ab4b42ab480ff61a7e6cd72d7c) [x]
	refs/tags/next-20200924 (ad44c03208e46b83e4ae3269e32c9e524aa71cf8 -> de194561359788871f7d8f5f7797557a2a166b4e) [x]
	refs/tags/next-20201027 (2580a493a97da4a302cb66251b558bfc04c16e68 -> 70bb9193728627e84e02eb0960b0aa138ae2cef5) [x]
	refs/tags/next-20201214 (c365d304d69ab2a38e1431323d17a216b7930e32 -> 05faf1559de52465f1e753e31883aa294e6179c1) [x]
	refs/tags/next-20210211 (5ceeb328637a01e0e54e2618cff129c6a1c31dba -> e2183fb135a7f62d317aa1c61eb3d1919080edba) [x]
	refs/tags/next-20210319 (5fd3de7a51855e086d9ce9d2d752489e9c15b850 -> 4cf1d8719aab0ad89690abb1d37ecf4552778420) [x]
	refs/tags/next-20210409 (167b400217121338a2beb78e09e2c77bd95491f5 -> 9c0fed84d5750e1eea6c664e073ffa2534a17743) [x]
	refs/tags/next-20210615 (a3a5f9d0fb15da90820254ba735491887cc12099 -> 1bd8a7dc28c1c410f1ceefae1f2a97c06d1a67c2) [x]
	refs/tags/next-20210714 (34bd46bcf3de72cbffcdc42d3fa67e543d1c869b -> 35d283658a6196b2057be562096610c6793e1219) [x]
	refs/tags/next-20210715 (35d283658a6196b2057be562096610c6793e1219 -> 85fd4a8a84316166640102676a356755ddec80e0) [-]
	refs/tags/next-20210726 (85fd4a8a84316166640102676a356755ddec80e0 -> 03b7c552d081b73ba814eefc257c704b4d096d93) [x]
	refs/tags/next-20210727 (03b7c552d081b73ba814eefc257c704b4d096d93 -> 87360168759879d68550b0c052bbcc2a0339ff74) [-]
	refs/tags/next-20210817 (87360168759879d68550b0c052bbcc2a0339ff74 -> 80cbd8808f85017b8aff4b223db68926b470be12) [x]
	refs/tags/next-20211101 (2b3374306b315be02db0f67d3102a0d1e1357270 -> b3ec8cdf457e5e63d396fe1346cc788cf7c1b578) [x]
	refs/tags/next-20211117 (bcae3af286f49bf4f6cda03f165fbe530f4a6bed -> a193f3b4e050e35c506a34d0870c838d8e0b0449) [x]
	refs/tags/next-20211217 (43d5ac7d07023cd133b978de473b3400edad941f -> d6c75c295f67b26fad8ba2e72db80e0f744e9da9) [x]
	refs/tags/next-20220317 (07f380da3ebd8d84fc866ccf83d93c667fcaaeaa -> f6d790e5a7fe42706756c7fa1686d08d230610fc) [x]
	refs/tags/next-20220406 (67bae5f28c895f8737a1974c3f31cf12b9170b14 -> 21d139a95682c6ade89a2151e44012c9797c0309) [x]
	refs/tags/next-20220513 (aebeb02dfccb61d6930112aede2db3db5b8e974e -> 6071c4c2a319da360b0bf2bc397d4fefad10b2c8) [x]
	refs/tags/next-20220610 (5ee8c8f930ba7d20717c4fc2d9f1ce0e757d1155 -> efeeaefe9be56e8ae5e5b4e9ff6d2275ec977ec5) [x]
	refs/tags/next-20220715 (887ddf3251928dc39bfc58c5c62083d38a633c14 -> c96cfaf8fc02d4bb70727dfa7ce7841a3cff9be2) [x]
	refs/tags/next-20220818 (2939deac1fa220bc82b89235f146df1d9b52e876 -> 8ba9249396bef37cb68be9e8dee7847f1737db9d) [x]
	refs/tags/next-20221007 (fdd0640b639070efb58226c96cea5861150e8dce -> 39dd0cc2e5bd0d5188dd69f27e18783cea7ff06a) [x]
	refs/tags/next-20221122 (e3ddd2d25533d1cc6f9fea421e4a5f16b60b3434 -> 29583dfcd2dd72c766422bd05c16f06c6b1fb356) [x]
	refs/tags/next-20230106 (03dec92c4f788c54a7c01b40a018f601eb8a6c52 -> 4c00ac500d0edd1a6730c4e8293834a694c1b304) [x]
	refs/tags/next-20230201 (d023d6f741c85bb00d2ca43d338327fbc150c113 -> aebd8f0c6f8280ba35bc989f4a9ea47469d3589a) [x]
	refs/tags/next-20230616 (c2807ecb529004ea6f2c2be823c495dc8491e205 -> cf683e8870bd4be0fd6b98639286700a35088660) [-]

so up to now it happend only three times (i.e. the lines with [-]) that
drm-misc/for-linux-next changed in a non-ff way and the commit wasn't
included later in the mainline (and for refs/tags/next-20230616 we
assume this will change to [x] during the next merge window)

So it seems to happen every few weeks ...

Best regards
Uwe

[1] My collection of historic next tags is incomplete, so there might be
more.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230618/bf6174b7/attachment-0001.sig>
