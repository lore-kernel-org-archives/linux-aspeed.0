From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Fri, 16 Aug 2024 04:06:38 +0000
Subject: [PATCH v1 00/10] Introduce ASPEED AST27XX BMC SoC
In-Reply-To: <241ceb9b-b29f-41fd-8987-2feba2e5e08e@kernel.org>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <172199921352.1507193.4411331020670815695.robh@kernel.org>
 <241ceb9b-b29f-41fd-8987-2feba2e5e08e@kernel.org>
Message-ID: <PSAPR06MB4949E84E4B4CF39991FCF9BE89812@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzk,

I will separate clock part in the v3 patch into Ryan's clock series.

>
> On 26/07/2024 15:09, Rob Herring (Arm) wrote:
> >
> > On Fri, 26 Jul 2024 19:03:45 +0800, Kevin Chen wrote:
> >> This patchset adds initial support for the ASPEED.
> >> AST27XX Board Management controller (BMC) SoC family.
> >>
> >> AST2700 is ASPEED's 8th-generation server management processor.
> >> Featuring a quad-core ARM Cortex A35 64-bit processor and two
> >> independent ARM Cortex M4 processors
> >>
> >> This patchset adds minimal architecture and drivers such as:
> >> Clocksource, Clock and Reset
> >>
> >> This patchset was tested on the ASPEED AST2700 evaluation board.
> >>
> >> Kevin Chen (10):
> >>   dt-binding: mfd: aspeed,ast2x00-scu: Add binding for ASPEED AST2700
> >>     SCU
> >>   dt-binding: clk: ast2700: Add binding for Aspeed AST27xx Clock
> >>   clk: ast2700: add clock controller
> >>   dt-bindings: reset: ast2700: Add binding for ASPEED AST2700 Reset
> >>   dt-bindings: arm: aspeed: Add maintainer
> >>   dt-bindings: arm: aspeed: Add aspeed,ast2700-evb compatible string
> >>   arm64: aspeed: Add support for ASPEED AST2700 BMC SoC
> >>   arm64: dts: aspeed: Add initial AST27XX device tree
> >>   arm64: dts: aspeed: Add initial AST2700 EVB device tree
> >>   arm64: defconfig: Add ASPEED AST2700 family support
> >>
> >>  .../bindings/arm/aspeed/aspeed.yaml           |    6 +
> >>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      |    3 +
> >>  MAINTAINERS                                   |    3 +
> >>  arch/arm64/Kconfig.platforms                  |   14 +
> >>  arch/arm64/boot/dts/Makefile                  |    1 +
> >>  arch/arm64/boot/dts/aspeed/Makefile           |    4 +
> >>  arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi     |  217 +++
> >>  arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |   50 +
> >>  arch/arm64/configs/defconfig                  |    1 +
> >>  drivers/clk/Makefile                          |    1 +
> >>  drivers/clk/clk-ast2700.c                     | 1166
> +++++++++++++++++
> >>  .../dt-bindings/clock/aspeed,ast2700-clk.h    |  180 +++
> >>  .../dt-bindings/reset/aspeed,ast2700-reset.h  |  126 ++
> >>  13 files changed, 1772 insertions(+)  create mode 100644
> >> arch/arm64/boot/dts/aspeed/Makefile
> >>  create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
> >>  create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts
> >>  create mode 100644 drivers/clk/clk-ast2700.c  create mode 100644
> >> include/dt-bindings/clock/aspeed,ast2700-clk.h
> >>  create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h
> >>
> >> --
> >> 2.34.1
> >>
> >>
> >>
> >
> >
> > My bot found new DTB warnings on the .dts files added or changed in
> > this series.
> >
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the
> > warnings are fixed by another series. Ultimately, it is up to the
> > platform maintainer whether these warnings are acceptable or not. No
> > need to reply unless the platform maintainer has comments.
> >
> > If you already ran DT checks and didn't see these error(s), then make
> > sure dt-schema is up to date:
> >
> >   pip3 install dtschema --upgrade
> >
> >
> > New warnings running 'make CHECK_DTBS=y aspeed/ast2700-evb.dtb' for
> 20240726110355.2181563-1-kevin_chen at aspeedtech.com:
>
> Kevin,
> Just to clarify. Looking at the patches it was quite obvious you did not test it
> with dtbs_check. For a new arm64 platform without any legacy, having 0
> warnings is a must.
Agree.

>
> Consider Documentation/process/maintainer-soc-clean-dts.rst being implied
> for this platform.
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
