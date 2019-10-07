From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Mon, 7 Oct 2019 12:10:37 +0200
Subject: [PATCH -next 00/34] rtc: use devm_platform_ioremap_resource() to
 simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191007101037.GE4254@piout.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/10/2019 18:29:19+0800, YueHaibing wrote:
> devm_platform_ioremap_resource() internally have platform_get_resource()
> and devm_ioremap_resource() in it. So instead of calling them separately
> use devm_platform_ioremap_resource() directly.
> 
> YueHaibing (34):
>   rtc: asm9260: use devm_platform_ioremap_resource() to simplify code
>   rtc: rtc-aspeed: use devm_platform_ioremap_resource() to simplify code
>   rtc: brcmstb-waketimer: use devm_platform_ioremap_resource() to
>     simplify code
>   rtc: at91sam9: use devm_platform_ioremap_resource() to simplify code
>   rtc: cadence: use devm_platform_ioremap_resource() to simplify code
>   rtc: coh901331: use devm_platform_ioremap_resource() to simplify code
>   rtc: davinci: use devm_platform_ioremap_resource() to simplify code
>   rtc: digicolor: use devm_platform_ioremap_resource() to simplify code
>   rtc: ds1216: use devm_platform_ioremap_resource() to simplify code
>   rtc: ds1511: use devm_platform_ioremap_resource() to simplify code
>   rtc: ds1553: use devm_platform_ioremap_resource() to simplify code
>   rtc: ep93xx: use devm_platform_ioremap_resource() to simplify code
>   rtc: jz4740: use devm_platform_ioremap_resource() to simplify code
>   rtc: lpc24xx: use devm_platform_ioremap_resource() to simplify code
>   rtc: lpc32xx: use devm_platform_ioremap_resource() to simplify code
>   rtc: meson: use devm_platform_ioremap_resource() to simplify code
>   rtc: mt7622: use devm_platform_ioremap_resource() to simplify code
>   rtc: mv: use devm_platform_ioremap_resource() to simplify code
>   rtc: omap: use devm_platform_ioremap_resource() to simplify code
>   rtc: pic32: use devm_platform_ioremap_resource() to simplify code
>   rtc: rtd119x: use devm_platform_ioremap_resource() to simplify code
>   rtc: s3c: use devm_platform_ioremap_resource() to simplify code
>   rtc: sa1100: use devm_platform_ioremap_resource() to simplify code
>   rtc: spear: use devm_platform_ioremap_resource() to simplify code
>   rtc: stk17ta8: use devm_platform_ioremap_resource() to simplify code
>   rtc: ds1286: use devm_platform_ioremap_resource() to simplify code
>   rtc: st-lpc: use devm_platform_ioremap_resource() to simplify code
>   rtc: stm32: use devm_platform_ioremap_resource() to simplify code
>   rtc: sunxi: use devm_platform_ioremap_resource() to simplify code
>   rtc: tegra: use devm_platform_ioremap_resource() to simplify code
>   rtc: tx4939: use devm_platform_ioremap_resource() to simplify code
>   rtc: vt8500: use devm_platform_ioremap_resource() to simplify code
>   rtc: xgene: use devm_platform_ioremap_resource() to simplify code
>   rtc: zynqmp: use devm_platform_ioremap_resource() to simplify code
> 
>  drivers/rtc/rtc-asm9260.c           | 4 +---
>  drivers/rtc/rtc-aspeed.c            | 4 +---
>  drivers/rtc/rtc-at91sam9.c          | 4 +---
>  drivers/rtc/rtc-brcmstb-waketimer.c | 4 +---
>  drivers/rtc/rtc-cadence.c           | 4 +---
>  drivers/rtc/rtc-coh901331.c         | 4 +---
>  drivers/rtc/rtc-davinci.c           | 4 +---
>  drivers/rtc/rtc-digicolor.c         | 4 +---
>  drivers/rtc/rtc-ds1216.c            | 4 +---
>  drivers/rtc/rtc-ds1286.c            | 4 +---
>  drivers/rtc/rtc-ds1511.c            | 4 +---
>  drivers/rtc/rtc-ds1553.c            | 4 +---
>  drivers/rtc/rtc-ep93xx.c            | 4 +---
>  drivers/rtc/rtc-jz4740.c            | 4 +---
>  drivers/rtc/rtc-lpc24xx.c           | 4 +---
>  drivers/rtc/rtc-lpc32xx.c           | 4 +---
>  drivers/rtc/rtc-meson.c             | 4 +---
>  drivers/rtc/rtc-mt7622.c            | 4 +---
>  drivers/rtc/rtc-mv.c                | 4 +---
>  drivers/rtc/rtc-omap.c              | 4 +---
>  drivers/rtc/rtc-pic32.c             | 4 +---
>  drivers/rtc/rtc-rtd119x.c           | 4 +---
>  drivers/rtc/rtc-s3c.c               | 4 +---
>  drivers/rtc/rtc-sa1100.c            | 4 +---
>  drivers/rtc/rtc-spear.c             | 4 +---
>  drivers/rtc/rtc-st-lpc.c            | 4 +---
>  drivers/rtc/rtc-stk17ta8.c          | 4 +---
>  drivers/rtc/rtc-stm32.c             | 4 +---
>  drivers/rtc/rtc-sunxi.c             | 4 +---
>  drivers/rtc/rtc-tegra.c             | 4 +---
>  drivers/rtc/rtc-tx4939.c            | 4 +---
>  drivers/rtc/rtc-vt8500.c            | 4 +---
>  drivers/rtc/rtc-xgene.c             | 4 +---
>  drivers/rtc/rtc-zynqmp.c            | 5 +----
>  34 files changed, 34 insertions(+), 103 deletions(-)
> 

I've quashed and applied.

> -- 
> 2.7.4
> 
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
