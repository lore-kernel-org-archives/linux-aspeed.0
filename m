From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 13 Oct 2020 19:50:22 -0700
Subject: [PATCH 1/1] clk: aspeed: modify some default clks are critical
In-Reply-To: <20200928070108.14040-2-ryan_chen@aspeedtech.com>
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com>
Message-ID: <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Ryan Chen (2020-09-28 00:01:08)
> In ASPEED SoC LCLK is LPC clock for all SuperIO device, UART1/UART2 are
> default for Host SuperIO UART device, eSPI clk for Host eSPI bus access
> eSPI slave channel, those clks can't be disable should keep default,
> otherwise will affect Host side access SuperIO and SPI slave device.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---

Is there resolution on this thread?
