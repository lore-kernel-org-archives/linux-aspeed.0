From: Marc Zyngier <maz@kernel.org>
Date: Thu, 16 Feb 2023 10:47:43 +0000
Subject: [PATCH 00/17] Mass convert GPIO IRQ chips to be immutable
In-Reply-To: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
Message-ID: <86pma9yjhs.wl-maz@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 16 Feb 2023 09:37:01 +0000,
Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> We are getting tired of these irq_chips not getting converted
> to be immutable, so I just take out the big hammer and fix
> some that I deem not too complex as best I can.

Thanks for taking the hit on this one.

I had a cursory look, and they seem fine overall. only the omap one
looks a bit scary, but I take it that Tony can give that one a go
before it gets merged.

FWIW:

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.
