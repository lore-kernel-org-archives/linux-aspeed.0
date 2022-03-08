From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 08 Mar 2022 11:11:57 +1030
Subject: [PATCH] pinctrl: aspeed: Add FWQSPI pinmux
In-Reply-To: <20220308003136.3930466-1-quic_jaehyoo@quicinc.com>
References: <20220308003136.3930466-1-quic_jaehyoo@quicinc.com>
Message-ID: <d2f125d8-07d1-4bff-8718-7dfba4d8fdb3@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 8 Mar 2022, at 11:01, Jae Hyun Yoo wrote:
> From: Johnny Huang <johnny_huang@aspeedtech.com>
>
> AST2600 FW SPI quad mode only need to set AE12 and AF12, no need
> to set Y1~Y4. FW SPI cs, clk, mosi and miso pins are dedicated.

They're not dedicated according to the datasheet?

Can you please look at this patch?

https://lore.kernel.org/all/20220304011010.974863-1-joel at jms.id.au/

Cheers,

Andrew
