From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Fri, 21 Sep 2018 15:46:42 -0700
Subject: [PATCH v3] i2c: aspeed: fix invalid clock parameters for very
 large divisors
In-Reply-To: <20180921223446.82685-1-brendanhiggins@google.com>
References: <20180921223446.82685-1-brendanhiggins@google.com>
Message-ID: <1f6b9bcd-f93c-4fa6-3abf-762d54c63dc0@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/21/2018 3:34 PM, Brendan Higgins wrote:
> @@ -142,7 +142,8 @@ struct aspeed_i2c_bus {
>   	/* Synchronizes I/O mem access to base. */
>   	spinlock_t			lock;
>   	struct completion		cmd_complete;
> -	u32				(*get_clk_reg_val)(u32 divisor);
> +	u32				(*get_clk_reg_val)(struct device *dev,
> +							   u32 divisor);

I realized that you changed *get_clk_reg_val type in v2. You probably
need to fix below code in aspeed_i2c_probe_bus() as well to remove
a sparse warning.

bus->get_clk_reg_val = (u32 (*)(u32))match->data;

-Jae
