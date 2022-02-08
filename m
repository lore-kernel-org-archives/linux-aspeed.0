From: Pratyush Yadav <p.yadav@ti.com>
Date: Wed, 9 Feb 2022 00:36:36 +0530
Subject: [PATCH] mtd: aspeed-smc: improve probe resilience
In-Reply-To: <53d53523-7174-89fd-8661-550346d53141@kaod.org>
References: <Yc3Qav+ULNdF5zRT@heinlein>
 <20211231102623.izaqlzjvracbbgmp@ti.com>
 <20220103171721.46c8e697@xps13> <YdSP6tKyQ2ZRUC+2@heinlein>
 <20220105063244.lno3xur64uepa7i5@ti.com>
 <d4ba6413-57ce-14c1-ed48-d00db2f74bd3@kaod.org>
 <20220124153644.m3iwlvq5ld5cpbyz@ti.com>
 <b222361a-288a-55b2-fc02-04c0b93b4220@kaod.org>
 <20220124203708.lm23sgsub234wlhq@ti.com>
 <53d53523-7174-89fd-8661-550346d53141@kaod.org>
Message-ID: <20220208190636.h6dubktkmuosvdxo@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 07/02/22 06:13PM, C?dric Le Goater wrote:
> Hello,
> 
> On 1/24/22 21:37, Pratyush Yadav wrote:
> > On 24/01/22 07:34PM, C?dric Le Goater wrote:
> > > > > spimem needs an extension I think. Sorry I have not been able to
> > > > > push that forward. Lack of time and other tasks to address on the
> > > > > host side of the machine. This is really a software problem, we
> > > > > have the HW procedures ready. If a spimem expert could get involved
> > > > > to make a few proposals, I would be happy to help and do some testing.
> > > > > QEMU models are good enough for the software part. We can do the
> > > > > training validation on real HW when ready.
> > > > 
> > > > What information about the flash do you need for this training?
> > > 
> > > Last time I looked, we lacked some post_init handler to setup a slave:
> > > configure the registers defining the AHB windows for each flash
> > > slave and perform the read timing calibration. calibration should
> > > only be done once.
> > > 
> > > See how the aspeed_spi_flash_init() routine doing the calibration
> > > is hooked up under aspeed_spi_claim_bus() in the u-boot driver :
> > 
> > My patch series should provide a hook for doing the calibration _after_
> > the flash is initialized.
> 
> You can also use the .dirmap_create handler. The flash device has
> been scanned when called and the size is available in the spi-mem
> dirmap descriptor.

I feel uncomfortable doing that since the API does not actually make 
this guarantee. Who knows if a future change will violate that 
assumption. That is why I added a new API call to explicitly mark the 
flash as ready. I suppose you can get the op from the .dirmap_create 
handler, but I guess we can debate that over the patches.

> 
> I reworked the current Aspeed driver with this approach and it
> seems sufficient for read calibration.
> 
> Thanks,
> 
> C.
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
