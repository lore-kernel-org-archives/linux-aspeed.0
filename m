From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 03 Oct 2022 14:12:18 -0700
Subject: [PATCH] clk: ast2600: BCLK comes from EPLL
In-Reply-To: <20220421040426.171256-1-joel@jms.id.au>
References: <20220421040426.171256-1-joel@jms.id.au>
Message-ID: <20221003211220.3EC63C433D6@smtp.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Joel Stanley (2022-04-20 21:04:26)
> This correction was made in the u-boot SDK recently. There are no
> in-tree users of this clock so the impact is minimal.
> 
> Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
> Link: https://github.com/AspeedTech-BMC/u-boot/commit/8ad54a5ae15f27fea5e894cc2539a20d90019717
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Applied to clk-next
