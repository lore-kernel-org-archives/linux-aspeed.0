From: Joel Stanley <joel@jms.id.au>
Date: Wed, 2 Dec 2020 21:19:47 +0000
Subject: [v2 0/4] Porting ASPEED FMC/SPI memory controller driver
In-Reply-To: <160683107674.35139.14509237313835347013.b4-ty@kernel.org>
References: <20201103072202.24705-1-chin-ting_kuo@aspeedtech.com>
 <160683107674.35139.14509237313835347013.b4-ty@kernel.org>
Message-ID: <CACPK8Xe4TcRVBnZL7vtqGq1PTe5NEx1k4hvk4FDeYgJQ9HALFg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 1 Dec 2020 at 13:58, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, 3 Nov 2020 15:21:58 +0800, Chin-Ting Kuo wrote:
> > This patch series aims to porting ASPEED FMC/SPI memory controller
> > driver with spi-mem interface. Adjust device tree setting of SPI NOR
> > flash in order to fit real AST2600 EVB and new SPI memory controller
> > driver. Also, this patch has been verified on AST2600-A1 EVB.
> >
> > v2: Fix sparse warnings reported by kernel test robot <lkp@intel.com>.
> >
> > [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Really? Or is there a bug in one of your scripts :)

Cheers,

Joel

>
> Thanks!
>
> [1/2] dt-bindings: spi: Add binding file for ASPEED FMC/SPI memory controller
>       (no commit info)
> [2/2] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
>       (no commit info)
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
