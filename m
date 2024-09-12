From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 12 Sep 2024 12:10:30 +0930
Subject: [PATCH 2/4] soc: aspeed: Simplify code with dev_err_probe()
In-Reply-To: <20240909122921.12627-3-zhangzekun11@huawei.com>
References: <20240909122921.12627-1-zhangzekun11@huawei.com>
	 <20240909122921.12627-3-zhangzekun11@huawei.com>
Message-ID: <354f8d1c5ef517337c9f9a74e70580a8d97fc159.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-09-09 at 20:29 +0800, Zhang Zekun wrote:
> Use dev_err_probe() directly in the driver probe phase, and we
> don't need to judge if the error code is not equal to -EPROBE_DEFER.
> This can simplify the code a bit.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

