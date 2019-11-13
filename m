From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Date: Wed, 13 Nov 2019 18:52:35 +0300
Subject: [PATCH 0/2] add inversion signal presence support
Message-ID: <20191113155237.30646-1-i.mikhaylov@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vesnin BMC uses microSD with card presence signal inversion in the
schematics. Change the .get_cd callback to detect 'cd-inverted' option
in dts. There is no WP switch, due to this 'disable-wp' also was added
into vesnin dts for sdhci.

Ivan Mikhaylov (2):
  aspeed: dts: add sd card for vesnin
  mmc: sdhci-of-aspeed: add inversion signal presence

 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 13 ++++++++++++
 drivers/mmc/host/sdhci-of-aspeed.c          | 23 +++++++++++++++++++++
 2 files changed, 36 insertions(+)

-- 
2.20.1

