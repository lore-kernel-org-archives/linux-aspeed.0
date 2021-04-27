From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 27 Apr 2021 13:29:22 +0930
Subject: [PATCH] ARM: dts: aspeed: update e3c246d4i vuart properties
In-Reply-To: <20210416075113.18047-1-zev@bewilderbeest.net>
References: <20210416075113.18047-1-zev@bewilderbeest.net>
Message-ID: <201d989f-882f-4b73-ab06-5085f99301ed@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 16 Apr 2021, at 17:21, Zev Weiss wrote:
> This device-tree was merged with a provisional vuart IRQ-polarity
> property that was still under review and ended up taking a somewhat
> different form.  This patch updates it to match the final form of the
> new vuart properties, which additionally allow specifying the SIRQ
> number and LPC address.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
