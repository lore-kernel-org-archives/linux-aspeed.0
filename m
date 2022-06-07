From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 7 Jun 2022 12:47:46 +0200
Subject: [PATCH 00/14] mtd: Fix platform remove callbacks to always
 return 0
In-Reply-To: <20220607093236.67txulke76mi6t75@ti.com>
References: <20220603210758.148493-1-u.kleine-koenig@pengutronix.de>
	<20220606151841.682a5939@xps-13>
	<20220607093236.67txulke76mi6t75@ti.com>
Message-ID: <20220607124746.20a2eaf0@xps-13>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Pratyush, Uwe,

p.yadav at ti.com wrote on Tue, 7 Jun 2022 15:02:36 +0530:

> Hi Miquel,
> 
> On 06/06/22 03:18PM, Miquel Raynal wrote:
> > Hi Folks,
> > 
> > u.kleine-koenig at pengutronix.de wrote on Fri,  3 Jun 2022 23:07:44 +0200:
> >   
> > > Hello,
> > > 
> > > this series prepares to make platform remove callbacks return void.
> > > Therefor first update them to always return 0. The rationale is that the
> > > Linux device model doesn't handle failures on remove and if a remove
> > > callback returns an error, it just emits a quite generic error message
> > > and still removes the device.  
> > 
> > Tudor, Pratyush, Richard, Vignesh,
> > 
> > The series looks good to me (besides the atmel patch), I think it's
> > best to take it directly through mtd/next instead of going through all
> > the different internal branches, please let me know if you disagree
> > with the idea.  
> 
> Patch 2 does not look good to me. It modifies the aspeed-smc driver in 
> drivers/mtd/spi-nor/controllers/ but the driver has been moved to 
> drivers/spi/ in Mark's next branch [0]. The patch would likely conflict 
> with that.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=9c63b846e6df43e5b3d31263f7db545f32deeda3

Right, I believe Uwe is sending per-subsystems series so now that he is
aware we can safely drop patch 2.

Thanks,
Miqu?l
