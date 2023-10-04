From: Heiko Stübner <heiko@sntech.de>
Date: Wed, 04 Oct 2023 23:18:45 +0200
Subject: [PATCH -next 25/25] spi: rockchip: Use helper function
 devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-26-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230822131237.1022815-26-lizetao1@huawei.com>
Message-ID: <16634210.geO5KgaWL5@diego>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Am Dienstag, 22. August 2023, 15:12:37 CEST schrieb Li Zetao:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it is
> no longer necessary to unprepare and disable the clocks explicitly.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


