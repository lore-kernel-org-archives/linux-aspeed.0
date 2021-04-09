From: Zev Weiss <zweiss@equinix.com>
Date: Fri, 9 Apr 2021 05:40:06 +0000
Subject: [PATCH v2 20/21] ipmi: kcs_bmc_aspeed: Fix IBFIE typo from
 datasheet
In-Reply-To: <20210319062752.145730-20-andrew@aj.id.au>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-20-andrew@aj.id.au>
Message-ID: <YG/otW6XwZFT6fPy@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 19, 2021 at 01:27:51AM CDT, Andrew Jeffery wrote:
>Input Buffer Full Interrupt Enable (IBFIE) is typoed as IBFIF for some
>registers in the datasheet. Fix the driver to use the sensible acronym.
>
>Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Zev Weiss <zweiss@equinix.com>
