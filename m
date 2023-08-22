From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Aug 2023 17:40:57 -0500
Subject: [PATCH] crypto: Explicitly include correct DT includes
In-Reply-To: <20230714174421.4054194-1-robh@kernel.org>
References: <20230714174421.4054194-1-robh@kernel.org>
Message-ID: <CAL_JsqL_CvroupJEFwrjt8WOq=4WBxvE3sOTMnY8hEuBAMG=1g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 14, 2023 at 12:44?PM Rob Herring <robh@kernel.org> wrote:
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c   | 1 -
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c   | 1 -
>  drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c   | 1 -
>  drivers/crypto/amlogic/amlogic-gxl-core.c           | 1 -
>  drivers/crypto/aspeed/aspeed-acry.c                 | 3 ---
>  drivers/crypto/atmel-aes.c                          | 6 ++----
>  drivers/crypto/atmel-ecc.c                          | 2 +-
>  drivers/crypto/atmel-sha.c                          | 6 ++----
>  drivers/crypto/atmel-tdes.c                         | 6 ++----
>  drivers/crypto/bcm/cipher.c                         | 3 +--
>  drivers/crypto/caam/ctrl.c                          | 1 +
>  drivers/crypto/caam/jr.c                            | 1 +
>  drivers/crypto/caam/qi.c                            | 1 +
>  drivers/crypto/ccree/cc_driver.c                    | 1 -
>  drivers/crypto/exynos-rng.c                         | 2 +-
>  drivers/crypto/gemini/sl3516-ce-core.c              | 1 -
>  drivers/crypto/img-hash.c                           | 4 ++--
>  drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c | 3 ++-
>  drivers/crypto/n2_core.c                            | 2 +-
>  drivers/crypto/omap-aes.c                           | 1 -
>  drivers/crypto/omap-des.c                           | 2 --
>  drivers/crypto/omap-sham.c                          | 1 -
>  drivers/crypto/rockchip/rk3288_crypto.c             | 1 -
>  drivers/crypto/s5p-sss.c                            | 1 -
>  drivers/crypto/sa2ul.c                              | 3 ++-
>  drivers/crypto/sahara.c                             | 1 -
>  drivers/crypto/starfive/jh7110-cryp.c               | 2 +-
>  drivers/crypto/starfive/jh7110-hash.c               | 1 -
>  drivers/crypto/stm32/stm32-cryp.c                   | 2 +-
>  drivers/crypto/stm32/stm32-hash.c                   | 2 +-
>  drivers/crypto/talitos.c                            | 4 ++--
>  drivers/crypto/xilinx/zynqmp-aes-gcm.c              | 2 +-
>  drivers/crypto/xilinx/zynqmp-sha.c                  | 1 -
>  33 files changed, 25 insertions(+), 45 deletions(-)

Ping!

>
> diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
> index 51a3a7b5b985..3bcfcfc37084 100644
> --- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
> +++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
> @@ -14,7 +14,6 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <crypto/scatterwalk.h>
>  #include <linux/scatterlist.h>
> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
> index 07ea0cc82b16..258d447765eb 100644
> --- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
> +++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
> @@ -18,7 +18,6 @@
>  #include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
> index 3dd844b40ff7..77bddd5ebaf0 100644
> --- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
> +++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
> @@ -19,7 +19,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index 937187027ad5..c8fa4a8bfd34 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -13,7 +13,6 @@
>  #include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <crypto/internal/skcipher.h>
>  #include <linux/dma-mapping.h>
> diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
> index 470122c87fea..d16f570c40d2 100644
> --- a/drivers/crypto/aspeed/aspeed-acry.c
> +++ b/drivers/crypto/aspeed/aspeed-acry.c
> @@ -11,10 +11,7 @@
>  #include <linux/clk.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
> -#include <linux/of_irq.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/interrupt.h>
>  #include <linux/count_zeros.h>
> diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
> index 143d33fbb316..21c8c2112c6a 100644
> --- a/drivers/crypto/atmel-aes.c
> +++ b/drivers/crypto/atmel-aes.c
> @@ -28,7 +28,7 @@
>  #include <linux/irq.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/delay.h>
>  #include <linux/crypto.h>
>  #include <crypto/scatterwalk.h>
> @@ -2533,13 +2533,11 @@ static void atmel_aes_get_cap(struct atmel_aes_dev *dd)
>         }
>  }
>
> -#if defined(CONFIG_OF)
>  static const struct of_device_id atmel_aes_dt_ids[] = {
>         { .compatible = "atmel,at91sam9g46-aes" },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, atmel_aes_dt_ids);
> -#endif
>
>  static int atmel_aes_probe(struct platform_device *pdev)
>  {
> @@ -2687,7 +2685,7 @@ static struct platform_driver atmel_aes_driver = {
>         .remove         = atmel_aes_remove,
>         .driver         = {
>                 .name   = "atmel_aes",
> -               .of_match_table = of_match_ptr(atmel_aes_dt_ids),
> +               .of_match_table = atmel_aes_dt_ids,
>         },
>  };
>
> diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
> index 432beabd79e6..590ea984c622 100644
> --- a/drivers/crypto/atmel-ecc.c
> +++ b/drivers/crypto/atmel-ecc.c
> @@ -14,7 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
> index 6bef634d3c86..b791be63d84b 100644
> --- a/drivers/crypto/atmel-sha.c
> +++ b/drivers/crypto/atmel-sha.c
> @@ -28,7 +28,7 @@
>  #include <linux/irq.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/delay.h>
>  #include <linux/crypto.h>
>  #include <crypto/scatterwalk.h>
> @@ -2570,14 +2570,12 @@ static void atmel_sha_get_cap(struct atmel_sha_dev *dd)
>         }
>  }
>
> -#if defined(CONFIG_OF)
>  static const struct of_device_id atmel_sha_dt_ids[] = {
>         { .compatible = "atmel,at91sam9g46-sha" },
>         { /* sentinel */ }
>  };
>
>  MODULE_DEVICE_TABLE(of, atmel_sha_dt_ids);
> -#endif
>
>  static int atmel_sha_probe(struct platform_device *pdev)
>  {
> @@ -2716,7 +2714,7 @@ static struct platform_driver atmel_sha_driver = {
>         .remove         = atmel_sha_remove,
>         .driver         = {
>                 .name   = "atmel_sha",
> -               .of_match_table = of_match_ptr(atmel_sha_dt_ids),
> +               .of_match_table = atmel_sha_dt_ids,
>         },
>  };
>
> diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
> index c9ded8be9c39..2f152f80f61a 100644
> --- a/drivers/crypto/atmel-tdes.c
> +++ b/drivers/crypto/atmel-tdes.c
> @@ -28,7 +28,7 @@
>  #include <linux/irq.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/delay.h>
>  #include <linux/crypto.h>
>  #include <crypto/scatterwalk.h>
> @@ -1139,13 +1139,11 @@ static void atmel_tdes_get_cap(struct atmel_tdes_dev *dd)
>         }
>  }
>
> -#if defined(CONFIG_OF)
>  static const struct of_device_id atmel_tdes_dt_ids[] = {
>         { .compatible = "atmel,at91sam9g46-tdes" },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, atmel_tdes_dt_ids);
> -#endif
>
>  static int atmel_tdes_probe(struct platform_device *pdev)
>  {
> @@ -1282,7 +1280,7 @@ static struct platform_driver atmel_tdes_driver = {
>         .remove         = atmel_tdes_remove,
>         .driver         = {
>                 .name   = "atmel_tdes",
> -               .of_match_table = of_match_ptr(atmel_tdes_dt_ids),
> +               .of_match_table = atmel_tdes_dt_ids,
>         },
>  };
>
> diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
> index 70b911baab26..262c7dbc5e5f 100644
> --- a/drivers/crypto/bcm/cipher.c
> +++ b/drivers/crypto/bcm/cipher.c
> @@ -15,8 +15,7 @@
>  #include <linux/kthread.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/sched.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/io.h>
>  #include <linux/bitops.h>
>
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
> index ff9ddbbca377..74bcd3083881 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/platform_device.h>
>  #include <linux/sys_soc.h>
>  #include <linux/fsl/mc.h>
>
> diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
> index 96dea5304d22..73b7aa68f21c 100644
> --- a/drivers/crypto/caam/jr.c
> +++ b/drivers/crypto/caam/jr.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
> +#include <linux/platform_device.h>
>
>  #include "compat.h"
>  #include "ctrl.h"
> diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
> index 2ad2c1035856..46a083849a8e 100644
> --- a/drivers/crypto/caam/qi.c
> +++ b/drivers/crypto/caam/qi.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
>  #include <linux/netdevice.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <soc/fsl/qman.h>
> diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
> index c57f929805d5..0f0694037dd7 100644
> --- a/drivers/crypto/ccree/cc_driver.c
> +++ b/drivers/crypto/ccree/cc_driver.c
> @@ -14,7 +14,6 @@
>  #include <linux/of.h>
>  #include <linux/clk.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>
>  #include "cc_driver.h"
> diff --git a/drivers/crypto/exynos-rng.c b/drivers/crypto/exynos-rng.c
> index cbd8ca6e52ee..773c3238c603 100644
> --- a/drivers/crypto/exynos-rng.c
> +++ b/drivers/crypto/exynos-rng.c
> @@ -15,7 +15,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>
>  #include <crypto/internal/rng.h>
> diff --git a/drivers/crypto/gemini/sl3516-ce-core.c b/drivers/crypto/gemini/sl3516-ce-core.c
> index b7524b649068..e9c00d76545b 100644
> --- a/drivers/crypto/gemini/sl3516-ce-core.c
> +++ b/drivers/crypto/gemini/sl3516-ce-core.c
> @@ -16,7 +16,6 @@
>  #include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/img-hash.c b/drivers/crypto/img-hash.c
> index 359aa2b41016..45063693859c 100644
> --- a/drivers/crypto/img-hash.c
> +++ b/drivers/crypto/img-hash.c
> @@ -13,7 +13,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/scatterlist.h>
>
> @@ -1105,7 +1105,7 @@ static struct platform_driver img_hash_driver = {
>         .driver         = {
>                 .name   = "img-hash-accelerator",
>                 .pm     = &img_hash_pm_ops,
> -               .of_match_table = of_match_ptr(img_hash_match),
> +               .of_match_table = img_hash_match,
>         }
>  };
>  module_platform_driver(img_hash_driver);
> diff --git a/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c b/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
> index d4bcbed1f546..226654b12779 100644
> --- a/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
> +++ b/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
> @@ -10,7 +10,8 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
>
>  #include <crypto/engine.h>
>  #include <crypto/scatterwalk.h>
> diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
> index 4f6ca229ee5e..d5a32d71a3e9 100644
> --- a/drivers/crypto/n2_core.c
> +++ b/drivers/crypto/n2_core.c
> @@ -10,7 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/cpumask.h>
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
> diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
> index 67a99c760bc4..71002a12993d 100644
> --- a/drivers/crypto/omap-aes.c
> +++ b/drivers/crypto/omap-aes.c
> @@ -24,7 +24,6 @@
>  #include <linux/dmaengine.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/of_address.h>
>  #include <linux/io.h>
>  #include <linux/crypto.h>
> diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
> index f783769ea110..82cca34017e4 100644
> --- a/drivers/crypto/omap-des.c
> +++ b/drivers/crypto/omap-des.c
> @@ -27,8 +27,6 @@
>  #include <linux/dmaengine.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
> -#include <linux/of_address.h>
>  #include <linux/io.h>
>  #include <linux/crypto.h>
>  #include <linux/interrupt.h>
> diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
> index cbeda59c6b19..4c25fc42044c 100644
> --- a/drivers/crypto/omap-sham.c
> +++ b/drivers/crypto/omap-sham.c
> @@ -28,7 +28,6 @@
>  #include <linux/dmaengine.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/delay.h>
> diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
> index 9f6ba770a90a..f3a79bec76a8 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto.c
> @@ -14,7 +14,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk.h>
>  #include <linux/crypto.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
> index 1c4d5fb05d69..fe8cf9ba8005 100644
> --- a/drivers/crypto/s5p-sss.c
> +++ b/drivers/crypto/s5p-sss.c
> @@ -20,7 +20,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/scatterlist.h>
>
> diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
> index df5f9d675c57..6238d34f8db2 100644
> --- a/drivers/crypto/sa2ul.c
> +++ b/drivers/crypto/sa2ul.c
> @@ -15,7 +15,8 @@
>  #include <linux/dmapool.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>
> diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
> index 4c799df3e883..62d93526920f 100644
> --- a/drivers/crypto/sahara.c
> +++ b/drivers/crypto/sahara.c
> @@ -27,7 +27,6 @@
>  #include <linux/kthread.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>
> diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
> index cc43556b6c80..0f517ea06bcb 100644
> --- a/drivers/crypto/starfive/jh7110-cryp.c
> +++ b/drivers/crypto/starfive/jh7110-cryp.c
> @@ -11,8 +11,8 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starfive/jh7110-hash.c
> index 5064150b8a1c..41c9e40c6551 100644
> --- a/drivers/crypto/starfive/jh7110-hash.c
> +++ b/drivers/crypto/starfive/jh7110-hash.c
> @@ -14,7 +14,6 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
> index 6b8d731092a4..ab12c782dec5 100644
> --- a/drivers/crypto/stm32/stm32-cryp.c
> +++ b/drivers/crypto/stm32/stm32-cryp.c
> @@ -10,7 +10,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
> index f0df32382719..cb3ca28fb193 100644
> --- a/drivers/crypto/stm32/stm32-hash.c
> +++ b/drivers/crypto/stm32/stm32-hash.c
> @@ -15,7 +15,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> index bb27f011cf31..4ca4fbd227bc 100644
> --- a/drivers/crypto/talitos.c
> +++ b/drivers/crypto/talitos.c
> @@ -19,9 +19,9 @@
>  #include <linux/interrupt.h>
>  #include <linux/crypto.h>
>  #include <linux/hw_random.h>
> -#include <linux/of_address.h>
> +#include <linux/of.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
>  #include <linux/spinlock.h>
> diff --git a/drivers/crypto/xilinx/zynqmp-aes-gcm.c b/drivers/crypto/xilinx/zynqmp-aes-gcm.c
> index bf1f421e05f2..6092ff0646a8 100644
> --- a/drivers/crypto/xilinx/zynqmp-aes-gcm.c
> +++ b/drivers/crypto/xilinx/zynqmp-aes-gcm.c
> @@ -12,7 +12,7 @@
>
>  #include <linux/dma-mapping.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>
>  #include <linux/firmware/xlnx-zynqmp.h>
> diff --git a/drivers/crypto/xilinx/zynqmp-sha.c b/drivers/crypto/xilinx/zynqmp-sha.c
> index 43ff170ff1c2..426bf1a72ba6 100644
> --- a/drivers/crypto/xilinx/zynqmp-sha.c
> +++ b/drivers/crypto/xilinx/zynqmp-sha.c
> @@ -15,7 +15,6 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>
>  #define ZYNQMP_DMA_BIT_MASK            32U
> --
> 2.40.1
>
