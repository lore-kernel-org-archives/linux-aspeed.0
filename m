From: Stephen Boyd <sboyd@kernel.org>
Date: Sat, 11 Jul 2020 09:16:11 -0700
Subject: [PATCH 1/2] clk: AST2600: Add mux for EMMC clock
In-Reply-To: <20200709195706.12741-2-eajames@linux.ibm.com>
References: <20200709195706.12741-1-eajames@linux.ibm.com>
 <20200709195706.12741-2-eajames@linux.ibm.com>
Message-ID: <159448417133.1987609.8669229169177662950@swboyd.mtv.corp.google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Eddie James (2020-07-09 12:57:05)
> The EMMC clock can be derived from either the HPLL or the MPLL. Register
> a clock mux so that the rate is calculated correctly based upon the
> parent.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---

Applied to clk-fixes
