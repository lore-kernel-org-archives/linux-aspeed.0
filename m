From: Mark Brown <broonie@kernel.org>
Date: Wed, 01 Feb 2023 16:57:31 +0000
Subject: (subset) [PATCH v2 00/13] spi: Add support for
 stacked/parallel memories
In-Reply-To: <20230119185342.2093323-1-amit.kumar-mahapatra@amd.com>
References: <20230119185342.2093323-1-amit.kumar-mahapatra@amd.com>
Message-ID: <167527065195.537421.10361370461620477483.b4-ty@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 20 Jan 2023 00:23:29 +0530, Amit Kumar Mahapatra wrote:
> This patch is in the continuation to the discussions which happened on
> 'commit f89504300e94 ("spi: Stacked/parallel memories bindings")' for
> adding dt-binding support for stacked/parallel memories.
> 
> This patch series updated the spi-nor, spi core and the spi drivers
> to add stacked and parallel memories support.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/13] spi: Add APIs in spi core to set/get spi->chip_select and spi->cs_gpiod
        commit: 303feb3cc06ac0665d0ee9c1414941200e60e8a3
[02/13] spi: Replace all spi->chip_select and spi->cs_gpiod references with function call
        (no commit info)
[03/13] net: Replace all spi->chip_select and spi->cs_gpiod references with function call
        (no commit info)
[04/13] iio: imu: Replace all spi->chip_select and spi->cs_gpiod references with function call
        (no commit info)
[05/13] mtd: devices: Replace all spi->chip_select and spi->cs_gpiod references with function call
        (no commit info)
[06/13] staging: Replace all spi->chip_select and spi->cs_gpiod references with function call
        (no commit info)
[07/13] platform/x86: serial-multi-instantiate: Replace all spi->chip_select and spi->cs_gpiod references with function call
        (no commit info)

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

