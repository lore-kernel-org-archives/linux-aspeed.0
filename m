From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 19 Jul 2023 13:59:53 -0700
Subject: [PATCH v2] clk: Explicitly include correct DT includes
In-Reply-To: <20230718143156.1066339-1-robh@kernel.org>
References: <20230718143156.1066339-1-robh@kernel.org>
Message-ID: <2198bbf6e40906ee76b734d0f6afa08f.sboyd@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Rob Herring (2023-07-18 07:31:43)
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> # samsung
> Acked-by: Heiko Stuebner <heiko@sntech.de> #rockchip
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # versaclock5
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
