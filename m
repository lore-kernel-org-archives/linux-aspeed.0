From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue,  8 Oct 2024 16:02:52 +0200
Subject: (subset) [PATCH v7 0/7] Add Aspeed G7 gpio support
In-Reply-To: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
References: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
Message-ID: <172839616610.55104.2573120540182552334.b4-ty@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 08 Oct 2024 16:14:43 +0800, Billy Tsai wrote:
> The Aspeed 7th generation SoC features two GPIO controllers: one with 12
> GPIO pins and another with 216 GPIO pins. The main difference from the
> previous generation is that the control logic has been updated to support
> per-pin control, allowing each pin to have its own 32-bit register for
> configuring value, direction, interrupt type, and more.
> This patch serial also add low-level operations (llops) to abstract the
> register access for GPIO registers and the coprocessor request/release in
> gpio-aspeed.c making it easier to extend the driver to support different
> hardware register layouts.
> 
> [...]

Applied, thanks!

[1/7] gpio: aspeed: Add the flush write to ensure the write complete.
      commit: 1bb5a99e1f3fd27accb804aa0443a789161f843c
[2/7] gpio: aspeed: Use devm_clk api to manage clock source
      commit: a6191a3d18119184237f4ee600039081ad992320

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
