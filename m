From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Date: Mon, 18 Nov 2019 13:46:43 +0300
Subject: [PATCH v3 0/3] add inversion signal presence support
Message-ID: <20191118104646.3838-1-i.mikhaylov@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vesnin BMC uses microSD with card presence signal inversion in the
schematics. Add the .read_l callback to detect 'cd-inverted' option
in dts. There is no WP switch, due to this 'disable-wp' also was added
into vesnin dts for sdhci.

Ivan Mikhaylov (3):
  aspeed: dts: add sd card for vesnin
  mmc: sdhci-of-aspeed: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
  mmc: sdhci-of-aspeed: add inversion signal presence

 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 13 +++++++++++++
 drivers/mmc/host/Kconfig                    |  1 +
 drivers/mmc/host/sdhci-of-aspeed.c          | 12 ++++++++++++
 3 files changed, 26 insertions(+)

-- 
2.20.1

