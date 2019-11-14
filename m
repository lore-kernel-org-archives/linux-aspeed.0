From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Date: Thu, 14 Nov 2019 15:54:33 +0300
Subject: [PATCH v2 0/2] add inversion signal presence support
Message-ID: <20191114125435.27756-1-i.mikhaylov@yadro.com>
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

 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 13 +++++++++++++
 drivers/mmc/host/sdhci-of-aspeed.c          | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.20.1

