From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Wed, 17 Oct 2018 13:50:57 +1100
Subject: [PATCH net-next v5] net/ncsi: Add NCSI Broadcom OEM command
In-Reply-To: <20181016191319.1909502-1-vijaykhemka@fb.com>
References: <20181016191319.1909502-1-vijaykhemka@fb.com>
Message-ID: <ef5233889f290ec62d0f371c8e05689535740d87.camel@mendozajonas.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2018-10-16 at 12:13 -0700, Vijay Khemka wrote:
> This patch adds OEM Broadcom commands and response handling. It also
> defines OEM Get MAC Address handler to get and configure the device.
> 
> ncsi_oem_gma_handler_bcm: This handler send NCSI broadcom command for
> getting mac address.
> ncsi_rsp_handler_oem_bcm: This handles response received for all
> broadcom OEM commands.
> ncsi_rsp_handler_oem_bcm_gma: This handles get mac address response and
> set it to device.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

