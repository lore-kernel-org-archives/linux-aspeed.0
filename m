From: Mark Brown <broonie@kernel.org>
Date: Tue, 07 Mar 2023 16:47:56 +0000
Subject: [PATCH 00/87] spi: Convert to platform remove callback
 returning void
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
Message-ID: <167820767637.97370.4908221156128194668.b4-ty@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 03 Mar 2023 18:19:14 +0100, Uwe Kleine-K?nig wrote:
> this patch series adapts the platform drivers below drivers/spi
> to use the .remove_new() callback. Compared to the traditional .remove()
> callback .remove_new() returns no value. This is a good thing because
> the driver core doesn't (and cannot) cope for errors during remove. The
> only effect of a non-zero return value in .remove() is that the driver
> core emits a warning. The device is removed anyhow and an early return
> from .remove() usually yields a resource leak.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/87] spi: ar934x: Convert to platform remove callback returning void
        commit: 24644ae031e71491e729d415d88c3cea98288c39
[02/87] spi: armada-3700: Convert to platform remove callback returning void
        commit: 9a49f22852201e6ba8aafd359e9fc13d32717748
[03/87] spi: aspeed-smc: Convert to platform remove callback returning void
        commit: ebf9a50d13a4406b9831f9e2b35f786a3bb18a3e
[04/87] spi: at91-usart: Convert to platform remove callback returning void
        commit: b9c5544877b03b7d5b3c4c97e9133d0bb695c9cb
[05/87] spi: ath79: Convert to platform remove callback returning void
        commit: 48c42f970b7d0cf034721fe7faf59e5698ad7382
[06/87] spi: atmel: Convert to platform remove callback returning void
        commit: 7412afb044178ac0e6facc5f12b5ab220e06c34c
[07/87] spi: au1550: Convert to platform remove callback returning void
        commit: 02a52038fe42bc4dcb477935d60fc779f9238bda
[08/87] spi: axi-spi-engine: Convert to platform remove callback returning void
        commit: fc87abbef23413943457459e2c473ce607b4dd24
[09/87] spi: bcm2835: Convert to platform remove callback returning void
        (no commit info)
[10/87] spi: bcm2835aux: Convert to platform remove callback returning void
        commit: f3a1c6a016193728a62929e0588e5f640cfe7c34
[11/87] spi: bcm63xx-hsspi: Convert to platform remove callback returning void
        commit: 04cd5f3fad161c27fe101ad7906ddd9085c2b4be
[12/87] spi: bcm63xx: Convert to platform remove callback returning void
        commit: 8c26432e9b5fd04aa59010941051d33fa4e289ba
[13/87] spi: bcmbca-hsspi: Convert to platform remove callback returning void
        commit: f54f9b00c62fb3ee280cd3ad0e4e483c9d401107
[14/87] spi: brcmstb-qspi: Convert to platform remove callback returning void
        commit: c4c34d5ded66204db90acaeaff5af1277ea0c21b
[15/87] spi: cadence-quadspi: Convert to platform remove callback returning void
        commit: 6fe41879e93313afdb18104d20d30783600591fe
[16/87] spi: cadence: Convert to platform remove callback returning void
        commit: 427353015333a1e0d6f61785a2f134c4c382f11f
[17/87] spi: cavium-octeon: Convert to platform remove callback returning void
        commit: f74d4b8b97e39b31ad88f6f679180c0800d57a0c
[18/87] spi: coldfire-qspi: Convert to platform remove callback returning void
        commit: 3f025840b9e9313dbd6479ca9117b1eb827d689f
[19/87] spi: davinci: Convert to platform remove callback returning void
        commit: d1a9fa8a3ece62c62aa8aaa573d8ceea8d8fae69
[20/87] spi: dln2: Convert to platform remove callback returning void
        commit: f8b81e0528b67a86172315aa0b516a5050e89c5d
[21/87] spi: dw-bt1: Convert to platform remove callback returning void
        commit: 42f8295cd7ea680f0e9a5a4d864186736f9f9b24
[22/87] spi: dw-mmio: Convert to platform remove callback returning void
        commit: f74abea25ab2809958c7ce8e29e710c66a490b64
[23/87] spi: ep93xx: Convert to platform remove callback returning void
        commit: bb2714d140913de16bcd59f068b1d7f6dafef964
[24/87] spi: fsl-dspi: Convert to platform remove callback returning void
        commit: 1bcab55f13e1c4d03c20a3d7ea37c4228e7bd41e
[25/87] spi: fsl-espi: Convert to platform remove callback returning void
        commit: de60b184d8dd274f36c7c93f3cefad3904420d00
[26/87] spi: fsl-lpspi: Convert to platform remove callback returning void
        commit: edd49c898751838009940fe38a7ad4c1d23224df
[27/87] spi: fsl-qspi: Convert to platform remove callback returning void
        commit: 94f445096932efc48cac128c8be4e34845a702d6
[28/87] spi: fsl-spi: Convert to platform remove callback returning void
        commit: fc4935a0f7ab1521a5f0500a9894d97558067985
[29/87] spi: geni-qcom: Convert to platform remove callback returning void
        commit: d0b52f6539e008a0d42bf673486bd21b7d2dc191
[30/87] spi: hisi-kunpeng: Convert to platform remove callback returning void
        commit: e77ccdfe0145211b5a20ab62950894aea881bbb3
[31/87] spi: img-spfi: Convert to platform remove callback returning void
        commit: 6b854e44b66ee1b3798eff87f1af8738edeccbde
[32/87] spi: iproc-qspi: Convert to platform remove callback returning void
        commit: a57b08c231ae4240c01b0623053a54cb7ec23194
[33/87] spi: lantiq-ssc: Convert to platform remove callback returning void
        commit: 1f85ed7d4757a24ba5b92fdf2a639002bcc78e95
[34/87] spi: meson-spicc: Convert to platform remove callback returning void
        commit: 8e8355d14187f6a65d9168c7dcfbb916f7fef9a7
[35/87] spi: meson-spifc: Convert to platform remove callback returning void
        commit: a4f5ad1196daf1f6f3329082c95d19adf05bd423
[36/87] spi: microchip-core-qspi: Convert to platform remove callback returning void
        commit: e4cf312d6db2941b8267de6e094312afc1b523ee
[37/87] spi: microchip-core: Convert to platform remove callback returning void
        commit: beb6ed0f8cfa844556ac1f6d494cc9b4f6cb1994
[38/87] spi: mpc512x-psc: Convert to platform remove callback returning void
        (no commit info)
[39/87] spi: mpc52xx-psc: Convert to platform remove callback returning void
        (no commit info)
[40/87] spi: mpc52xx: Convert to platform remove callback returning void
        commit: 3fa689a85df4664a62ea931be31e5276cde1e8fe
[41/87] spi: mtk-nor: Convert to platform remove callback returning void
        commit: b558435810cc68755527e55ccaba6c35c340900a
[42/87] spi: mtk-snfi: Convert to platform remove callback returning void
        commit: 976a689122df6c7d8d826ad36578c0291a1dc214
[43/87] spi: mxic: Convert to platform remove callback returning void
        commit: c64e92dfa0bd1256fc3f9f1a32a5c844e49d8681
[44/87] spi: mxs: Convert to platform remove callback returning void
        commit: a760db097cfdce093c0483343d9f831a33702ad9
[45/87] spi: npcm-fiu: Convert to platform remove callback returning void
        commit: 5e4830adb09a3577eb80c0b8c7611d0c0de02ab8
[46/87] spi: npcm-pspi: Convert to platform remove callback returning void
        commit: 445534b5f25ab8394082b47b50d973676ce54ee4
[47/87] spi: nxp-fspi: Convert to platform remove callback returning void
        commit: 2dd82e32c20b57ad693287b546f775c933670e43
[48/87] spi: oc-tiny: Convert to platform remove callback returning void
        commit: bdffa602d741126896de50307126803ffab7a3de
[49/87] spi: omap-uwire: Convert to platform remove callback returning void
        commit: c43bdb3a1154facd844f6a753b6a30fecaadc16e
[50/87] spi: omap2-mcspi: Convert to platform remove callback returning void
        commit: 0a4192a52082118d0da3bdd34145ebabfde40d93
[51/87] spi: orion: Convert to platform remove callback returning void
        commit: 2e0de1efb233ab8b1a488a6663d31edab9ef0f4f
[52/87] spi: pic32-sqi: Convert to platform remove callback returning void
        commit: 503425ed9c50096a0e0c61f38bc39752f3696266
[53/87] spi: pic32: Convert to platform remove callback returning void
        commit: 01c30f51266acf2595cc06885071e752080ca052
[54/87] spi: ppc4xx: Convert to platform remove callback returning void
        commit: 224d9437eb2967b67ae67c4743bb589f86668e8d
[55/87] spi: pxa2xx: Convert to platform remove callback returning void
        commit: 31f6d96d6807cc1dde70cda36cb45ec61d41fe6b
[56/87] spi: qcom-qspi: Convert to platform remove callback returning void
        commit: e0c30566e5333247bbfdad61f98dccf989ff54e1
[57/87] spi: rb4xx: Convert to platform remove callback returning void
        commit: a006c353a115d429c114e9bc26ab0f6a40d3de23
[58/87] spi: rockchip-sfc: Convert to platform remove callback returning void
        commit: e5fcb34d7934aceb39c7d68d30fbf53d93f1eda6
[59/87] spi: rockchip: Convert to platform remove callback returning void
        commit: 5ff5e676201deca9bcc3c9474842b2f4456f24b8
[60/87] spi: rpc-if: Convert to platform remove callback returning void
        commit: c42ee93aded47fe8cf3615df2e20704c720b7433
[61/87] spi: rspi: Convert to platform remove callback returning void
        commit: 72ec0e8f89a1536e4594606d60a946636ee7d94b
[62/87] spi: s3c64xx: Convert to platform remove callback returning void
        commit: 2b7981a65527a51706b895e170e07b2eaeae69c5
[63/87] spi: sh-hspi: Convert to platform remove callback returning void
        commit: f3a762b613598d198b5ebd5c1fcf6a902f8a9d9f
[64/87] spi: sh-msiof: Convert to platform remove callback returning void
        commit: 74af1328a694d3a2a176935c93db8ad406aacb81
[65/87] spi: sh-sci: Convert to platform remove callback returning void
        commit: 80dc51da19cebaf85b03d910cbf4e56af165b0ff
[66/87] spi: sh: Convert to platform remove callback returning void
        commit: dee2e25572e42faa581b6c86cd1252546680362a
[67/87] spi: sifive: Convert to platform remove callback returning void
        commit: fd8998c4633737310c8165c6c3fc81197380d1d9
[68/87] spi: slave-mt27xx: Convert to platform remove callback returning void
        commit: 1037cfa33cedf733a751c8708d174ba11708ce4a
[69/87] spi: sn-f-ospi: Convert to platform remove callback returning void
        commit: 462414a3d0613cf71ecb3c4fb183698d2441bbb9
[70/87] spi: sprd-adi: Convert to platform remove callback returning void
        commit: f7f785f125d03360d3766d96d04cf08b8472ce8f
[71/87] spi: st-ssc4: Convert to platform remove callback returning void
        commit: 2dd42da0b479ffb4604c81b7c1b30aa9b5f0a4a9
[72/87] spi: stm32-qspi: Convert to platform remove callback returning void
        commit: a19ca20a0e4eccacf44119fccc86c2f3e5edb3f0
[73/87] spi: stm32: Convert to platform remove callback returning void
        commit: 3e11e4f336f603d3cddcc89f94e518391b6a08a5
[74/87] spi: sun4i: Convert to platform remove callback returning void
        commit: b7b949458ac391963e56ae354b73fee63016dcee
[75/87] spi: sun6i: Convert to platform remove callback returning void
        commit: edf69ab9c777abf9ab30c6a5a215d16a094bae87
[76/87] spi: sunplus-sp7021: Convert to platform remove callback returning void
        commit: 18bb7328171203f4ade267bcd7cf5b073a1a9405
[77/87] spi: synquacer: Convert to platform remove callback returning void
        commit: 1972cdc47df737f5b90ac2132080004f5e413e91
[78/87] spi: tegra114: Convert to platform remove callback returning void
        commit: bff9694e97790c7f8c9ff1e979b2af9cb6e69adc
[79/87] spi: tegra20-sflash: Convert to platform remove callback returning void
        commit: 8394b7186cf27be24a75516212d5e76d263397d7
[80/87] spi: tegra20-slink: Convert to platform remove callback returning void
        commit: 7f47f7a2ee28938a7ac104e187ec0bd81b0aecf7
[81/87] spi: tegra210-quad: Convert to platform remove callback returning void
        commit: 001ea026c07dad216e1f6fbb8b1619e1d31c8799
[82/87] spi: topcliff-pch: Convert to platform remove callback returning void
        commit: b082694f18bdff807b42a3bccc62c3a524168f23
[83/87] spi: uniphier: Convert to platform remove callback returning void
        commit: 1b13d196d2813dadc1947940dbd4aaad6ae21c02
[84/87] spi: xilinx: Convert to platform remove callback returning void
        commit: 3b1d7e1193315fc96f5e28d08bc3a7e3594628e5
[85/87] spi: xtensa-xtfpga: Convert to platform remove callback returning void
        commit: 795b3ac702716eca422494766cc0136b4a0554ce
[86/87] spi: zynq-qspi: Convert to platform remove callback returning void
        commit: ae9084b6458d34ebf3e377d0407ebe513e41ac71
[87/87] spi: zynqmp-gqspi: Convert to platform remove callback returning void
        commit: 3ffefa1d9c9eba60c7f8b4a9ce2df3e4c7f4a88e

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

