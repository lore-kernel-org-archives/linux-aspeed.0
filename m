From: Mark Brown <broonie@kernel.org>
Date: Fri, 23 Sep 2022 18:21:43 +0100
Subject: [PATCH -next] spi: aspeed: Remove redundant dev_err call
In-Reply-To: <20220923101632.19170-1-shangxiaojing@huawei.com>
References: <20220923101632.19170-1-shangxiaojing@huawei.com>
Message-ID: <166395370362.637404.4217222260781909886.b4-ty@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 23 Sep 2022 18:16:32 +0800, Shang XiaoJing wrote:
> devm_ioremap_resource() prints error message in itself. Remove the
> dev_err call to avoid redundant error message.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: aspeed: Remove redundant dev_err call
      commit: 04e0456f778de550a14d222d1a9ae0625511244d

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
