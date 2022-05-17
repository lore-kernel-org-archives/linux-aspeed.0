From: Pratyush Yadav <p.yadav@ti.com>
Date: Tue, 17 May 2022 16:35:09 +0530
Subject: (subset) [PATCH v7 00/11] spi: spi-mem: Convert Aspeed SMC
 driver to spi-mem
In-Reply-To: <165272636363.750911.14933122170662994904.b4-ty@kernel.org>
References: <20220509175616.1089346-1-clg@kaod.org>
 <165272636363.750911.14933122170662994904.b4-ty@kernel.org>
Message-ID: <20220517110509.2e6xbwot63yl6a3c@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Cedric,

On 16/05/22 07:39PM, Mark Brown wrote:
> On Mon, 9 May 2022 19:56:05 +0200, C?dric Le Goater wrote:
> > This series adds a new SPI driver using the spi-mem interface for the
> > Aspeed static memory controllers of the AST2600, AST2500 and AST2400
> > SoCs.
> > 
> >  * AST2600 Firmware SPI Memory Controller (FMC)
> >  * AST2600 SPI Flash Controller (SPI1 and SPI2)
> >  * AST2500 Firmware SPI Memory Controller (FMC)
> >  * AST2500 SPI Flash Controller (SPI1 and SPI2)
> >  * AST2400 New Static Memory Controller (also referred as FMC)
> >  * AST2400 SPI Flash Controller (SPI)
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [02/11] dt-bindings: spi: Convert the Aspeed SMC controllers device tree binding
>         commit: ce9858ea499da025684a7a5f19823c2c3f14bdce
> [03/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
>         commit: 9c63b846e6df43e5b3d31263f7db545f32deeda3
> [04/11] spi: aspeed: Add support for direct mapping
>         commit: 9da06d7bdec7dad8018c23b180e410ef2e7a4367
> [05/11] spi: aspeed: Adjust direct mapping to device size
>         commit: bb084f94e1bca4a5c4f689d7aa9b410220c1ed71
> [06/11] spi: aspeed: Workaround AST2500 limitations
>         commit: 5785eedee42c34cfec496199a80fa8ec9ddcf7fe
> [07/11] spi: aspeed: Add support for the AST2400 SPI controller
>         commit: 53526ab27d9c256504f267713aea60db7af18fb0
> [08/11] spi: aspeed: Calibrate read timings
>         commit: eeaec1ea05c0e0f08e04c6844f20cc24a2fcc0f4

I have repeatedly objected to this patch [0][1][2] and you have 
repeatedly decided to not address my objections. I won't spend any more 
time fighting it. But I will say that you should not expect any 
guarantees that SPI NOR or SPI NAND will not break your calibration in 
the future if they decide to move the dirmap_create() call around.

> [11/11] mtd: spi-nor: aspeed: set the decoding size to at least 2MB for AST2600
>         commit: 73ae97e3cabb580639f02f12a192324a53c4bebb
> 

[0] https://patchwork.kernel.org/project/spi-devel-general/patch/20220325100849.2019209-9-clg at kaod.org/
[1] https://patchwork.kernel.org/project/spi-devel-general/patch/20220214094231.3753686-9-clg at kaod.org/
[2] https://lore.kernel.org/all/20220208190636.h6dubktkmuosvdxo at ti.com/

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
