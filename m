From: Nishanth Menon <nm@ti.com>
Date: Mon, 2 Oct 2023 09:13:43 -0500
Subject: (subset) [PATCH 00/40] soc: Convert to platform remove callback returning void
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
Message-ID: <169625598637.2878306.1181893226380989815.b4-ty@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Uwe Kleine-K?nig,

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

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[33/40] soc/ti: k3-ringacc: Convert to platform remove callback returning void
        commit: f34b902c5ba67841902cd7f0e24e64bb82f69cb4
[34/40] soc/ti: knav_dma: Convert to platform remove callback returning void
        commit: 3af4ec7c7dd39a2c4618f6536b2e7b73a19be169
[35/40] soc/ti: knav_qmss_queue: Convert to platform remove callback returning void
        commit: af97160a0c5f1908c6f2830023fb93baac4451d3
[36/40] soc/ti: pm33xx: Convert to platform remove callback returning void
        commit: 9eb950e9fffc5337bfe1798cf89ce4d97a4f1221
[37/40] soc/ti: pruss: Convert to platform remove callback returning void
        commit: d183b20d340b7c098f44cb5c02f4ced01cfd0b16
[38/40] soc/ti: smartreflex: Convert to platform remove callback returning void
        commit: ba03aab9bfb4c9d456419da3891375d45c6bfe15
[39/40] soc/ti: wkup_m3_ipc: Convert to platform remove callback returning void
        commit: 82e83cb51c87b5bf3ab83f7c7b150c19400056c2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

