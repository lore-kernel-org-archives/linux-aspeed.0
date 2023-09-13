From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Wed, 13 Sep 2023 11:15:34 +0200
Subject: [PATCH -next v2 19/25] spi: mtk-snfi: Use helper function
 devm_clk_get_enabled()
In-Reply-To: <20230823133938.1359106-20-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
 <20230823133938.1359106-20-lizetao1@huawei.com>
Message-ID: <93074a59-8747-910e-0b76-4682e827ff73@collabora.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Il 23/08/23 15:39, Li Zetao ha scritto:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it is
> no longer necessary to unprepare and disable the clocks explicitly.
> Also, devm_clk_get_optional() and clk_prepare_enable() can now be
> replaced by devm_clk_get_optional_enabled().Moreover, the two functions
> mtk_snand_enable_clk() and mtk_snand_disable_clk() no longer are used,
> drop them for clean code.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


