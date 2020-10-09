From: Greg KH <greg@kroah.com>
Date: Fri, 9 Oct 2020 06:45:26 +0200
Subject: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
In-Reply-To: <20201009024937.11246-2-ryan_chen@aspeedtech.com>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com>
 <20201009024937.11246-2-ryan_chen@aspeedtech.com>
Message-ID: <20201009044526.GB111063@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 09, 2020 at 10:49:35AM +0800, Ryan Chen wrote:
> v2:
>  -Changed : Add SCSI, BLK_DEV_SD, USB_STORAGE support.
> v1:
>  -Enable UHCI driver in aspeed_g5_defconfig.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Why do you need this in a defconfig?
