From: Zev Weiss <zweiss@equinix.com>
Date: Fri, 18 Jun 2021 23:30:13 +0000
Subject: [PATCH v4 11/16] ipmi: kcs_bmc: Add serio adaptor
In-Reply-To: <20210608104757.582199-12-andrew@aj.id.au>
References: <20210608104757.582199-1-andrew@aj.id.au>
 <20210608104757.582199-12-andrew@aj.id.au>
Message-ID: <20210618233012.GD9658@hatter>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 08, 2021 at 05:47:52AM CDT, Andrew Jeffery wrote:
>kcs_bmc_serio acts as a bridge between the KCS drivers in the IPMI
>subsystem and the existing userspace interfaces available through the
>serio subsystem. This is useful when userspace would like to make use of
>the BMC KCS devices for purposes that aren't IPMI.
>
>Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>---
> drivers/char/ipmi/Kconfig         |  14 +++
> drivers/char/ipmi/Makefile        |   1 +
> drivers/char/ipmi/kcs_bmc_serio.c | 157 ++++++++++++++++++++++++++++++
> 3 files changed, 172 insertions(+)
> create mode 100644 drivers/char/ipmi/kcs_bmc_serio.c
>

Reviewed-by: Zev Weiss <zweiss@equinix.com>
