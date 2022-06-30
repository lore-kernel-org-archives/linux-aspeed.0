From: Mark Brown <broonie@kernel.org>
Date: Thu, 30 Jun 2022 12:46:17 +0100
Subject: [PATCH v3 0/2] spi: aspeed: Fix division by zero
In-Reply-To: <20220622161617.3719096-1-clg@kaod.org>
References: <20220622161617.3719096-1-clg@kaod.org>
Message-ID: <165658957778.347350.13855044340681991332.b4-ty@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 22 Jun 2022 18:16:15 +0200, C?dric Le Goater wrote:
> Here is a small series adding some debug and fixing a division by zero
> on a board using normal speed reads.
> 
> Thanks,
> 
> C.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: aspeed: Add dev_dbg() to dump the spi-mem direct mapping descriptor
      commit: 8988ba7dec43aabd43adb1214b922b8873e9da88
[2/2] spi: aspeed: Fix division by zero
      commit: 30554a1f0fd6a5d2e2413bdc05389995d5611736

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
