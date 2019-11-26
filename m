From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 26 Nov 2019 10:03:19 -0800
Subject: [PATCH v2 2/2] clk: aspeed: Add RMII RCLK gates for both AST2500
 MACs
In-Reply-To: <20191010020655.3776-3-andrew@aj.id.au>
References: <20191010020655.3776-1-andrew@aj.id.au>
 <20191010020655.3776-3-andrew@aj.id.au>
Message-ID: <20191126180320.1A2132071A@mail.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Andrew Jeffery (2019-10-09 19:06:55)
> RCLK is a fixed 50MHz clock derived from HPLL that is described by a
> single gate for each MAC.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---

Applied to clk-next

