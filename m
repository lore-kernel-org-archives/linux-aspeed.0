From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 08 Nov 2019 08:48:53 -0800
Subject: [PATCH v2 2/2] clk: ast2600: Add RMII RCLK gates for all four MACs
In-Reply-To: <20191010020725.3990-3-andrew@aj.id.au>
References: <20191010020725.3990-1-andrew@aj.id.au>
 <20191010020725.3990-3-andrew@aj.id.au>
Message-ID: <20191108164853.EA1C22178F@mail.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Andrew Jeffery (2019-10-09 19:07:25)
> RCLK is a fixed 50MHz clock derived from HPLL/HCLK that is described by a
> single gate for each MAC.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---

Applied to clk-next

