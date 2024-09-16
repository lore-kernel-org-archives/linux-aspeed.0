From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Sep 2024 12:33:10 +0930
Subject: [PATCH v3 6/6] gpio: aspeed: Add the flush write to ensure the
 write complete.
In-Reply-To: <20240913074325.239390-7-billy_tsai@aspeedtech.com>
References: <20240913074325.239390-1-billy_tsai@aspeedtech.com>
	 <20240913074325.239390-7-billy_tsai@aspeedtech.com>
Message-ID: <7433f7d95a0a51eb54ea0b1c9db102adb029f946.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-13 at 15:43 +0800, Billy Tsai wrote:
> Performing a dummy read ensures that the register write operation is fully
> completed, mitigating any potential bus delays that could otherwise impact
> the frequency of bitbang usage. E.g., if the JTAG application uses GPIO to
> control the JTAG pins (TCK, TMS, TDI, TDO, and TRST), and the application
> sets the TCK clock to 1 MHz, the GPIO?s high/low transitions will rely on
> a delay function to ensure the clock frequency does not exceed 1 MHz.
> However, this can lead to rapid toggling of the GPIO because the write
> operation is POSTed and does not wait for a bus acknowledgment.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

... are you aware of any other driver concerns of a similar nature wrt
the architecture of the SoCs?
