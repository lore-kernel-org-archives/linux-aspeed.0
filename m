From: Douglas Anderson <dianders@chromium.org>
Date: Thu,  3 Sep 2020 16:24:35 -0700
Subject: [PATCH 0/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for all host drivers
Message-ID: <20200903232441.2694866-1-dianders@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

As per discussion [1], it seems like it should be quite safe to turn
on PROBE_PREFER_ASYNCHRONOUS for all sd/mmc host controllers.  Let's
give it a shot.  For some discussion about this flag, see the commit
message for commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
probe").

I've broken this series into chunks based on LTS kernel releases to
attempt to make it easier if someone wanted to cherry-pick it to an
older kernel.  While these cherry-picks won't be conflict free, there
should only be trivial context conflicts and no problems with drivers
that are totally missing.  This is a bit of a compromise between a
1-big patch and a many-part patch series.

I have only tested this on a rk3399-kevin (sdhci-of-arasan) and a
rk3288-veyron (dw_mmc-rockchip) device and only lightly.  If this
patch causes anyone problems those drivers should be marked with
PROBE_FORCE_SYNCHRONOUS, debugged, and then go back to prefer
asynchronous.  Any problems are likely just a hidden bug that has been
exposed by this change.

NOTE: in theory, it'd be nice if there was a KConfig option that we
could flip that would turn on async probe everywhere (except for those
that opt out by adding PROBE_FORCE_SYNCHRONOUS).  My hope is that by
adding this flag in more places it will become clear that this flag is
working reliably and easier to move over when we're ready.

While coccinelle is too difficult for my feeble brain, I managed to
whip up a pretty terrible python script to help with this.  For your
edification:

import os
import sys
import re

for filename in os.listdir("."):
    found_plat = False
    found_driver = False
    output = []
    for line in open(filename, "r").readlines():
        output.append(line)

        if "struct platform_driver" in line:
            found_plat = True
        if found_plat and re.search(r"\t\.driver\s*=\s*{", line):
            found_driver = True
            found_plat = False
        mo = re.search(r"(\s*)\.name(\s*)=", line)
        if found_driver and mo:
            if mo.group(2) == " ":
                space = " "
            elif mo.group(2) == "\t":
                # Best we can do
                space = " "
            elif mo.group(2).startswith("\t"):
                # Guess that removing one tab is right
                space = mo.group(2)[1:]
            else:
                # Guess it's all spaces
                space = mo.group(2)[7:] + " "

            output.append("%s.probe_type%s= PROBE_PREFER_ASYNCHRONOUS,\n" % (mo.group(1), space))
            found_driver = False

    open(filename, "w").write("".join(output))

[1] https://lore.kernel.org/r/CAPDyKFq31bucJhP9hp1HSqh-qM2uNGHgDoyQpmbJf00nEf_T4Q at mail.gmail.com/


Douglas Anderson (6):
  mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.4
  mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.9
  mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.14
  mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.19
  mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v5.4
  mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that are newer than 5.4

 drivers/mmc/host/alcor.c                      | 1 +
 drivers/mmc/host/android-goldfish.c           | 1 +
 drivers/mmc/host/atmel-mci.c                  | 1 +
 drivers/mmc/host/au1xmmc.c                    | 1 +
 drivers/mmc/host/bcm2835.c                    | 1 +
 drivers/mmc/host/cavium-octeon.c              | 1 +
 drivers/mmc/host/davinci_mmc.c                | 1 +
 drivers/mmc/host/dw_mmc-bluefield.c           | 1 +
 drivers/mmc/host/dw_mmc-exynos.c              | 1 +
 drivers/mmc/host/dw_mmc-hi3798cv200.c         | 1 +
 drivers/mmc/host/dw_mmc-k3.c                  | 1 +
 drivers/mmc/host/dw_mmc-pltfm.c               | 1 +
 drivers/mmc/host/dw_mmc-rockchip.c            | 1 +
 drivers/mmc/host/dw_mmc-zx.c                  | 1 +
 drivers/mmc/host/jz4740_mmc.c                 | 1 +
 drivers/mmc/host/meson-gx-mmc.c               | 1 +
 drivers/mmc/host/meson-mx-sdhc-mmc.c          | 1 +
 drivers/mmc/host/meson-mx-sdio.c              | 1 +
 drivers/mmc/host/moxart-mmc.c                 | 1 +
 drivers/mmc/host/mtk-sd.c                     | 1 +
 drivers/mmc/host/mvsdio.c                     | 1 +
 drivers/mmc/host/mxcmmc.c                     | 1 +
 drivers/mmc/host/mxs-mmc.c                    | 1 +
 drivers/mmc/host/omap.c                       | 1 +
 drivers/mmc/host/omap_hsmmc.c                 | 1 +
 drivers/mmc/host/owl-mmc.c                    | 1 +
 drivers/mmc/host/pxamci.c                     | 1 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 1 +
 drivers/mmc/host/rtsx_pci_sdmmc.c             | 1 +
 drivers/mmc/host/rtsx_usb_sdmmc.c             | 1 +
 drivers/mmc/host/s3cmci.c                     | 1 +
 drivers/mmc/host/sdhci-acpi.c                 | 1 +
 drivers/mmc/host/sdhci-bcm-kona.c             | 1 +
 drivers/mmc/host/sdhci-brcmstb.c              | 1 +
 drivers/mmc/host/sdhci-cadence.c              | 1 +
 drivers/mmc/host/sdhci-cns3xxx.c              | 1 +
 drivers/mmc/host/sdhci-dove.c                 | 1 +
 drivers/mmc/host/sdhci-esdhc-imx.c            | 1 +
 drivers/mmc/host/sdhci-esdhc-mcf.c            | 1 +
 drivers/mmc/host/sdhci-iproc.c                | 1 +
 drivers/mmc/host/sdhci-milbeaut.c             | 1 +
 drivers/mmc/host/sdhci-of-arasan.c            | 1 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 2 ++
 drivers/mmc/host/sdhci-of-at91.c              | 1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 1 +
 drivers/mmc/host/sdhci-of-esdhc.c             | 1 +
 drivers/mmc/host/sdhci-of-hlwd.c              | 1 +
 drivers/mmc/host/sdhci-of-sparx5.c            | 1 +
 drivers/mmc/host/sdhci-omap.c                 | 1 +
 drivers/mmc/host/sdhci-pic32.c                | 1 +
 drivers/mmc/host/sdhci-pxav2.c                | 1 +
 drivers/mmc/host/sdhci-pxav3.c                | 1 +
 drivers/mmc/host/sdhci-s3c.c                  | 1 +
 drivers/mmc/host/sdhci-sirf.c                 | 1 +
 drivers/mmc/host/sdhci-spear.c                | 1 +
 drivers/mmc/host/sdhci-sprd.c                 | 1 +
 drivers/mmc/host/sdhci-st.c                   | 1 +
 drivers/mmc/host/sdhci-tegra.c                | 1 +
 drivers/mmc/host/sdhci-xenon.c                | 1 +
 drivers/mmc/host/sdhci_am654.c                | 1 +
 drivers/mmc/host/sdhci_f_sdh30.c              | 1 +
 drivers/mmc/host/sh_mmcif.c                   | 1 +
 drivers/mmc/host/sunxi-mmc.c                  | 1 +
 drivers/mmc/host/tmio_mmc.c                   | 1 +
 drivers/mmc/host/uniphier-sd.c                | 1 +
 drivers/mmc/host/usdhi6rol0.c                 | 1 +
 drivers/mmc/host/wbsd.c                       | 1 +
 drivers/mmc/host/wmt-sdmmc.c                  | 1 +
 69 files changed, 70 insertions(+)

-- 
2.28.0.526.ge36021eeef-goog

