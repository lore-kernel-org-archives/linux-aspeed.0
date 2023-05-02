From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 2 May 2023 16:27:39 -0500
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <CACRpkdZx6vEVnxVt0tW4nYtnbv8g=Dc11sa_3myB3GW4jXk1oA@mail.gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com> <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <CACRpkdZx6vEVnxVt0tW4nYtnbv8g=Dc11sa_3myB3GW4jXk1oA@mail.gmail.com>
Message-ID: <CAL_JsqKzof_mYRw9Dd0YAVWr1AFoO8gwkVUR22AJX_RF2xv0aA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 2, 2023 at 4:19?PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, May 2, 2023 at 9:40?PM Rob Herring <robh+dt@kernel.org> wrote:
>
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
>
> I see my nits were fixed like I wanted them, and it's now mostly a
> mix of soc and vendor names that make sense so from my point of view:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> NB:
> arch/arm64/boot/dts/arm$
> vexpress-v2m-rs1.dtsi -> ../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi
>
> This still works after the script, yes?

Yes, because in the script I do:

git grep -l -F "vexpress-v2m-rs1" arch/arm64/boot/dts | xargs perl -p
-i -e "s/vexpress-v2m-rs1/arm\/arm\/vexpress-v2m-rs1/"

Rob
