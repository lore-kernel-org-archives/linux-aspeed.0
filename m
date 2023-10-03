From: Bjorn Andersson <andersson@kernel.org>
Date: Mon,  2 Oct 2023 18:10:02 -0700
Subject: (subset) [PATCH 00/40] soc: Convert to platform remove callback returning void
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
Message-ID: <169629539848.1944895.16954663145011378401.b4-ty@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Mon, 25 Sep 2023 11:54:51 +0200, Uwe Kleine-K?nig wrote:
> this series converts all platform drivers below drivers/soc to use
> .remove_new(). The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.
> 
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
> 
> [...]

Applied, thanks!

[18/40] soc/qcom: icc-bwmon: Convert to platform remove callback returning void
        commit: dd714c568ed4e6f79017be45077de71e9908af03
[19/40] soc/qcom: llcc-qcom: Convert to platform remove callback returning void
        commit: d85a9d18a58156fc8b5ab185e00e078adaaeefde
[20/40] soc/qcom: ocmem: Convert to platform remove callback returning void
        commit: 0b742c498bcd7d215501b10fe9df72a16237735a
[21/40] soc/qcom: pmic_glink: Convert to platform remove callback returning void
        commit: 4b3373e42dc2caa34394ac090c8c70bed49badd6
[22/40] soc/qcom: qcom_aoss: Convert to platform remove callback returning void
        commit: ffbe84a514f863a46a85c1e47b2b6d930b1b463e
[23/40] soc/qcom: qcom_gsbi: Convert to platform remove callback returning void
        commit: 57b31729bd2c72b00d400106e18db91e9d95d3c3
[24/40] soc/qcom: qcom_stats: Convert to platform remove callback returning void
        commit: a47ff90bf2f93ce4ca99858948a74a0c10a2bc45
[25/40] soc/qcom: rmtfs_mem: Convert to platform remove callback returning void
        commit: 7c93da5b8b69d4e4e7270c33ba3206af43930e1d
[26/40] soc/qcom: smem: Convert to platform remove callback returning void
        commit: 4b8dee9a34d51a61f60add996fae6a7140a20ae5
[27/40] soc/qcom: smp2p: Convert to platform remove callback returning void
        commit: 1cd966c2dc19654ed08c843e5c933db8c1349636
[28/40] soc/qcom: smsm: Convert to platform remove callback returning void
        commit: bdd7cc62cf69fe989557445d65d6c8cb2f956518
[29/40] soc/qcom: socinfo: Convert to platform remove callback returning void
        commit: c0989f7d1264b2b1885345a28a32fd5e1e61f9c7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
