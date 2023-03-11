From: Mark Brown <broonie@kernel.org>
Date: Sat, 11 Mar 2023 21:16:42 +0000
Subject: (subset) [PATCH V6 00/15] Add support for stacked/parallel
 memories
In-Reply-To: <20230310173217.3429788-1-amit.kumar-mahapatra@amd.com>
References: <20230310173217.3429788-1-amit.kumar-mahapatra@amd.com>
Message-ID: <167856940280.964268.10660159170818600511.b4-ty@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 10 Mar 2023 23:02:02 +0530, Amit Kumar Mahapatra wrote:
> This patch is in the continuation to the discussions which happened on
> 'commit f89504300e94 ("spi: Stacked/parallel memories bindings")' for
> adding dt-binding support for stacked/parallel memories.
> 
> This patch series updated the spi-nor, spi core and the spi drivers
> to add stacked and parallel memories support.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[01/15] spi: Replace all spi->chip_select and spi->cs_gpiod references with function call
        commit: 9e264f3f85a56cc109cc2d6010a48aa89d5c1ff1
[02/15] net: Replace all spi->chip_select and spi->cs_gpiod references with function call
        commit: 25fd0550d9b9c92288a17fb7d605cdcdb4a65a64
[03/15] iio: imu: Replace all spi->chip_select and spi->cs_gpiod references with function call
        commit: 0183f81fce154ae1d4df2bb28d22ad6612317148
[04/15] mtd: devices: Replace all spi->chip_select and spi->cs_gpiod references with function call
        commit: 0817bcef53e4e3df23c023eddaa2b35b7288400e
[05/15] staging: Replace all spi->chip_select and spi->cs_gpiod references with function call
        commit: caa9d3475b1c5566f0272273c147cc9b72f2be28
[06/15] platform/x86: serial-multi-instantiate: Replace all spi->chip_select and spi->cs_gpiod references with function call
        commit: e20451f44ca33ec40422e9868775e117ef2da935
[07/15] powerpc/83xx/mpc832x_rdb: Replace all spi->chip_select references with function call
        commit: 3aba06a9fee04f6fefa9df71d3ee27dd4c464ad5
[08/15] ALSA: hda: cs35l41: Replace all spi->chip_select references with function call
        commit: 06b5e53c8b2b016e06a53ab6f01006ca7bbfa5df

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

