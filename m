From: Andy Shevchenko <andy@kernel.org>
Date: Tue, 3 Oct 2023 11:54:55 +0300
Subject: [PATCH] gpio: aspeed: fix the GPIO number passed to
 pinctrl_gpio_set_config()
In-Reply-To: <20231003073926.10771-1-brgl@bgdev.pl>
References: <20231003073926.10771-1-brgl@bgdev.pl>
Message-ID: <ZRvW31qf/cbd5fYT@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 03, 2023 at 09:39:26AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> pinctrl_gpio_set_config() expects the GPIO number from the global GPIO
> numberspace, not the controller-relative offset, which needs to be added
> to the chip base.

Right, because it has no clue what chip this offset is related to.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


