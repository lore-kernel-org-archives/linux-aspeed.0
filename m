From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 27 Aug 2024 11:40:35 +0930
Subject: [PATCH -next] mmc: sdhci-of-aspeed: fix module autoloading
In-Reply-To: <20240826124851.379759-1-liaochen4@huawei.com>
References: <20240826124851.379759-1-liaochen4@huawei.com>
Message-ID: <9a810b982c7d9b3c2b6ea1feb560ee9cd8ffe113.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-08-26 at 12:48 +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
