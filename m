From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Fri, 16 Aug 2024 04:07:11 +0000
Subject: [PATCH v1 09/10] arm64: dts: aspeed: Add initial AST2700 EVB
 device tree
In-Reply-To: <79d13e65-ca4a-461f-9888-9664e204f2ed@kernel.org>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-10-kevin_chen@aspeedtech.com>
 <79d13e65-ca4a-461f-9888-9664e204f2ed@kernel.org>
Message-ID: <PSAPR06MB4949C5E5ED62614F16244F3289812@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzk,

> > ---
> >  arch/arm64/boot/dts/aspeed/Makefile        |  4 ++
> >  arch/arm64/boot/dts/aspeed/ast2700-evb.dts | 50
> ++++++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
> >  create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts
> >
> > diff --git a/arch/arm64/boot/dts/aspeed/Makefile
> b/arch/arm64/boot/dts/aspeed/Makefile
> > new file mode 100644
> > index 000000000000..ffe7e15017cc
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/aspeed/Makefile
> > @@ -0,0 +1,4 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +dtb-$(CONFIG_ARCH_ASPEED) += \
> > +   ast2700-evb.dtb
> > diff --git a/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
> b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
> > new file mode 100644
> > index 000000000000..187c458e566b
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
> > @@ -0,0 +1,50 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +/dts-v1/;
> > +
> > +#include "aspeed-g7.dtsi"
> > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > +
> > +/ {
> > +   model = "AST2700A1-EVB";
> > +   compatible = "aspeed,ast2700a1-evb", "aspeed,ast2700";
>
> You have never tested this.
>
> Sorry, test your DTS first.
Agree. I will test my dts by make dtbs_check W=1

>
> > +
> > +   chosen {
> > +           bootargs = "console=ttyS12,115200n8";
>
> Drop.
Agree.

>
> > +           stdout-path = &uart12;
> > +   };
> > +
> > +   firmware {
> > +           optee: optee {
> > +                   compatible = "linaro,optee-tz";
> > +                   method = "smc";
> > +           };
> > +   };
> > +
> > +   memory at 400000000 {
> > +           device_type = "memory";
> > +           reg = <0x4 0x00000000 0x0 0x40000000>;
> > +   };
> > +
> > +   reserved-memory {
> > +           #address-cells = <2>;
> > +           #size-cells = <2>;
> > +           ranges;
> > +
> > +           mcu_fw: mcu-firmware at 42fe00000 {
> > +                   reg = <0x4 0x2fe00000 0x0 0x200000>;
> > +                   no-map;
> > +           };
> > +
> > +           atf: trusted-firmware-a at 430000000 {
> > +                   reg = <0x4 0x30000000 0x0 0x80000>;
> > +                   no-map;
> > +           };
> > +
> > +           optee_core: optee_core at 430080000 {
>
> Read DTS coding style.
Agree. Should I change to optee_core: optee-core at 430080000 {

>
> > +                   reg = <0x4 0x30080000 0x0 0x1000000>;
> > +                   no-map;
> > +           };
> > +   };
> > +};
> > +
>
> Remove stray blank line.
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
