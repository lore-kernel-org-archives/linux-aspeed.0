From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 19 Sep 2024 06:12:46 +0000
Subject: [PATCH v3 3/6] gpio: aspeed: Create llops to handle hardware
 access
In-Reply-To: <2be44ea18d15f1ecda22d867396671802be14ebf.camel@codeconstruct.com.au>
References: <20240913074325.239390-1-billy_tsai@aspeedtech.com>
	 <20240913074325.239390-4-billy_tsai@aspeedtech.com>
 <2be44ea18d15f1ecda22d867396671802be14ebf.camel@codeconstruct.com.au>
Message-ID: <OSQPR06MB72528D55D21A34EFA29797CC8B632@OSQPR06MB7252.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

I will add the following change on the next patch:

1. Add `privilege_ctrl` and `privilege_init` callback
2. Use `bool aspeed_gpio_support_copro()` api to replace the `cmd_source_supoort` flag
3. Add the `dcache_require` flag and move the dcache usage into the `reg_bit_set` callback
4. `reg_bits_set` -> `reg_bit_set` and `reg_bits_read` -> `reg_bits_get`
5. `bool copro = 0` -> `bool copro = false`
6. if (!gpio->config->llops->reg_bit_set || !gpio->config->llops->reg_bits_get) return -EINVAL;

Thanks for your comments.
