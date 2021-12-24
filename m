From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 24 Dec 2021 09:32:44 +0100
Subject: [PATCH v6 6/9] misc: smpro-errmon: Add Ampere's SMpro error
 monitor driver
In-Reply-To: <20211224041352.29405-7-quan@os.amperecomputing.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-7-quan@os.amperecomputing.com>
Message-ID: <YcWFrCjWSG65KQgb@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 24, 2021 at 11:13:49AM +0700, Quan Nguyen wrote:
> This commit adds Ampere's SMpro error monitor driver for monitoring
> and reporting RAS-related errors as reported by SMpro co-processor
> found on Ampere's Altra processor family.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> Change in v6:
>   + First introduced in v6 [Quan]
> 
>  drivers/mfd/smpro-mfd.c     |   1 +
>  drivers/misc/Kconfig        |   7 +
>  drivers/misc/Makefile       |   1 +
>  drivers/misc/smpro-errmon.c | 571 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 580 insertions(+)
>  create mode 100644 drivers/misc/smpro-errmon.c

You need Documentation/ABI/ updates when you add sysfs files.  Please do
that for your next version of this patch.

Also remember that sysfs is only "one value per file", this driver seems
to violate that in huge ways and is not ok.

thanks,

greg k-h
