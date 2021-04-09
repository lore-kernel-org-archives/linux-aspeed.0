From: Zev Weiss <zweiss@equinix.com>
Date: Fri, 9 Apr 2021 05:32:01 +0000
Subject: [PATCH v2 07/21] ipmi: kcs_bmc: Make status update atomic
In-Reply-To: <20210319062752.145730-7-andrew@aj.id.au>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-7-andrew@aj.id.au>
Message-ID: <YG/m0Hh4BRGRnm7u@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 19, 2021 at 01:27:38AM CDT, Andrew Jeffery wrote:
>Enable more efficient implementation of read-modify-write sequences.
>Both device drivers for the KCS BMC stack use regmaps. The new callback
>allows us to exploit regmap_update_bits().
>
>Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Zev Weiss <zweiss@equinix.com>
