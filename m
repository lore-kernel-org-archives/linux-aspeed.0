From: Zev Weiss <zweiss@equinix.com>
Date: Fri, 18 Jun 2021 23:19:57 +0000
Subject: [PATCH v4 01/16] ipmi: kcs_bmc_aspeed: Use of match data to
 extract KCS properties
In-Reply-To: <20210608104757.582199-2-andrew@aj.id.au>
References: <20210608104757.582199-1-andrew@aj.id.au>
 <20210608104757.582199-2-andrew@aj.id.au>
Message-ID: <20210618231933.GA9658@hatter>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 08, 2021 at 05:47:42AM CDT, Andrew Jeffery wrote:
>Unpack and remove the aspeed_kcs_probe_of_v[12]() functions to aid
>rearranging how the private device-driver memory is allocated.
>
>Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>---
> drivers/char/ipmi/kcs_bmc_aspeed.c | 154 ++++++++++++++---------------
> 1 file changed, 77 insertions(+), 77 deletions(-)
>

Reviewed-by: Zev Weiss <zweiss@equinix.com>
