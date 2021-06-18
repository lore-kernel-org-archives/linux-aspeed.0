From: Zev Weiss <zweiss@equinix.com>
Date: Fri, 18 Jun 2021 23:24:17 +0000
Subject: [PATCH v4 06/16] ipmi: kcs_bmc: Split headers into device and
 client
In-Reply-To: <20210608104757.582199-7-andrew@aj.id.au>
References: <20210608104757.582199-1-andrew@aj.id.au>
 <20210608104757.582199-7-andrew@aj.id.au>
Message-ID: <20210618232417.GB9658@hatter>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 08, 2021 at 05:47:47AM CDT, Andrew Jeffery wrote:
>Strengthen the distinction between code that abstracts the
>implementation of the KCS behaviours (device drivers) and code that
>exploits KCS behaviours (clients). Neither needs to know about the APIs
>required by the other, so provide separate headers.
>
>Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>---
> drivers/char/ipmi/kcs_bmc.c           | 23 ++++++++++------
> drivers/char/ipmi/kcs_bmc.h           | 27 +++++++++----------
> drivers/char/ipmi/kcs_bmc_aspeed.c    | 17 ++++++------
> drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 39 ++++++++++++++++++---------
> drivers/char/ipmi/kcs_bmc_client.h    | 27 +++++++++++++++++++
> drivers/char/ipmi/kcs_bmc_device.h    | 19 +++++++++++++
> drivers/char/ipmi/kcs_bmc_npcm7xx.c   | 17 ++++++------
> 7 files changed, 117 insertions(+), 52 deletions(-)
> create mode 100644 drivers/char/ipmi/kcs_bmc_client.h
> create mode 100644 drivers/char/ipmi/kcs_bmc_device.h
>

Reviewed-by: Zev Weiss <zweiss@equinix.com>
