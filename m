From: Joel Stanley <joel@jms.id.au>
Date: Tue, 3 May 2022 05:38:29 +0000
Subject: [PATCH v5 00/11] spi: spi-mem: Convert Aspeed SMC driver to
 spi-mem
In-Reply-To: <20220502081341.203369-1-clg@kaod.org>
References: <20220502081341.203369-1-clg@kaod.org>
Message-ID: <CACPK8XfxsXgVHKY3tqgs=-ZX95jkpjcG_4HE=igG4QBULd0vRA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2 May 2022 at 08:13, C?dric Le Goater <clg@kaod.org> wrote:
> This series adds a new SPI driver using the spi-mem interface for the
> Aspeed static memory controllers of the AST2600, AST2500 and AST2400
> SoCs.

I put this into the OpenBMC yocto tree, which pushes it through CI and
does a qemu boot on Romulus. I also tested on Palmetto in qemu and the
AST2600A3 EVB.

 https://gerrit.openbmc-project.xyz/c/openbmc/openbmc/+/51551

It looks good.

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
