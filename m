From: Troy Lee <troy_lee@aspeedtech.com>
Date: Tue, 1 Dec 2020 10:04:51 +0000
Subject: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
In-Reply-To: <4AD4AB7A-54E7-4922-9547-7E26D61F7C77@cisco.com>
References: <20201130083345.4814-1-troy_lee@aspeedtech.com>
 <20201130083345.4814-3-troy_lee@aspeedtech.com>
 <4AD4AB7A-54E7-4922-9547-7E26D61F7C77@cisco.com>
Message-ID: <PS1PR06MB26008D10C46C5DF0B47F81368AF40@PS1PR06MB2600.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Stefan,

The driver was ported from latest ASPEED BSP, so I only test with ECC-on/off 
from u-boot and check if driver runs correctly.

The test doc you provided is very nice and detailed, I'll try to reproduce the 
injection test in v2 patch.

Thanks,
Troy Lee

> -----Original Message-----
> From: Stefan Schaeckeler (sschaeck) <sschaeck@cisco.com>
> Sent: Monday, November 30, 2020 5:16 PM
> To: Troy Lee <troy_lee@aspeedtech.com>; Rob Herring <robh+dt@kernel.org>;
> Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Borislav
> Petkov <bp@alien8.de>; Mauro Carvalho Chehab <mchehab@kernel.org>;
> Tony Luck <tony.luck@intel.com>; James Morse <james.morse@arm.com>;
> Robert Richter <rrichter@marvell.com>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; moderated
> list:ARM/ASPEED MACHINE SUPPORT <linux-arm-kernel@lists.infradead.org>;
> moderated list:ARM/ASPEED MACHINE SUPPORT
> <linux-aspeed@lists.ozlabs.org>; open list <linux-kernel@vger.kernel.org>;
> open list:EDAC-CORE <linux-edac@vger.kernel.org>
> Cc: leetroy at gmail.com; Ryan Chen <ryan_chen@aspeedtech.com>; Stefan
> Schaeckeler <schaecsn@gmx.net>
> Subject: Re: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
> 
> Hello Troy,
> 
> > Adding AST2400 and AST2600 edac driver support.
> >
> > Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> > ---
> > drivers/edac/Kconfig       |   6 +-
> > drivers/edac/aspeed_edac.c | 114 +++++++++++++++++++++++++++++--------
> > 2 files changed, 94 insertions(+), 26 deletions(-)
> 
> Uh, there are quite some non-trivial changes. I'll have a look over the coming
> weekend.
> 
> Testing an edac driver comes with challenges. Did you test your code? If so,
> how?
> 
> That's how I was testing my original edac 2500 driver
> http://students.engr.scu.edu/~sschaeck/misc/aspeed-edac.html
> 
>  Stefan

