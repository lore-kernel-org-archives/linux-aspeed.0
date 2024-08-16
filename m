From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Fri, 16 Aug 2024 04:07:59 +0000
Subject: [PATCH v1 07/10] arm64: aspeed: Add support for ASPEED AST2700
 BMC SoC
In-Reply-To: <b7b3cbc2-5f20-4a78-b189-b509acfee3ac@kernel.org>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-8-kevin_chen@aspeedtech.com>
 <b7b3cbc2-5f20-4a78-b189-b509acfee3ac@kernel.org>
Message-ID: <PSAPR06MB4949D912D866D3515279BAA389812@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzk,

> > ---
> >  MAINTAINERS                  |  3 +++
> >  arch/arm64/Kconfig.platforms | 14 ++++++++++++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > c0a3d9e93689..08609430cfe0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2121,7 +2121,10 @@ Q:
>       https://patchwork.ozlabs.org/project/linux-aspeed/list/
> >  T: git git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
> >  F: Documentation/devicetree/bindings/arm/aspeed/
> >  F: arch/arm/boot/dts/aspeed/
> > +F: arch/arm64/boot/dts/aspeed/
> >  F: arch/arm/mach-aspeed/
> > +F: include/dt-bindings/clock/aspeed,ast2700-clk.h
> > +F: include/dt-bindings/reset/aspeed,ast2700-reset.h
> >  N: aspeed
> >
> >  ARM/AXM LSI SOC
> > diff --git a/arch/arm64/Kconfig.platforms
> > b/arch/arm64/Kconfig.platforms index 6c6d11536b42..1db7b6f1ee0a 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -40,6 +40,20 @@ config ARCH_APPLE
> >       This enables support for Apple's in-house ARM SoC family, starting
> >       with the Apple M1.
> >
> > +config ARCH_ASPEED
> > +   bool "Aspeed SoC family"
> > +   select MACH_ASPEED_G7
> > +   help
> > +     Say yes if you intend to run on an Aspeed ast2700 or similar
> > +     seventh generation Aspeed BMCs.
> > +
> > +config MACH_ASPEED_G7
> > +   bool "Aspeed SoC AST2700"
>
> There are no MACHines for arm64. Look at this code. Do you see MACH
> anywhere else? No. Then why Aspeed must be different?
>
> No. Drop.
Agree.

>
> Best regards,
> Krzysztof

--
Best Regards,
Kevin.Chen
************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
