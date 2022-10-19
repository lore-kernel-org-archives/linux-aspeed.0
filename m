From: Mark Brown <broonie@kernel.org>
Date: Wed, 19 Oct 2022 17:04:01 +0100
Subject: [PATCH] spi: aspeed: Fix window offset of CE1
In-Reply-To: <20221016155722.3520802-1-clg@kaod.org>
References: <20221016155722.3520802-1-clg@kaod.org>
Message-ID: <166619544147.915751.17829368293456984572.b4-ty@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, 16 Oct 2022 17:57:22 +0200, C?dric Le Goater wrote:
> The offset value of the mapping window in the kernel structure is
> calculated using the value of the previous window offset. This doesn't
> reflect how the HW is configured and can lead to erroneous setting of
> the second flash device (CE1).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: aspeed: Fix window offset of CE1
      commit: f8aa6c895d482847c9b799dcdac8bbdb56cb8e04

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
