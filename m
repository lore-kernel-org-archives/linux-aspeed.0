From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 8 Jun 2023 14:33:53 -0600
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <ZFrPJQdwoxqFpzUO@probook>
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com> <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <ZFrPJQdwoxqFpzUO@probook>
Message-ID: <CAL_JsqLTj_L-V8HR=TzO6+r9Xew=yivaKG1ngCn+NCjgPZwZzw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 9, 2023 at 4:55?PM Jonathan Neusch?fer
<j.neuschaefer@gmx.net> wrote:
>
> On Tue, May 02, 2023 at 02:40:19PM -0500, Rob Herring wrote:
> [...]
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
> [...]
> >     'aspeed' : 'aspeed',
> >     'ast2' : 'aspeed',
> >     'facebook' : 'aspeed',
> >     'ibm' : 'aspeed',
>
> >     'openbmc' : 'aspeed',
>
> The openbmc flash layouts are currently only used by aspeed devicetrees,
> but they don't really depend on any aspeed details. It would be possible
> to reuse them in Nuvoton BMC devicetrees in the future, for example.
>
> In that sense, I think putting them in a separate "openbmc" directory
> would be slightly better.

Could be used on arm64 or riscv too at some point. We do some cross
arch includes, but IMO it would be better to move to
include/dt-bindings/ or somewhere outside of arch/. Other common
things I didn't move. I could do that here too. I prefer to that the
sub-directories are just chip vendors/families.

Rob
