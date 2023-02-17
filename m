From: Tony Lindgren <tony@atomide.com>
Date: Fri, 17 Feb 2023 07:58:03 +0200
Subject: [PATCH 14/17] gpio: omap: Drop irq_base
In-Reply-To: <20230215-immutable-chips-v1-14-51a8f224a5d0@linaro.org>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
 <20230215-immutable-chips-v1-14-51a8f224a5d0@linaro.org>
Message-ID: <Y+8XaxwKSjM40k6e@atomide.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

* Linus Walleij <linus.walleij@linaro.org> [230216 09:37]:
> The OMAP1 at one point was using static irqs but that time is gone,
> OMAP1 uses sparse irqs like all other multiplatform targets so this
> static allocation of descriptors should just go.

Reviewed-by: Tony Lindgren <tony@atomide.com>
