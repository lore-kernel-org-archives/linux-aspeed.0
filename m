From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 16 Aug 2019 10:01:49 -0700
Subject: [PATCH 1/2] clk: aspeed: Move structures to header
In-Reply-To: <20190816155806.22869-2-joel@jms.id.au>
References: <20190816155806.22869-1-joel@jms.id.au>
 <20190816155806.22869-2-joel@jms.id.au>
Message-ID: <20190816170150.4E6772077C@mail.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Joel Stanley (2019-08-16 08:58:05)
> diff --git a/drivers/clk/clk-aspeed.h b/drivers/clk/clk-aspeed.h
> new file mode 100644
> index 000000000000..92d384367c25
> --- /dev/null
> +++ b/drivers/clk/clk-aspeed.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Structures used by ASPEED clock drivers
> + *
> + * Copyright 2019 IBM Corp.
> + */

Please include reset.h (or whatever defines reset_controller_dev),
clk-provider.h, kernel.h (for container_of and types), and forward
declare struct regmap and clk_div_table here.

> +
> +/**
> + * struct aspeed_gate_data - Aspeed gated clocks
