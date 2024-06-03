From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon,  3 Jun 2024 10:35:01 +0200
Subject: [PATCH v2 0/2] dt-bindings: gpio: aspeed,sgpio: Miscellaneous cleanups
In-Reply-To: <20240530-dt-warnings-gpio-sgpio-interrupt-cells-v2-0-912cd16e641f@codeconstruct.com.au>
References: <20240530-dt-warnings-gpio-sgpio-interrupt-cells-v2-0-912cd16e641f@codeconstruct.com.au>
Message-ID: <171740369951.11706.10620844731089866743.b4-ty@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 30 May 2024 11:09:47 +0930, Andrew Jeffery wrote:
> This short series fixes some SGPIO-related devicetree warnings currently
> emitted by `make dtbs_check` for Aspeed devicetrees.
> 
> Please review!
> 
> Andrew
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: gpio: aspeed,sgpio: Specify gpio-line-names
      commit: a31517b11bd188527b2f8a4b8fd3e91a10f44d04
[2/2] dt-bindings: gpio: aspeed,sgpio: Specify #interrupt-cells
      commit: 3a40985960bcab918da23f8945ab0cd3be12d716

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
