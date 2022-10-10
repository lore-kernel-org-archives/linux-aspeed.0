From: Mark Brown <broonie@kernel.org>
Date: Mon, 10 Oct 2022 15:12:48 +0100
Subject: [v2] spi: aspeed: Fix typo in mode_bits field for AST2600 platform
In-Reply-To: <20221005083209.222272-1-chin-ting_kuo@aspeedtech.com>
References: <20221005083209.222272-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <166541116820.121778.9566592036880610465.b4-ty@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 5 Oct 2022 16:32:09 +0800, Chin-Ting Kuo wrote:
> Both quad SPI TX and RX modes can be supported on AST2600.
> Correct typo in mode_bits field in both ast2600_fmc_data
> and ast2600_spi_data structs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: aspeed: Fix typo in mode_bits field for AST2600 platform
      commit: 5302e1ff315b40dfc9bb3f08911f5a788cc1de01

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
