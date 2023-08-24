From: Cédric Le Goater <clg@kaod.org>
Date: Thu, 24 Aug 2023 10:55:37 +0200
Subject: [PATCH -next 03/25] spi: aspeed: Use helper function
 devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-4-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230822131237.1022815-4-lizetao1@huawei.com>
Message-ID: <4450e65b-5de4-e503-ea2e-da95410f4c50@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 8/22/23 15:12, Li Zetao wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it is
> no longer necessary to unprepare and disable the clocks explicitly.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>


Reviewed-by: C?dric Le Goater <clg@kaod.org>

Thanks,

C.

