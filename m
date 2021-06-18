From: Zev Weiss <zweiss@equinix.com>
Date: Fri, 18 Jun 2021 23:26:04 +0000
Subject: [PATCH v4 08/16] ipmi: kcs_bmc: Decouple the IPMI chardev from
 the core
In-Reply-To: <20210608104757.582199-9-andrew@aj.id.au>
References: <20210608104757.582199-1-andrew@aj.id.au>
 <20210608104757.582199-9-andrew@aj.id.au>
Message-ID: <20210618232603.GC9658@hatter>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 08, 2021 at 05:47:49AM CDT, Andrew Jeffery wrote:
>Now that we have untangled the data-structures, split the userspace
>interface out into its own module. Userspace interfaces and drivers are
>registered to the KCS BMC core to support arbitrary binding of either.
>
>Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>---
> drivers/char/ipmi/Kconfig             | 13 +++++
> drivers/char/ipmi/Makefile            |  3 +-
> drivers/char/ipmi/kcs_bmc.c           | 80 +++++++++++++++++++++++++--
> drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 31 +++++++++--
> drivers/char/ipmi/kcs_bmc_client.h    | 14 +++++
> 5 files changed, 128 insertions(+), 13 deletions(-)
>

Reviewed-by: Zev Weiss <zweiss@equinix.com>
