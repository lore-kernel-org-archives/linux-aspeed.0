From: David Miller <davem@davemloft.net>
Date: Wed, 21 Nov 2018 16:52:44 -0800 (PST)
Subject: [PATCH net-next] net/ncsi: Add NCSI Mellanox OEM command
In-Reply-To: <20181120203516.3460764-1-vijaykhemka@fb.com>
References: <20181120203516.3460764-1-vijaykhemka@fb.com>
Message-ID: <20181121.165244.777667590099933299.davem@davemloft.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 20 Nov 2018 12:35:16 -0800

> +static int ncsi_oem_gma_handler_mlx(struct ncsi_cmd_arg *nca)
> +{
> +	unsigned char data[NCSI_OEM_MLX_CMD_GMA_LEN];
> +	int ret = 0;
> +
> +	nca->payload = NCSI_OEM_MLX_CMD_GMA_LEN;
> +
> +	memset(data, 0, NCSI_OEM_MLX_CMD_GMA_LEN);
> +	*(unsigned int *)data = ntohl(NCSI_OEM_MFR_MLX_ID);

'data' is not necessarily aligned on an unsigned int boundary.

But second of all you want to use a fixed size type like "u32" or
similar here, not "unsigned int".

Altogether, something like:

	union {
		u8 data_u8[NCSI_OEM_MLX_CMD_GMA_LEN];
		u32 data_u32[[NCSI_OEM_MLX_CMD_GMA_LEN / sizeof(u32)];
	} u;

	memset(&u, 0, sizeof(u));
	u.data_u32[0] = ntohl(NCSI_OEM_MFR_MLX_ID);
	u.data_u8[5] = NCSI_OEM_MLX_CMD_GMA;
	u.data_u8[6] = NCSI_OEM_MLX_CMD_GMA_PARAM;

If the rest of the ncsi driver has crud like this, it all needs
to be fixed up similarly.
