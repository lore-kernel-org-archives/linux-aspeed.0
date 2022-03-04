From: Tao Ren <rentao.bupt@gmail.com>
Date: Thu, 3 Mar 2022 23:57:50 -0800
Subject: [PATCH v2 00/10] spi: spi-mem: Add driver for Aspeed SMC
 controllers
In-Reply-To: <CACPK8Xdo=krCNVVs5=jiSnmyiPkNPd9Dxxyx0Tv8eUHKR5J3cQ@mail.gmail.com>
References: <20220302173114.927476-1-clg@kaod.org>
 <CACPK8Xdo=krCNVVs5=jiSnmyiPkNPd9Dxxyx0Tv8eUHKR5J3cQ@mail.gmail.com>
Message-ID: <YiHGfh/4xZRim6Ka@taoren-fedora-PC23YAB4>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 03, 2022 at 10:01:20AM +0000, Joel Stanley wrote:
> On Wed, 2 Mar 2022 at 17:31, C?dric Le Goater <clg@kaod.org> wrote:
> >
> > Hi,
> >
> > This series adds a new SPI driver using the spi-mem interface for the
> > Aspeed static memory controllers of the AST2600, AST2500 and AST2400
> > SoCs.
> >
> >  * AST2600 Firmware SPI Memory Controller (FMC)
> >  * AST2600 SPI Flash Controller (SPI1 and SPI2)
> 
> I've performed read and write tests on the 2600 controllers, and the
> driver seems stable at the settings you have in the device tree.
> 
> Tested-by: Joel Stanley <joel@jms.id.au>
> 
> I've added Tao and John to cc as they have tested the 2400 and 2500,
> and I'm sure will be able to provide some Tested-by.
> 
> Cheers,
> 
> Joel

I've tested the patch series on ast2400 (wedge100) and ast2500 (cmm) by
reading/writing FMC flash0 and flash1 for several times, and no issues
observed so far.

Tested-by: Tao Ren <rentao.bupt@gmail.com>


Cheers,

Tao
