From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 7 Oct 2019 16:11:38 +0800
Subject: [PATCH -next 29/34] rtc: sunxi: use
 devm_platform_ioremap_resource() to simplify code
In-Reply-To: <20191006102953.57536-30-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
 <20191006102953.57536-30-yuehaibing@huawei.com>
Message-ID: <CAGb2v64hUaddO-29=ZP53HDrrOUKqfa52Qk9Q2dGf_RkfwZfyA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Oct 6, 2019 at 6:39 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
