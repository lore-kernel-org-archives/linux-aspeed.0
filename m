From: David Miller <davem@davemloft.net>
Date: Fri, 11 Oct 2019 20:38:12 -0700 (PDT)
Subject: [PATCH v2 0/3] net: ftgmac100: Ungate RCLK for RMII on ASPEED MACs
In-Reply-To: <20191010020756.4198-1-andrew@aj.id.au>
References: <20191010020756.4198-1-andrew@aj.id.au>
Message-ID: <20191011.203812.1828730130029996774.davem@davemloft.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 10 Oct 2019 12:37:53 +1030

> This series slightly extends the devicetree binding and driver for the
> FTGMAC100 to describe an optional RMII RCLK gate in the clocks property.
> Currently it's necessary for the kernel to ungate RCLK on the AST2600 in NCSI
> configurations as u-boot does not yet support NCSI (which uses the
> R(educed)MII).
> 
> v2:
> * Clear up Reduced vs Reversed MII in the cover letter
> * Mitigate anxiety in the commit message for 1/3 
> * Clarify that AST2500 is also affected in the clocks property description in
>   2/3
> * Rework the error paths and update some comments in 3/3
> 
> v1 can be found here: https://lore.kernel.org/netdev/20191008115143.14149-1-andrew at aj.id.au/

Series applied to net-next, thank you.
