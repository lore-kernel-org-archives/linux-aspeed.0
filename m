From: Joel Stanley <joel@jms.id.au>
Date: Fri, 9 Apr 2021 03:35:34 +0000
Subject: [PATCH v2 03/21] ipmi: kcs: aspeed: Adapt to new LPC DTS layout
In-Reply-To: <20210319062752.145730-3-andrew@aj.id.au>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-3-andrew@aj.id.au>
Message-ID: <CACPK8XfkvBA+9_WFb96oEa4F1vDPd90hG+M2Y-Ek=Xt5FUFqmQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 19 Mar 2021 at 06:28, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> From: "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
>
> Add check against LPC device v2 compatible string to
> ensure that the fixed device tree layout is adopted.
> The LPC register offsets are also fixed accordingly.
>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Acked-by: Haiyue Wang <haiyue.wang@linux.intel.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>
