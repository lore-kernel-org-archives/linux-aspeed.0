From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 15 Dec 2020 12:31:39 -0800
Subject: [Aspeed,ncsi-rx, v1 1/1] net: ftgmac100: Fix AST2600 EVB NCSI
 RX issue
In-Reply-To: <20201215192323.24359-2-hongweiz@ami.com>
References: <20201215192323.24359-1-hongweiz@ami.com>
 <20201215192323.24359-2-hongweiz@ami.com>
Message-ID: <20201215123139.27fd45cd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 15 Dec 2020 14:23:23 -0500 Hongwei Zhang wrote:
> Fix AST2600 EVB NCSI RX timeout issue by removing FTGMAC100_RXDES0_RX_ERR bit
> from macro RXDES0_ANY_ERROR.
> 
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>

Thanks for the patch. Please repost CCing the netdev mailing list so it
can be merged to the networking tree (which I assume is your intent).
Please also include a Fixes tag pointing to the commit where the
timeout issue started (even if it's the first commit of the driver).
