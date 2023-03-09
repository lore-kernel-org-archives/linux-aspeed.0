From: Michael Walle <michael@walle.cc>
Date: Thu, 09 Mar 2023 09:38:05 +0100
Subject: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
In-Reply-To: <1766f6ef-d9d8-04f7-a6bf-0ea6bc0b3d23@linaro.org>
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
 <20220925220304.buk3yuqoh6vszfci@mobilestation>
 <18e6e8a8-6412-7e31-21e0-6becd4400ac1@microchip.com>
 <20220926172454.kbpzck7med5bopre@mobilestation>
 <1766f6ef-d9d8-04f7-a6bf-0ea6bc0b3d23@linaro.org>
Message-ID: <f647e713a65f5d3f0f2e3af95c4d0a89@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> In an ideal world, where both the controller and the device talk about
> dummy number of cycles, I would agree with you, buswidth and dtr should
> not be relevant for the number of dummy cycles. But it seems that there
> are old controllers (e.g. spi-hisi-sfc-v3xx.c, spi-mt65xx.c, 
> spi-mxic.c)
> that support buswidths > 1 and work only with dummy nbytes, they are 
> not
> capable of specifying a smaller granularity (ncycles). Thus the older
> controllers would have to convert the dummy ncycles to dummy nbytes.
> Since mixed transfer modes are a thing (see jesd251, it talks about
> 4S-4D-4D), where single transfer mode (S) can be mixed with double
> transfer mode (D) for a command, the controller would have to guess the
> buswidth and dtr of the dummy. Shall they replicate the buswidth and 
> dtr
> of the address or of the data? There's no rule for that.

But in the end that doesn't matter because they are just dummy clock
cycles and the mode will only affect the data/address/command. 
Therefore,
the controller is free to choose the mode that suits it best.

But that begs the question, is ncycles in regard to DTR or SDR? That is,
are you counting just one type of edges or both the falling and rising
edges. The smallest granularity would be ncycles in regard of DTR. To 
me,
it's not obvious what the SEMPER Nano Flash [1] uses. I'd say we choose
the smallest granularty in spi-mem to be future proof and maybe provide
some spi-mem helper to help setting the cycles for SDR/DTR. As an 
example,
if you want to wait 4 cycles in SDR you'd have ncycles=8 in spi-mem.

So you won't need the mode nor the dtr property.

-michael

[1] 
https://www.infineon.com/dgdl/Infineon-S25FS256T_256Mb_SEMPER_Nano_Flash_Quad_SPI_1.8V-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c80027ecd0180740c5a46707a
