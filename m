From: Zev Weiss <zweiss@equinix.com>
Date: Fri, 9 Apr 2021 05:33:30 +0000
Subject: [PATCH v2 08/21] ipmi: kcs_bmc: Rename {read, write}_{status,
 data}() functions
In-Reply-To: <20210319062752.145730-8-andrew@aj.id.au>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-8-andrew@aj.id.au>
Message-ID: <YG/nKd3ERFYPoLhZ@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 19, 2021 at 01:27:39AM CDT, Andrew Jeffery wrote:
>Rename the functions in preparation for separating the IPMI chardev out
>from the KCS BMC core.
>
>Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Zev Weiss <zweiss@equinix.com>
