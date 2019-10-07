From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 7 Oct 2019 11:15:33 -0700
Subject: [PATCH -next 03/34] rtc: brcmstb-waketimer: use
 devm_platform_ioremap_resource() to simplify code
In-Reply-To: <20191006102953.57536-4-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
 <20191006102953.57536-4-yuehaibing@huawei.com>
Message-ID: <dd5ef249-820c-9a5c-9fdf-50c7af9b0f61@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/6/19 3:29 AM, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
