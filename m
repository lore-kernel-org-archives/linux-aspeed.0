From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 20 May 2022 02:46:49 +0000
Subject: [PATCH v3 0/3] Add ASPEED AST2600 I2C new controller driver
In-Reply-To: <DDAAA045-3BDE-4712-A6CC-B1A52713634A@fb.com>
References: <20220516064900.30517-1-ryan_chen@aspeedtech.com>
 <DDAAA045-3BDE-4712-A6CC-B1A52713634A@fb.com>
Message-ID: <SEZPR06MB52697491CF6D06ECB85F0FB7F2D39@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

> -----Original Message-----
> From: Peter Delevoryas <pdel@fb.com>
> Sent: Friday, May 20, 2022 3:56 AM
> Cc: Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Philipp
> Zabel <p.zabel@pengutronix.de>; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org; OpenBMC List
> <openbmc@lists.ozlabs.org>; BMC-SW <BMC-SW@aspeedtech.com>; Peter
> Delevoryas <pdel@fb.com>; Ryan Chen <ryan_chen@aspeedtech.com>
> Subject: Re: [PATCH v3 0/3] Add ASPEED AST2600 I2C new controller driver
> 
> 
> 
> > On May 15, 2022, at 11:48 PM, ryan_chen <ryan_chen@aspeedtech.com>
> wrote:
> >
> > This series add AST2600 i2c new register set driver. The i2c new
> > register set have new clock divider option for more flexiable generation.
> > And also have separate i2c master and slave register set for control.
> 
> Hey Ryan, thanks for this work! This is a little bit off-topic, but are you or
> anyone else at Aspeed working on an equivalent QEMU patch series? Without
> it, I don?t think QEMU will work with this series right? I think QEMU only
> supports the old register set right now.
> 
No, there are two submit in QEMU about i2c new register mode.
One is ASPEED submit : https://patchwork.kernel.org/project/qemu-devel/list/?series=626028&archive=both
Another is GOOGLE : https://patchwork.kernel.org/project/qemu-devel/list/?series=627706&archive=both

> 
> >
> > v3:
> > -fix i2c global clock divide default value -remove i2c slave no used
> > dev_dbg info.
> >
> > v2:
> > -add i2c global ymal file commit
> > -rename file name from new to ast2600.
> > aspeed-i2c-new-global.c -> i2c-ast2600-global.c
> > aspeed-i2c-new-global.h -> i2c-ast2600-global.h i2c-new-aspeed.c ->
> > i2c-ast2600.c -rename all driver function name to ast2600
> >
> > ryan_chen (3):
> >  dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C global register
> >    controller
> >  dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C driver
> > i2c:aspeed:support ast2600 i2c new register mode driver
> >
> > .../i2c/aspeed,i2c-ast2600-global.ymal        |   44 +
> > .../bindings/i2c/aspeed,i2c-ast2600.ymal      |   78 +
> > drivers/i2c/busses/Kconfig                    |   11 +
> > drivers/i2c/busses/Makefile                   |    1 +
> > drivers/i2c/busses/i2c-ast2600-global.c       |   94 +
> > drivers/i2c/busses/i2c-ast2600-global.h       |   19 +
> > drivers/i2c/busses/i2c-ast2600.c              | 1703
> +++++++++++++++++
> > 7 files changed, 1950 insertions(+)
> > create mode 100644
> > Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.ymal
> > create mode 100644
> > Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
> > create mode 100644 drivers/i2c/busses/i2c-ast2600-global.c
> > create mode 100644 drivers/i2c/busses/i2c-ast2600-global.h
> > create mode 100644 drivers/i2c/busses/i2c-ast2600.c
> >
> > --
> > 2.17.1
> >
> >

