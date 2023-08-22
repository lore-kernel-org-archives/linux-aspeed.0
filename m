From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 22 Aug 2023 14:00:34 -0700
Subject: [PATCH] clk: Annotate struct clk_hw_onecell_data with __counted_by
In-Reply-To: <20230817203019.never.795-kees@kernel.org>
References: <20230817203019.never.795-kees@kernel.org>
Message-ID: <cb4f740cd5bcb6c9b19ce970d8573388.sboyd@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Kees Cook (2023-08-17 13:30:22)
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct clk_hw_onecell_data.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Taichi Sugaya <sugaya.taichi@socionext.com>
> Cc: Takao Orito <orito.takao@socionext.com>
> Cc: Qin Jian <qinjian@cqplus1.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> Cc: linux-clk at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-aspeed at lists.ozlabs.org
> Cc: linux-arm-msm at vger.kernel.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-sunxi at lists.linux.dev
> Cc: linux-phy at lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Applied to clk-next
