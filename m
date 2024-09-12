From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 12 Sep 2024 12:37:10 +0930
Subject: [PATCH -next] serial: 8250_aspeed_vuart: Enable module
 autoloading
In-Reply-To: <20240903131503.961178-1-liaochen4@huawei.com>
References: <20240903131503.961178-1-liaochen4@huawei.com>
Message-ID: <3a5fb92a32cd1d23029dce8a87297175858bf0c0.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-09-03 at 13:15 +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
> on the alias from of_device_id table.
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

