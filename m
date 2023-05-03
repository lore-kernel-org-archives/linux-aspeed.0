From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 2 May 2023 20:17:17 -0500
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <bce93654-fc36-3d12-282d-76fafb8f51ce@linaro.org>
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com> <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <bce93654-fc36-3d12-282d-76fafb8f51ce@linaro.org>
Message-ID: <CAL_JsqJXd_EpOQwwNEAn25mzFfkhEvqzur6ui5Ca+dbt2kA8-Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 2, 2023 at 5:52?PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 02/05/2023 22:40, Rob Herring wrote:
> > On Tue, May 2, 2023 at 3:15?AM Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> On Tue, Apr 25, 2023, at 17:57, Rob Herring wrote:
> >>> On Tue, Apr 25, 2023 at 2:28?AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>>
> >>>> Does your script also cater for .dts files not matching any pattern,
> >>>> but including a .dtsi file that does match a pattern?
> >>>
> >>> I assume I built everything after moving, but maybe not...
> >>>
> >>> That's all just "details". First, we need agreement on a) moving
> >>> things to subdirs and b) doing it 1-by-1 or all at once. So far we've
> >>> been stuck on a) for being 'too much churn'.
> >>
> >> Sorry for missing most of the discussion last week. The script sounds
> >> fine to me, the only reason I didn't want to do this in the past is that
> >> we had the plan to move platforms out of the kernel tree to an external
> >> repository and I wanted to do this platform at a time and also only move
> >> each one once. I don't think that is going to happen anytime soon now,
> >> so let's just do your script.
> >>
> >> Can you send me the script and/or a pull request of the resulting
> >> tree based on my soc/dt branch? Everything is merged upstream,
> >> and I think git-merge would handle the remaining merges with any
> >> other changes in mainline.
> >
> > I've dusted off my script and made a branch[1] with the result.
> > There's just a couple of fixes needed after the script is run (see the
> > top commit). The cross arch includes are all fixed up by the script.
> > dtbs_install maintains a flat install. I compared the number of .dtbs
> > before and after to check the script.
> >
> > I think the only issue remaining is finalizing the mapping of
> > platforms to subdirs. What I have currently is a mixture of SoC
> > families and vendors. The most notable are all the Freescale/NXP
> > platforms, pxa, socfpga, and stm32. It's not consistent with arm64
> > either. Once that's finalized, I still need to go update MAINTAINERS.
> >
> > Here's the current mapping:
> >
> > vendor_map = {
> >      'alphascale' : 'alphascale',
> >      'alpine' : 'alpine',
> >      'artpec' : 'axis',
> >      'axm' : 'lsi',
> >      'cx9' : 'cnxt',
> >      'ecx' : 'calxeda',
> >      'highbank' : 'calxeda',
> >      'ep7' : 'cirrus',
> >      'mxs': 'mxs',
> >      'imx23': 'mxs',
> >      'imx28': 'mxs',
> >      'sun' : 'allwinner',
> >      'imx': 'imx',
> >      'e6' : 'imx',
> >      'e7' : 'imx',
> >      'mba6' : 'imx',
> >      'ls': 'fsl',
> >      'vf': 'fsl',
> >      'qcom': 'qcom',
> >      'am3' : 'ti',
> >      'am4' : 'ti',
> >      'am5' : 'ti',
> >      'dra' : 'ti',
> >      'keystone' : 'ti',
> >      'omap' : 'ti',
> >      'compulab' : 'ti',
> >      'logicpd' : 'ti',
> >      'elpida' : 'ti',
> >      'motorola' : 'ti',
> >      'twl' : 'ti',
> >      'da' : 'ti',
> >      'dm' : 'ti',
> >      'nspire' : 'nspire',
> >      'armada' : 'marvell',
> >      'dove' : 'marvell',
> >      'kirkwood' : 'marvell',
> >      'orion' : 'marvell',
> >      'mvebu' : 'marvell',
> >      'mmp' : 'marvell',
> >      'berlin' : 'berlin',
> >      'pxa2' : 'pxa',
> >      'pxa3' : 'pxa',
> >      'pxa' : 'marvell',
>
> I'd question if it makes sense to split the pxa line. Yes, it was sold
> by Intel to Marvell, but IIRC the devices still had some inheritance.
> So, if we have the 'pxa' subdir, I'd move Marvell PXAs to that dir too.

I think I probably split it because it was different maintainers.
Though it doesn't look like pxa168 or pxa910 have any maintainer. They
are a mixture of pxa and mmp I think.

Rob
