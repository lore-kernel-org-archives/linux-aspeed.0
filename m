From: Joel Stanley <joel@jms.id.au>
Date: Fri, 9 Apr 2021 03:36:57 +0000
Subject: [PATCH v2 04/21] pinctrl: aspeed-g5: Adapt to new LPC device tree
 layout
In-Reply-To: <20210319062752.145730-4-andrew@aj.id.au>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-4-andrew@aj.id.au>
Message-ID: <CACPK8Xfre_HriZXa10GVRvzxM51_6jkxCrXi-Ofto6cCKcLw4g@mail.gmail.com>
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
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
