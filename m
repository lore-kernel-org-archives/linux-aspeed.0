From: David Miller <davem@davemloft.net>
Date: Thu, 25 Oct 2018 15:53:35 -0700 (PDT)
Subject: [PATCH net-next] net/ncsi: Add NCSI Mellanox OEM command
In-Reply-To: <20181025220413.2936698-1-vijaykhemka@fb.com>
References: <20181025220413.2936698-1-vijaykhemka@fb.com>
Message-ID: <20181025.155335.2132843393553452471.davem@davemloft.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 25 Oct 2018 15:04:13 -0700

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

net-next is closed, please resubmit this when the net-next tree opens
back up.

Thank you.
