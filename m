From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 26 Nov 2022 18:25:07 +0100
Subject: [PATCH v2] media: aspeed: Fix return value check in
 aspeed_video_debugfs_create()
In-Reply-To: <20221126022813.57372-1-zhengyongjun3@huawei.com>
References: <20221126022813.57372-1-zhengyongjun3@huawei.com>
Message-ID: <Y4JL89BCcs1pjWZZ@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Nov 26, 2022 at 02:28:13AM +0000, Zheng Yongjun wrote:
> In case of error, the function debugfs_create_file() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
> 
> Fixes: 52fed10ad756 ("media: aspeed: add debugfs")
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Please see:

https://patchwork.kernel.org/project/linux-wireless/patch/20200429101526.GA2094124 at kroah.com/

and there are other examples. Just delete all the checks.

	Andrew
