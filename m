From: Andrzej Hajda <a.hajda@samsung.com>
Date: Fri, 12 Jul 2019 14:54:09 +0200
Subject: [PATCH 00/12] treewide: Fix GENMASK misuses
In-Reply-To: <cover.1562734889.git.joe@perches.com>
References: <CGME20190710050444epcas1p250f7aa0f8798a7757df51d66f5970c2a@epcas1p2.samsung.com>
 <cover.1562734889.git.joe@perches.com>
Message-ID: <469b0d3d-9466-b287-5ca3-27f3d01ff3cd@samsung.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joe,

On 10.07.2019 07:04, Joe Perches wrote:
> These GENMASK uses are inverted argument order and the
> actual masks produced are incorrect.  Fix them.
>
> Add checkpatch tests to help avoid more misuses too.
>
> Joe Perches (12):
>   checkpatch: Add GENMASK tests
>   clocksource/drivers/npcm: Fix misuse of GENMASK macro
>   drm: aspeed_gfx: Fix misuse of GENMASK macro
>   iio: adc: max9611: Fix misuse of GENMASK macro
>   irqchip/gic-v3-its: Fix misuse of GENMASK macro
>   mmc: meson-mx-sdio: Fix misuse of GENMASK macro
>   net: ethernet: mediatek: Fix misuses of GENMASK macro
>   net: stmmac: Fix misuses of GENMASK macro
>   rtw88: Fix misuse of GENMASK macro
>   phy: amlogic: G12A: Fix misuse of GENMASK macro
>   staging: media: cedrus: Fix misuse of GENMASK macro
>   ASoC: wcd9335: Fix misuse of GENMASK macro
>
>  drivers/clocksource/timer-npcm7xx.c               |  2 +-
>  drivers/gpu/drm/aspeed/aspeed_gfx.h               |  2 +-
>  drivers/iio/adc/max9611.c                         |  2 +-
>  drivers/irqchip/irq-gic-v3-its.c                  |  2 +-
>  drivers/mmc/host/meson-mx-sdio.c                  |  2 +-
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h       |  2 +-
>  drivers/net/ethernet/mediatek/mtk_sgmii.c         |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/descs.h       |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  4 ++--
>  drivers/net/wireless/realtek/rtw88/rtw8822b.c     |  2 +-
>  drivers/phy/amlogic/phy-meson-g12a-usb2.c         |  2 +-
>  drivers/staging/media/sunxi/cedrus/cedrus_regs.h  |  2 +-
>  scripts/checkpatch.pl                             | 15 +++++++++++++++
>  sound/soc/codecs/wcd-clsh-v2.c                    |  2 +-
>  14 files changed, 29 insertions(+), 14 deletions(-)
>
After adding following compile time check:

------

diff --git a/Makefile b/Makefile
index 5102b2bbd224..ac4ea5f443a9 100644
--- a/Makefile
+++ b/Makefile
@@ -457,7 +457,7 @@ KBUILD_AFLAGS?? := -D__ASSEMBLY__ -fno-PIE
?KBUILD_CFLAGS?? := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
?????????????????? -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
?????????????????? -Werror=implicit-function-declaration
-Werror=implicit-int \
-????????????????? -Wno-format-security \
+????????????????? -Wno-format-security -Werror=div-by-zero \
?????????????????? -std=gnu89
?KBUILD_CPPFLAGS := -D__KERNEL__
?KBUILD_AFLAGS_KERNEL :=
diff --git a/include/linux/bits.h b/include/linux/bits.h
index 669d69441a62..61d74b103055 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -19,11 +19,11 @@
? * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
? */
?#define GENMASK(h, l) \
-?????? (((~UL(0)) - (UL(1) << (l)) + 1) & \
+?????? (((~UL(0)) - (UL(1) << (l)) + 1 + 0/((h) >= (l))) & \
???????? (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
?
?#define GENMASK_ULL(h, l) \
-?????? (((~ULL(0)) - (ULL(1) << (l)) + 1) & \
+?????? (((~ULL(0)) - (ULL(1) << (l)) + 1 + 0/((h) >= (l))) & \
???????? (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
?
?#endif /* __LINUX_BITS_H */

-------

I was able to detect one more GENMASK misue (AARCH64, allyesconfig):

? CC????? drivers/phy/rockchip/phy-rockchip-inno-hdmi.o
In file included from ../include/linux/bitops.h:5:0,
???????????????? from ../include/linux/kernel.h:12,
???????????????? from ../include/linux/clk.h:13,
???????????????? from ../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:9:
../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c: In function
?inno_hdmi_phy_rk3328_power_on?:
../include/linux/bits.h:22:37: error: division by zero [-Werror=div-by-zero]
? (((~UL(0)) - (UL(1) << (l)) + 1 + 0/((h) >= (l))) & \
???????????????????????????????????? ^
../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:24:42: note: in
expansion of macro ?GENMASK?
?#define UPDATE(x, h, l)? (((x) << (l)) & GENMASK((h), (l)))
????????????????????????????????????????? ^~~~~~~
../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:201:50: note: in
expansion of macro ?UPDATE?
?#define RK3328_TERM_RESISTOR_CALIB_SPEED_7_0(x)? UPDATE(x, 7, 9)
????????????????????????????????????????????????? ^~~~~~
../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:1046:26: note: in
expansion of macro ?RK3328_TERM_RESISTOR_CALIB_SPEED_7_0?
?? inno_write(inno, 0xc6, RK3328_TERM_RESISTOR_CALIB_SPEED_7_0(v));


Of course I do not advise to add the check as is to Kernel - it is
undefined behavior area AFAIK.


Regards

Andrzej

