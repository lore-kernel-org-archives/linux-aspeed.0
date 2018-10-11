From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 11 Oct 2018 22:12:26 +0000
Subject: [PATCH v2 1/2] net/ncsi: Add NCSI Broadcom OEM command
In-Reply-To: <7893ec3aa673b6009d00df1646b2820be2fc33a6.camel@mendozajonas.com>
References: <20181009174806.404791-1-vijaykhemka@fb.com>
 <7893ec3aa673b6009d00df1646b2820be2fc33a6.camel@mendozajonas.com>
Message-ID: <65877506-90AD-4383-955E-23ED94E5337F@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks Sam,
I will take care of this and generate new patch.

Regards
-Vijay

?On 10/9/18, 9:40 PM, "Samuel Mendoza-Jonas" <sam@mendozajonas.com> wrote:

    On Tue, 2018-10-09 at 10:48 -0700, Vijay Khemka wrote:
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
    > ---
    >  net/ncsi/Kconfig       |  6 ++++
    >  net/ncsi/internal.h    |  8 +++++
    >  net/ncsi/ncsi-manage.c | 70 +++++++++++++++++++++++++++++++++++++++++-
    >  net/ncsi/ncsi-pkt.h    |  8 +++++
    >  net/ncsi/ncsi-rsp.c    | 40 +++++++++++++++++++++++-
    >  5 files changed, 130 insertions(+), 2 deletions(-)
    > 
    
    <snip>
    
    >  static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
    >  {
    >  	struct ncsi_dev *nd = &ndp->ndev;
    > @@ -643,9 +676,10 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
    >  	struct ncsi_channel *nc = ndp->active_channel;
    >  	struct ncsi_channel *hot_nc = NULL;
    >  	struct ncsi_cmd_arg nca;
    > +	struct ncsi_oem_gma_handler *nch = NULL;
    >  	unsigned char index;
    >  	unsigned long flags;
    > -	int ret;
    > +	int ret, i;
    >  
    
    I just noticed that if CONFIG_NCSI_OEM_CMD_GET_MAC is not set then this
    generates unused variable warnings for i and nch. Otherwise all looking good!
    
    Regards,
    Sam
    
    
    

