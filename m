From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 7 Mar 2022 15:31:40 +0700
Subject: [PATCH v6 6/9] misc: smpro-errmon: Add Ampere's SMpro error
 monitor driver
In-Reply-To: <20211224041352.29405-7-quan@os.amperecomputing.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-7-quan@os.amperecomputing.com>
Message-ID: <ab145110-6a9d-8a1d-811d-0c209b4bac60@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Lee Jones,

This mail is to reply your comment in https://lkml.org/lkml/2021/12/29/120

Thanks for the review,
- Quan

On 24/12/2021 11:13, Quan Nguyen wrote:
> This commit adds Ampere's SMpro error monitor driver for monitoring
> and reporting RAS-related errors as reported by SMpro co-processor
> found on Ampere's Altra processor family.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> Change in v6:
>    + First introduced in v6 [Quan]
> 
>   drivers/mfd/smpro-mfd.c     |   1 +

[Lee Jones] Separate patch please

Will separate this smpro-mfd.c in single patch only in my next version

>   drivers/misc/Kconfig        |   7 +
>   drivers/misc/Makefile       |   1 +
>   drivers/misc/smpro-errmon.c | 571 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 580 insertions(+)
>   create mode 100644 drivers/misc/smpro-errmon.c
> 

