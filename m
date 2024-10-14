From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 09:04:23 +0200
Subject: (subset) [PATCH v7 0/7] Add Aspeed G7 gpio support
In-Reply-To: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
References: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
Message-ID: <172888945458.6232.12570065156992505241.b4-ty@linaro.org>
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

[3/7] gpio: aspeed: Change the macro to support deferred probe
      commit: f1bc03e7e9bbbb18ad60ad6c6908b16fb7f40545
[4/7] gpio: aspeed: Remove the name for bank array
      commit: d787289589202cd449cabed3d7fde84e18fb6dd6
[5/7] gpio: aspeed: Create llops to handle hardware access
      commit: 79fc9a2fcc457f4375118fbcdb6767163870b5ff
[6/7] dt-bindings: gpio: aspeed,ast2400-gpio: Support ast2700
      commit: bef6959a3746fc8207a0ca75e239c95d7409fd90
[7/7] gpio: aspeed: Support G7 Aspeed gpio controller
      commit: b2e861bd1eaf4c5f75139df9b75dade3334a5b6c

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
