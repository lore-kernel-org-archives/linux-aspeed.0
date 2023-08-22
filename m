From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Tue, 22 Aug 2023 17:16:27 +0100
Subject: [PATCH -next 00/25] spi: Use devm_clk_get_*() helper function
 to simplify the drivers.
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822171627.00007020@Huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 21:12:12 +0800
Li Zetao <lizetao1@huawei.com> wrote:

> Commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks") provides a new helper function for prepared and
> enabled clocks when a driver keeps a clock prepared (or enabled) during
> the whole lifetime of the driver. So where drivers get clocks and enable
> them immediately, it can be combined into a single function
> devm_clk_get_*(). Moreover, the unprepare and disable function
> has been registered to devm_clk_state, and before devm_clk_state is
> released, the clocks will be unprepareed and disable, so it is unnecessary
> to unprepare and disable clocks explicitly when remove drivers or in the
> error handling path.

For all except 2, 12 and 24
they look good to me and I don't think there are any other ordering issues
of the sort we tend to see in devm conversions where things get turned off
later than in pre devm version.

So for those..
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> 
> Li Zetao (25):
>   spi: ar934x: Use helper function devm_clk_get_enabled()
>   spi: armada-3700: Use helper function devm_clk_get_prepared()
>   spi: aspeed: Use helper function devm_clk_get_enabled()
>   spi: ath79: Use helper function devm_clk_get_enabled()
>   spi: spi-axi-spi-engine: Use helper function devm_clk_get_enabled()
>   spi: bcm2835: Use helper function devm_clk_get_enabled()
>   spi: bcm2835aux: Use helper function devm_clk_get_enabled()
>   spi: spi-cadence: Use helper function devm_clk_get_enabled()
>   spi: spi-cavium-thunderx: Use helper function devm_clk_get_enabled()
>   spi: davinci: Use helper function devm_clk_get_enabled()
>   spi: dw-bt1: Use helper function devm_clk_get_enabled()
>   spi: dw-mmio: Use helper function devm_clk_get_*()
>   spi: spi-fsl-dspi: Use helper function devm_clk_get_enabled()
>   spi: lantiq-ssc: Use helper function devm_clk_get_enabled()
>   spi: meson-spicc: Use helper function devm_clk_get_enabled()
>   spi: spi-meson-spifc: Use helper function devm_clk_get_enabled()
>   spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()
>   spi: microchip-core: Use helper function devm_clk_get_enabled()
>   spi: mtk-snfi: Use helper function devm_clk_get_enabled()
>   spi: npcm-fiu: Use helper function devm_clk_get_enabled()
>   spi: orion: Use helper function devm_clk_get_enabled()
>   spi: pic32-sqi: Use helper function devm_clk_get_enabled()
>   spi: pic32: Use helper function devm_clk_get_enabled()
>   spi: spl022: Use helper function devm_clk_get_enabled()
>   spi: rockchip: Use helper function devm_clk_get_enabled()
> 
>  drivers/spi/spi-ar934x.c              | 22 ++--------
>  drivers/spi/spi-armada-3700.c         | 18 ++------
>  drivers/spi/spi-aspeed-smc.c          | 16 +------
>  drivers/spi/spi-ath79.c               | 11 +----
>  drivers/spi/spi-axi-spi-engine.c      | 25 +++--------
>  drivers/spi/spi-bcm2835.c             | 11 +----
>  drivers/spi/spi-bcm2835aux.c          | 23 ++--------
>  drivers/spi/spi-cadence.c             | 23 ++--------
>  drivers/spi/spi-cavium-thunderx.c     |  8 +---
>  drivers/spi/spi-davinci.c             | 11 +----
>  drivers/spi/spi-dw-bt1.c              | 23 +++-------
>  drivers/spi/spi-dw-mmio.c             | 20 +++------
>  drivers/spi/spi-fsl-dspi.c            | 12 ++----
>  drivers/spi/spi-lantiq-ssc.c          | 10 +----
>  drivers/spi/spi-meson-spicc.c         | 33 +++------------
>  drivers/spi/spi-meson-spifc.c         | 17 ++------
>  drivers/spi/spi-microchip-core-qspi.c | 29 +++----------
>  drivers/spi/spi-microchip-core.c      |  9 +---
>  drivers/spi/spi-mtk-snfi.c            | 61 ++++-----------------------
>  drivers/spi/spi-npcm-fiu.c            | 14 ++----
>  drivers/spi/spi-orion.c               | 11 +----
>  drivers/spi/spi-pic32-sqi.c           | 27 ++----------
>  drivers/spi/spi-pic32.c               |  8 +---
>  drivers/spi/spi-pl022.c               | 21 +++------
>  drivers/spi/spi-rockchip.c            | 30 +++----------
>  25 files changed, 88 insertions(+), 405 deletions(-)
> 

