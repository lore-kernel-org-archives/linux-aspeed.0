From: David Miller <davem@davemloft.net>
Date: Tue, 27 Nov 2018 16:37:35 -0800 (PST)
Subject: [PATCH net-next v2] net/ncsi: Add NCSI Mellanox OEM command
In-Reply-To: <20181126214905.3703229-1-vijaykhemka@fb.com>
References: <20181126214905.3703229-1-vijaykhemka@fb.com>
Message-ID: <20181127.163735.780394807984803791.davem@davemloft.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 26 Nov 2018 13:49:04 -0800

> This patch adds OEM Mellanox commands and response handling. It also
> defines OEM Get MAC Address handler to get and configure the device.
> 
> ncsi_oem_gma_handler_mlx: This handler send NCSI mellanox command for
> getting mac address.
> ncsi_rsp_handler_oem_mlx: This handles response received for all
> mellanox OEM commands.
> ncsi_rsp_handler_oem_mlx_gma: This handles get mac address response and
> set it to device.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied.
