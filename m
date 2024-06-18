From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 18 Jun 2024 11:52:58 -0000
Subject: [PATCH v2 00/20] pinctrl: Use scope based of_node_put() cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <AM6PR04MB594163BAB898D8689A94056F88CE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus,

> Subject: [PATCH v2 00/20] pinctrl: Use scope based of_node_put()
> cleanups

st/stm32/renesas patches are picked. Would you handle the remaining
ones?

Thanks,
Peng.

> 
> Use scope based of_node_put() to simplify code. It reduces the chance
> of forgetting of_node_put(), and also simplifies error handling path.
> I not able to test the changes on all the hardwares, so driver owners,
> please help review when you have time.
> 
> This patchset was inspired from Dan's comments on pinctrl-scmi-imx.c,
> thanks.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v2:
> - Drop aspeed changes per Andrew Jeffery
> - Drop changes to code pattern that of_node_get(or other refcount
> increasing) followed by of_node_put. That said, but I still have a change
> for samsung pinctrl that drops several of_node_put places. If this is not
> welcomed, patch 20/20 could be dropped.
> - Add Fix tag for patch 1
> - Add A-b for patch 4
> - Drop unneeded {} in patch 8 Per Dan Carpenter
> - Add a new patch 18.
> - Moved patch [19,20]/20, in case people are not happy with the
> changes, the two patch could be dropped when apply if no v3 patchset.
> - Link to v1: https://lore.kernel.org/r/20240501-pinctrl-cleanup-v1-0-
> 797ceca46e5c at nxp.com
> 
> ---
> Peng Fan (20):
>       pinctrl: ti: iodelay: Use scope based of_node_put() cleanups
>       pinctrl: tegra: Use scope based of_node_put() cleanups
>       pinctrl: stm32: Use scope based of_node_put() cleanups
>       pinctrl: starfive: Use scope based of_node_put() cleanups
>       pinctrl: sprd: Use scope based of_node_put() cleanups
>       pinctrl: spear: Use scope based of_node_put() cleanups
>       pinctrl: renesas: Use scope based of_node_put() cleanups
>       pinctrl: st: Use scope based of_node_put() cleanups
>       pinctrl: rockchip: Use scope based of_node_put() cleanups
>       pinctrl: equilibrium: Use scope based of_node_put() cleanups
>       pinctrl: at91: Use scope based of_node_put() cleanups
>       pinctrl: s32cc: Use scope based of_node_put() cleanups
>       pinctrl: nomadik: Use scope based of_node_put() cleanups
>       pinctrl: mediatek: Use scope based of_node_put() cleanups
>       pinctrl: freescale: Use scope based of_node_put() cleanups
>       pinctrl: bcm: bcm63xx: Use scope based of_node_put() cleanups
>       pinctrl: pinconf-generic: Use scope based of_node_put() cleanups
>       pinctrl: freescale: mxs: Fix refcount of child
>       pinctrl: k210: Use scope based of_node_put() cleanups
>       pinctrl: samsung: Use scope based of_node_put() cleanups
> 
>  drivers/pinctrl/bcm/pinctrl-bcm63xx.c              |  4 +--
>  drivers/pinctrl/freescale/pinctrl-imx.c            | 25 ++++-----------
>  drivers/pinctrl/freescale/pinctrl-imx1-core.c      | 16 +++-------
>  drivers/pinctrl/freescale/pinctrl-mxs.c            | 18 ++++-------
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |  4 +--
>  drivers/pinctrl/mediatek/pinctrl-paris.c           |  4 +--
>  drivers/pinctrl/nomadik/pinctrl-abx500.c           |  4 +--
>  drivers/pinctrl/nomadik/pinctrl-nomadik.c          |  4 +--
>  drivers/pinctrl/nxp/pinctrl-s32cc.c                | 31 ++++++------------
>  drivers/pinctrl/pinconf-generic.c                  |  7 ++--
>  drivers/pinctrl/pinctrl-at91-pio4.c                |  7 ++--
>  drivers/pinctrl/pinctrl-at91.c                     | 14 +++-----
>  drivers/pinctrl/pinctrl-equilibrium.c              | 21 +++---------
>  drivers/pinctrl/pinctrl-k210.c                     |  7 ++--
>  drivers/pinctrl/pinctrl-rockchip.c                 | 11 ++-----
>  drivers/pinctrl/pinctrl-st.c                       | 37 +++++++---------------
>  drivers/pinctrl/renesas/pinctrl-rza1.c             | 14 +++-----
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c            |  7 ++--
>  drivers/pinctrl/renesas/pinctrl-rzn1.c             | 23 ++++----------
>  drivers/pinctrl/renesas/pinctrl-rzv2m.c            |  7 ++--
>  drivers/pinctrl/renesas/pinctrl.c                  |  7 ++--
>  drivers/pinctrl/samsung/pinctrl-exynos.c           | 16 +++-------
>  drivers/pinctrl/samsung/pinctrl-samsung.c          | 19 +++--------
>  drivers/pinctrl/spear/pinctrl-spear.c              | 13 +++-----
>  drivers/pinctrl/sprd/pinctrl-sprd.c                | 14 +++-----
>  drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 27 +++++++---------
> drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 18 +++++------
>  drivers/pinctrl/stm32/pinctrl-stm32.c              |  4 +--
>  drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         |  7 ++--
>  drivers/pinctrl/tegra/pinctrl-tegra.c              |  4 +--
>  drivers/pinctrl/ti/pinctrl-ti-iodelay.c            | 37 ++++++++--------------
>  31 files changed, 133 insertions(+), 298 deletions(-)
> ---
> base-commit: bb7a2467e6beef44a80a17d45ebf2931e7631083
> change-id: 20240429-pinctrl-cleanup-e4d461c32648
> 
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>

