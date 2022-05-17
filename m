From: Pratyush Yadav <p.yadav@ti.com>
Date: Tue, 17 May 2022 18:03:43 +0530
Subject: (subset) [PATCH v7 00/11] spi: spi-mem: Convert Aspeed SMC
 driver to spi-mem
In-Reply-To: <a17b2446-f5a6-d606-8ef4-3931b8bc94da@kaod.org>
References: <20220509175616.1089346-1-clg@kaod.org>
 <165272636363.750911.14933122170662994904.b4-ty@kernel.org>
 <20220517110509.2e6xbwot63yl6a3c@ti.com>
 <a17b2446-f5a6-d606-8ef4-3931b8bc94da@kaod.org>
Message-ID: <20220517123343.5cust7y6uqeeamjs@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Cedric,

On 17/05/22 02:03PM, C?dric Le Goater wrote:
> Pratyush,
> 
> On 5/17/22 13:05, Pratyush Yadav wrote:
> > Hi Cedric,
> > 
> > On 16/05/22 07:39PM, Mark Brown wrote:
> > > On Mon, 9 May 2022 19:56:05 +0200, C?dric Le Goater wrote:
> > > > This series adds a new SPI driver using the spi-mem interface for the
> > > > Aspeed static memory controllers of the AST2600, AST2500 and AST2400
> > > > SoCs.
> > > > 
> > > >   * AST2600 Firmware SPI Memory Controller (FMC)
> > > >   * AST2600 SPI Flash Controller (SPI1 and SPI2)
> > > >   * AST2500 Firmware SPI Memory Controller (FMC)
> > > >   * AST2500 SPI Flash Controller (SPI1 and SPI2)
> > > >   * AST2400 New Static Memory Controller (also referred as FMC)
> > > >   * AST2400 SPI Flash Controller (SPI)
> > > > 
> > > > [...]
> > > 
> > > Applied to
> > > 
> > >     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> > > 
> > > Thanks!
> > > 
> > > [02/11] dt-bindings: spi: Convert the Aspeed SMC controllers device tree binding
> > >          commit: ce9858ea499da025684a7a5f19823c2c3f14bdce
> > > [03/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
> > >          commit: 9c63b846e6df43e5b3d31263f7db545f32deeda3
> > > [04/11] spi: aspeed: Add support for direct mapping
> > >          commit: 9da06d7bdec7dad8018c23b180e410ef2e7a4367
> > > [05/11] spi: aspeed: Adjust direct mapping to device size
> > >          commit: bb084f94e1bca4a5c4f689d7aa9b410220c1ed71
> > > [06/11] spi: aspeed: Workaround AST2500 limitations
> > >          commit: 5785eedee42c34cfec496199a80fa8ec9ddcf7fe
> > > [07/11] spi: aspeed: Add support for the AST2400 SPI controller
> > >          commit: 53526ab27d9c256504f267713aea60db7af18fb0
> > > [08/11] spi: aspeed: Calibrate read timings
> > >          commit: eeaec1ea05c0e0f08e04c6844f20cc24a2fcc0f4
> > 
> > I have repeatedly objected to this patch [0][1][2] and you have
> > repeatedly decided to not address my objections.
> 
> That's a very harsh way of saying things. I did not decide anything
> or ignore your comments. I answered your questions and acknowledged
> that indeed the read training was done under the dirmap handler but
> this was not a concern today since we had all the required information
> from spimem.

I think the correct thing to do here would be to move this patch out of 
your main series. Since the old driver did not have this feature anyway, 
it is not necessary for the conversion to achieve feature parity. Then 
have a separate series to drive the conversation on how to best 
implement this contentious feature.

> 
> We waited _together_, 5 or 6 weeks, for more inputs on how to address
> the concerns you raised regarding the sustainability of this method.
> 
> > I won't spend any more time fighting it.
> 
> This is not a fight. I don't know why you interpret it that way.

I interpret it this way because I feel you have ignored my comments and 
have kept this patch in regardless. But maybe I _am_ being too harsh. So 
apologies if I have interpreted things wrong.

> 
> Now, since you object so explicitly, and since this patchset has
> not reached the Linux kernel yet, we should consider dropping it.
> I rather do that than push crap in mainline. But then, please,
> provide solutions and not only objections !

Yes please. I would like to have this patch dropped, and then reopen 
this discussion in a separate thread.

I have provided solutions before but maybe you missed them. Please see 
[3]. Specifically patches 1 and 3. These are still not very refined and 
might not be accepted in their current state (especially patch 3 since 
it does the calibration after registering the device with MTD), but they 
should be a good starting point for discussion.

And we might end up deciding to just use the dirmap_create() hook to do 
the calibration, but it is important to have this conversation 
separately and clearly instead of it being missed as part of a large 
patch series.

> 
> > But I will say that you should not expect any
> > guarantees that SPI NOR or SPI NAND will not break your calibration in
> > the future if they decide to move the dirmap_create() call around.
> 
> If that's the case one day, we have multiple solutions :
> 
>   - stop doing the training
>   - move the training to the appropriate handler if it exists

This is my preferred option, [3] is a good starting point for proposing 
that handler.

>   - use a default value
> > > [11/11] mtd: spi-nor: aspeed: set the decoding size to at least 2MB for AST2600
> > >          commit: 73ae97e3cabb580639f02f12a192324a53c4bebb
> > > 
> > 
> > [0] https://patchwork.kernel.org/project/spi-devel-general/patch/20220325100849.2019209-9-clg at kaod.org/
> > [1] https://patchwork.kernel.org/project/spi-devel-general/patch/20220214094231.3753686-9-clg at kaod.org/
> > [2] https://lore.kernel.org/all/20220208190636.h6dubktkmuosvdxo at ti.com/
[3] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=233504&state=%2A&archive=both

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
